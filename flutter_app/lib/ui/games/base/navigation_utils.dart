import 'package:flutter/material.dart';
import '../../../config/app_config.dart';
import '../../debug/debug_menu_screen.dart';

/// ゲーム画面からの戻る処理を開発モードに応じて適切に実行するヘルパー関数
class GameNavigationUtils {
  /// 開発モードかどうかに応じて適切な戻る処理を実行
  /// 
  /// 開発モード（jumpToDebugOnLaunch = true）の場合：
  /// - DebugMenuScreenに戻る（履歴をクリア）
  /// 
  /// 本番モード（jumpToDebugOnLaunch = false）の場合：
  /// - 通常のNavigator.pop()を実行
  static void handleBackPress(BuildContext context) {
    // 開発環境・本番環境問わず、シンプルに前の画面に戻る
    Navigator.of(context).pop();
  }

  /// ホーム画面に戻る処理（必要に応じて使用）
  static void handleHomePage(BuildContext context) {
    if (appConfig.jumpToDebugOnLaunch) {
      // 開発環境ではデバッグメニューに戻る
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const DebugMenuScreen()),
        (route) => false,
      );
    } else {
      // 本番環境ではメインメニューに戻る
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }
}