import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/app_config.dart';
import '../debug/debug_menu_screen.dart';
import 'widgets/mode_card.dart';
import '../games/daily_challenge_screen.dart';
import '../screens/my_cards_screen.dart';
import '../components/user_info_header.dart';

/// ホーム画面（横固定レイアウト）
/// 構成：[ きょうのもんだい | まえのもんだい | ぼくのカード ]
class HomeLandscape extends ConsumerStatefulWidget {
  const HomeLandscape({super.key});

  @override
  ConsumerState<HomeLandscape> createState() => _HomeLandscapeState();
}

class _HomeLandscapeState extends ConsumerState<HomeLandscape> {
  // アプリ全体で一度だけ自動ジャンプするための静的フラグ
  static bool _hasEverJumped = false;
  
  @override
  void initState() {
    super.initState();

    try {
      // 設定に基づいて起動時にデバッグメニューへ自動遷移（アプリ全体で一度のみ）
      if (!_hasEverJumped && appConfig.jumpToDebugOnLaunch) {
        _hasEverJumped = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _navigateToDebugMenu();
          }
        });
      }
    } catch (e) {
      debugPrint('HomeLandscape initState error: $e');
    }
  }
  
  /// デバッグメニューへ遷移
  void _navigateToDebugMenu() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DebugMenuScreen()),
    );
  }
  
  /// 今日のレッスンへ遷移
  void _navigateToTodayLesson() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DailyChallengeScreen(),
        settings: const RouteSettings(name: '/daily_challenge'),
      ),
    );
  }
  
  /// カードコレクションへ遷移
  void _navigateToCardCollection() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MyCardsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/menu/background_a.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // ユーザー情報ヘッダー（エラー時はスキップ）
                const UserInfoHeader(),

              // メインコンテンツ
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final size = constraints.biggest;
                    final isTablet = size.width > 600;
                    final cardSpacing = isTablet ? 20.0 : 12.0;
                    final padding = EdgeInsets.symmetric(
                      horizontal: isTablet ? 32.0 : 16.0,
                      vertical: isTablet ? 24.0 : 12.0,
                    );

                    return Padding(
                      padding: padding,
                      child: Column(
                        children: [
                          // モード選択カード
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                // 利用可能な高さから余白を引いた値を使用
                                final availableHeight = constraints.maxHeight - 20;
                                final cardSize = availableHeight.clamp(120.0, 220.0);

                                return Center(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        // きょうのもんだい
                                        SizedBox(
                                          width: cardSize,
                                          height: cardSize,
                                          child: ModeCard(
                                            title: 'きょうの\nもんだい',
                                            icon: Icons.school,
                                            accent: Colors.blue,
                                            onTap: _navigateToTodayLesson,
                                          ),
                                        ),
                                        SizedBox(width: cardSpacing),

                                        // まえのもんだい（クリック不可）
                                        SizedBox(
                                          width: cardSize,
                                          height: cardSize,
                                          child: ModeCard(
                                            title: 'まえの\nもんだい',
                                            icon: Icons.history,
                                          accent: Colors.green,
                                          onTap: null,  // クリック無効
                                          isDisabled: true,
                                        ),
                                      ),
                                      SizedBox(width: cardSpacing),

                                      // ぼくのカード
                                      SizedBox(
                                        width: cardSize,
                                        height: cardSize,
                                        child: ModeCard(
                                          title: 'ぼくの\nカード',
                                          icon: Icons.collections,
                                          accent: Colors.orange,
                                          onTap: _navigateToCardCollection,
                                        ),
                                      ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // バージョン表示
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'v1.0.0',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    } catch (e) {
      debugPrint('HomeLandscape build error: $e');
      // エラー時は簡単な画面を表示
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text('ホーム画面の読み込みに失敗しました'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const DebugMenuScreen()),
                  );
                },
                child: const Text('デバッグメニューに戻る'),
              ),
            ],
          ),
        ),
      );
    }
  }
}