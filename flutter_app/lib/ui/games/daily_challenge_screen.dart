import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/game_header.dart';
import '../../core/lesson/lesson_loader.dart';
import '../../core/lesson/lesson_models.dart';
import '../../core/lesson/game_type_mapper.dart';
import '../../core/progress/game_progress_provider.dart';
import '../components/medal_display.dart';

/// デイリーチャレンジ画面（今日のレッスン）
/// ちえ、かず、もじの3つのカテゴリボタンを表示
class DailyChallengeScreen extends ConsumerStatefulWidget {
  const DailyChallengeScreen({super.key});

  @override
  ConsumerState<DailyChallengeScreen> createState() => _DailyChallengeScreenState();
}

class _DailyChallengeScreenState extends ConsumerState<DailyChallengeScreen> {
  Course4yo? _course;
  bool _loading = true;
  String? _currentCategory; // 現在プレイ中のカテゴリを追跡
  
  @override
  void initState() {
    super.initState();
    _loadCourse();
  }
  
  Future<void> _loadCourse() async {
    try {
      final course = await LessonLoader.loadCourse4yo();
      setState(() {
        _course = course;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('レッスンデータの読み込みに失敗しました: $e')),
        );
      }
    }
  }

  /// カテゴリゲームへの汎用遷移メソッド
  void _navigateToCategory(BuildContext context, String category) {
    if (_course == null) return;

    final lesson = _course!.currentLesson;
    final gameKey = '${category}_game'; // chie_game, kazu_game, moji_game

    final gameConfig = lesson[gameKey] as Map<String, dynamic>?;
    if (gameConfig == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${category}ゲームの設定が見つかりません')),
      );
      return;
    }

    // 動的にゲーム画面を生成
    final gameScreen = GameTypeMapper.createGameScreen(gameConfig);
    if (gameScreen == null) {
      final gameType = gameConfig['type'] as String? ?? '不明';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ゲームタイプ "$gameType" はサポートされていません')),
      );
      return;
    }

    // カテゴリを保存してからゲーム画面へ遷移
    _currentCategory = _getCategoryKey(category);
    print('DEBUG: Starting game for category: $_currentCategory');

    // ゲーム画面へ遷移
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => gameScreen,
        settings: RouteSettings(name: '/daily_${category}_game'),
      ),
    ).then((result) {
      // ゲーム画面から戻ってきた時の処理
      _onReturnFromGame(result);
    });
  }

  /// カテゴリキーを取得（chie -> ちえ）
  String _getCategoryKey(String category) {
    switch (category) {
      case 'chie':
        return 'ちえ';
      case 'kazu':
        return 'かず';
      case 'moji':
        return 'もじ';  // たんご → もじに修正
      default:
        return category;
    }
  }

  /// ゲームタイプからスクリーンショットパスを取得（例: figureOrientation.v1 -> figureOrientation.jpg）
  String? _getScreenshotPath(String gameType) {
    // .v1などのバージョンサフィックスを削除
    final baseName = gameType.replaceAll(RegExp(r'\.v\d+$'), '');

    // 利用可能なスクリーンショットファイルとのマッピング
    final availableScreenshots = {
      'counting': 'counting.jpg',
      'figureOrientation': 'figureOrientation.jpg',
      'shapeMatching': 'shapeMatching.jpg',
      'wordGame': 'wordGame.jpg',
      'writing': 'writing.jpg',
    };

    // 直接マッチする場合
    if (availableScreenshots.containsKey(baseName)) {
      return 'images/screenshot/${availableScreenshots[baseName]}';
    }

    // フォールバック: デフォルトのスクリーンショット
    return 'images/screenshot/$baseName.jpg';
  }

  /// カテゴリのゲーム設定からスクリーンショットパスを取得
  String? _getCategoryScreenshotPath(String category) {
    if (_course == null) return null;

    final lesson = _course!.currentLesson;
    final gameKey = '${category}_game';
    final gameConfig = lesson[gameKey] as Map<String, dynamic>?;

    if (gameConfig == null) return null;

    final gameType = gameConfig['type'] as String?;
    if (gameType == null) return null;

    return _getScreenshotPath(gameType);
  }

  /// ゲーム画面から戻ってきた時の処理
  void _onReturnFromGame(dynamic result) {
    if (_currentCategory != null) {
      print('DEBUG: Returned from game, category: $_currentCategory, result: $result');

      // ゲーム完了データがある場合は記録
      if (result is Map<String, dynamic> && result['completed'] == true) {
        final scoreRatio = result['scoreRatio'] as double;
        print('DEBUG: Recording completion - category: $_currentCategory, scoreRatio: $scoreRatio');

        // ゲーム完了を記録
        ref.read(gameProgressProvider.notifier).markGameCompleted(_currentCategory!, scoreRatio);
      }

      _currentCategory = null; // リセット
    }
  }

  /// ちえモードへ遷移
  void _navigateToWisdom(BuildContext context) => _navigateToCategory(context, 'chie');

  /// かずモードへ遷移
  void _navigateToNumbers(BuildContext context) => _navigateToCategory(context, 'kazu');
  
  /// もじモードへ遷移
  void _navigateToLetters(BuildContext context) => _navigateToCategory(context, 'moji');

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF4A90E2),
                Color(0xFF357ABD),
              ],
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      );
    }
    
    if (_course == null) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF4A90E2),
                Color(0xFF357ABD),
              ],
            ),
          ),
          child: const Center(
            child: Text(
              'レッスンデータを読み込めませんでした',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8BBD9), // pink-300
              Color(0xFFC084FC), // purple-300  
              Color(0xFF818CF8), // indigo-400
            ],
          ),
        ),
        child: Column(
          children: [
            // ヘッダーバー
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Stack(
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final gameProgress = ref.watch(gameProgressProvider);

                      // 完了したゲーム数を計算
                      int completedCount = 0;
                      if (gameProgress.getCompletionData('ちえ') != null) completedCount++;
                      if (gameProgress.getCompletionData('かず') != null) completedCount++;
                      if (gameProgress.getCompletionData('もじ') != null) completedCount++;

                      return GameHeader(
                        title: 'きょうのもんだい ４さい レベル１ ($completedCount/3)',
                        subtitle: '${_course?.currentDay ?? 1}にちめ',
                        onBack: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            
            // コンテンツエリア
            Expanded(
              child: SafeArea(
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
                          const SizedBox(height: 10),

                          // カテゴリ選択カード（上部に配置）
                          Expanded(
                            flex: 5,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final availableHeight = constraints.maxHeight - 10;
                                final cardSize = availableHeight.clamp(180.0, 280.0);
                                
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isTablet ? 32 : 16,
                                  ),
                                  child: Consumer(
                                    builder: (context, ref, child) {
                                      final gameProgress = ref.watch(gameProgressProvider);

                                      return Row(
                                        children: [
                                          // ちえモード - 紫→ピンクグラデーション
                                          Expanded(
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: _ModernCategoryCard(
                                                title: 'ちえ',
                                                icon: Icons.lightbulb_outline,
                                                gradientColors: [
                                                  const Color(0xFFAB47BC), // purple-400
                                                  const Color(0xFFEC407A), // pink-400
                                                ],
                                                onTap: () => _navigateToWisdom(context),
                                                completionData: gameProgress.getCompletionData('ちえ'),
                                                screenshotPath: _getCategoryScreenshotPath('chie'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: cardSpacing),

                                          // かずモード - 青→シアングラデーション
                                          Expanded(
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: _ModernCategoryCard(
                                                title: 'かず',
                                                icon: Icons.calculate_outlined,
                                                gradientColors: [
                                                  const Color(0xFF42A5F5), // blue-400
                                                  const Color(0xFF26C6DA), // cyan-400
                                                ],
                                                onTap: () => _navigateToNumbers(context),
                                                completionData: gameProgress.getCompletionData('かず'),
                                                screenshotPath: _getCategoryScreenshotPath('kazu'),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: cardSpacing),

                                          // もじモード - 緑→エメラルドグラデーション
                                          Expanded(
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: _ModernCategoryCard(
                                                title: 'もじ',
                                                icon: Icons.text_fields_outlined,
                                                gradientColors: [
                                                  const Color(0xFF66BB6A), // green-400
                                                  const Color(0xFF26A69A), // emerald-400
                                                ],
                                                onTap: () => _navigateToLetters(context),
                                                completionData: gameProgress.getCompletionData('もじ'),
                                                screenshotPath: _getCategoryScreenshotPath('moji'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),

                          // ごほうびモンスターガチャボタン
                          Padding(
                            padding: EdgeInsets.only(
                              top: isTablet ? 12 : 10,
                              bottom: isTablet ? 12 : 10,
                            ),
                            child: Consumer(
                              builder: (context, ref, child) {
                                final gameProgress = ref.watch(gameProgressProvider);

                                // 完了したゲーム数をカウント
                                int completedCount = 0;
                                if (gameProgress.getCompletionData('ちえ') != null) completedCount++;
                                if (gameProgress.getCompletionData('かず') != null) completedCount++;
                                if (gameProgress.getCompletionData('もじ') != null) completedCount++;

                                final isEnabled = completedCount >= 3;

                                return SizedBox(
                                  width: double.infinity,
                                  height: isTablet ? 60 : 55,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(16),
                                    elevation: 3,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(16),
                                      onTap: isEnabled ? () {
                                        // ガチャ画面への遷移
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('ごほうびモンスターガチャは準備中です！'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      } : null,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: isEnabled ? [
                                              const Color(0xFFFFC107), // Amber
                                              const Color(0xFFFF9800), // Orange
                                            ] : [
                                              Colors.grey.shade400,
                                              Colors.grey.shade500,
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(0.4),
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'ごほうびモンスターガチャ',
                                            style: TextStyle(
                                              fontSize: isTablet ? 20 : 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white.withOpacity(isEnabled ? 1 : 0.7),
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// モダンなカテゴリ選択カード（Figmaデザイン準拠）
class _ModernCategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Color> gradientColors;
  final VoidCallback onTap;
  final GameCompletionData? completionData;
  final String? screenshotPath;

  const _ModernCategoryCard({
    required this.title,
    required this.icon,
    required this.gradientColors,
    required this.onTap,
    this.completionData,
    this.screenshotPath,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = completionData != null;
    final fadeOpacity = isCompleted ? 0.6 : 1.0;


    return Material(
      borderRadius: BorderRadius.circular(24),
      elevation: 0,
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors.map((color) => color.withOpacity(fadeOpacity)).toList(),
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 16,
                offset: const Offset(0, 8),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Stack(
            children: [
              // スクリーンショット背景エリア（下部）
              if (screenshotPath != null)
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // 16:9の比率で高さを計算
                      final width = constraints.maxWidth;
                      final height = width * 9 / 16;

                      return Container(
                        width: width,
                        height: height,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            screenshotPath!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.white.withOpacity(0.1),
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.white70,
                                  size: 24,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

              // タイトルを上部に配置
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // アイコンをタイトルの下に配置
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      icon,
                      size: 36,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // 完了マーク（チェックマーク） - 右上に表示
              if (isCompleted)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),

              // 完了時のオーバーレイ
              if (isCompleted)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),

              // メダル表示 - 中央に大きく表示
              if (completionData != null)
                Center(
                  child: PreciseMedalDisplay(
                    medalLevel: completionData!.medalLevel,
                    size: 160,  // サイズを倍に戻す
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}