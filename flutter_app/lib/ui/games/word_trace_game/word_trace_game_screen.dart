import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../base/base_game_screen.dart';
import '../base/common_game_phase.dart';
import '../../components/success_effect.dart';
import 'models/word_trace_models.dart';
import 'modern_word_trace_logic.dart';

/// 文字辿りゲーム画面
class WordTraceGameScreen extends BaseGameScreen<WordTraceSettings, WordTraceState,
    ModernWordTraceLogic> {
  const WordTraceGameScreen({
    super.key,
    super.initialSettings,
  }) : super(
          enableHomeButton: false,
        );

  @override
  WordTraceGameScreenState createState() => WordTraceGameScreenState();
}

class WordTraceGameScreenState extends BaseGameScreenState<WordTraceGameScreen,
    WordTraceSettings, WordTraceState, ModernWordTraceLogic> {

  @override
  String get gameTitle => 'もじめぐり';

  @override
  WordTraceState watchState(WidgetRef ref) =>
      ref.watch(modernWordTraceLogicProvider);

  @override
  ModernWordTraceLogic readLogic(WidgetRef ref) =>
      ref.read(modernWordTraceLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(WordTraceState s) {
    return s.phase.toGameUiPhase;
  }

  @override
  WordTraceSettings? settingsOf(WordTraceState s) => s.settings;

  @override
  int? scoreOf(WordTraceState s) => s.session?.score;

  @override
  int totalQuestionsOf(WordTraceSettings s) => s.questionCount;

  @override
  String getSettingsDisplayName(WordTraceSettings settings) =>
      settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFFFFF8E1), // 薄い黄色のグラデーション（上）
      Color(0xFFFFECB3), // 薄い黄色のグラデーション（下）
    ];
  }

  @override
  String? getQuestionText(WordTraceState state) {
    return state.session?.currentProblem?.questionText;
  }

  @override
  String? getProgressText(WordTraceState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }

  @override
  Widget buildSettingsView(
      BuildContext context, void Function(WordTraceSettings) onStart) {
    // 自動的に開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onStart(const WordTraceSettings(questionCount: 3));
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
  Widget buildPlayingView(
      BuildContext context, WordTraceState state, ModernWordTraceLogic logic) {
    if (state.session?.currentProblem == null) {
      return const Center(
        child: Text(
          'もんだいを よみこみちゅう...',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
      );
    }

    final problem = state.session!.currentProblem!;
    final session = state.session!;

    return Stack(
      children: [
        // 文字グリッド（中央配置）
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _WordGridWidget(
              grid: problem.grid,
              correctPath: problem.correctPath,
              selectedPath: session.selectedPath,
              canSelect: state.canSelectChar,
              onSelectChar: (pos) => logic.selectChar(pos),
              onTapChar: (pos) => logic.tapChar(pos),
            ),
          ),
        ),

        // 成功エフェクト
        if (state.phase == CommonGamePhase.feedbackOk)
          SuccessEffect(
            onComplete: () {},
            hadWrongAnswer: session.wrongAttempts > 0,
          ),
      ],
    );
  }
}

/// 文字グリッドウィジェット
class _WordGridWidget extends StatefulWidget {
  final List<List<String>> grid;
  final List<CharPosition> correctPath;
  final List<CharPosition> selectedPath;
  final bool canSelect;
  final Function(CharPosition) onSelectChar;
  final Function(CharPosition) onTapChar;

  const _WordGridWidget({
    required this.grid,
    required this.correctPath,
    required this.selectedPath,
    required this.canSelect,
    required this.onSelectChar,
    required this.onTapChar,
  });

  @override
  State<_WordGridWidget> createState() => _WordGridWidgetState();
}

class _WordGridWidgetState extends State<_WordGridWidget> {
  Offset? _dragPosition;

