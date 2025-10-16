// Service Worker for Flutter PWA
// Version: 1.0.0

const CACHE_NAME = 'flutter-app-cache-v1';
const OFFLINE_CACHE_NAME = 'flutter-app-offline-v1';
const DATA_CACHE_NAME = 'flutter-app-data-v1';

// キャッシュするリソース
const urlsToCache = [
  '/',
  '/index.html',
  '/main.dart.js',
  '/flutter.js',
  '/flutter_bootstrap.js',
  '/manifest.json',
  '/favicon.png',
  '/icons/Icon-192.png',
  '/icons/Icon-512.png',
  '/ort.min.js',
  '/mnist_ocr.js',
  // フォントやアセットも必要に応じて追加
];

// Service Worker のインストール
self.addEventListener('install', (event) => {
  console.log('[ServiceWorker] Install');

  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        console.log('[ServiceWorker] Caching app shell');
        return cache.addAll(urlsToCache);
      })
      .then(() => {
        // すぐにアクティベートする
        return self.skipWaiting();
      })
  );
});

// Service Worker のアクティベート
self.addEventListener('activate', (event) => {
  console.log('[ServiceWorker] Activate');

  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          // 古いキャッシュを削除
          if (cacheName !== CACHE_NAME &&
              cacheName !== OFFLINE_CACHE_NAME &&
              cacheName !== DATA_CACHE_NAME) {
            console.log('[ServiceWorker] Removing old cache:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    }).then(() => {
      // すぐにコントロールを取得
      return self.clients.claim();
    })
  );
});

// フェッチイベントの処理
self.addEventListener('fetch', (event) => {
  const { request } = event;
  const url = new URL(request.url);

  // APIリクエストの処理
  if (url.pathname.startsWith('/api/')) {
    event.respondWith(handleApiRequest(request));
    return;
  }

  // 静的リソースの処理（Cache First戦略）
  event.respondWith(
    caches.match(request)
      .then((response) => {
        if (response) {
          return response;
        }

        // キャッシュになければネットワークから取得
        return fetch(request).then((response) => {
          // レスポンスが有効でない場合はそのまま返す
          if (!response || response.status !== 200 || response.type === 'opaque') {
            return response;
          }

          // レスポンスをクローンしてキャッシュに保存
          const responseToCache = response.clone();

          caches.open(CACHE_NAME)
            .then((cache) => {
              cache.put(request, responseToCache);
            });

          return response;
        });
      })
      .catch(() => {
        // オフラインフォールバック
        if (request.destination === 'document') {
          return caches.match('/index.html');
        }
      })
  );
});

// APIリクエストの処理（Network First戦略）
async function handleApiRequest(request) {
  try {
    const response = await fetch(request);

    // レスポンスをキャッシュに保存
    if (response.status === 200) {
      const responseToCache = response.clone();
      const cache = await caches.open(DATA_CACHE_NAME);
      cache.put(request, responseToCache);
    }

    return response;
  } catch (error) {
    // ネットワークエラーの場合はキャッシュから取得
    const cachedResponse = await caches.match(request);
    if (cachedResponse) {
      return cachedResponse;
    }

    // キャッシュもない場合はエラーレスポンス
    return new Response(JSON.stringify({
      error: 'Offline',
      message: 'ネットワークに接続できません'
    }), {
      status: 503,
      headers: { 'Content-Type': 'application/json' }
    });
  }
}

// バックグラウンド同期
self.addEventListener('sync', (event) => {
  console.log('[ServiceWorker] Sync event:', event.tag);

  if (event.tag === 'sync-data') {
    event.waitUntil(syncData());
  }
});

// データ同期処理
async function syncData() {
  console.log('[ServiceWorker] Syncing data...');

  // IndexedDBからペンディングデータを取得して同期
  // 実装は後で追加

  return Promise.resolve();
}

// プッシュ通知（将来の実装用）
self.addEventListener('push', (event) => {
  console.log('[ServiceWorker] Push received');

  const title = 'Flutter App';
  const options = {
    body: event.data ? event.data.text() : '新しい通知があります',
    icon: '/icons/Icon-192.png',
    badge: '/icons/Icon-192.png'
  };

  event.waitUntil(
    self.registration.showNotification(title, options)
  );
});

// メッセージリスナー（アプリとの通信用）
self.addEventListener('message', (event) => {
  console.log('[ServiceWorker] Message received:', event.data);

  if (event.data.action === 'skipWaiting') {
    self.skipWaiting();
  }

  if (event.data.action === 'clearCache') {
    event.waitUntil(
      caches.keys().then((cacheNames) => {
        return Promise.all(
          cacheNames.map((cacheName) => {
            return caches.delete(cacheName);
          })
        );
      })
    );
  }
});