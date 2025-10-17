import 'package:flutter/material.dart';
import 'daily_challenge_screen.dart';
import 'review_screen.dart';
import 'test_mode_selection_screen.dart';

enum TabItem { practice, review, test }

/// メインタブ画面（問題演習/復習/テストの3つのタブを管理）
/// 各タブにネストされたNavigatorを配置し、BottomNavを常駐させる
class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  final _pageController = PageController();
  int _currentIndex = 0;

  // 各タブ専用の NavigatorKey
  final Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.practice: GlobalKey<NavigatorState>(),
    TabItem.review: GlobalKey<NavigatorState>(),
    TabItem.test: GlobalKey<NavigatorState>(),
  };

  // タブ再タップでスタックをrootまで戻す
  Future<void> _popToFirstRoute(TabItem item) async {
    final nav = _navigatorKeys[item]!.currentState;
    if (nav == null) return;
    while (nav.canPop()) {
      nav.pop();
    }
  }

  void _onTapBottomNav(int index) {
    final tapped = TabItem.values[index];
    if (_currentIndex == index) {
      // 同じタブをタップ → ルートまで戻す
      _popToFirstRoute(tapped);
    } else {
      // 別のタブに切り替える前に、現在のタブをルートまで戻す
      final currentTab = TabItem.values[_currentIndex];
      _popToFirstRoute(currentTab);

      setState(() => _currentIndex = index);
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  // Android戻るボタン対策：まず現在タブのNavigatorでpopを試みる
  Future<bool> _onWillPop() async {
    final currentTab = TabItem.values[_currentIndex];
    final nav = _navigatorKeys[currentTab]!.currentState;
    if (nav == null) return true;

    if (nav.canPop()) {
      nav.pop();
      return false; // アプリは閉じない
    }

    // 例えば：ホームタブへ戻す（現在がホームでなければ）
    if (_currentIndex != 0) {
      _onTapBottomNav(0);
      return false;
    }

    // それでもrootならアプリを閉じてよい
    return true;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildTabNavigator({
    required GlobalKey<NavigatorState> navigatorKey,
    required Widget root,
  }) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => root,
          settings: const RouteSettings(name: 'root'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(), // スワイプ禁止（仕様通り）
          children: [
            _buildTabNavigator(
              navigatorKey: _navigatorKeys[TabItem.practice]!,
              root: const DailyChallengeScreen(), // ← ルートは各タブのトップ
            ),
            _buildTabNavigator(
              navigatorKey: _navigatorKeys[TabItem.review]!,
              root: const ReviewScreen(),
            ),
            _buildTabNavigator(
              navigatorKey: _navigatorKeys[TabItem.test]!,
              root: const TestModeSelectionScreen(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTapBottomNav,
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
      ),
    );
  }
}
