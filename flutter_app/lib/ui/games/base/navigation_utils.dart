import 'package:flutter/material.dart';

/// ゲーム画面からの戻る処理を適切に実行するヘルパー関数
class GameNavigationUtils {
  /// 開発モードかどうかに応じて適切な戻る処理を実行
  ///
  /// 開発モード・本番モード問わず、シンプルに前の画面に戻る
  static void handleBackPress(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// ホーム画面に戻る処理（必要に応じて使用）
  static void handleHomePage(BuildContext context) {
    // メインメニューに戻る
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}