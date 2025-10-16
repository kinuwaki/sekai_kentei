import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sekai_kentei_game/sekai_kentei_screen.dart';
import 'sekai_kentei_game/models/sekai_kentei_models.dart';
import 'review_screen.dart';
import 'test_mode_selection_screen.dart';

/// デイリーチャレンジ画面（世界遺産クイズ専用）
class DailyChallengeScreen extends ConsumerStatefulWidget {
  const DailyChallengeScreen({super.key});

  @override
  ConsumerState<DailyChallengeScreen> createState() => _DailyChallengeScreenState();
}

class _DailyChallengeScreenState extends ConsumerState<DailyChallengeScreen> {
  int _selectedIndex = 0;


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

  void _onTabTapped(int index) async {
    print('[DailyChallenge] _onTabTapped: index=$index, currentIndex=$_selectedIndex');

    // 現在のタブと同じタブをタップした場合は何もしない
    if (_selectedIndex == index) {
      print('[DailyChallenge] Same tab tapped, ignoring');
      return;
    }

    // タブに応じたアクションを実行
    switch (index) {
      case 0:
        // 問題演習 - 現在の画面なので何もしない
        print('[DailyChallenge] Tab 0 - staying on current screen');
        setState(() {
          _selectedIndex = 0;
        });
        break;
      case 1:
        print('[DailyChallenge] Tab 1 - navigating to Review');
        setState(() {
          _selectedIndex = 1;
        });
        final result = await Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const ReviewScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        // 戻ってきた時の処理
        if (mounted) {
          setState(() {
            _selectedIndex = 0;
          });
          print('[DailyChallenge] Returned from Review with result: $result');

          // 他のタブに遷移する必要があるかチェック
          if (result is Map && result['targetTabIndex'] != null) {
            final targetIndex = result['targetTabIndex'] as int;
            print('[DailyChallenge] Navigating to target tab: $targetIndex');
            _onTabTapped(targetIndex);
          }
        }
        break;
      case 2:
        print('[DailyChallenge] Tab 2 - navigating to Test');
        setState(() {
          _selectedIndex = 2;
        });
        final result = await Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const TestModeSelectionScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        // 戻ってきた時の処理
        if (mounted) {
          setState(() {
            _selectedIndex = 0;
          });
          print('[DailyChallenge] Returned from Test with result: $result');

          // 他のタブに遷移する必要があるかチェック
          if (result is Map && result['targetTabIndex'] != null) {
            final targetIndex = result['targetTabIndex'] as int;
            print('[DailyChallenge] Navigating to target tab: $targetIndex');
            _onTabTapped(targetIndex);
          }
        }
        break;
    }
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
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
}
