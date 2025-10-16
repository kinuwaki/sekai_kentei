console.log('=== MNIST DEBUG START ===');

if (!window.ort) {
  console.error('ORT is UNDEFINED at mnist_ocr.js load time');
} else {
  console.log('ORT version:', window.ort.version || '(version unknown)');
}

// WASM設定を正しく設定（安定優先）
if (window.ort && window.ort.env) {
  window.ort.env.wasm.wasmPaths = './ort/';  // 末尾スラッシュ必須
  window.ort.env.wasm.numThreads = 1;        // COOP/COEP不要で安定
  window.ort.env.wasm.simd = false;          // 安全設定
}

// 初期化 Promise を "必ず" window に公開
window.mnistReady = (async function () {
  if (!window.ort) throw new Error('ort undefined');
  console.log('MNIST init: creating session...');
  
  // WASMプロバイダーを明示的に指定
  const session = await window.ort.InferenceSession.create('./mnist.onnx', {
    executionProviders: ['wasm']  // ブラウザ用はwasm（cpuではない）
  });
  window.__mnistSession = session;
  console.log('MNIST session created successfully');
})().catch(e => {
  console.error('MNIST init error:', e);
  window.__MNIST_INIT_ERROR = e;
  throw e;
});

// 28x28(784) の Float32Array を受け取り、{digit, score, margin} を返す
window.predictDigit28x28 = async function (float32Array) {
  await window.mnistReady;
  const s = window.__mnistSession;
  if (!s) throw new Error('session not ready');
  if (!float32Array || float32Array.length !== 784) {
    throw new Error('input must be Float32Array[784]');
  }
  const input = new window.ort.Tensor('float32', float32Array, [1, 1, 28, 28]);
  
  // モデルの入力名を動的に取得（Input3, input, Input などに対応）
  const inputName = s.inputNames[0];
  console.log('MNIST model input name:', inputName);
  
  const feeds = {};
  feeds[inputName] = input;
  const out = await s.run(feeds);              // 正しい入力名で実行
  const first = out[Object.keys(out)[0]];      // 最初の出力
  const logits = first.data;                   // Float32Array(10)

  let top = -Infinity, t2 = -Infinity, idx = 0;
  for (let i = 0; i < logits.length; i++) {
    const v = logits[i];
    if (v > top) { t2 = top; top = v; idx = i; }
    else if (v > t2) { t2 = v; }
  }
  return { digit: idx, score: top, margin: top - t2 };
};

// デバッグ用：状態確認関数
window.debugMNIST = function() {
  console.log('=== MNIST DEBUG INFO ===');
  console.log('ort:', window.ort);
  console.log('ort version:', window.ort?.version);
  console.log('mnistReady:', window.mnistReady);
  console.log('session:', window.__mnistSession);
  console.log('init error:', window.__MNIST_INIT_ERROR);
  
  // mnistReady の状態をチェック
  if (window.mnistReady) {
    window.mnistReady.then(() => {
      console.log('✓ MNIST is ready');
      console.log('✓ Session:', window.__mnistSession);
    }).catch(e => {
      console.error('✗ MNIST init failed:', e);
    });
  }
};

window.__MNIST_WIRED__ = true;
console.log('=== MNIST DEBUG WIRED ===');

// 自動的にデバッグ情報を表示
setTimeout(() => {
  console.log('=== AUTO DEBUG (after 1s) ===');
  window.debugMNIST();
}, 1000);