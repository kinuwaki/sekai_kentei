import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../base/base_game_screen.dart';
import '../base/common_game_phase.dart';
import '../../components/success_effect.dart';
import 'models/word_game_models.dart';
import 'modern_word_game_logic.dart';

class WordGameScreen extends BaseGameScreen<WordGameSettings, WordGameState, ModernWordGameLogic> {
  const WordGameScreen({
    super.key,
    super.initialSettings,
  });

  @override
  BaseGameScreenState<WordGameScreen, WordGameSettings, WordGameState, ModernWordGameLogic>
      createState() => _WordGameScreenState();
}

class _WordGameScreenState extends BaseGameScreenState<
    WordGameScreen,
    WordGameSettings,
    WordGameState,
    ModernWordGameLogic> {
  
  @override
  String get gameTitle => 'たんご';

  @override
  WordGameState watchState(WidgetRef ref) =>
      ref.watch(modernWordGameLogicProvider);

  @override
  ModernWordGameLogic readLogic(WidgetRef ref) =>
      ref.read(modernWordGameLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(WordGameState s) {
    return s.phase.toGameUiPhase;
  }

  @override
  WordGameSettings? settingsOf(WordGameState s) => s.settings;

  @override
  int? scoreOf(WordGameState s) {
    if (s.session == null) return null;
    return s.session!.correctCount;
  }

  @override
  int totalQuestionsOf(WordGameSettings settings) => settings.questionCount;

  @override
  String getSettingsDisplayName(WordGameSettings settings) => settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFFF0F8FF), // 水色のグラデーション（上）
      Color(0xFFE6F3FF), // 水色のグラデーション（下）
    ];
  }

  @override
  String? getQuestionText(WordGameState state) {
    return state.questionText;
  }

  @override
  String? getProgressText(WordGameState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }


  @override
  Widget buildSettingsView(BuildContext context, void Function(WordGameSettings) onStart) {
    return Center(
      child: Card(
        elevation: 8,
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'たんご',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              _ModeSelector(
                onSettingsSelected: (settings) {
                  onStart(settings);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildPlayingView(BuildContext context, WordGameState state, ModernWordGameLogic logic) {
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
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // 左側：問題表示エリア
                Expanded(
                  flex: 1,
                  child: _buildQuestionArea(problem, screenSize),
                ),

                // 右側：選択肢グリッド（2×2）
                Expanded(
                  flex: 2,
                  child: _buildOptionsGrid(
                    problem,
                    session,
                    state,
                    logic,
                    screenSize,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // 正解エフェクト
        if (state.phase == CommonGamePhase.feedbackOk)
          SuccessEffect(
            onComplete: () {},
            hadWrongAnswer: state.session?.wrongAnswers != null && state.session!.wrongAnswers > 0,
          ),
      ],
    );
  }

  Widget _buildQuestionArea(WordGameProblem problem, Size screenSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Picture→Textモードの場合のみヘッダーを表示
        if (problem.questionType == QuestionType.pictureToText) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF4A90E2),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Text(
              'もんだい',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],

        if (problem.questionType == QuestionType.pictureToText)
          Container(
            width: math.min(screenSize.width * 0.35, 220), // サイズを拡大
            height: math.min(screenSize.width * 0.35, 220), // サイズを拡大
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF4A90E2),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Image.asset(
              problem.imagePath,
              fit: BoxFit.contain,
            ),
          )
        else
          // Text→Pictureモードでも同じサイズの枠を表示
          Container(
            width: math.min(screenSize.width * 0.35, 220),
            height: math.min(screenSize.width * 0.35, 220),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF4A90E2),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                problem.word,
                style: TextStyle(
                  fontSize: math.min(screenSize.width * 0.04, 32),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C3E50),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildOptionsGrid(
    WordGameProblem problem,
    WordGameSession session,
    WordGameState state,
    ModernWordGameLogic logic,
    Size screenSize,
  ) {
    const int rows = 2;
    const int cols = 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        // 利用可能な制約から計算
        final availableWidth = constraints.maxWidth;
        final availableHeight = constraints.maxHeight;

        // 動的パディングとサイズ計算
        final containerPadding = availableWidth * 0.02;
        final borderRadius = availableWidth * 0.03;
        final cellPadding = availableWidth * 0.008;

        // セルサイズ計算（制約内に収まるように）
        final totalHorizontalPadding = containerPadding * 2 + cellPadding * (cols - 1);
        final totalVerticalPadding = containerPadding * 2 + cellPadding * (rows - 1);

        final maxCellWidth = (availableWidth - totalHorizontalPadding) / cols;
        final maxCellHeight = (availableHeight - totalVerticalPadding) / rows;

        final cellSize = math.min(maxCellWidth, maxCellHeight) * 0.9;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
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
                children: List.generate(rows, (row) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(cols, (col) {
                      final index = row * cols + col;

                      // 選択肢が4個未満の場合、空のセルを表示
                      if (index >= problem.options.length) {
                        return Padding(
                          padding: EdgeInsets.all(cellPadding),
                          child: SizedBox(
                            width: cellSize,
                            height: cellSize,
                          ),
                        );
                      }

                      final option = problem.options[index];
                      final isCorrect = index == problem.correctIndex;
                      final showResult = state.phase == CommonGamePhase.feedbackOk ||
                                       state.phase == CommonGamePhase.feedbackNg;
                      final isSelected = state.lastResult?.selectedIndex == index;

                      return Padding(
                        padding: EdgeInsets.all(cellPadding),
                        child: _buildOptionCell(
                          option: option,
                          index: index,
                          isCorrect: isCorrect,
                          showResult: showResult,
                          isSelected: isSelected,
                          canAnswer: state.canAnswer,
                          cellSize: cellSize,
                          mode: problem.questionType,
                          problem: problem,
                          onTap: () => logic.answerQuestion(index),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildOptionCell({
    required String option,
    required int index,
    required bool isCorrect,
    required bool showResult,
    required bool isSelected,
    required bool canAnswer,
    required double cellSize,
    required QuestionType mode,
    required WordGameProblem problem,
    required VoidCallback onTap,
  }) {
    Color backgroundColor = Colors.grey.shade200;
    Color borderColor = Colors.grey.shade400;
    
    if (showResult) {
      if (isCorrect) {
        backgroundColor = Colors.green.shade100;
        borderColor = Colors.green;
      } else if (isSelected) {
        backgroundColor = Colors.red.shade100;
        borderColor = Colors.red;
      }
    }
    
    return GestureDetector(
      onTap: canAnswer ? onTap : null,
      child: Container(
        width: cellSize,
        height: cellSize,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: showResult && (isCorrect || isSelected) ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: mode == QuestionType.pictureToText
              ? Text(
                  option,
                  style: TextStyle(
                    fontSize: cellSize * 0.15, // 0.2 → 0.15で6文字にも対応
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              : Image.asset(
                  VocabularyImages.getImagePath(option, problem.scriptType),
                  width: cellSize * 0.7,
                  height: cellSize * 0.7,
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }
}

class _ModeSelector extends StatefulWidget {
  final Function(WordGameSettings) onSettingsSelected;

  const _ModeSelector({required this.onSettingsSelected});

  @override
  State<_ModeSelector> createState() => _ModeSelectorState();
}

class _ModeSelectorState extends State<_ModeSelector> {
  WordGameMode? _selectedMode;
  QuestionType? _selectedQuestionType;

  @override
  Widget build(BuildContext context) {
    if (_selectedMode == null) {
      // ステップ1: 文字種選択（ひらがな/カタカナ）
      return Column(
        children: [
          const Text(
            'もじのしゅるいをえらんでね',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),

          ...WordGameMode.values.map((mode) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedMode = mode;
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor: Colors.blue,
              ),
              child: Text(
                mode.displayName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )),
        ],
      );
    } else {
      // ステップ2: 問題タイプ選択（絵→文字/文字→絵）
      return Column(
        children: [
          Text(
            '${_selectedMode!.displayName}：もんだいのしゅるいをえらんでね',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),

          ...QuestionType.values.map((type) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                widget.onSettingsSelected(WordGameSettings(
                  mode: _selectedMode!,
                  questionType: type,
                ));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor: Colors.green,
              ),
              child: Text(
                type.description,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )),

          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              setState(() {
                _selectedMode = null;
              });
            },
            child: const Text(
              'もどる',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      );
    }
  }
}