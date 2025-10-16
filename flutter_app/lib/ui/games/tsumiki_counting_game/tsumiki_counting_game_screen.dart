import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../base/base_game_screen.dart';
import '../../components/success_effect.dart';
import 'models/tsumiki_counting_models.dart';
import '../base/common_game_phase.dart';
import 'modern_tsumiki_counting_logic.dart';

class TsumikiCountingGameScreen extends BaseGameScreen<TsumikiCountingSettings, TsumikiCountingState, ModernTsumikiCountingLogic> {
  const TsumikiCountingGameScreen({
    super.key,
    super.initialSettings,
  });

  @override
  BaseGameScreenState<TsumikiCountingGameScreen, TsumikiCountingSettings, TsumikiCountingState, ModernTsumikiCountingLogic>
      createState() => _TsumikiCountingGameScreenState();
}

class _TsumikiCountingGameScreenState extends BaseGameScreenState<
    TsumikiCountingGameScreen,
    TsumikiCountingSettings,
    TsumikiCountingState,
    ModernTsumikiCountingLogic> {

  @override
  String get gameTitle => 'つみき';

  @override
  TsumikiCountingState watchState(WidgetRef ref) =>
      ref.watch(modernTsumikiCountingLogicProvider);

  @override
  ModernTsumikiCountingLogic readLogic(WidgetRef ref) =>
      ref.read(modernTsumikiCountingLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(TsumikiCountingState s) {
    return s.phase.toGameUiPhase;
  }

  @override
  TsumikiCountingSettings? settingsOf(TsumikiCountingState s) => s.settings;

  @override
  int? scoreOf(TsumikiCountingState s) {
    if (s.session == null) return null;
    return s.session!.results.where((r) => r == true).length;
  }

  @override
  int totalQuestionsOf(TsumikiCountingSettings settings) => settings.questionCount;

  @override
  String getSettingsDisplayName(TsumikiCountingSettings settings) => settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFFF0F8FF), // 水色のグラデーション（上）
      Color(0xFFE6F3FF), // 水色のグラデーション（下）
    ];
  }

  @override
  String? getQuestionText(TsumikiCountingState state) => state.questionText;

  @override
  String? getProgressText(TsumikiCountingState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }


  @override
  Widget buildSettingsView(BuildContext context, void Function(TsumikiCountingSettings) onStart) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFF2FF), // 背景色 255,242,255
      ),
      child: _TwoStepSelector(
        onGameStart: onStart,
      ),
    );
  }

  @override
  Widget buildPlayingView(BuildContext context, TsumikiCountingState state, ModernTsumikiCountingLogic logic) {
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
              colors: [Color(0xFFFFE8F0), Color(0xFFFFF2FF)],
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

  Widget _buildQuestionArea(TsumikiCountingProblem problem, Size screenSize) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 利用可能な制約から動的にサイズ計算
        final availableWidth = constraints.maxWidth;
        final availableHeight = constraints.maxHeight;

        // コンテナサイズを制約内で最大化（正方形を維持）
        final maxSize = math.min(availableWidth * 0.8, availableHeight * 0.6);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ヘッダー（imageToNumberモードのみ）
            if (problem.mode == TsumikiCountingMode.imageToNumber) ...[
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

            // 問題内容
            if (problem.mode == TsumikiCountingMode.imageToNumber)
              Container(
                width: maxSize,
                height: maxSize,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: problem.imagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/figures/tsumiki/${problem.imagePath}',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_not_supported,
                                size: 48,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'つみき${problem.blockCount}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                    color: Colors.grey.shade200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.view_in_ar,
                          size: 48,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'つみき${problem.blockCount}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
          )
            else
              Container(
                width: maxSize,
                height: maxSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                    '${problem.blockCount}',
                    style: const TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A90E2),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildOptionsGrid(
    TsumikiCountingProblem problem,
    TsumikiCountingSession session,
    TsumikiCountingState state,
    ModernTsumikiCountingLogic logic,
    Size screenSize,
  ) {
    const rows = 2;
    const cols = 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        // 利用可能な制約から計算
        final availableWidth = constraints.maxWidth;
        final availableHeight = constraints.maxHeight;

        // 動的パディングとサイズ計算
        final containerPadding = availableWidth * 0.02;
        final borderRadius = availableWidth * 0.015;
        final cellPadding = availableWidth * 0.01;

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
                color: Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
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
                      final isCorrect = index == problem.correctAnswerIndex;
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
                          mode: problem.mode,
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
    required TsumikiCountingMode mode,
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
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: mode == TsumikiCountingMode.numberToImage
              ? Image.asset(
                  'assets/images/figures/tsumiki/$option',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade300,
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: cellSize * 0.4,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  color: backgroundColor,
                  child: Center(
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: cellSize * 0.3,
                        fontWeight: FontWeight.bold,
                        color: showResult
                            ? (isCorrect ? Colors.green.shade700 :
                               isSelected ? Colors.red.shade700 : Colors.black87)
                            : Colors.black87,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _TwoStepSelector extends StatefulWidget {
  final Function(TsumikiCountingSettings) onGameStart;

  const _TwoStepSelector({required this.onGameStart});

  @override
  State<_TwoStepSelector> createState() => _TwoStepSelectorState();
}

class _TwoStepSelectorState extends State<_TwoStepSelector> {
  TsumikiCountingMode? selectedMode;
  TsumikiCountingRange? selectedRange;
  int questionCount = 5;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.width * 0.03;
    final maxButtonWidth = 600.0;

    // ステップ1: モード選択
    if (selectedMode == null) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'どちらにしますか？',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize * 1.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
              const SizedBox(height: 30),

              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxButtonWidth),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 1行目: えから すうじ
                        Row(
                          children: [
                            Expanded(
                              child: _buildModeButton(
                                context,
                                mode: TsumikiCountingMode.imageToNumber,
                                title: 'えから すうじ',
                                subtitle: '画像を見て正しい数字を選んでね',
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildModeButton(
                                context,
                                mode: TsumikiCountingMode.numberToImage,
                                title: 'すうじから え',
                                subtitle: '数字を見て正しい画像を選んでね',
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ステップ2: 範囲選択
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedMode = null;
                    });
                  },
                  icon: const Icon(Icons.arrow_back, size: 28),
                  color: Colors.blue.shade700,
                ),
                Expanded(
                  child: Text(
                    'つみきのかずをえらんでね',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize * 1.3,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
                const SizedBox(width: 56), // IconButtonのサイズ分
              ],
            ),
            const SizedBox(height: 30),

            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxButtonWidth),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 1行目: 2, 3, 4, 5
                      Row(
                        children: [
                          ...TsumikiCountingRange.values.take(4).map((range) =>
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: _buildRangeButton(
                                  context,
                                  range: range,
                                  color: _getRangeColor(range),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // 2行目: 6, 7, 8, 9
                      Row(
                        children: [
                          ...TsumikiCountingRange.values.skip(4).map((range) =>
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: _buildRangeButton(
                                  context,
                                  range: range,
                                  color: _getRangeColor(range),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeButton(
    BuildContext context, {
    required TsumikiCountingMode mode,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final buttonHeight = screenSize.height * 0.25;

    return Container(
      height: buttonHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              selectedMode = mode;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRangeButton(
    BuildContext context, {
    required TsumikiCountingRange range,
    required Color color,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final buttonHeight = screenSize.height * 0.12;

    return Container(
      height: buttonHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            final settings = TsumikiCountingSettings(
              range: range,
              mode: selectedMode!,
              questionCount: questionCount,
            );
            widget.onGameStart(settings);
          },
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: Text(
              range.displayName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Color _getRangeColor(TsumikiCountingRange range) {
    switch (range) {
      case TsumikiCountingRange.oneToThree:
        return Colors.green;
      case TsumikiCountingRange.twoToFour:
        return Colors.blue;
      case TsumikiCountingRange.threeToFive:
        return Colors.orange;
      case TsumikiCountingRange.fourToSix:
        return Colors.red;
      case TsumikiCountingRange.fiveToSeven:
        return Colors.purple;
      case TsumikiCountingRange.sixToEight:
        return Colors.teal;
      case TsumikiCountingRange.sevenToNine:
        return Colors.indigo;
    }
  }
}