#!/usr/bin/env node
import 'dotenv/config';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import yargs from 'yargs';
import { hideBin } from 'yargs/helpers';
import { chromium, devices } from 'playwright';
import Anthropic from '@anthropic-ai/sdk';
import { createCanvas, loadImage } from 'canvas';

const argv = yargs(hideBin(process.argv))
  .option('url',   { type: 'string', default: 'http://localhost:8080' })
  .option('dev',   { type: 'boolean', default: true })
  .option('maxSteps', { type: 'number', default: 80 })
  .option('out',   { type: 'string', default: './runs' })
  .argv;

const anthropic = new Anthropic({ apiKey: process.env.ANTHROPIC_API_KEY });
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const iPhone12Pro = devices['iPhone 12 Pro'];
const VIEWPORT = { width: 844, height: 390, isLandscape: true };

const LABELS = {
  start:  ['スタート','はじめる','開始','PLAY','Start','Go','はじめ','ゲームをはじめる'],
  next:   ['つぎ','次へ','Next','Continue','すすむ','OK','つづける','つぎへ'],
  back:   ['もどる','戻る','Back','ホーム','Home','Exit','メニューへ'],
  correct:['正解','やった','Great','Correct','クリア','Clear','Success','せいかい'],
  wrong:  ['不正解','ちがう','Wrong','Miss','もういちど','Retry','リトライ','ふせいかい'],
};

function ensureDir(p){ fs.mkdirSync(p, {recursive:true}); }
function ts(){ return new Date().toISOString().replace(/[:.]/g,'-'); }

async function takeScreenshot(page, outDir, name='screen'){
  const file = path.join(outDir, `${name}.png`);
  await page.screenshot({ path: file, fullPage: false });
  return file;
}

async function drawOverlay(basePng, rects, clicks, outPath){
  const img = await loadImage(basePng);
  const canvas = createCanvas(img.width, img.height);
  const ctx = canvas.getContext('2d');
  ctx.drawImage(img, 0, 0);

  ctx.lineWidth = 2;
  for(const r of rects){
    ctx.strokeStyle = 'rgba(0, 128, 255, 0.8)';
    ctx.strokeRect(r.x, r.y, r.w, r.h);
  }
  for(const c of clicks){
    ctx.fillStyle = 'rgba(255, 0, 0, 0.5)';
    ctx.beginPath();
    ctx.arc(c.x, c.y, 12, 0, 2*Math.PI);
    ctx.fill();
  }
  fs.writeFileSync(outPath, canvas.toBuffer('image/png'));
}

async function collectUiCandidates(page){
  return await page.evaluate(() => {
    const sels = [
      'button','[role="button"]','a[href]',
      'input[type="button"]','input[type="submit"]',
      '[tabindex]'
    ];
    const list = Array.from(document.querySelectorAll(sels.join(',')));
    const visible = el => {
      const cs = getComputedStyle(el);
      if (cs.display === 'none' || cs.visibility === 'hidden' || parseFloat(cs.opacity) === 0) return false;
      const r = el.getBoundingClientRect();
      return r.width > 0 && r.height > 0;
    };
    return list.filter(visible).map(el => {
      const r = el.getBoundingClientRect();
      const text = (el.innerText || '').trim();
      const aria = el.getAttribute('aria-label') || '';
      const role = el.getAttribute('role') || el.tagName.toLowerCase();
      return {
        text, aria, role,
        rect: { x: r.x, y: r.y, w: r.width, h: r.height },
        center: { x: r.x + r.width/2, y: r.y + r.height/2 },
        outerHTML: el.outerHTML.slice(0, 180)
      };
    });
  });
}

function hasAny(text, words){
  if(!text) return false;
  const t = text.toLowerCase();
  return words.some(w => t.toLowerCase().includes(w.toLowerCase()));
}

async function observeState(page){
  const bodyText = await page.evaluate(() => document.body.innerText || '');
  const s = (k)=> bodyText.includes(k);
  const correct = Object.values(LABELS.correct).flat().some(k=>s(k));
  const wrong   = Object.values(LABELS.wrong).flat().some(k=>s(k));
  return { bodyText, correct, wrong };
}

function toBase64(pngPath){
  return fs.readFileSync(pngPath).toString('base64');
}

const SYSTEM_PROMPT = `
You are a vision-based QA agent testing a children's educational game.
Given a screenshot and a list of clickable UI candidates (with text, aria, role, and coordinates),
choose the SINGLE best next action to solve problems and progress.
Output ONLY JSON with this schema, no extra text:

{
  "action": "click" | "type" | "wait" | "scroll" | "finish" | "fail",
  "target": {
    "by": "text" | "aria" | "selector" | "coords",
    "text": "<optional>",
    "aria": "<optional>",
    "selector": "<optional>",
    "x": <number>, "y": <number>
  },
  "text": "<if action=type>",
  "reason_short": "<max 12 words, no chain-of-thought>",
  "confidence": 0.0
}

Rules:
- Prefer buttons with meanings like Start/Next/OK/Retry when appropriate.
- If the screen displays a question with choices, select the correct choice.
- If nothing actionable, use "scroll" or "wait" briefly; if stuck, "fail".
- Never explain your reasoning; fill "reason_short" briefly.
`;

