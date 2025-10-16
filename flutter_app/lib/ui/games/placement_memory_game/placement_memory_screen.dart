import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../base/base_game_screen.dart';
import '../base/common_game_phase.dart';
import '../../components/success_effect.dart';
import 'models/placement_memory_models.dart';
import 'modern_placement_memory_logic.dart';

class PlacementMemoryScreen extends BaseGameScreen<PlacementMemorySettings,
    PlacementMemoryState, ModernPlacementMemoryLogic> {
  const PlacementMemoryScreen({super.key}) : super(enableHomeButton: false);

  @override
  PlacementMemoryScreenState createState() => PlacementMemoryScreenState();
}

class PlacementMemoryScreenState extends BaseGameScreenState<
    PlacementMemoryScreen,
    PlacementMemorySettings,
    PlacementMemoryState,
    ModernPlacementMemoryLogic> {

  @override
  String get gameTitle => 'はいちきおく';

  @override
  PlacementMemoryState watchState(WidgetRef ref) =>
      ref.watch(modernPlacementMemoryLogicProvider);

  @override
  ModernPlacementMemoryLogic readLogic(WidgetRef ref) =>
      ref.read(modernPlacementMemoryLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(PlacementMemoryState s) {
    return s.phase.toGameUiPhase;
  }

  @override
  PlacementMemorySettings? settingsOf(PlacementMemoryState s) => s.settings;

  @override
  int? scoreOf(PlacementMemoryState s) => s.session?.correctCount;

  @override
  int totalQuestionsOf(PlacementMemorySettings s) => s.questionCount;

  @override
  String getSettingsDisplayName(PlacementMemorySettings settings) =>
      settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Colors.white,
      Colors.white,
    ];
  }

  @override
  String? getQuestionText(PlacementMemoryState state) {
    if (state.session?.currentProblem == null) return null;

    final showingAnswer = state.showingAnswer;

    if (!showingAnswer) {
      return '８びょうで\nえのばしょをおぼえてください';
    } else if (state.canAnswer) {
      return 'さっきおぼえたばしょに\nえをもどしてください';
    }
    return null;
  }

  @override
  String? getProgressText(PlacementMemoryState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }

  @override
  Widget buildSettingsView(BuildContext context, void Function(PlacementMemorySettings) onStart) {
    final screenSize = MediaQuery.of(context).size;
    final buttonWidth = screenSize.width * 0.28;
    final buttonHeight = screenSize.height * 0.065;

    Widget _buildButton(String label, PlacementMemorySettings settings) {
      return ElevatedButton(
        onPressed: () => onStart(settings),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4CAF50),
          foregroundColor: Colors.white,
          minimumSize: Size(buttonWidth, buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: screenSize.width * 0.03,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'はいちきおく',
            style: TextStyle(
              fontSize: screenSize.width * 0.04,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4CAF50),
            ),
          ),
          SizedBox(height: screenSize.height * 0.04),
          // 1行目: 2×2 (2こ), 2×2 (3こ), 2×2 (4こ)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('2×2 (2こ)', PlacementMemorySettings(questionCount: 3, rows: 2, cols: 2, itemCount: 2)),
              SizedBox(width: screenSize.width * 0.02),
              _buildButton('2×2 (3こ)', PlacementMemorySettings(questionCount: 3, rows: 2, cols: 2, itemCount: 3)),
              SizedBox(width: screenSize.width * 0.02),
              _buildButton('2×2 (4こ)', PlacementMemorySettings(questionCount: 3, rows: 2, cols: 2, itemCount: 4)),
            ],
          ),
          SizedBox(height: screenSize.height * 0.015),
          // 2行目: 3×2 (3こ), 3×2 (6こ)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('3×2 (3こ)', PlacementMemorySettings(questionCount: 3, rows: 2, cols: 3, itemCount: 3)),
              SizedBox(width: screenSize.width * 0.02),
              _buildButton('3×2 (6こ)', PlacementMemorySettings(questionCount: 3, rows: 2, cols: 3, itemCount: 6)),
            ],
          ),
          SizedBox(height: screenSize.height * 0.015),
          // 3行目: 3×3 (3こ), 3×3 (9こ)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('3×3 (3こ)', PlacementMemorySettings(questionCount: 3, rows: 3, cols: 3, itemCount: 3)),
              SizedBox(width: screenSize.width * 0.02),
              _buildButton('3×3 (9こ)', PlacementMemorySettings(questionCount: 3, rows: 3, cols: 3, itemCount: 9)),
            ],
          ),
          SizedBox(height: screenSize.height * 0.015),
          // 4行目: 4×2 (4こ), 4×2 (8こ)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('4×2 (4こ)', PlacementMemorySettings(questionCount: 3, rows: 2, cols: 4, itemCount: 4)),
              SizedBox(width: screenSize.width * 0.02),
              _buildButton('4×2 (8こ)', PlacementMemorySettings(questionCount: 3, rows: 2, cols: 4, itemCount: 8)),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget buildPlayingView(BuildContext context, PlacementMemoryState state, ModernPlacementMemoryLogic logic) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        // 白背景
        Container(
          color: Colors.white,
        ),

        // メインコンテンツ（上部にパディング追加）
        Padding(
          padding: EdgeInsets.only(top: screenSize.height * 0.02),
          child: _buildGameContent(context, state, logic, screenSize),
        ),

        // 成功エフェクト
        if (state.phase == CommonGamePhase.feedbackOk)
          SuccessEffect(
            onComplete: () {},
            hadWrongAnswer: (state.session?.wrongAttempts ?? 0) > 0,
          ),
      ],
    );
  }

  Widget _buildGameContent(
    BuildContext context,
    PlacementMemoryState state,
    ModernPlacementMemoryLogic logic,
    Size screenSize,
  ) {
    final session = state.session;
    final problem = session?.currentProblem;

    if (problem == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final showingAnswer = state.showingAnswer;

    if (!showingAnswer) {
      // 記憶フェーズ: 2x2グリッドで正しい配置を表示
      return _build2x2Grid(context, state, problem.items, screenSize);
    } else {
      // 回答フェーズ: ドラッグアンドドロップUI
      return _buildDragDropUI(context, state, logic, problem, screenSize);
    }
  }

  // グリッド表示（記憶フェーズ）
  Widget _build2x2Grid(BuildContext context, PlacementMemoryState state, List<GridItem> items, Size screenSize) {
    final settings = state.settings;
    if (settings == null) return const SizedBox();

    final rows = settings.rows;
    final cols = settings.cols;
    final gridSize = settings.gridSize;

    // グリッドサイズに応じてセルサイズを調整（8%小さく）
    final gridWidth = cols == 4 ? screenSize.width * 0.46 : screenSize.width * 0.368;
    final cellWidth = gridWidth / cols;
    final cellHeight = cellWidth; // 正方形のセル
    final gridHeight = cellHeight * rows;
    final itemSize = cellWidth * 0.77;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 左側の空スペース（回答フェーズと同じレイアウト）
        SizedBox(width: cellWidth),
        const SizedBox(width: 16),
        // 中央のグリッド
        SizedBox(
          width: gridWidth,
          height: gridHeight,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: gridSize,
            itemBuilder: (context, index) {
              final item = items.firstWhere(
                (item) => item.gridIndex == index,
                orElse: () => const GridItem(word: '', gridIndex: -1),
              );
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade100,
                ),
                child: Center(
                  child: item.word.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            item.imagePath,
                            fit: BoxFit.contain,
                          ),
                        )
                      : null,
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        // 右側の空スペース（回答フェーズと同じレイアウト）
        SizedBox(width: cellWidth * 1.3),
      ],
    );
  }

  // ドラッグアンドドロップUI（回答フェーズ）
  Widget _buildDragDropUI(
    BuildContext context,
    PlacementMemoryState state,
    ModernPlacementMemoryLogic logic,
    PlacementMemoryProblem problem,
    Size screenSize,
  ) {
    final settings = state.settings!;
    final rows = settings.rows;
    final cols = settings.cols;
    final totalGridSize = settings.gridSize;

    // グリッドサイズに応じてセルサイズを調整（8%小さく）
    final gridWidth = cols == 4 ? screenSize.width * 0.46 : screenSize.width * 0.368;
    final cellWidth = gridWidth / cols;
    final cellHeight = cellWidth;
    final gridHeight = cellHeight * rows;
    final itemSize = cellWidth * 0.77;

    // 全アイテムを表示（配置済みのものは非表示に）
    final allItems = problem.items;
    final halfSize = (allItems.length / 2).ceil();
    final leftItems = allItems.take(halfSize).toList();
    final rightItems = allItems.skip(halfSize).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 左側のアイテム（全部配置済みなら空）
        SizedBox(
          width: cellWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: leftItems.map((item) {
              final isPlaced = state.session!.userPlacement.any((p) => p.word == item.word);
              return _buildDraggableItem(item, itemSize, cellWidth, cellHeight, isPlaced);
            }).toList(),
          ),
        ),
        const SizedBox(width: 16),
        // 中央のグリッド
        SizedBox(
          width: gridWidth,
          height: gridHeight,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: totalGridSize,
            itemBuilder: (context, index) {
              final placedItem = state.session!.userPlacement.firstWhere(
                (item) => item.gridIndex == index,
                orElse: () => const GridItem(word: '', gridIndex: -1),
              );

              return DragTarget<GridItem>(
                onAcceptWithDetails: (details) {
                  final newPlacement = List<GridItem>.from(state.session!.userPlacement);
                  newPlacement.removeWhere((item) => item.word == details.data.word);
                  newPlacement.add(GridItem(word: details.data.word, gridIndex: index));
                  logic.updateUserPlacement(newPlacement);
                },
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(8),
                      color: candidateData.isNotEmpty ? Colors.blue.shade100 : Colors.grey.shade100,
                    ),
                    child: Center(
                      child: placedItem.word.isNotEmpty
                          ? Draggable<GridItem>(
                              data: placedItem,
                              feedback: Material(
                                color: Colors.transparent,
                                child: SizedBox(
                                  width: cellWidth,
                                  height: cellHeight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.asset(
                                      placedItem.imagePath,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              childWhenDragging: Container(),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Image.asset(
                                  placedItem.imagePath,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          : null,
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        // 右側: アイテム → 全部配置したらボタン（縦並び）
        SizedBox(
          width: cellWidth * 1.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: state.session!.userPlacement.length == settings.actualItemCount
                ? [
                    ElevatedButton(
                      onPressed: () => logic.resetPlacement(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        minimumSize: Size(cellWidth * 1.3, 60),
                      ),
                      child: const Text('やりなおし', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => logic.submitAnswer(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        minimumSize: Size(cellWidth * 1.3, 60),
                      ),
                      child: const Text('できた', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ]
                : rightItems.map((item) {
                    final isPlaced = state.session!.userPlacement.any((p) => p.word == item.word);
                    return _buildDraggableItem(item, itemSize, cellWidth, cellHeight, isPlaced);
                  }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDraggableItem(GridItem item, double size, double cellWidth, double cellHeight, bool isPlaced) {
    // サイドバーの画像もグリッドのセルと同じサイズにする
    final displaySize = cellWidth;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: displaySize,
        height: displaySize,
        child: isPlaced
            ? null // 配置済みの場合は非表示
            : Draggable<GridItem>(
                data: item,
                feedback: Material(
                  color: Colors.transparent,
                  child: SizedBox(
                    width: cellWidth,
                    height: cellHeight,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        item.imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                childWhenDragging: Opacity(
                  opacity: 0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      item.imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    item.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
      ),
    );
  }
}
