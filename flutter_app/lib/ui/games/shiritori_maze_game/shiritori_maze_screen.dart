import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../base/base_game_screen.dart';
import '../base/common_game_phase.dart';
import '../../components/success_effect.dart';
import 'models/shiritori_maze_models.dart';
import 'modern_shiritori_maze_logic.dart';

class ShiritoriMazeScreen extends BaseGameScreen<ShiritoriMazeSettings,
    ShiritoriMazeState, ModernShiritoriMazeLogic> {
  const ShiritoriMazeScreen({super.key}) : super(enableHomeButton: false);

  @override
  ShiritoriMazeScreenState createState() => ShiritoriMazeScreenState();
}

class ShiritoriMazeScreenState extends BaseGameScreenState<
    ShiritoriMazeScreen,
    ShiritoriMazeSettings,
    ShiritoriMazeState,
    ModernShiritoriMazeLogic> {

  @override
  String get gameTitle => 'しりとりめいろ';

  @override
  ShiritoriMazeState watchState(WidgetRef ref) =>
      ref.watch(modernShiritoriMazeLogicProvider);

  @override
  ModernShiritoriMazeLogic readLogic(WidgetRef ref) =>
      ref.read(modernShiritoriMazeLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(ShiritoriMazeState s) {
    return s.phase.toGameUiPhase;
  }

  @override
  ShiritoriMazeSettings? settingsOf(ShiritoriMazeState s) => s.settings;

  @override
  int? scoreOf(ShiritoriMazeState s) => s.session?.correctCount;

  @override
  int totalQuestionsOf(ShiritoriMazeSettings s) => s.questionCount;

  @override
  String getSettingsDisplayName(ShiritoriMazeSettings settings) =>
      settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Colors.white,
      Colors.white,
    ];
  }

  @override
  String? getQuestionText(ShiritoriMazeState state) {
    return state.questionText;
  }

  @override
  String? getProgressText(ShiritoriMazeState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }

  @override
  Widget buildSettingsView(BuildContext context, void Function(ShiritoriMazeSettings) onStart) {
    // 自動的に開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onStart(const ShiritoriMazeSettings(questionCount: 3));
    });

    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text(
            'ゲームを じゅんび しています...',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildPlayingView(BuildContext context, ShiritoriMazeState state, ModernShiritoriMazeLogic logic) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        // 白背景
        Container(
          color: Colors.white,
        ),

        // メインコンテンツ
        _buildGameContent(context, state, logic, screenSize),

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
    ShiritoriMazeState state,
    ModernShiritoriMazeLogic logic,
    Size screenSize,
  ) {
    final session = state.session;
    final problem = session?.currentProblem;

    if (problem == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: _buildGrid(context, state, logic, problem, screenSize),
    );
  }

  Widget _buildGrid(
    BuildContext context,
    ShiritoriMazeState state,
    ModernShiritoriMazeLogic logic,
    ShiritoriMazeProblem problem,
    Size screenSize,
  ) {
    return _ShiritoriGridWidget(
      state: state,
      logic: logic,
      problem: problem,
      screenSize: screenSize,
    );
  }
}

class _ShiritoriGridWidget extends StatefulWidget {
  final ShiritoriMazeState state;
  final ModernShiritoriMazeLogic logic;
  final ShiritoriMazeProblem problem;
  final Size screenSize;

  const _ShiritoriGridWidget({
    super.key,
    required this.state,
    required this.logic,
    required this.problem,
    required this.screenSize,
  });

  @override
  State<_ShiritoriGridWidget> createState() => _ShiritoriGridWidgetState();
}

class _ShiritoriGridWidgetState extends State<_ShiritoriGridWidget> {
  Offset? _dragPosition;

