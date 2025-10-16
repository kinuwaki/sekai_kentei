import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../games/counting_game/counting_game_settings_screen.dart';
import '../games/comparison_game/comparison_game_settings_screen.dart';
import '../games/writing_game/writing_practice_screen.dart';
import '../games/writing_game/writing_practice_settings.dart';
import '../games/writing_game/writing_game_models.dart';
import '../games/puzzle_game/puzzle_game_screen.dart';
import '../games/shape_matching_game/shape_matching_screen.dart';
import '../games/number_recognition_game/number_recognition_game_screen.dart';
import '../games/odd_even_game/odd_even_settings_screen.dart';
import '../games/size_comparison_game/size_comparison_screen.dart';
import '../games/figure_orientation_game/figure_orientation_game_screen.dart';
import '../games/word_game/word_game_screen.dart';
import '../games/tsumiki_counting_game/tsumiki_counting_game_screen.dart';
import '../games/dot_copy_game/dot_copy_game_screen.dart';
import '../games/word_trace_game/word_trace_game_screen.dart';
import '../games/pattern_matching_game/pattern_matching_screen.dart';
import '../games/pattern_matching_game/models/pattern_matching_models.dart';
import '../games/instant_memory_game/instant_memory_screen.dart';
import '../games/placement_memory_game/placement_memory_screen.dart';
import '../games/word_fill_game/word_fill_screen.dart';
import '../games/shiritori_maze_game/shiritori_maze_screen.dart';
import '../games/janken_game/janken_game_screen.dart';
import '../home/landscape_home.dart';
import '../onboarding/app_initializer.dart';
import '../../config/app_config.dart';
import '../../core/lesson/lesson_loader.dart';
import '../../core/lesson/lesson_exporter.dart';
import '../../services/user_data_manager.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'dart:convert' show utf8;
import 'package:shared_preferences/shared_preferences.dart';

class DebugMenuScreen extends StatelessWidget {
  const DebugMenuScreen({super.key});

