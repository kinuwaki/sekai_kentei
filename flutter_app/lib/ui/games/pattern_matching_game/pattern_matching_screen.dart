import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/success_effect.dart';
import '../base/base_game_screen.dart';
import '../base/common_game_phase.dart';
import '../base/common_game_widgets.dart';
import 'models/pattern_matching_models.dart';
import 'modern_pattern_matching_logic.dart';
import 'widgets/pattern_shape_painter.dart';

class PatternMatchingScreen extends BaseGameScreen<
    PatternMatchingSettings, PatternMatchingState, ModernPatternMatchingLogic> {
  final bool skipResultScreen;

  const PatternMatchingScreen({
    super.key,
    super.initialSettings,
    this.skipResultScreen = false,
  }) : super(enableHomeButton: false);

  @override
  PatternMatchingScreenState createState() => PatternMatchingScreenState();
}

class PatternMatchingScreenState extends BaseGameScreenState<
    PatternMatchingScreen,
    PatternMatchingSettings,
    PatternMatchingState,
    ModernPatternMatchingLogic> {
  static const double _horizontalPadding = 20.0;
  static const double _verticalSpacing = 20.0;
  static const double _shapeSize = 70.0;

  @override
  String get gameTitle => 'きそくせい';

  @override
  PatternMatchingState watchState(WidgetRef ref) =>
      ref.watch(modernPatternMatchingLogicProvider);

  @override
  ModernPatternMatchingLogic readLogic(WidgetRef ref) =>
      ref.read(modernPatternMatchingLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(PatternMatchingState s) {
    if (s.phase == CommonGamePhase.completed && widget.skipResultScreen) {
      return GameUiPhase.playing;
    }
    return s.phase.toGameUiPhase;
  }

  @override
  PatternMatchingSettings? settingsOf(PatternMatchingState s) => s.settings;

  @override
  int? scoreOf(PatternMatchingState s) => s.session?.correctCount;

  @override
  int totalQuestionsOf(PatternMatchingSettings s) => s.questionCount;

  @override
  String getSettingsDisplayName(PatternMatchingSettings settings) =>
      settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFFF0F8FF),
      Color(0xFFE6F3FF),
    ];
  }

  @override
  String? getQuestionText(PatternMatchingState state) {
    return state.canAnswer && state.session != null
        ? state.session!.currentProblem?.questionText
        : null;
  }

  @override
  String? getProgressText(PatternMatchingState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }

  @override
  void initializeGame() {
    // 即開始ゲーム：設定なしで自動スタート
    final logic = readLogic(ref);
    final settings = widget.initialSettings ?? const PatternMatchingSettings(questionCount: 5);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logic.startGame(settings);
    });
  }

  @override
  Widget buildSettingsView(
      BuildContext context, void Function(PatternMatchingSettings) onStart) {
    // 即開始ゲームなので設定画面は表示しない
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget buildPlayingView(BuildContext context, PatternMatchingState state,
      ModernPatternMatchingLogic logic) {
    if (state.session == null || state.session!.currentProblem == null) {
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

    final problem = state.session!.currentProblem!;

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: _buildQuestionScreen(context, state, logic, problem),
            ),
          ],
        ),
        // Success effect overlay
        if (state.phase == CommonGamePhase.feedbackOk)
          SuccessEffect(
            onComplete: () {},
            hadWrongAnswer: (state.session?.wrongAttempts ?? 0) > 0,
          ),
      ],
    );
  }

  Widget _buildQuestionScreen(
    BuildContext context,
    PatternMatchingState state,
    ModernPatternMatchingLogic logic,
    PatternMatchingProblem problem,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // marginを考慮した実際の幅を計算
        final actualWidth = constraints.maxWidth - (_horizontalPadding * 2);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 上段：9個の図形（規則性のあるシーケンス）
              _buildSequence(context, problem, actualWidth),

              SizedBox(height: _verticalSpacing * 2),

              // 下段：3個の選択肢ボタン
              _buildChoiceButtons(context, state, logic, problem, actualWidth),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSequence(
    BuildContext context,
    PatternMatchingProblem problem,
    double containerWidth,
  ) {
    // 外側を大きく、内側を小さく
    final spacing = 2.0;
    final totalSpacing = spacing * 8;
    final padding = 16.0;
    final borderWidth = 3.0;
    // 内側の図形サイズをさらに小さく計算（+2で調整）
    final availableWidth = containerWidth - (padding * 2) - (borderWidth * 2) - totalSpacing - 2;
    final shapeSize = availableWidth / 9;

    return Container(
      width: containerWidth, // 外側を明示的に設定
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        border: Border.all(
          color: const Color(0xFF9E9E9E),
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(9, (index) {
          final spec = problem.sequence[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing / 2),
            child: spec == null
                ? _buildQuestionMark(shapeSize)
                : PatternShapeWidget(
                    spec: spec,
                    size: shapeSize,
                  ),
          );
        }),
      ),
    );
  }

  Widget _buildQuestionMark(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE53935), // 赤枠
          width: 4,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '？',
          style: TextStyle(
            fontSize: size * 0.5,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFE53935),
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceButtons(
    BuildContext context,
    PatternMatchingState state,
    ModernPatternMatchingLogic logic,
    PatternMatchingProblem problem,
    double containerWidth,
  ) {
    // 上段と同じサイズ計算
    final spacing = 2.0;
    final totalSpacing = spacing * 8;
    final padding = 16.0;
    final borderWidth = 3.0;
    // 内側の図形サイズをさらに小さく計算（+2で調整）
    final availableWidth = containerWidth - (padding * 2) - (borderWidth * 2) - totalSpacing - 2;
    final shapeSize = availableWidth / 9;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: _buildChoiceButton(
            context,
            state,
            logic,
            problem.choices[index],
            index,
            shapeSize,
          ),
        );
      }),
    );
  }

  Widget _buildChoiceButton(
    BuildContext context,
    PatternMatchingState state,
    ModernPatternMatchingLogic logic,
    PatternSpec spec,
    int index,
    double size,
  ) {
    return GestureDetector(
      onTap: state.canAnswer ? () => logic.answerQuestion(index) : null,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFF4A90E2),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: CustomPaint(
            painter: PatternShapePainter(spec: spec),
          ),
        ),
      ),
    );
  }
}
