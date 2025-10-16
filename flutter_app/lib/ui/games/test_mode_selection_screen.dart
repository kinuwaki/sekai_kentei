import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sekai_kentei_game/sekai_kentei_screen.dart';
import 'sekai_kentei_game/models/sekai_kentei_models.dart';

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
                    '実力テスト',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1976D2),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '問題数を選んで開始',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF424242),
                    ),
                  ),
                  const SizedBox(height: 48),

                  // 3つのテストオプション
                  _buildTestButton('20問テスト', 20, 600),
                  const SizedBox(height: 16),
                  _buildTestButton('50問テスト', 50, 1500),
                  const SizedBox(height: 16),
                  _buildTestButton('100問テスト', 100, 3000),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (index) {
          if (index == 2) {
            // テストタブ - 現在の画面なので何もしない
            return;
          }
          // その他のタブは前の画面に戻る
          Navigator.pop(context);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.school, size: 24),
            label: '問題演習',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_edu, size: 24),
            label: '復習',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment, size: 24),
            label: 'テスト',
          ),
        ],
      ),
    );
  }

  Widget _buildTestButton(String label, int questionCount, int timeLimitSeconds) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ElevatedButton(
        onPressed: () => _startTest(questionCount, timeLimitSeconds),
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
          label,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
