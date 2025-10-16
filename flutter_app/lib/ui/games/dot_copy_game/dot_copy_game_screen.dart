import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../base/base_game_screen.dart';
import '../base/common_game_phase.dart';
import '../../components/success_effect.dart';
import 'models/dot_copy_models.dart';
import 'modern_dot_copy_logic.dart';

/// ドット図形模写ゲーム画面
class DotCopyGameScreen extends BaseGameScreen<DotCopySettings, DotCopyState,
    ModernDotCopyLogic> {
  const DotCopyGameScreen({
    super.key,
    super.initialSettings,
  }) : super(
          enableHomeButton: false,
        );

  @override
  DotCopyGameScreenState createState() => DotCopyGameScreenState();
}

class DotCopyGameScreenState extends BaseGameScreenState<DotCopyGameScreen,
    DotCopySettings, DotCopyState, ModernDotCopyLogic> {

  @override
  String get gameTitle => 'ずけいもしゃ';

  @override
  DotCopyState watchState(WidgetRef ref) =>
      ref.watch(modernDotCopyLogicProvider);

  @override
  ModernDotCopyLogic readLogic(WidgetRef ref) =>
      ref.read(modernDotCopyLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(DotCopyState s) {
    return s.phase.toGameUiPhase;
  }

  @override
  DotCopySettings? settingsOf(DotCopyState s) => s.settings;

  @override
  int? scoreOf(DotCopyState s) => s.session?.score;

  @override
  int totalQuestionsOf(DotCopySettings s) => s.questionCount;

  @override
  String getSettingsDisplayName(DotCopySettings settings) =>
      settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFFF0F8FF), // 水色のグラデーション（上）
      Color(0xFFE6F3FF), // 水色のグラデーション（下）
    ];
  }

  @override
  String? getQuestionText(DotCopyState state) {
    return state.session?.currentProblem?.questionText;
  }

  @override
  String? getProgressText(DotCopyState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }

  @override
  Widget buildSettingsView(
      BuildContext context, void Function(DotCopySettings) onStart) {
    return _DotCopySettingsView(onStart: onStart);
  }

  @override
  Widget buildPlayingView(
      BuildContext context, DotCopyState state, ModernDotCopyLogic logic) {
    if (state.session?.currentProblem == null) {
      return const Center(
        child: Text(
          'もんだいを よみこみちゅう...',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      );
    }

    final screenSize = MediaQuery.of(context).size;
    final problem = state.session!.currentProblem!;
    final session = state.session!;

    return Stack(
      children: [
        // メインコンテンツ
        Column(
          children: [
            // お手本とプレイエリア
            Expanded(
              child: Row(
                children: [
                  // 左：お手本
                  Expanded(
                    child: _buildPatternArea(
                      context,
                      problem,
                      screenSize,
                      isPattern: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // 右：プレイエリア
                  Expanded(
                    child: _buildPatternArea(
                      context,
                      problem,
                      screenSize,
                      isPattern: false,
                      drawnLines: session.drawnLines,
                      selectedDot: session.selectedDot,
                      dragPosition: session.dragPosition,
                      onDragStart: (dot) => logic.onDragStart(dot),
                      onDragUpdate: (position, dot) => logic.onDragUpdate(position, dotAtPosition: dot),
                      onDragEnd: () => logic.onDragEnd(),
                    ),
                  ),
                ],
              ),
            ),

            // 下部ボタン
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // やりなおしボタン
                  ElevatedButton(
                    onPressed: state.canDrawLine ? () => logic.clearAllLines() : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      minimumSize: Size(screenSize.width * 0.25, 50),
                      disabledBackgroundColor: Colors.grey.withValues(alpha: 0.5),
                    ),
                    child: const Text(
                      'やりなおし',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // もどすボタン
                  ElevatedButton(
                    onPressed: state.canDrawLine && session.drawnLines.isNotEmpty
                        ? () => logic.undoLastLine()
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(screenSize.width * 0.25, 50),
                      disabledBackgroundColor: Colors.blue.withValues(alpha: 0.5),
                    ),
                    child: const Text(
                      'もどす',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // できたボタン（こたえあわせ）
                  ElevatedButton(
                    onPressed: state.showCheckButton ? () => logic.checkAnswer() : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: Size(screenSize.width * 0.25, 50),
                      disabledBackgroundColor: Colors.orange.withValues(alpha: 0.5),
                    ),
                    child: const Text(
                      'できた',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // 成功エフェクト
        if (state.phase == CommonGamePhase.feedbackOk)
          SuccessEffect(
            onComplete: () {
              // エフェクト完了後は自動で次へ進む
            },
            hadWrongAnswer: session.wrongAttempts > 0,
          ),
      ],
    );
  }

  /// お手本エリアまたはプレイエリアを構築
  Widget _buildPatternArea(
    BuildContext context,
    DotCopyProblem problem,
    Size screenSize, {
    required bool isPattern,
    List<LineSegment>? drawnLines,
    DotPosition? selectedDot,
    Offset? dragPosition,
    Function(DotPosition)? onDragStart,
    Function(Offset, DotPosition?)? onDragUpdate,
    VoidCallback? onDragEnd,
  }) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: _DotGridWidget(
        gridSize: problem.gridSize,
        lines: isPattern ? problem.patternLines : (drawnLines ?? []),
        selectedDot: isPattern ? null : selectedDot,
        dragPosition: isPattern ? null : dragPosition,
        onDragStart: isPattern ? null : onDragStart,
        onDragUpdate: isPattern ? null : onDragUpdate,
        onDragEnd: isPattern ? null : onDragEnd,
      ),
    );
  }
}

/// ドットグリッドウィジェット
class _DotGridWidget extends StatelessWidget {
  final int gridSize;
  final List<LineSegment> lines;
  final DotPosition? selectedDot;
  final Offset? dragPosition;
  final Function(DotPosition)? onDragStart;
  final Function(Offset, DotPosition?)? onDragUpdate;
  final VoidCallback? onDragEnd;

  const _DotGridWidget({
    required this.gridSize,
    required this.lines,
    this.selectedDot,
    this.dragPosition,
    this.onDragStart,
    this.onDragUpdate,
    this.onDragEnd,
  });

  /// ドラッグ位置からドット座標を検出
  DotPosition? _getDotAtPosition(Offset localPosition, double dotSpacing, double padding) {
    for (int y = 0; y < gridSize; y++) {
      for (int x = 0; x < gridSize; x++) {
        final dotX = padding + (x * dotSpacing);
        final dotY = padding + (y * dotSpacing);
        final dx = localPosition.dx - dotX;
        final dy = localPosition.dy - dotY;
        final distance = dx * dx + dy * dy;

        // ドットの半径の2倍以内なら「当たり」
        if (distance <= (16 * 16)) {
          return DotPosition(x: x, y: y);
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 画面いっぱいに広げる - 縦横の小さい方を使用
        final size = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;
        // 画面いっぱいに配置：端に余白を少し残してドットを均等配置
        final padding = size * 0.1; // 10%の余白
        final availableSize = size - (padding * 2);
        final dotSpacing = availableSize / (gridSize - 1);
        final dotRadius = 8.0;

        return Center(
          child: SizedBox(
            width: size,
            height: size,
            child: GestureDetector(
              onPanStart: onDragStart != null
                  ? (details) {
                      final dot = _getDotAtPosition(details.localPosition, dotSpacing, padding);
                      if (dot != null) {
                        onDragStart!(dot);
                      }
                    }
                  : null,
              onPanUpdate: onDragUpdate != null
                  ? (details) {
                      final dot = _getDotAtPosition(details.localPosition, dotSpacing, padding);
                      onDragUpdate!(details.localPosition, dot);
                    }
                  : null,
              onPanEnd: onDragEnd != null
                  ? (details) => onDragEnd!()
                  : null,
              child: CustomPaint(
                painter: _LinePainter(
                  lines: lines,
                  gridSize: gridSize,
                  dotSpacing: dotSpacing,
                  padding: padding,
                  selectedDot: selectedDot,
                  dragPosition: dragPosition,
                ),
                child: Stack(
                  children: [
                    for (int y = 0; y < gridSize; y++)
                      for (int x = 0; x < gridSize; x++)
                        Positioned(
                          left: padding + (x * dotSpacing) - dotRadius,
                          top: padding + (y * dotSpacing) - dotRadius,
                          child: Container(
                            width: dotRadius * 2,
                            height: dotRadius * 2,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedDot?.x == x && selectedDot?.y == y
                                  ? Colors.red
                                  : Colors.black,
                            ),
                          ),
                        ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 線を描画するCustomPainter
class _LinePainter extends CustomPainter {
  final List<LineSegment> lines;
  final int gridSize;
  final double dotSpacing;
  final double padding;
  final DotPosition? selectedDot;
  final Offset? dragPosition;

  _LinePainter({
    required this.lines,
    required this.gridSize,
    required this.dotSpacing,
    required this.padding,
    this.selectedDot,
    this.dragPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // 確定した線を描画
    for (final line in lines) {
      final startX = padding + (line.start.x * dotSpacing);
      final startY = padding + (line.start.y * dotSpacing);
      final endX = padding + (line.end.x * dotSpacing);
      final endY = padding + (line.end.y * dotSpacing);

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );
    }

    // ドラッグ中の一時線を描画
    if (selectedDot != null && dragPosition != null) {
      final startX = padding + (selectedDot!.x * dotSpacing);
      final startY = padding + (selectedDot!.y * dotSpacing);

      final tempPaint = Paint()
        ..color = Colors.blue.withValues(alpha: 0.5)
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        Offset(startX, startY),
        dragPosition!,
        tempPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_LinePainter oldDelegate) {
    return lines != oldDelegate.lines ||
        selectedDot != oldDelegate.selectedDot ||
        dragPosition != oldDelegate.dragPosition;
  }
}

/// 図形模写設定画面
class _DotCopySettingsView extends StatefulWidget {
  final Function(DotCopySettings) onStart;

  const _DotCopySettingsView({required this.onStart});

  @override
  State<_DotCopySettingsView> createState() => _DotCopySettingsViewState();
}

class _DotCopySettingsViewState extends State<_DotCopySettingsView> {
  int _selectedGridSize = 3;
  DotCopyDifficulty? _selectedDifficulty;

  // グリッドサイズごとの利用可能な難易度
  List<DotCopyDifficulty> _getAvailableDifficulties(int gridSize) {
    switch (gridSize) {
      case 3:
        return [DotCopyDifficulty.easy]; // 3x3はかんたんのみ
      case 4:
        return [DotCopyDifficulty.easy, DotCopyDifficulty.normal]; // 4x4はかんたん・ふつう
      case 5:
        return DotCopyDifficulty.values; // 5x5は全難易度
      default:
        return [DotCopyDifficulty.easy];
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDifficulty = _getAvailableDifficulties(_selectedGridSize).first;
  }

  void _onGridSizeChanged(int gridSize) {
    setState(() {
      _selectedGridSize = gridSize;
      final available = _getAvailableDifficulties(gridSize);
      // 選択中の難易度が利用不可の場合は最初の難易度に変更
      if (!available.contains(_selectedDifficulty)) {
        _selectedDifficulty = available.first;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableDifficulties = _getAvailableDifficulties(_selectedGridSize);
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'グリッドサイズをえらんでね',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 12),

            // グリッドサイズ選択
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGridSizeButton(3, '3×3'),
                const SizedBox(width: 8),
                _buildGridSizeButton(4, '4×4'),
                const SizedBox(width: 8),
                _buildGridSizeButton(5, '5×5'),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'むずかしさをえらんでね',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 12),

            // 難易度選択
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final buttonCount = DotCopyDifficulty.values.length;
                  final spacing = 8.0;
                  final totalSpacing = spacing * (buttonCount - 1);
                  final buttonWidth = (constraints.maxWidth - totalSpacing) / buttonCount;
                  final buttonHeight = constraints.maxHeight * 0.7;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDifficultyButton(
                        DotCopyDifficulty.easy,
                        Colors.green,
                        availableDifficulties.contains(DotCopyDifficulty.easy),
                        buttonWidth,
                        buttonHeight,
                      ),
                      SizedBox(width: spacing),
                      _buildDifficultyButton(
                        DotCopyDifficulty.normal,
                        Colors.orange,
                        availableDifficulties.contains(DotCopyDifficulty.normal),
                        buttonWidth,
                        buttonHeight,
                      ),
                      SizedBox(width: spacing),
                      _buildDifficultyButton(
                        DotCopyDifficulty.hard,
                        Colors.red,
                        availableDifficulties.contains(DotCopyDifficulty.hard),
                        buttonWidth,
                        buttonHeight,
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // スタートボタン
            ElevatedButton(
              onPressed: _selectedDifficulty == null
                  ? null
                  : () {
                      final settings = DotCopySettings(
                        gridSize: _selectedGridSize,
                        questionCount: 5,
                        difficulty: _selectedDifficulty!,
                      );
                      widget.onStart(settings);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'はじめる',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(
    DotCopyDifficulty difficulty,
    Color color,
    bool isEnabled,
    double width,
    double height,
  ) {
    final isSelected = _selectedDifficulty == difficulty;
    final fontSize = 18.0; // 固定サイズに変更

    return Opacity(
      opacity: isEnabled ? 1.0 : 0.3,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? [color, color.withOpacity(0.8)]
                : [color.withOpacity(0.6), color.withOpacity(0.4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: Colors.white, width: 4)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isEnabled
                ? () {
                    setState(() {
                      _selectedDifficulty = difficulty;
                    });
                  }
                : null,
            borderRadius: BorderRadius.circular(8),
            child: Center(
              child: Text(
                difficulty.displayName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridSizeButton(int gridSize, String label) {
    final isSelected = _selectedGridSize == gridSize;

    return ElevatedButton(
      onPressed: () => _onGridSizeChanged(gridSize),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey.shade300,
        foregroundColor: isSelected ? Colors.white : Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 3,
          ),
        ),
        minimumSize: const Size(80, 60),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}