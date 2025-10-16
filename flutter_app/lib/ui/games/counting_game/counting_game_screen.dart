import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/success_effect.dart';
import '../base/base_game_screen.dart';
import 'models/counting_models.dart';
import '../base/common_game_phase.dart';
import '../base/common_game_widgets.dart';
import 'widgets/dot_display_container.dart';
import 'widgets/answer_button.dart';
import 'modern_counting_logic.dart';

class CountingGameScreen extends BaseGameScreen<
    CountingGameSettings, CountingState, ModernCountingLogic> {
  final bool skipResultScreen;
  
  const CountingGameScreen({
    super.key,
    super.initialSettings,
    this.skipResultScreen = false,
  }) : super(
        enableHomeButton: true, // Counting はホームボタンあり
      );

  @override
  CountingGameScreenState createState() => CountingGameScreenState();
}

class CountingGameScreenState extends BaseGameScreenState<
    CountingGameScreen, CountingGameSettings, CountingState, ModernCountingLogic> {

  // レスポンシブサイズ定数
  static const double _headerHeightRatio = 0.07;
  static const double _dotMinSizeRatio = 0.266;
  static const double _dotMaxSizeRatio = 0.532;
  static const double _buttonMinSizeRatio = 0.0539;
  static const double _buttonMaxSizeRatio = 0.0898;
  static const double _buttonSpacingRatio = 0.02;
  static const double _buttonFontSizeRatio = 0.48;
  static const double _dotSizeMinRatio = 0.02;
  static const double _dotSizeMaxRatio = 0.06;

  @override
  String get gameTitle => 'かずかぞえ';

  // Riverpod: 状態購読（直接）
  @override
  CountingState watchState(WidgetRef ref) =>
      ref.watch(modernCountingLogicProvider);

  // Riverpod: ロジック取得（直接）
  @override
  ModernCountingLogic readLogic(WidgetRef ref) =>
      ref.read(modernCountingLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(CountingState s) {
    if (s.phase == CommonGamePhase.completed && widget.skipResultScreen) {
      return GameUiPhase.playing;
    }
    return s.phase.toGameUiPhase;
  }

  @override
  CountingGameSettings? settingsOf(CountingState s) => s.settings;

  @override
  int? scoreOf(CountingState s) => s.session?.score;

  @override
  int totalQuestionsOf(CountingGameSettings s) => s.questionCount;

  @override
  String getSettingsDisplayName(CountingGameSettings settings) => settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFF4A90E2), // 青いグラデーション（上）
      Color(0xFF357ABD), // 青いグラデーション（下）
    ];
  }

  // ヘッダー情報の実装
  @override
  String? getQuestionText(CountingState state) {
    return state.session != null
        ? state.session!.current.questionText
        : null;
  }

  // getSpeakerCallback と getIsSpeaking は BaseGameScreen が自動実装

  @override
  String? getProgressText(CountingState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }

  // ゲーム初期化
  @override
  void initializeGame() {
    // BaseGameScreenが自動的にTTSを初期化するため、特別な初期化は不要
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 画面構築 - 最小限の実装
  @override
  Widget buildSettingsView(BuildContext context, void Function(CountingGameSettings) onStart) {
    return _buildRangeSelection(context, onStart);
  }

  Widget _buildRangeSelection(BuildContext context, void Function(CountingGameSettings) onStart) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'どのはんいでやる？',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildRangeCard(context, '1-5', CountingRange.range1to5, Colors.lightBlue, onStart),
            _buildRangeCard(context, '5-10', CountingRange.range5to10, Colors.blue, onStart),
            _buildRangeCard(context, '1-10', CountingRange.range1to10, Colors.indigo, onStart),
          ],
        ),
      ],
    );
  }

  Widget _buildRangeCard(BuildContext context, String label, CountingRange range, Color color, void Function(CountingGameSettings) onStart) {
    return GestureDetector(
      onTap: () {
        final settings = CountingGameSettings(
          range: range,
          questionCount: 5,
        );
        onStart(settings);
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildPlayingView(BuildContext context, CountingState state, ModernCountingLogic logic) {
    // BaseGameScreenが自動的に質問テキストの変更を検出して再生

    if (state.session == null) {
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

    return Stack(
      children: [
        // Question screen content (background handled by BaseGameScreen)
        _buildQuestionScreen(context, state, logic),

        // Success effect overlay
        if (state.showSuccessEffect)
          SuccessEffect(
            onComplete: () => logic.hideSuccessEffect(),
            hadWrongAnswer: state.hadAnyWrongAnswer,
          ),
      ],
    );
  }

  // _handleSpeakerPressed は BaseGameScreen が自動実装

  Widget _buildQuestionScreen(BuildContext context, CountingState state, ModernCountingLogic logic) {
    final question = state.session!.current;

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8), // ヘッダーと問題の間に空白を追加

          // ドット表示（白い枠内）
          DotDisplayContainer(
            child: _buildDotDisplay(
              question.targetNumber,
              question.dotShape,
              question.dotColor,
              ref,
              question.dotPositions[question.targetNumber]!,
              state,
            ),
          ),

          const SizedBox(height: 2),

          // Answer options
          _buildAnswerOptions(context, state, logic, ref),
        ],
      ),
    );
  }

  Widget _buildDotDisplay(int number, DotShape dotShape, Color dotColor, WidgetRef ref, List<Offset> positions, CountingState gameState) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        
        final headerHeight = screenHeight * _headerHeightRatio;
        final progressHeight = 8.0;
        final buttonHeight = screenWidth * 0.18;
        final margins = screenHeight * 0.12;
        final headerSpacing = 8.0; // ヘッダーと問題の間の空白
        final bottomSpacing = 2.0; // 問題と選択肢の間の空白
        final availableHeight = screenHeight - headerHeight - progressHeight - buttonHeight - margins - headerSpacing - bottomSpacing;
        final availableWidth = screenWidth * 0.9;

        final minSize = screenWidth * _dotMinSizeRatio;
        final maxSize = screenWidth * _dotMaxSizeRatio;
        final rawSize = (availableHeight < availableWidth ? availableHeight : availableWidth).clamp(minSize, maxSize);
        final dotDisplaySize = rawSize * 0.94; // 6%縮小
        
        const originalSize = 540.0;
        final scale = dotDisplaySize / originalSize;
        
        final scaledPositions = positions.map((pos) => Offset(pos.dx * scale, pos.dy * scale)).toList();
        
        final minDotSize = screenWidth * _dotSizeMinRatio;
        final maxDotSize = screenWidth * _dotSizeMaxRatio;
        final dynamicDotSize = (dotDisplaySize / 12).clamp(minDotSize, maxDotSize);
        
        return SizedBox(
          width: dotDisplaySize,
          height: dotDisplaySize,
          child: Stack(
            children: ref.read(modernCountingLogicProvider.notifier).buildDotsFromPositions(
              scaledPositions,
              dotShape,
              dotColor,
              dynamicDotSize,
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnswerOptions(BuildContext context, CountingState gameState, ModernCountingLogic gameLogic, WidgetRef ref) {
    final question = gameState.session!.current;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: question.options.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * _buttonSpacingRatio),
          child: _buildAnswerButton(
            option.toString(),
            () => gameLogic.answerQuestion(index),
            gameState.session?.currentWrong ?? false,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnswerButton(String text, VoidCallback onPressed, bool hadWrongAnswer) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final minButtonSize = screenWidth * _buttonMinSizeRatio;
        final maxButtonSize = screenWidth * _buttonMaxSizeRatio;
        final buttonSize = (screenWidth / 5).clamp(minButtonSize, maxButtonSize);
        
        return AnswerButton(
          text: text,
          onPressed: onPressed,
          hadWrongAnswer: hadWrongAnswer,
          size: buttonSize,
          fontSizeRatio: _buttonFontSizeRatio,
        );
      },
    );
  }

}