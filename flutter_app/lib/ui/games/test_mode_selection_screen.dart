import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sekai_kentei_game/sekai_kentei_screen.dart';
import 'sekai_kentei_game/models/sekai_kentei_models.dart';
import '../theme/app_theme.dart';

/// テストモード選択画面（実力テスト）
class TestModeSelectionScreen extends ConsumerStatefulWidget {
  const TestModeSelectionScreen({super.key});

  @override
  ConsumerState<TestModeSelectionScreen> createState() => _TestModeSelectionScreenState();
}

class _TestModeSelectionScreenState extends ConsumerState<TestModeSelectionScreen> {
  /// テスト開始
  void _startTest(int questionCount, int timeLimitSeconds) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SekaiKenteiScreen(
          themeKey: '全問題',
          questionCount: questionCount,
          mode: QuizMode.test,
          timeLimitSeconds: timeLimitSeconds,
          initialSettings: SekaiKenteiSettings(theme: QuizTheme.basic),
        ),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              padding: const EdgeInsets.all(AppSizes.paddingLarge),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '実力テスト',
                    style: AppTextStyles.title,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.paddingMedium),
                  const Text(
                    '問題数を選んで開始',
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: 48),

                  // 3つのテストオプション
                  _buildTestButton('20問テスト', 20, 600),
                  const SizedBox(height: AppSizes.paddingMedium),
                  _buildTestButton('50問テスト', 50, 1500),
                  const SizedBox(height: AppSizes.paddingMedium),
                  _buildTestButton('100問テスト', 100, 3000),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTestButton(String label, int questionCount, int timeLimitSeconds) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeightLarge,
      child: ElevatedButton(
        onPressed: () => _startTest(questionCount, timeLimitSeconds),
        style: AppButtonStyles.primaryLarge,
        child: Text(
          label,
          style: AppTextStyles.buttonLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
