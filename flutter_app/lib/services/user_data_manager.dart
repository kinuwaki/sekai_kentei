import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/user_data.dart';
import 'storage/storage_simple.dart';
import 'storage/storage_interface.dart';

/// ユーザーデータマネージャー
/// ユーザーデータの読み書きと状態管理を行う
class UserDataManager extends ChangeNotifier {
  static final UserDataManager _instance = UserDataManager._internal();

  factory UserDataManager() => _instance;

  UserDataManager._internal();

  // ストレージサービス
  late final StorageInterface _storage;

  // 現在のユーザーデータ
  UserData? _currentUser;

  // 初期化状態
  bool _isInitialized = false;


  // Getters
  UserData? get currentUser => _currentUser;
  bool get isInitialized => _isInitialized;
  bool get isInitialSetupCompleted => _currentUser?.isInitialSetupCompleted ?? false;
  UserSettings get settings => _currentUser?.settings ?? const UserSettings();

  /// 初期化
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // ストレージサービスを取得
      _storage = SimpleStorageFactory.getInstance();

      // ユーザーデータを読み込み
      await _loadUserData();


      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('UserDataManager initialization failed: $e');
      // 新規ユーザーとして作成
      await _createNewUser();
    }
  }

  /// ユーザーデータを読み込み
  Future<void> _loadUserData() async {
    try {
      final settings = await _storage.loadSettings();

      if (settings.containsKey('userData')) {
        _currentUser = UserData.fromJson(settings['userData'] as Map<String, dynamic>);

        // 最終アクセス日時を更新
        _currentUser = _currentUser!.copyWith(
          lastAccessDate: DateTime.now(),
        );
      } else {
        // ユーザーデータがない場合は新規作成
        await _createNewUser();
      }
    } catch (e) {
      debugPrint('Failed to load user data: $e');
      await _createNewUser();
    }
  }

  /// 新規ユーザーを作成
  Future<void> _createNewUser() async {
    final uuid = const Uuid();
    final now = DateTime.now();

    _currentUser = UserData(
      userId: uuid.v4(),
      firstLaunchDate: now,
      lastAccessDate: now,
      isInitialSetupCompleted: false,
    );

    await _saveUserData();
    _isInitialized = true;
    notifyListeners();
  }

  /// ユーザーデータを保存
  Future<void> _saveUserData() async {
    if (_currentUser == null) return;

    try {
      final allSettings = await _storage.loadSettings();
      allSettings['userData'] = _currentUser!.toJson();
      await _storage.saveSettings(allSettings);

      debugPrint('User data saved successfully');
    } catch (e) {
      debugPrint('Failed to save user data: $e');
    }
  }


  /// 初期設定を完了
  Future<void> completeInitialSetup({
    String? userName,
    UserSettings? settings,
  }) async {
    if (_currentUser == null) return;

    _currentUser = _currentUser!.copyWith(
      isInitialSetupCompleted: true,
      userName: userName ?? _currentUser!.userName,
      settings: settings ?? _currentUser!.settings,
    );

    await _saveUserData();
    notifyListeners();
  }


  /// ユーザー名を更新
  Future<void> updateUserName(String userName) async {
    if (_currentUser == null) return;

    _currentUser = _currentUser!.copyWith(userName: userName);
    await _saveUserData();
    notifyListeners();
  }

  /// 設定を更新
  Future<void> updateSettings(UserSettings Function(UserSettings) updater) async {
    if (_currentUser == null) return;

    _currentUser = _currentUser!.copyWith(
      settings: updater(_currentUser!.settings),
    );

    await _saveUserData();
    notifyListeners();
  }

  /// ゲームプレイを記録
  Future<void> recordGamePlay(String gameId) async {
    if (_currentUser == null) return;

    final now = DateTime.now();

    // 総プレイ回数を更新
    _currentUser = _currentUser!.copyWith(
      totalGamesPlayed: _currentUser!.totalGamesPlayed + 1,
      lastAccessDate: now,
    );

    await _saveUserData();
    notifyListeners();
  }


  /// カスタムデータを保存
  Future<void> saveCustomData(String key, dynamic value) async {
    if (_currentUser == null) return;

    final customData = Map<String, dynamic>.from(_currentUser!.customData ?? {});
    customData[key] = value;

    _currentUser = _currentUser!.copyWith(customData: customData);
    await _saveUserData();
    notifyListeners();
  }

  /// カスタムデータを取得
  dynamic getCustomData(String key) {
    return _currentUser?.customData?[key];
  }

  /// 全データをエクスポート
  Future<Map<String, dynamic>> exportAllData() async {
    final userData = _currentUser?.toJson() ?? {};
    final storageData = await _storage.exportData();

    return {
      'userData': userData,
      'storageData': storageData,
      'exportedAt': DateTime.now().toIso8601String(),
      'version': '1.0.0',
    };
  }

  /// 全データをインポート
  Future<void> importAllData(Map<String, dynamic> data) async {
    try {
      // ユーザーデータのインポート
      if (data.containsKey('userData')) {
        _currentUser = UserData.fromJson(data['userData'] as Map<String, dynamic>);
      }

      // ストレージデータのインポート
      if (data.containsKey('storageData')) {
        await _storage.importData(data['storageData'] as Map<String, dynamic>);
      }

      await _saveUserData();
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to import data: $e');
      throw Exception('データのインポートに失敗しました');
    }
  }

  /// データをリセット
  Future<void> resetAllData() async {
    await _storage.clearAll();
    await _createNewUser();
  }

  /// クリーンアップ
  @override
  void dispose() {
    _saveUserData(); // 最後に保存
    super.dispose();
  }
}