import 'dart:async';
import 'dart:html' as html if (dart.library.html) 'dart:html';
import 'dart:js' as js if (dart.library.js) 'dart:js';

import 'package:flutter/foundation.dart';

/// PWA（Progressive Web App）サービスマネージャー
/// Service Worker、インストール促進、オフライン対応を管理
class PWAService {
  static final PWAService _instance = PWAService._internal();

  factory PWAService() => _instance;

  PWAService._internal();

  // PWAインストール可能状態
  final _installAvailable = ValueNotifier<bool>(false);

  // オンライン状態
  final _isOnline = ValueNotifier<bool>(true);

  // Service Worker状態
  final _swState = ValueNotifier<ServiceWorkerState>(ServiceWorkerState.unknown);

  // アップデート可能状態
  final _updateAvailable = ValueNotifier<bool>(false);

  ValueNotifier<bool> get installAvailable => _installAvailable;
  ValueNotifier<bool> get isOnline => _isOnline;
  ValueNotifier<ServiceWorkerState> get swState => _swState;
  ValueNotifier<bool> get updateAvailable => _updateAvailable;

  /// PWAサービスを初期化
  Future<void> initialize() async {
    if (!kIsWeb) return;

    // オンライン/オフライン監視
    _setupOnlineListener();

    // PWAインストール監視
    _setupInstallListener();

    // Service Worker状態監視
    await _checkServiceWorkerState();

    // アップデート監視
    _setupUpdateListener();
  }

  /// オンライン/オフライン状態を監視
  void _setupOnlineListener() {
    _isOnline.value = html.window.navigator.onLine ?? true;

    html.window.addEventListener('online', (event) {
      _isOnline.value = true;
      print('PWAService: Online');
    });

    html.window.addEventListener('offline', (event) {
      _isOnline.value = false;
      print('PWAService: Offline');
    });
  }

  /// PWAインストール可能状態を監視
  void _setupInstallListener() {
    // カスタムイベントを監視
    html.window.addEventListener('pwa-install-available', (event) {
      _installAvailable.value = true;
      print('PWAService: Install available');
    });
  }

  /// Service Worker状態をチェック
  Future<void> _checkServiceWorkerState() async {
    if (html.window.navigator.serviceWorker == null) {
      _swState.value = ServiceWorkerState.unsupported;
      return;
    }

    final sw = html.window.navigator.serviceWorker!;

    // 現在の登録状態を確認
    final registrations = await sw.getRegistrations();

    if (registrations.isEmpty) {
      _swState.value = ServiceWorkerState.notInstalled;
    } else {
      final registration = registrations.first;

      if (registration.active != null) {
        _swState.value = ServiceWorkerState.active;
      } else if (registration.installing != null) {
        _swState.value = ServiceWorkerState.installing;
      } else if (registration.waiting != null) {
        _swState.value = ServiceWorkerState.waiting;
      } else {
        _swState.value = ServiceWorkerState.notInstalled;
      }
    }

    // 状態変化を監視
    sw.addEventListener('controllerchange', (event) {
      _checkServiceWorkerState();
    });
  }

  /// Service Workerアップデートを監視
  void _setupUpdateListener() {
    if (html.window.navigator.serviceWorker == null) return;

    html.window.navigator.serviceWorker!.ready.then((registration) {
      // アップデート確認
      registration.addEventListener('updatefound', (event) {
        final newWorker = registration.installing;
        if (newWorker != null) {
          newWorker.addEventListener('statechange', (event) {
            if (newWorker.state == 'installed' &&
                html.window.navigator.serviceWorker!.controller != null) {
              _updateAvailable.value = true;
              print('PWAService: Update available');
            }
          });
        }
      });
    });
  }

  /// PWAをインストール
  Future<bool> installPWA() async {
    if (!_installAvailable.value) {
      print('PWAService: Install not available');
      return false;
    }

    try {
      // JavaScript側のグローバル関数を呼び出し
      final result = await js.context.callMethod('installPWA');
      _installAvailable.value = false;
      return result as bool;
    } catch (e) {
      print('PWAService: Install failed: $e');
      return false;
    }
  }

  /// Service Workerを更新
  Future<void> updateServiceWorker() async {
    if (!_updateAvailable.value) return;

    final sw = html.window.navigator.serviceWorker;
    if (sw == null) return;

    final registration = await sw.ready;

    // 待機中のWorkerにスキップメッセージを送信
    registration.waiting?.postMessage({'action': 'skipWaiting'});

    // ページをリロード
    html.window.location.reload();
  }

