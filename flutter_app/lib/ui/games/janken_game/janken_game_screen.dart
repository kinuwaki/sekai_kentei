import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/success_effect.dart';
import '../base/base_game_screen.dart';
import 'models/janken_game_models.dart';
import '../base/common_game_phase.dart';
import 'modern_janken_logic.dart';
import '../base/common_game_widgets.dart';

class JankenGameScreen extends BaseGameScreen<JankenGameSettings, JankenState,
    ModernJankenLogic> {
  final bool skipResultScreen;

  const JankenGameScreen({
    super.key,
    super.initialSettings,
    this.skipResultScreen = false,
  }) : super(
          enableHomeButton: false,
        );

  @override
  JankenGameScreenState createState() => JankenGameScreenState();
}

class JankenGameScreenState extends BaseGameScreenState<JankenGameScreen,
    JankenGameSettings, JankenState, ModernJankenLogic> {
  // レイアウト定数
  static const double _horizontalPadding = 40.0;
  static const double _exampleContainerSize = 200.0;
  static const double _choiceContainerSize = 150.0;
  static const double _containerSpacing = 30.0;
  static const double _emojiSize = 100.0;
  static const double _choiceEmojiSize = 70.0;

  @override
  String get gameTitle => 'じゃんけん';

  // Riverpod: 状態購読
  @override
  JankenState watchState(WidgetRef ref) =>
      ref.watch(modernJankenLogicProvider);

  // Riverpod: ロジック取得
  @override
  ModernJankenLogic readLogic(WidgetRef ref) =>
      ref.read(modernJankenLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(JankenState s) {
    if (s.phase == CommonGamePhase.completed && widget.skipResultScreen) {
      return GameUiPhase.playing;
    }
    return s.phase.toGameUiPhase;
  }

  @override
  JankenGameSettings? settingsOf(JankenState s) => s.settings;

  @override
  int? scoreOf(JankenState s) => s.session?.score;

  @override
  int totalQuestionsOf(JankenGameSettings s) => s.questionCount;

  @override
  String getSettingsDisplayName(JankenGameSettings settings) =>
      settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFFFFF8DC), // クリーム色（上）
      Color(0xFFFFE4B5), // モカシン色（下）
    ];
  }

  // ヘッダー情報の実装
  @override
  String? getQuestionText(JankenState state) {
    return state.canAnswer && state.session != null
        ? state.session!.current.questionText
        : null;
  }

  @override
  String? getProgressText(JankenState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }

  @override
  void initializeGame() {
    // 特別な初期化は不要
  }

  // 画面構築
  @override
  Widget buildSettingsView(
      BuildContext context, void Function(JankenGameSettings) onStart) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'モードをえらんでね',
            style: TextStyle(
              fontSize: screenHeight * 0.04,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF8B4513),
            ),
          ),
          SizedBox(height: screenHeight * 0.06),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: JankenGameMode.values.map((mode) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: _buildModeButton(
                  context,
                  mode,
                  () => onStart(JankenGameSettings(mode: mode)),
                  screenHeight,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildModeButton(
      BuildContext context, JankenGameMode mode, VoidCallback onPressed, double screenHeight) {
    return SizedBox(
      width: screenHeight * 0.18,
      height: screenHeight * 0.12,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFD700),
          foregroundColor: const Color(0xFF8B4513),
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          mode.displayName,
          style: TextStyle(
            fontSize: screenHeight * 0.038,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildPlayingView(
      BuildContext context, JankenState state, ModernJankenLogic logic) {
    if (state.session == null) {
      return const Center(
        child: Text(
          'もんだいを よみこみちゅう...',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B4513),
          ),
        ),
      );
    }

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: _buildGameContent(context, state, logic),
            ),
          ],
        ),
        // Success effect overlay
        if (state.showSuccessEffect)
          SuccessEffect(
            onComplete: () {},
            hadWrongAnswer: state.hadAnyWrongAnswer,
          ),
      ],
    );
  }

  Widget _buildGameContent(
      BuildContext context, JankenState state, ModernJankenLogic logic) {
    final problem = state.session!.current;
    final screenSize = MediaQuery.of(context).size;

    return Row(
      children: [
        // 左側：お手本
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'みほん',
                  style: TextStyle(
                    fontSize: screenSize.height * 0.035,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF8B4513),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _buildExampleContainer(problem.exampleHand),
                ),
              ],
            ),
          ),
        ),

        // 右側：選択肢
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'こたえ',
                  style: TextStyle(
                    fontSize: screenSize.height * 0.035,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF8B4513),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _buildChoicesGrid(context, state, problem, logic, screenSize),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExampleContainer(JankenHand hand) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // お手本は利用可能な領域いっぱいに表示
        final size = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;
        final emojiSize = size * 0.5;

        return Center(
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFFFD700),
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                hand.emoji,
                style: TextStyle(fontSize: emojiSize),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChoicesGrid(BuildContext context, JankenState state,
      JankenProblem problem, ModernJankenLogic logic, Size screenSize) {
    // 3つの選択肢を2列に配置（1つ目は上、2-3つ目は下に横並び）
    // パズルゲームのレイアウトを参考
    return LayoutBuilder(
      builder: (context, constraints) {
        // 利用可能な領域の計算
        final availableWidth = constraints.maxWidth;
        final availableHeight = constraints.maxHeight;

        // 縦横の間隔を割合で計算
        final verticalSpacing = availableHeight * 0.02;
        final horizontalSpacing = availableWidth * 0.02;

        // ボタンサイズの計算（下段に2つ並ぶことを前提）
        final totalHorizontalSpacing = horizontalSpacing;
        double buttonWidth = (availableWidth - totalHorizontalSpacing) / 2;

        // 高さは上段＋下段＋間隔から逆算
        final totalVerticalSpacing = verticalSpacing;
        double buttonHeight = (availableHeight - totalVerticalSpacing) / 2;

        // 正方形を維持（小さい方に合わせる）
        final buttonSize = buttonWidth < buttonHeight ? buttonWidth : buttonHeight;

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 上段：1つ目の選択肢
              SizedBox(
                width: buttonSize,
                height: buttonSize,
                child: _buildChoiceButton(
                  problem.choices[0],
                  () {
                    if (state.canAnswer) {
                      logic.answerQuestion(0);
                    }
                  },
                  isCorrect: 0 == problem.correctAnswerIndex,
                  showResult: state.phase == CommonGamePhase.feedbackNg,
                  enabled: state.canAnswer,
                  buttonSize: buttonSize,
                ),
              ),

              // 縦間隔
              SizedBox(height: verticalSpacing),

              // 下段：2-3つ目の選択肢を横並び
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: buttonSize,
                    height: buttonSize,
                    child: _buildChoiceButton(
                      problem.choices[1],
                      () {
                        if (state.canAnswer) {
                          logic.answerQuestion(1);
                        }
                      },
                      isCorrect: 1 == problem.correctAnswerIndex,
                      showResult: state.phase == CommonGamePhase.feedbackNg,
                      enabled: state.canAnswer,
                      buttonSize: buttonSize,
                    ),
                  ),
                  SizedBox(width: horizontalSpacing),
                  SizedBox(
                    width: buttonSize,
                    height: buttonSize,
                    child: _buildChoiceButton(
                      problem.choices[2],
                      () {
                        if (state.canAnswer) {
                          logic.answerQuestion(2);
                        }
                      },
                      isCorrect: 2 == problem.correctAnswerIndex,
                      showResult: state.phase == CommonGamePhase.feedbackNg,
                      enabled: state.canAnswer,
                      buttonSize: buttonSize,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChoiceButton(
    JankenHand hand,
    VoidCallback onPressed, {
    required bool isCorrect,
    required bool showResult,
    required bool enabled,
    required double buttonSize,
  }) {
    Color backgroundColor = Colors.white;
    Color borderColor = const Color(0xFFDEB887);

    if (showResult) {
      if (isCorrect) {
        backgroundColor = const Color(0xFF90EE90);
        borderColor = const Color(0xFF32CD32);
      } else {
        backgroundColor = const Color(0xFFFFB6C1);
        borderColor = const Color(0xFFFF69B4);
      }
    }

    final emojiSize = buttonSize * 0.5;

    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: borderColor,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            hand.emoji,
            style: TextStyle(fontSize: emojiSize),
          ),
        ),
      ),
    );
  }
}