  @override
  Widget build(BuildContext context) {
    final rows = widget.grid.length;
    final cols = widget.grid[0].length;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        // セルのサイズを計算（6列、4行）+ マージン分を考慮
        const cellMargin = 1.0; // EdgeInsets.all(1)
        final totalMarginWidth = cellMargin * 2 * cols; // 左右のマージン
        final totalMarginHeight = cellMargin * 2 * rows; // 上下のマージン

        final cellWidth = (maxWidth - totalMarginWidth) / cols;
        final cellHeight = (maxHeight - totalMarginHeight) / rows;
        final cellSize = cellWidth < cellHeight ? cellWidth : cellHeight;

        return Center(
          child: SizedBox(
            width: (cellSize + cellMargin * 2) * cols,
            height: (cellSize + cellMargin * 2) * rows,
            child: GestureDetector(
              onTapUp: widget.canSelect ? (details) {
                final pos = _getCharAtPosition(details.localPosition, cellSize + cellMargin * 2, cols, rows);
                if (pos != null) {
                  widget.onTapChar(pos);
                }
              } : null,
              onPanStart: widget.canSelect ? (details) {
                final pos = _getCharAtPosition(details.localPosition, cellSize + cellMargin * 2, cols, rows);
                if (pos != null) {
                  widget.onSelectChar(pos);
                  setState(() {
                    _dragPosition = details.localPosition;
                  });
                }
              } : null,
              onPanUpdate: widget.canSelect ? (details) {
                setState(() {
                  _dragPosition = details.localPosition;
                });
                final pos = _getCharAtPosition(details.localPosition, cellSize + cellMargin * 2, cols, rows);
                if (pos != null) {
                  widget.onSelectChar(pos);
                }
              } : null,
              onPanEnd: widget.canSelect ? (_) {
                setState(() {
                  _dragPosition = null;
                });
              } : null,
              child: Stack(
                children: [
                  // グリッド
                  Column(
                    children: [
                      for (int y = 0; y < rows; y++)
                        Row(
                          children: [
                            for (int x = 0; x < cols; x++)
                              _CharCell(
                                char: widget.grid[y][x],
                                position: CharPosition(x: x, y: y),
                                isSelected: _isSelected(x, y),
                                selectionOrder: _getSelectionOrder(x, y),
                                onTap: null, // タップ機能は一旦無効化（ドラッグのみ）
                                size: cellSize,
                              ),
                          ],
                        ),
                    ],
                  ),

                  // 線を描画
                  CustomPaint(
                    size: Size((cellSize + cellMargin * 2) * cols, (cellSize + cellMargin * 2) * rows),
                    painter: _PathPainter(
                      path: widget.selectedPath,
                      cellSize: cellSize + cellMargin * 2,
                      dragPosition: _dragPosition,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isSelected(int x, int y) {
    return widget.selectedPath.any((p) => p.x == x && p.y == y);
  }

  int _getSelectionOrder(int x, int y) {
    final index = widget.selectedPath.indexWhere((p) => p.x == x && p.y == y);
    return index >= 0 ? index + 1 : 0;
  }

  CharPosition? _getCharAtPosition(Offset position, double cellSize, int cols, int rows) {
    final x = (position.dx / cellSize).floor();
    final y = (position.dy / cellSize).floor();

    if (x >= 0 && x < cols && y >= 0 && y < rows) {
      return CharPosition(x: x, y: y);
    }
    return null;
  }
}

/// 文字セル
class _CharCell extends StatelessWidget {
  final String char;
  final CharPosition position;
  final bool isSelected;
  final int selectionOrder;
  final VoidCallback? onTap;
  final double size;

  const _CharCell({
    required this.char,
    required this.position,
    required this.isSelected,
    required this.selectionOrder,
    this.onTap,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade200 : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            char,
            style: TextStyle(
              fontSize: size * 0.5,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
    );
  }
}

/// パスを描画するカスタムペインター
class _PathPainter extends CustomPainter {
  final List<CharPosition> path;
  final double cellSize;
  final Offset? dragPosition;

  _PathPainter({
    required this.path,
    required this.cellSize,
    this.dragPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withValues(alpha: 0.6)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // 確定した線を描画
    if (path.length >= 2) {
      final pathObj = Path();

      for (int i = 0; i < path.length; i++) {
        final pos = path[i];
        final centerX = (pos.x + 0.5) * cellSize;
        final centerY = (pos.y + 0.5) * cellSize;

        if (i == 0) {
          pathObj.moveTo(centerX, centerY);
        } else {
          pathObj.lineTo(centerX, centerY);
        }
      }

      canvas.drawPath(pathObj, paint);
    }

    // ドラッグ中の一時線を描画
    if (path.isNotEmpty && dragPosition != null) {
      final lastPos = path.last;
      final startX = (lastPos.x + 0.5) * cellSize;
      final startY = (lastPos.y + 0.5) * cellSize;

      final tempPaint = Paint()
        ..color = Colors.blue.withValues(alpha: 0.3)
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        Offset(startX, startY),
        dragPosition!,
        tempPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_PathPainter oldDelegate) {
    return path != oldDelegate.path || dragPosition != oldDelegate.dragPosition;
  }
}
