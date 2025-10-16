import 'dart:async';
import 'package:flutter/foundation.dart';

/// PWAサービスのスタブ実装（非Web環境用）
class PWAService {
  static final PWAService _instance = PWAService._internal();
  factory PWAService() => _instance;
  PWAService._internal();

  final _isOnline = ValueNotifier<bool>(true);
  final _installAvailable = ValueNotifier<bool>(false);
  final _swState = ValueNotifier<ServiceWorkerState>(ServiceWorkerState.unsupported);
  final _updateAvailable = ValueNotifier<bool>(false);
  final _pushPermission = ValueNotifier<PushPermission>(PushPermission.denied);

  ValueListenable<bool> get isOnline => _isOnline;
  ValueListenable<bool> get installAvailable => _installAvailable;
  ValueListenable<ServiceWorkerState> get swState => _swState;
  ValueListenable<bool> get updateAvailable => _updateAvailable;
  ValueListenable<PushPermission> get pushPermission => _pushPermission;

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized || !kIsWeb) return;
    _isInitialized = true;
  }

  Future<void> promptInstall() async {}
  Future<void> checkForUpdate() async {}
  Future<void> update() async {}
  Future<void> clearCache() async {}
  Future<PushPermission> requestPushPermission() async {
    return PushPermission.denied;
  }
  Future<void> showPushNotification(String title, String body) async {}
  void dispose() {}
}

enum ServiceWorkerState {
  unsupported,
  notRegistered,
  installing,
  waiting,
  active,
  redundant,
}

enum PushPermission {
  granted,
  denied,
  prompt,
}