async function askClaude({imgB64, candidates, state}){
  const content = [
    { type: 'text', text: 'Screenshot and UI candidates for next action.' },
    { type: 'image', source: { type: 'base64', media_type: 'image/png', data: imgB64 } },
    { type: 'text', text: `UI candidates (JSON):\n${JSON.stringify(candidates).slice(0, 15000)}` },
    { type: 'text', text: `State: ${JSON.stringify(state)}` },
    { type: 'text', text: 'Respond with JSON only as per schema.' }
  ];
  const resp = await anthropic.messages.create({
    model: 'claude-3-5-sonnet-20241022',
    max_tokens: 512,
    temperature: 0,
    system: SYSTEM_PROMPT,
    messages: [{ role: 'user', content }]
  });
  const txt = resp.content?.[0]?.text || '{}';
  try { return JSON.parse(txt); } catch(e){ return { action:'fail', reason_short:'bad-json', confidence:0 }; }
}

async function main(){
  const runDir = path.join(argv.out, `run-${ts()}`);
  ensureDir(runDir);

  const browser = await chromium.launch({ headless: !argv.dev });
  const ctx = await browser.newContext({
    ...iPhone12Pro,
    viewport: { width: VIEWPORT.width, height: VIEWPORT.height },
    deviceScaleFactor: iPhone12Pro.deviceScaleFactor,
    hasTouch: true, isMobile: true, screen: { width: VIEWPORT.width, height: VIEWPORT.height }
  });
  const page = await ctx.newPage();
  await page.goto(argv.url, { waitUntil: 'networkidle' });

  let step = 0, problem = 1;
  let lastHash = '';
  const logPath = path.join(runDir, 'events.jsonl');
  const log = (obj)=> fs.appendFileSync(logPath, JSON.stringify({ts:new Date().toISOString(), problem, step, ...obj})+'\n');

  while(step < argv.maxSteps){
    step++;

    // 1) 観測
    const png = await takeScreenshot(page, runDir, `step-${String(step).padStart(3,'0')}`);
    const candidates = await collectUiCandidates(page);
    const state = await observeState(page);

    // 同一画面ループ検出（簡易）
    const curHash = fs.readFileSync(png).slice(-8192).toString('base64');
    const stuck = curHash === lastHash;
    lastHash = curHash;

    // 2) 決定（Claude）
    const action = await askClaude({ imgB64: toBase64(png), candidates, state });

    // 3) 実行
    let clickPoint = null;
    try{
      if(action.action === 'click'){
        if(action.target?.x && action.target?.y){
          await page.mouse.click(action.target.x, action.target.y, { delay: 10 });
          clickPoint = { x: action.target.x, y: action.target.y };
        }else if(action.target?.text){
          const idx = candidates.findIndex(c => (c.text||'').includes(action.target.text) || (c.aria||'').includes(action.target.text));
          if(idx>=0){
            const c = candidates[idx];
            await page.mouse.click(c.center.x, c.center.y, { delay: 10 });
            clickPoint = { x: c.center.x, y: c.center.y };
          }
        }else{
          const big = [...candidates].sort((a,b)=> (b.rect.w*b.rect.h)-(a.rect.w*a.rect.h))[0];
          if(big){ await page.mouse.click(big.center.x, big.center.y); clickPoint = big.center; }
        }
      }else if(action.action === 'type' && action.text){
        await page.keyboard.type(action.text, { delay: 30 });
      }else if(action.action === 'scroll'){
        await page.mouse.wheel(0, 400);
      }else if(action.action === 'wait'){
        await page.waitForTimeout(600);
      }else if(action.action === 'finish'){
        log({ event:'finish', action });
        break;
      }else if(action.action === 'fail'){
        log({ event:'fail', action });
        break;
      }
    }catch(e){
      log({ event:'error', error: String(e), action });
    }

    await page.waitForTimeout(500);

    // 4) 判定：正解/不正解/進行
    const after = await observeState(page);
    const outcome = after.correct ? 'correct' : after.wrong ? 'wrong' : 'progress';
    if(after.correct) problem++;

    // 5) 記録（オーバーレイ）
    const overlay = path.join(runDir, `overlay-${String(step).padStart(3,'0')}.png`);
    await drawOverlay(png, candidates.map(c => ({...c.rect})), clickPoint? [clickPoint]:[], overlay);

    log({ event:'step', action, outcome, screenshot: path.basename(png), overlay: path.basename(overlay), state: after });

    // スタック回避
    if(stuck && action.action==='wait'){
      const nx = candidates.find(c => LABELS.next.some(w => (c.text||'').toLowerCase().includes(w.toLowerCase()) || (c.aria||'').toLowerCase().includes(w.toLowerCase())));
      if(nx){ await page.mouse.click(nx.center.x, nx.center.y); }
    }
  }

  await browser.close();

  // 簡易レポート（Markdown）
  const md = [`# Visual QA Report`,
              `- URL: ${argv.url}`,
              `- Run: ${path.basename(runDir)}`,
              ``,
              `|Step|Problem|Outcome|Overlay|`,
              `|---:|---:|---|---|`];
  const lines = fs.readFileSync(logPath,'utf8').trim().split('\n').map(x=>JSON.parse(x));
  for(const ev of lines.filter(x=>x.event==='step')){
    md.push(`|${ev.step}|${ev.problem}|${ev.outcome}|![](${ev.overlay})|`);
  }
  fs.writeFileSync(path.join(runDir,'report.md'), md.join('\n'));
  console.log(`✅ Report: ${path.join(runDir,'report.md')}`);
}

main().catch(e=>{ console.error(e); process.exit(1); });
