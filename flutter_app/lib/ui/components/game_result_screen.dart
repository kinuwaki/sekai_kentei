import 'package:flutter/material.dart';
import '../games/base/navigation_utils.dart';

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
    final percentage = (score / totalQuestions * 100).round();
    final handleBack = onBack ?? () {
      // デフォルトの戻る処理
      if (onHome != null) {
        onHome!();
      } else {
        // 統一されたナビゲーション処理を使用（開発環境ではデバッグメニュー、本番ではメインメニュー）
        GameNavigationUtils.handleBackPress(context);
      }
    };

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // タイトル
          const Text(
            'ゲーム終了',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1976D2),
            ),
          ),
          const SizedBox(height: 40),

          // スコア表示
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'あなたのスコア',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '$score / $totalQuestions',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1976D2),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '正答率: $percentage%',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // もう一度ボタン
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B9BD5),
                foregroundColor: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'もう一度',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 戻るボタン
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: handleBack,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF5B9BD5),
                side: const BorderSide(
                  color: Color(0xFF5B9BD5),
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                '戻る',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}