  /// キャッシュをクリア
  Future<void> clearCache() async {
    final sw = html.window.navigator.serviceWorker;
    if (sw == null) return;

    final registration = await sw.ready;
    registration.active?.postMessage({'action': 'clearCache'});
  }

  /// Service Workerを登録解除
  Future<bool> unregisterServiceWorker() async {
    final sw = html.window.navigator.serviceWorker;
    if (sw == null) return false;

    try {
      final registrations = await sw.getRegistrations();
      for (final registration in registrations) {
        await registration.unregister();
      }
      _swState.value = ServiceWorkerState.notInstalled;
      return true;
    } catch (e) {
      print('PWAService: Unregister failed: $e');
      return false;
    }
  }

  /// PWAステータス情報を取得
  Map<String, dynamic> getStatus() {
    return {
      'installAvailable': _installAvailable.value,
      'isOnline': _isOnline.value,
      'serviceWorkerState': _swState.value.toString(),
      'updateAvailable': _updateAvailable.value,
      'isPWA': _isPWAMode(),
    };
  }

  /// PWAモードで実行中かチェック
  bool _isPWAMode() {
    // スタンドアロンモードで実行中かチェック
    final displayMode = html.window.matchMedia('(display-mode: standalone)').matches;

    // または、navigator.standaloneプロパティ（iOS Safari用）
    final isStandalone = js.context['navigator']['standalone'] as bool? ?? false;

    return displayMode || isStandalone;
  }

  /// ストレージ使用量を取得
  Future<StorageEstimate?> getStorageEstimate() async {
    if (html.window.navigator.storage == null) return null;

    try {
      final estimate = await html.window.navigator.storage!.estimate();
      return StorageEstimate(
        usage: (estimate?['usage'] as int?) ?? 0,
        quota: (estimate?['quota'] as int?) ?? 0,
      );
    } catch (e) {
      print('PWAService: Failed to get storage estimate: $e');
      return null;
    }
  }

  /// 永続ストレージを要求
  Future<bool> requestPersistentStorage() async {
    if (html.window.navigator.storage == null) return false;

    try {
      final result = await html.window.navigator.storage!.persist();
      return result;
    } catch (e) {
      print('PWAService: Failed to request persistent storage: $e');
      return false;
    }
  }

  /// 永続ストレージ状態を確認
  Future<bool> isPersistentStorage() async {
    if (html.window.navigator.storage == null) return false;

    try {
      final result = await html.window.navigator.storage!.persisted();
      return result;
    } catch (e) {
      print('PWAService: Failed to check persistent storage: $e');
      return false;
    }
  }

  /// バックグラウンド同期を要求
  Future<void> requestBackgroundSync(String tag) async {
    final sw = html.window.navigator.serviceWorker;
    if (sw == null) return;

    try {
      final registration = await sw.ready;

      // Background Sync APIが利用可能か確認
      if (js.context['SyncManager'] != null) {
        await registration.sync?.register(tag);
        print('PWAService: Background sync registered: $tag');
      }
    } catch (e) {
      print('PWAService: Background sync failed: $e');
    }
  }

  /// プッシュ通知の許可を要求
  Future<bool> requestNotificationPermission() async {
    try {
      final permission = await html.Notification.requestPermission();
      return permission == 'granted';
    } catch (e) {
      print('PWAService: Notification permission failed: $e');
      return false;
    }
  }

  /// テスト通知を送信
  Future<void> showTestNotification() async {
    if (html.Notification.permission != 'granted') {
      print('PWAService: Notification permission not granted');
      return;
    }

    try {
      final notification = html.Notification(
        'Flutter App',
        body: 'テスト通知です',
        icon: '/icons/Icon-192.png',
      );

      // 3秒後に自動で閉じる
      Timer(Duration(seconds: 3), () {
        notification.close();
      });
    } catch (e) {
      print('PWAService: Show notification failed: $e');
    }
  }

  /// クリーンアップ
  void dispose() {
    _installAvailable.dispose();
    _isOnline.dispose();
    _swState.dispose();
    _updateAvailable.dispose();
  }
}

/// Service Worker状態
enum ServiceWorkerState {
  unsupported,
  notInstalled,
  installing,
  waiting,
  active,
  unknown,
}

/// ストレージ使用量情報
class StorageEstimate {
  final int usage;
  final int quota;

  StorageEstimate({
    required this.usage,
    required this.quota,
  });

  double get usagePercentage => quota > 0 ? (usage / quota) * 100 : 0;

  String get usageFormatted => _formatBytes(usage);
  String get quotaFormatted => _formatBytes(quota);

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}