  @override
  void didUpdateWidget(_ShiritoriGridWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 問題が変わったらドラッグ位置をリセット
    if (oldWidget.problem != widget.problem) {
      _dragPosition = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = widget.state.settings!;
    final rows = settings.rows;
    final cols = settings.cols;
    final session = widget.state.session!;

    // 利用可能な高さからセルサイズを逆算
    final headerHeight = widget.screenSize.height * 0.126;
    final availableHeight = widget.screenSize.height - headerHeight - 40; // 40px = マージン
    final spacing = 4.0;

    // グリッド高さ = cellSize * rows + spacing * (rows - 1)
    // cellSize = (availableHeight - spacing * (rows - 1)) / rows
    final calculatedCellSize = (availableHeight - spacing * (rows - 1)) / rows;

    // 幅の制約も考慮
    final maxCellSizeByWidth = widget.screenSize.width * 0.20;
    final cellSize = calculatedCellSize < maxCellSizeByWidth ? calculatedCellSize : maxCellSizeByWidth;

    final gridWidth = cellSize * cols + spacing * (cols - 1);
    final gridHeight = cellSize * rows + spacing * (rows - 1);

    return Center(
      child: SizedBox(
        width: gridWidth,
        height: gridHeight,
        child: GestureDetector(
          onPanStart: widget.state.canAnswer ? (details) {
            setState(() {
              _dragPosition = details.localPosition;
            });
            final index = _getIndexAtPosition(details.localPosition, cellSize + spacing, cols, rows);
            if (index != null) {
              widget.logic.onCellTapped(index);
            }
          } : null,
          onPanUpdate: widget.state.canAnswer ? (details) {
            setState(() {
              _dragPosition = details.localPosition;
            });
            final index = _getIndexAtPosition(details.localPosition, cellSize + spacing, cols, rows);
            if (index != null) {
              widget.logic.onCellTapped(index);
            }
          } : null,
          onPanEnd: widget.state.canAnswer ? (_) {
            setState(() {
              _dragPosition = null;
            });
          } : null,
          child: Stack(
            children: [
              // グリッド
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: spacing,
                  crossAxisSpacing: spacing,
                ),
                itemCount: settings.gridSize,
                itemBuilder: (context, index) {
                  final word = widget.problem.gridMap[index];
                  if (word == null) return const SizedBox();

                  final isStart = index == widget.problem.correctPath.first;
                  final isGoal = index == widget.problem.correctPath.last;
                  final isSelected = session.selectedPath.contains(index);

                  return _buildCell(
                    word: word,
                    cellSize: cellSize,
                    isStart: isStart,
                    isGoal: isGoal,
                    isSelected: isSelected,
                    onTap: null, // ドラッグのみ有効
                  );
                },
              ),

              // 線を描画
              CustomPaint(
                size: Size(gridWidth, gridHeight),
                painter: _ShiritoriPathPainter(
                  selectedPath: session.selectedPath,
                  cellSize: cellSize + spacing,
                  cols: cols,
                  dragPosition: _dragPosition,
                  gridMap: widget.problem.gridMap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int? _getIndexAtPosition(Offset position, double cellSize, int cols, int rows) {
    final x = (position.dx / cellSize).floor();
    final y = (position.dy / cellSize).floor();

    if (x >= 0 && x < cols && y >= 0 && y < rows) {
      return y * cols + x;
    }
    return null;
  }

  Widget _buildCell({
    required String word,
    required double cellSize,
    required bool isStart,
    required bool isGoal,
    required bool isSelected,
    VoidCallback? onTap,
  }) {
    Color backgroundColor = Colors.grey.shade100;
    Color borderColor = Colors.grey.shade400;
    double borderWidth = 2;

    if (isStart) {
      backgroundColor = Colors.red.shade100;
      borderColor = Colors.red;
      borderWidth = 4;
    } else if (isGoal) {
      backgroundColor = Colors.blue.shade100;
      borderColor = Colors.blue;
      borderWidth = 4;
    } else if (isSelected) {
      backgroundColor = Colors.green.shade100;
      borderColor = Colors.green;
      borderWidth = 3;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: borderWidth),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // ひらがな表示（画像の代わり）
            Center(
              child: Text(
                word,
                style: TextStyle(
                  fontSize: cellSize * 0.22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// しりとりパスを描画するカスタムペインター
class _ShiritoriPathPainter extends CustomPainter {
  final List<int> selectedPath;
  final double cellSize;
  final int cols;
  final Offset? dragPosition;
  final Map<int, String> gridMap;

  _ShiritoriPathPainter({
    required this.selectedPath,
    required this.cellSize,
    required this.cols,
    this.dragPosition,
    required this.gridMap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.withOpacity(0.6)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // 確定した線を描画
    if (selectedPath.length >= 2) {
      final path = Path();

      for (int i = 0; i < selectedPath.length; i++) {
        final index = selectedPath[i];
        final x = index % cols;
        final y = index ~/ cols;
        final centerX = (x + 0.5) * cellSize;
        final centerY = (y + 0.5) * cellSize;

        if (i == 0) {
          path.moveTo(centerX, centerY);
        } else {
          path.lineTo(centerX, centerY);
        }
      }

      canvas.drawPath(path, paint);
    }

    // ドラッグ中の一時線を描画
    if (selectedPath.isNotEmpty && dragPosition != null) {
      final lastIndex = selectedPath.last;
      final lastX = lastIndex % cols;
      final lastY = lastIndex ~/ cols;
      final startX = (lastX + 0.5) * cellSize;
      final startY = (lastY + 0.5) * cellSize;

      final tempPaint = Paint()
        ..color = Colors.green.withOpacity(0.3)
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        Offset(startX, startY),
        dragPosition!,
        tempPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_ShiritoriPathPainter oldDelegate) {
    return selectedPath != oldDelegate.selectedPath ||
        dragPosition != oldDelegate.dragPosition;
  }
}
