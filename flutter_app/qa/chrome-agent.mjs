#!/usr/bin/env node
// Chrome QA Agent (Chromium + Playwright)
// 検出: 48px未満/8px未満/overflow/はみ出し/低コントラスト/重なり
import { chromium } from 'playwright';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import yargs from 'yargs';
import { hideBin } from 'yargs/helpers';
import sharp from 'sharp';

const argv = yargs(hideBin(process.argv))
  .option('url', { type: 'string', demandOption: true })
  .option('out', { type: 'string', default: './qa_out' })
  .option('width', { type: 'number', default: 1280 })
  .option('height', { type: 'number', default: 800 })
  .option('dpr', { type: 'number', default: 1 })
  .option('wait', { type: 'number', default: 1200 })
  .option('timeout', { type: 'number', default: 30000 })
  .option('headful', { type: 'boolean', default: false })
  .option('max-issues', { type: 'number', default: null, describe: '閾値超で非0終了' })
  .argv;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const ensureDir = p => fs.mkdirSync(p, { recursive: true });

function luminance([r, g, b]) {
  const s = [r, g, b].map(v => v / 255).map(c => c <= 0.03928 ? c / 12.92 : Math.pow((c + 0.055) / 1.055, 2.4));
  return 0.2126 * s[0] + 0.7152 * s[1] + 0.0722 * s[2];
}
function contrastRatio(fg, bg) {
  const L1 = luminance(fg), L2 = luminance(bg);
  const hi = Math.max(L1, L2), lo = Math.min(L1, L2);
  return (hi + 0.05) / (lo + 0.05);
}
function parseCssRgb(css) {
  if (!css) return [0, 0, 0];
  const m = css.match(/\((\d+),\s*(\d+),\s*(\d+)/);
  if (m) return [parseInt(m[1]), parseInt(m[2]), parseInt(m[3])];
  return [0, 0, 0];
}
function escapeXml(str) {
  return str
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
}

async function main() {
  ensureDir(argv.out);
  const browser = await chromium.launch({ headless: !argv.headful });
  const ctx = await browser.newContext({
    viewport: { width: argv.width, height: argv.height },
    deviceScaleFactor: argv.dpr
  });
  const page = await ctx.newPage();
  page.setDefaultTimeout(argv.timeout);

  await page.goto(argv.url, { waitUntil: 'networkidle' });
  await page.waitForTimeout(argv.wait);

  // 生スクショ
  const screenPng = path.join(argv.out, 'screen.png');
  await page.screenshot({ path: screenPng });

  // DOM解析
  const result = await page.evaluate(() => {
    const issues = [];
    const visible = el => {
      const cs = getComputedStyle(el);
      if (cs.display === 'none' || cs.visibility === 'hidden' || parseFloat(cs.opacity) === 0) return false;
      const r = el.getBoundingClientRect();
      return r.width > 0 && r.height > 0;
    };
    const bgOf = el => {
      let e = el;
      while (e && e !== document.documentElement) {
        const bg = getComputedStyle(e).backgroundColor;
        if (bg && !bg.includes('rgba(0, 0, 0, 0)') && !bg.includes('transparent')) return bg;
        e = e.parentElement;
      }
      return getComputedStyle(document.body).backgroundColor || 'rgb(255,255,255)';
    };

    const clickables = Array.from(document.querySelectorAll([
      'button', '[role="button"]', 'a[href]',
      'input[type="button"]', 'input[type="submit"]',
      '[onclick]', '[tabindex]'
    ].join(','))).filter(visible).map(el => ({ el, r: el.getBoundingClientRect() }));

    // 1) タップ領域 / はみ出し
    for (const { el, r } of clickables) {
      const w = Math.round(r.width), h = Math.round(r.height);
      if (w < 48 || h < 48) {
        issues.push({
          type: 'tap-target-too-small', severity: 'high',
          rect: { x: r.x, y: r.y, w: r.width, h: r.height },
          msg: `タップ領域が小さい ${w}x${h} (<48px)`,
          selectorHint: el.outerHTML.slice(0, 120)
        });
      }
      if (r.left < 0 || r.top < 0 || r.right > innerWidth || r.bottom > innerHeight) {
        issues.push({
          type: 'off-viewport', severity: 'medium',
          rect: { x: r.x, y: r.y, w: r.width, h: r.height },
          msg: '要素がビューポート外にはみ出し',
          selectorHint: el.outerHTML.slice(0, 120)
        });
      }
    }

    // 2) 近接 <8px
    const minGap = 8;
    for (let i = 0; i < clickables.length; i++) {
      for (let j = i + 1; j < clickables.length; j++) {
        const a = clickables[i].r, b = clickables[j].r;
        const dx = Math.max(0, Math.max(a.left, b.left) - Math.min(a.right, b.right));
        const dy = Math.max(0, Math.max(a.top, b.top) - Math.min(a.bottom, b.bottom));
        const gap = Math.hypot(dx, dy);
        if (gap < minGap) {
          issues.push({
            type: 'tap-target-too-close', severity: 'medium',
            rect: { x: (a.left + b.left) / 2, y: (a.top + b.top) / 2, w: 1, h: 1 },
            msg: `クリックターゲット間隔が狭い (<${minGap}px)`,
            selectorHint: clickables[i].el.outerHTML.slice(0, 120) + ' ... ' + clickables[j].el.outerHTML.slice(0, 120)
          });
        }
      }
    }

    // 3) テキスト系
    const textEls = Array.from(document.querySelectorAll('*')).filter(el => {
      if (!visible(el)) return false;
      return Array.from(el.childNodes).some(n => n.nodeType === Node.TEXT_NODE && (n.nodeValue || '').trim().length > 0);
    });

    const textRects = [];

    for (const el of textEls) {
      const cs = getComputedStyle(el);
      const r = el.getBoundingClientRect();
      textRects.push({ el, r });

      const overflowHidden = ['hidden', 'clip'].includes(cs.overflow) || ['hidden', 'clip'].includes(cs.overflowX) || ['hidden', 'clip'].includes(cs.overflowY);
      const scrollH = el.scrollHeight, clientH = el.clientHeight;
      const scrollW = el.scrollWidth, clientW = el.clientWidth;
      if ((overflowHidden || cs.textOverflow === 'ellipsis') && (scrollH - clientH > 1 || scrollW - clientW > 1)) {
        issues.push({
          type: 'text-truncated', severity: 'high',
          rect: { x: r.x, y: r.y, w: r.width, h: r.height },
          msg: 'テキストが切れている可能性（overflow/ellipsis）',
          selectorHint: el.outerHTML.slice(0, 120)
        });
      }
      if (r.left < 0 || r.top < 0 || r.right > innerWidth || r.bottom > innerHeight) {
        issues.push({
          type: 'text-off-viewport', severity: 'medium',
          rect: { x: r.x, y: r.y, w: r.width, h: r.height },
          msg: 'テキストがビューポート外にはみ出し',
          selectorHint: el.outerHTML.slice(0, 120)
        });
      }

      // 低コントラスト
      const fg = getComputedStyle(el).color;
      const bg = bgOf(el);
      const fgArr = (fg.match(/\d+/g) || []).map(Number);
      const bgArr = (bg.match(/\d+/g) || []).map(Number);
      if (fgArr.length >= 3 && bgArr.length >= 3) {
        const fs = parseFloat(cs.fontSize || '16');
        const bold = (parseInt(cs.fontWeight || '400', 10) >= 700);
        const isLarge = fs >= 24 || (bold && fs >= 18.66);
        const ratio = (() => {
          const l1 = (() => {
            const f = fgArr.map(v => v / 255).map(c => c <= 0.03928 ? c / 12.92 : Math.pow((c + 0.055) / 1.055, 2.4));
            return 0.2126 * f[0] + 0.7152 * f[1] + 0.0722 * f[2];
          })();
          const l2 = (() => {
            const b = bgArr.map(v => v / 255).map(c => c <= 0.03928 ? c / 12.92 : Math.pow((c + 0.055) / 1.055, 2.4));
            return 0.2126 * b[0] + 0.7152 * b[1] + 0.0722 * b[2];
          })();
          const hi = Math.max(l1, l2), lo = Math.min(l1, l2);
          return (hi + 0.05) / (lo + 0.05);
        })();
        const threshold = isLarge ? 3.0 : 4.5;
        if (ratio < threshold) {
          issues.push({
            type: 'low-contrast', severity: 'high',
            rect: { x: r.x, y: r.y, w: r.width, h: r.height },
            msg: `コントラスト不足: ${ratio.toFixed(2)} (< ${threshold})`,
            selectorHint: el.outerHTML.slice(0, 120)
          });
        }
      }
    }

    // 4) 簡易重なり（テキスト矩形の交差）
    for (let i = 0; i < textRects.length; i++) {
      for (let j = i + 1; j < textRects.length; j++) {
        const a = textRects[i].r, b = textRects[j].r;
        const overlap = !(a.right <= b.left || b.right <= a.left || a.bottom <= b.top || b.bottom <= a.top);
        if (overlap) {
          const ix = Math.max(a.left, b.left), iy = Math.max(a.top, b.top);
          const iw = Math.min(a.right, b.right) - ix, ih = Math.min(a.bottom, b.bottom) - iy;
          if (iw > 2 && ih > 2) {
            issues.push({
              type: 'overlap', severity: 'low',
              rect: { x: ix, y: iy, w: iw, h: ih },
              msg: 'テキスト領域が重なっている可能性',
              selectorHint: textRects[i].el.outerHTML.slice(0, 120) + ' ... ' + textRects[j].el.outerHTML.slice(0, 120)
            });
          }
        }
      }
    }

    return {
      issues,
      viewport: { w: innerWidth, h: innerHeight, dpr: devicePixelRatio || 1 }
    };
  });

  // レポート組み立て
  const report = {
    meta: {
      url: argv.url,
      viewport: { w: argv.width, h: argv.height, dpr: argv.dpr },
      timestamp: new Date().toISOString()
    },
    issues: result.issues,
    stats: result.issues.reduce((acc, it) => {
      acc[it.severity] = (acc[it.severity] || 0) + 1;
      return acc;
    }, { high: 0, medium: 0, low: 0 })
  };

  const reportPath = path.join(argv.out, 'report.json');
  fs.writeFileSync(reportPath, JSON.stringify(report, null, 2));

  // overlay描画（sharpを使用してシンプルに）
  const overlayPath = path.join(argv.out, 'overlay.png');
  const metadata = await sharp(screenPng).metadata();

  // SVGで矩形とラベルを描画
  const svgRects = report.issues.map((it, idx) => {
    const colorOf = (sev) => sev === 'high' ? '#ff0000' : sev === 'medium' ? '#ffa500' : '#ffff00';
    const color = colorOf(it.severity);
    const { x, y, w, h } = it.rect;
    const label = escapeXml(`${it.type}: ${it.msg}`.slice(0, 60));
    return `
      <rect x="${x}" y="${y}" width="${w}" height="${h}"
        fill="${color}" fill-opacity="0.15" stroke="${color}" stroke-width="2"/>
      <rect x="${x}" y="${Math.max(0, y - 22)}" width="${label.length * 7 + 8}" height="20"
        fill="${color}" fill-opacity="0.85"/>
      <text x="${x + 4}" y="${Math.max(14, y - 6)}" font-size="12" fill="white">${label}</text>
    `;
  }).join('');

  const svg = `
    <svg width="${metadata.width}" height="${metadata.height}">
      ${svgRects}
    </svg>
  `;

  await sharp(screenPng)
    .composite([{ input: Buffer.from(svg), top: 0, left: 0 }])
    .toFile(overlayPath);

  await browser.close();

  // 失敗条件
  const total = report.issues.length;
  const high = report.stats.high || 0;
  const maxIssues = argv['max-issues'];
  if (high > 0 || (maxIssues !== null && total > maxIssues)) {
    console.error(`[QA] Fail: high=${high}, total=${total}, maxIssues=${maxIssues}`);
    process.exit(1);
  } else {
    console.log(`[QA] Pass: high=${high}, total=${total}`);
  }
}

main().catch(err => {
  console.error(err);
  process.exit(2);
});
