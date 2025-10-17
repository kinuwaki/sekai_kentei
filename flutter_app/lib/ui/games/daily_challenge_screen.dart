import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sekai_kentei_game/sekai_kentei_screen.dart';
import 'sekai_kentei_game/models/sekai_kentei_models.dart';

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
      height: 80,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5B9BD5),
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        ),
        child: Text(
          theme.displayName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFE3F2FD), // 薄い青色で統一
        child: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '世界検定４級',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1976D2),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'テーマを選んで開始',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF424242),
                    ),
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