  /// 全データをリセット
  Future<void> _resetAllData(BuildContext context) async {
    // 確認ダイアログを表示
    final shouldReset = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('データリセット確認'),
          content: const Text('すべてのユーザーデータと設定を削除します。この操作は取り消せません。\n\n実行しますか？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('キャンセル'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('リセット', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );

    if (shouldReset != true) return;

    try {
      // UserDataManagerでデータをリセット
      await UserDataManager().resetAllData();

      // SharedPreferencesからも古い形式のデータを削除
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_first_launch', true);
      await prefs.remove('user_name');
      await prefs.remove('user_age_years');
      await prefs.remove('user_age_months');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('すべてのデータをリセットしました。アプリを再起動すると初回設定画面が表示されます。'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('データリセットエラー: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// ゲーム設定カタログをJSONでエクスポート
  Future<void> _exportLessonsToJson(BuildContext context) async {
    try {
      // ゲーム設定カタログを生成
      final catalog = LessonExporter.exportGameSettingsCatalog();
      
      // JSON文字列に変換（見やすい形式）
      const encoder = JsonEncoder.withIndent('  ');
      final catalogJson = encoder.convert(catalog);

      // ファイル保存処理
      String savedPath = '';
      if (kIsWeb) {
        // Web版は現在サポートしていません
        savedPath = 'Web版では現在利用できません';
      } else {
        // デスクトップ/モバイル版はassetsフォルダのみ更新
        try {
          // assetsフォルダ更新（開発用）
          final assetsFile = File('flutter_app/assets/lessons/game_settings_catalog.json');
          if (await assetsFile.parent.exists()) {
            await assetsFile.writeAsString(catalogJson);
            savedPath = 'assets/lessons/game_settings_catalog.json';
          } else {
            savedPath = 'assets更新スキップ（フォルダなし）';
          }
        } catch (e) {
          savedPath = 'assets更新失敗: $e';
        }
      }

      // 完了通知
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ゲーム設定カタログを保存: $savedPath'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
          ),
        );
      }
      
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('エクスポートエラー: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 左上の小さなヘッダー
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purple.shade400, Colors.blue.shade600],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.games,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ミニゲーム集',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'デバッグメニュー',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // ゲームグリッド
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // 画面幅に応じて列数を動的に決定（さらに多く表示）
                      final crossAxisCount = constraints.maxWidth > 800 ? 8 : 
                                           constraints.maxWidth > 600 ? 6 : 5;
                      return GridView.count(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                        childAspectRatio: 1.3,
                    children: [
                      _buildGameCard(
                        context,
                        title: 'ドットかぞえ',
                        icon: Icons.quiz,
                        color: Colors.purple,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CountingGameSettingsScreen()),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'おおきい\nちいさい',
                        icon: Icons.compare_arrows,
                        color: Colors.teal,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ComparisonGameSettingsScreen()),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'もじれんしゅう',
                        icon: Icons.edit,
                        color: Colors.indigo,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProviderScope(
                              overrides: [
                                writingPracticeSettingsProvider.overrideWith((ref) =>
                                  WritingPracticeSettings(
                                    character: 'あ', // デフォルト文字
                                    sequence: [WritingMode.tracing, WritingMode.tracingFree, WritingMode.freeWrite],
                                  ),
                                ),
                              ],
                              child: const WritingPracticeScreen(),
                            ),
                          ),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'ばらばら\nパズル',
                        icon: Icons.extension,
                        color: Colors.amber,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PuzzleGameScreen()),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'かたちさがし',
                        icon: Icons.grid_view,
                        color: Colors.deepOrange,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ShapeMatchingScreen()),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'たしひきさゆう',
                        icon: Icons.edit_outlined,
                        color: Colors.pink,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const NumberRecognitionGameScreen()),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'きすうぐうすう',
                        icon: Icons.numbers,
                        color: Colors.teal,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const OddEvenSettingsScreen()),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'なんばんめ',
                        icon: Icons.view_in_ar,
                        color: Colors.purple,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SizeComparisonScreen()),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'ずけいむき\nまちがい',
                        icon: Icons.rotate_90_degrees_ccw,
                        color: Colors.cyan,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const FigureOrientationGameScreen()),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'たんご',
                        icon: Icons.photo_library,
                        color: Colors.pink,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const WordGameScreen()),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'つみき',
                        icon: Icons.view_in_ar,
                        color: Colors.brown,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const TsumikiCountingGameScreen()),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'ドット図形\n模写',
                        icon: Icons.grid_on,
                        color: Colors.lightBlue,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const DotCopyGameScreen()),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: '文字辿り',
                        icon: Icons.text_fields,
                        color: Colors.orange,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const WordTraceGameScreen()),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'きそくせい',
                        icon: Icons.pattern,
                        color: Colors.deepPurple,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PatternMatchingScreen(
                              initialSettings: PatternMatchingSettings(questionCount: 5),
                            ),
                          ),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'しゅんかん\nきおく',
                        icon: Icons.psychology,
                        color: Colors.pink,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const InstantMemoryScreen()),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'はいち\nきおく',
                        icon: Icons.grid_4x4,
                        color: Colors.green,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PlacementMemoryScreen()),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'ことば\nあなうめ',
                        icon: Icons.edit_note,
                        color: Colors.purple,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const WordFillScreen()),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'じゃんけん',
                        icon: Icons.front_hand,
                        color: Colors.orange,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const JankenGameScreen()),
                        ),
                      ),
                      _buildGameCard(
                        context,
                        title: 'しりとり\nめいろ',
                        icon: Icons.grid_3x3,
                        color: Colors.teal,
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ShiritoriMazeScreen()),
                        ),
                      ),
                      // 製品版モードでメインメニューへ
                      _buildGameCard(
                        context,
                        title: '製品版起動',
                        icon: Icons.rocket_launch,
                        color: Colors.green,
                        onPressed: () {
                          overrideToProductionMode();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const AppInitializer()),
                            (route) => false,
                          );
                        },
                      ),
                      _buildGameCard(
                        context,
                        title: 'ゲーム設定出力',
                        icon: Icons.download,
                        color: Colors.deepPurple,
                        onPressed: () => _exportLessonsToJson(context),
                      ),
                      _buildGameCard(
                        context,
                        title: 'データ\nリセット',
                        icon: Icons.restart_alt,
                        color: Colors.red,
                        onPressed: () => _resetAllData(context),
                      ),
                      _buildComingSoonCard(context),
                    ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  Widget _buildGameCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.8),
                color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComingSoonCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.add,
                size: 14,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'きっと',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}