import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sekai_kentei_game/sekai_kentei_screen.dart';
import 'sekai_kentei_game/models/sekai_kentei_models.dart';
import '../theme/app_theme.dart';

/// デイリーチャレンジ画面（世界遺産クイズ専用）
class DailyChallengeScreen extends ConsumerStatefulWidget {
  const DailyChallengeScreen({super.key});

  @override
  ConsumerState<DailyChallengeScreen> createState() => _DailyChallengeScreenState();
}

class _DailyChallengeScreenState extends ConsumerState<DailyChallengeScreen> {
  Widget _buildThemeButton({
    required QuizTheme theme,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeightLarge,
      child: ElevatedButton(
        onPressed: onPressed,
        style: AppButtonStyles.primaryLarge,
        child: Text(
          theme.displayName,
          style: AppTextStyles.buttonLarge,
          textAlign: TextAlign.center,
        ),
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
                    '世界検定４級',
                    style: AppTextStyles.title,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.paddingMedium),
                  const Text(
                    'テーマを選んで開始',
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: 48),

                  // 3つのテーマボタン
                  ...QuizTheme.values.map((theme) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildThemeButton(
                      theme: theme,
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => SekaiKenteiScreen(
                              themeKey: theme.displayName,
                              questionCount: 10,
                              mode: QuizMode.practice,
                              initialSettings: SekaiKenteiSettings(theme: theme),
                            ),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
