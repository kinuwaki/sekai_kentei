import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../games/base/navigation_utils.dart';
import 'common_game_result.dart';

/// 全ミニゲーム共通の結果画面
class GameResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final VoidCallback onRetry;
  final VoidCallback? onHome;
  final VoidCallback? onBack;

  const GameResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.onRetry,
    this.onHome,
    this.onBack,
  });
  
  @override
  Widget build(BuildContext context) {
    return CommonGameResult.withScore(
      score: score,
      totalQuestions: totalQuestions,
      onRetry: onRetry,
      onBack: onBack ?? () {
        // デフォルトの戻る処理
        if (onHome != null) {
          onHome!();
        } else {
          // 統一されたナビゲーション処理を使用（開発環境ではデバッグメニュー、本番ではメインメニュー）
          GameNavigationUtils.handleBackPress(context);
        }
      },
    );
  }
}