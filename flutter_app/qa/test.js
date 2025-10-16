const puppeteer = require('puppeteer');
const { KnownDevices } = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({ headless: false });
  const page = await browser.newPage();

  // iPhone 12 Pro の設定を取得
  const iPhone12Pro = KnownDevices['iPhone 12 Pro'];

  // 横向きにエミュレート
  await page.emulate({
    ...iPhone12Pro,
    viewport: {
      ...iPhone12Pro.viewport,
      width: iPhone12Pro.viewport.height,
      height: iPhone12Pro.viewport.width,
      isLandscape: true
    }
  });

  // Flutter Web の固定ポートURL
  await page.goto('http://localhost:8080', { waitUntil: 'networkidle2' });

  // ページが完全に読み込まれるまで待機
  await new Promise(resolve => setTimeout(resolve, 3000));

  // スクリーンショット保存
  await page.screenshot({ path: 'flutter-iphone12-landscape.png' });

  console.log('✅ スクリーンショット保存完了: flutter-iphone12-landscape.png');

  await browser.close();
})();
