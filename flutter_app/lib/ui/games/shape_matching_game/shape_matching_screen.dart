import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../base/base_game_screen.dart';
import '../base/common_game_phase.dart';
import '../../components/success_effect.dart';
import 'models/shape_matching_models.dart';
import 'modern_shape_matching_logic.dart';
import 'widgets/geo_shape_painter.dart';

class ShapeMatchingScreen extends BaseGameScreen<ShapeMatchingSettings, ShapeMatchingState, ModernShapeMatchingLogic> {
  const ShapeMatchingScreen({
    super.key,
    super.initialSettings,
  });

  @override
  BaseGameScreenState<ShapeMatchingScreen, ShapeMatchingSettings, ShapeMatchingState, ModernShapeMatchingLogic>
      createState() => _ShapeMatchingScreenState();
}

class _ShapeMatchingScreenState extends BaseGameScreenState<
    ShapeMatchingScreen,
    ShapeMatchingSettings,
    ShapeMatchingState,
    ModernShapeMatchingLogic> {
  
  @override
  String get gameTitle => 'かたちさがし';

  @override
  ShapeMatchingState watchState(WidgetRef ref) =>
      ref.watch(modernShapeMatchingLogicProvider);

  @override
  ModernShapeMatchingLogic readLogic(WidgetRef ref) =>
      ref.read(modernShapeMatchingLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(ShapeMatchingState s) {
    switch (s.phase) {
      case CommonGamePhase.ready:
        return GameUiPhase.settings;
      case CommonGamePhase.completed:
        return GameUiPhase.result;
      default:
        return GameUiPhase.playing;
    }
  }

  @override
  ShapeMatchingSettings? settingsOf(ShapeMatchingState s) => s.settings;

  @override
  int? scoreOf(ShapeMatchingState s) {
    if (s.session == null) return null;
    return s.session!.correctCount;
  }

  @override
  int totalQuestionsOf(ShapeMatchingSettings settings) => settings.questionCount;

  @override
  String getSettingsDisplayName(ShapeMatchingSettings settings) => settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFFF0F8FF), // 水色のグラデーション（上）
      Color(0xFFE6F3FF), // 水色のグラデーション（下）
    ];
  }

  @override
  String? getQuestionText(ShapeMatchingState state) {
    // 動的に生成される問題文を使用（例: "まるを つけましょう"）
    return state.session?.currentProblem?.questionText;
  }

  @override
  String? getProgressText(ShapeMatchingState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }

  @override
  void initializeGame() {
    super.initializeGame();
    // 自動的にゲームを開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final logic = readLogic(ref);
      logic.startGame(const ShapeMatchingSettings());
    });
  }

  @override
  Widget buildSettingsView(BuildContext context, void Function(ShapeMatchingSettings) onStart) {
    // 設定画面は表示せず、直接ゲームを開始
    return const Center(child: CircularProgressIndicator());
  }

  @override
  Widget buildPlayingView(BuildContext context, ShapeMatchingState state, ModernShapeMatchingLogic logic) {
    final screenSize = MediaQuery.of(context).size;
    
    if (state.session?.currentProblem == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final problem = state.session!.currentProblem!;
    final session = state.session!;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF0F8FF), Color(0xFFE6F3FF)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // メインコンテンツ
                Expanded(
                  child: Row(
                children: [
                  // 左側：お手本
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B7355),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'おてほん',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.blue,
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: GeoShapeWidget(
                            spec: problem.target,
                            size: math.min(screenSize.width * 0.3, 180), // 1.5倍に拡大（0.2→0.3, 120→180）
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // 右側：グリッド
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.008),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // グリッド
                          Flexible(
                            child: _buildGrid(problem, session, state, logic, screenSize),
                          ),

                          SizedBox(height: screenSize.height * 0.006),

                          // こたえあわせボタン（常に表示、無効化で対応）
                          ElevatedButton(
                            onPressed: state.canAnswer ? () => logic.checkAnswer() : null,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.025,
                                vertical: screenSize.height * 0.006,
                              ),
                              backgroundColor: Colors.orange,
                              disabledBackgroundColor: Colors.orange.withOpacity(0.5),
                            ),
                            child: Text(
                              'こたえあわせ',
                              style: TextStyle(
                                fontSize: screenSize.width * 0.016,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // 正解エフェクト（統一された表示）
        if (state.phase == CommonGamePhase.feedbackOk)
          SuccessEffect(
            onComplete: () {
              // エフェクト完了後の処理はロジック側で管理
            },
            hadWrongAnswer: state.session?.wrongAttempts != null && state.session!.wrongAttempts > 0,
          ),
      ],
    );
  }

  Widget _buildGrid(
    ShapeMatchingProblem problem,
    ShapeMatchingSession session,
    ShapeMatchingState state,
    ModernShapeMatchingLogic logic,
    Size screenSize,
  ) {
    final settings = state.settings ?? const ShapeMatchingSettings();
    
    // 動的計算ベースのサイズ設定（マジックナンバー排除）
    final gridAreaWidthRatio = 0.5; // グリッドエリアの幅比率
    final availableScreenHeight = screenSize.height - 100; // ヘッダーとボタン分を除く
    final gridAreaHeightRatio = math.min(0.4, (availableScreenHeight * 0.7) / screenSize.height); // 動的高さ比率
    final cellSizeReductionFactor = 1.4; // セルサイズ調整（1.5→1.4に縮小）
    final containerPaddingRatio = 0.008; // 画面幅の0.8%をパディングに使用（0.01→0.008に縮小）
    final borderRadiusRatio = 0.02; // 画面幅の2%をボーダー半径に使用
    final cellPaddingRatio = 0.002; // 画面幅の0.2%をセル間パディングに使用（0.003→0.002に縮小）
    
    final availableWidth = screenSize.width * gridAreaWidthRatio;
    final availableHeight = screenSize.height * gridAreaHeightRatio;
    final cellSize = math.min(
      availableWidth / settings.cols, 
      availableHeight / settings.rows
    ) * cellSizeReductionFactor;
    final containerPadding = screenSize.width * containerPaddingRatio;
    final borderRadius = screenSize.width * borderRadiusRatio;
    final cellPadding = screenSize.width * cellPaddingRatio;

    return Container(
      padding: EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(settings.rows, (row) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(settings.cols, (col) {
              final index = row * settings.cols + col;
              final tile = problem.grid[index];
              final isSelected = session.selectedTiles.contains(index);
              
              // ハイライト判定（正解時のみ）
              TileHighlight highlight = TileHighlight.none;
              if (state.phase == CommonGamePhase.feedbackOk && problem.answerIndices.contains(index)) {
                highlight = TileHighlight.correct;
              }

              return Padding(
                padding: EdgeInsets.all(cellPadding),
                child: GeoShapeWidget(
                  spec: tile,
                  size: cellSize,
                  isSelected: isSelected,
                  highlight: highlight,
                  onTap: state.canSelectTiles ? () => logic.toggleTile(index) : null,
                ),
              );
            }),
          );
        }),
      ),
    );
  }

}