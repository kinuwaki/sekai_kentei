import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

// ビルド時の環境変数からフレーバーを取得（デフォルトは dev）
const _flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');

/// アプリケーション設定を管理するクラス
class AppConfig {
  /// 起動時に自動でデバッグメニューへ遷移するか
  final bool jumpToDebugOnLaunch;
  
  const AppConfig({
    required this.jumpToDebugOnLaunch,
  });

  /// JSONから設定を読み込み
  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      jumpToDebugOnLaunch: json['jumpToDebugOnLaunch'] == true,
    );
  }

  /// 現在のフレーバーを取得
  static String get flavor => _flavor;
  
  /// 開発環境かどうか
  static bool get isDev => _flavor == 'dev';
  
  /// ステージング環境かどうか  
  static bool get isStaging => _flavor == 'staging';
}

/// グローバルな設定インスタンス
AppConfig appConfig = const AppConfig(jumpToDebugOnLaunch: true); // デフォルトでデバッグメニュー（開発中）

/// 設定を初期化（main関数で呼び出す）
Future<void> initializeConfig() async {
  try {
    final jsonStr = await rootBundle.loadString('config.$_flavor.json');
    appConfig = AppConfig.fromJson(json.decode(jsonStr));

    // デバッグ出力
    if (kDebugMode) {
      print('🔧 AppConfig initialized:');
      print('  - Flavor: $_flavor');
      print('  - Jump to debug: ${appConfig.jumpToDebugOnLaunch}');
    }
  } catch (e) {
    if (kDebugMode) {
      print('🔧 AppConfig initialization failed, using defaults: $e');
      print('  - Flavor: $_flavor');
      print('  - Jump to debug: ${appConfig.jumpToDebugOnLaunch}');
    }
  }
}

/// デバッグメニューから製品版モードに切り替える
void overrideToProductionMode() {
  appConfig = const AppConfig(
    jumpToDebugOnLaunch: false,
  );
  if (kDebugMode) {
    print('🔧 AppConfig overridden to production mode');
  }
}