import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/success_effect.dart';
import '../../../services/dot_layout_service.dart';
import '../base/base_game_screen.dart';
import 'models/comparison_models.dart';
import '../base/common_game_phase.dart';
import 'modern_comparison_logic.dart';
import '../base/common_game_widgets.dart';

class ComparisonGameScreen extends BaseGameScreen<
    ComparisonGameSettings, ComparisonState, ModernComparisonLogic> {
  final bool skipResultScreen;
  
  const ComparisonGameScreen({
    super.key,
    super.initialSettings,
    this.skipResultScreen = false,
  }) : super(
        enableHomeButton: false, // Comparison はホームボタンなし
      );

  @override
  ComparisonGameScreenState createState() => ComparisonGameScreenState();
}

class ComparisonGameScreenState extends BaseGameScreenState<
    ComparisonGameScreen, ComparisonGameSettings, ComparisonState, ModernComparisonLogic> {

  // レイアウト定数
  static const double _horizontalPadding = 20.0;
  static const double _optionSpacing = 20.0;
  static const double _containerPadding = 6.0;  // かずかぞえと同じパディング
  static const double _twoOptionHeightRatio = 0.85;  // 2択の高さを最大化
  static const double _multiOptionHeightRatio = 0.75;  // 3択の高さを最大化  
  static const double _fourOptionHeightRatio = 0.45;  // 4択の高さを最大化（2行なので）
  static const double _digitFontSizeRatio = 0.25; // 画面幅に対する比率

  @override
  String get gameTitle => 'おおきい・ちいさい';

  // Riverpod: 状態購読（直接）
  @override
  ComparisonState watchState(WidgetRef ref) =>
      ref.watch(modernComparisonLogicProvider);

  // Riverpod: ロジック取得（直接）
  @override
  ModernComparisonLogic readLogic(WidgetRef ref) =>
      ref.read(modernComparisonLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(ComparisonState s) {
    if (s.phase == CommonGamePhase.completed && widget.skipResultScreen) {
      return GameUiPhase.playing;
    }
    return s.phase.toGameUiPhase;
  }

  @override
  ComparisonGameSettings? settingsOf(ComparisonState s) => s.settings;

  @override
  int? scoreOf(ComparisonState s) => s.session?.score;

  @override
  int totalQuestionsOf(ComparisonGameSettings s) => s.questionCount;

  @override
  String getSettingsDisplayName(ComparisonGameSettings settings) => settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFF4A90E2), // 青いグラデーション（上）
      Color(0xFF357ABD), // 青いグラデーション（下）
    ];
  }

  // ヘッダー情報の実装
  @override
  String? getQuestionText(ComparisonState state) {
    return state.canAnswer && state.session != null
        ? state.session!.current.questionText
        : null;
  }

  // getSpeakerCallback と getIsSpeaking は BaseGameScreen が自動実装

  @override
  String? getProgressText(ComparisonState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }

  // BaseGameScreenが自動的にTTSを初期化
  @override
  void initializeGame() {
    // 特別な初期化は不要
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 画面構築
  @override
  Widget buildSettingsView(BuildContext context, void Function(ComparisonGameSettings) onStart) {
    return const GameLoadingWidget();
  }

  @override
  Widget buildPlayingView(BuildContext context, ComparisonState state, ModernComparisonLogic logic) {
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
        // Content (background handled by BaseGameScreen)
        Column(
          children: [
            Expanded(
              child: _buildQuestionScreen(context, state, logic, ref),
            ),
          ],
        ),
        // Success effect overlay
        if (state.showSuccessEffect)
          SuccessEffect(
            onComplete: () => logic.hideSuccessEffect(),
            hadWrongAnswer: state.hadAnyWrongAnswer,
          ),
      ],
    );
  }

  Widget _buildQuestionScreen(BuildContext context, ComparisonState gameState, ModernComparisonLogic gameLogic, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Answer options - 全高さを使用
          Expanded(
            child: _buildAnswerOptions(context, gameState, gameLogic, ref),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOptions(BuildContext context, ComparisonState gameState, ModernComparisonLogic gameLogic, WidgetRef ref) {
    final question = gameState.session!.current;
    final settings = gameState.settings!;
    
    if (settings.optionCount == 2) {
      // 2択の場合：左右に大きく表示（中央寄せで適切な間隔）
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _buildComparisonOption(
                question.options[0],
                question.dotShape,
                question.dotColor,
                () => gameLogic.answerQuestion(0),
                gameState.session?.currentWrong ?? false,
                ref,
                context,
                settings.displayType,
                dotSizes: question.dotSizes,
                dotPositions: question.dotPositions,
                isMultipleChoice: false,
                gameState: gameState,
              ),
            ),
            SizedBox(width: _optionSpacing),
            Expanded(
              child: _buildComparisonOption(
                question.options[1],
                question.dotShape,
                question.dotColor,
                () => gameLogic.answerQuestion(1),
                gameState.session?.currentWrong ?? false,
                ref,
                context,
                settings.displayType,
                dotSizes: question.dotSizes,
                dotPositions: question.dotPositions,
                isMultipleChoice: false,
                gameState: gameState,
              ),
            ),
          ],
        ),
      );
    } else if (question.options.length <= 3) {
      // 3択の場合：画面内に収める
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: question.options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: _optionSpacing / 4),
                child: _buildComparisonOption(
                  option,
                  question.dotShape,
                  question.dotColor,
                  () => gameLogic.answerQuestion(index),
                  gameState.session?.currentWrong ?? false,
                  ref,
                  context,
                  settings.displayType,
                  dotSizes: question.dotSizes,
                  dotPositions: question.dotPositions,
                  isMultipleChoice: true,
                  gameState: gameState,
                ),
              ),
            );
          }).toList(),
        ),
      );
    } else {
      // 4択以上の場合：2行に分ける
      final halfLength = (question.options.length / 2).ceil();
      final firstRow = question.options.sublist(0, halfLength);
      final secondRow = question.options.sublist(halfLength);
      
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: firstRow.asMap().entries.map((entry) {
                final index = entry.key;
                final option = entry.value;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: _optionSpacing / 4),
                    child: _buildComparisonOption(
                      option,
                      question.dotShape,
                      question.dotColor,
                      () => gameLogic.answerQuestion(index),
                      gameState.session?.currentWrong ?? false,
                      ref,
                      context,
                      settings.displayType,
                      dotSizes: question.dotSizes,
                      dotPositions: question.dotPositions,
                      isMultipleChoice: true,
                      gameState: gameState,
                      isFourOption: true,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: _optionSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: secondRow.asMap().entries.map((entry) {
                final actualIndex = halfLength + entry.key;
                final option = entry.value;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: _optionSpacing / 4),
                    child: _buildComparisonOption(
                      option,
                      question.dotShape,
                      question.dotColor,
                      () => gameLogic.answerQuestion(actualIndex),
                      gameState.session?.currentWrong ?? false,
                      ref,
                      context,
                      settings.displayType,
                      dotSizes: question.dotSizes,
                      dotPositions: question.dotPositions,
                      isMultipleChoice: true,
                      gameState: gameState,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildComparisonOption(int number, DotShape dotShape, Color dotColor, VoidCallback onPressed, bool hadWrongAnswer, WidgetRef ref, BuildContext context, ComparisonDisplayType displayType, {Map<int, double>? dotSizes, Map<int, List<Offset>>? dotPositions, bool isMultipleChoice = false, ComparisonState? gameState, bool isFourOption = false}) {
    final screenSize = MediaQuery.of(context).size;
    
    // 画面サイズに応じて動的にサイズを設定
    // Expandedを使用するため、幅は指定しない
    final containerWidth = null;  // Expandedで自動調整
    final containerHeight = isFourOption
        ? screenSize.height * _fourOptionHeightRatio  // 4択の場合は小さく
        : isMultipleChoice
            ? screenSize.height * _multiOptionHeightRatio  // 3択の場合
            : screenSize.height * _twoOptionHeightRatio;  // 2択の場合
    
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: containerWidth,
        height: containerHeight,
        padding: EdgeInsets.all(_containerPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: hadWrongAnswer ? Border.all(color: Colors.red, width: 3) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: displayType == ComparisonDisplayType.digits
            ? // 数字のみ表示：ボックス全体に大きく中央表示
              Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // コンテナの実際のサイズから適切なフォントサイズを計算
                    final fontSize = isMultipleChoice 
                        ? constraints.maxWidth * 0.4  // コンテナ幅の40%
                        : screenSize.width * _digitFontSizeRatio;  // 画面幅の比率
                    
                    return Text(
                      number.toString(),
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2E3A59),
                      ),
                    );
                  },
                ),
              )
            : // ドット表示：最大限画面を活用
              LayoutBuilder(
                      builder: (context, constraints) {
                        final dotContainerWidth = constraints.maxWidth;
                        final dotContainerHeight = constraints.maxHeight;
                        
                        // 実際のコンテナサイズで統一ドットサイズを計算
                        final dotLayoutService = DotLayoutService();

                        // 全選択肢の中で最小のドットサイズを計算（統一サイズ）
                        double uniformDotSize = double.infinity;
                        if (gameState?.session?.current != null) {
                          for (final option in gameState!.session!.current.options) {
                            final dotSize = dotLayoutService.calculateDotSize(
                              dotContainerWidth, dotContainerHeight, option
                            );
                            if (dotSize < uniformDotSize) {
                              uniformDotSize = dotSize;
                            }
                          }
                        }

                        // 統一サイズでドット位置を生成
                        final actualDotPositions = dotLayoutService.generateDotPositions(
                          count: number,
                          containerWidth: dotContainerWidth,
                          containerHeight: dotContainerHeight,
                          seed: number * 1000 + (gameState?.session?.index ?? 0),
                          customDotRadius: uniformDotSize,
                        );
                        
                        return SizedBox(
                          width: dotContainerWidth,
                          height: dotContainerHeight,
                          child: Stack(
                            children: ref.read(modernComparisonLogicProvider.notifier).buildDotsFromPositions(
                              actualDotPositions,
                              dotShape,
                              dotColor,
                              uniformDotSize,
                            ),
                          ),
                        );
                      }
                ),
      ),
    );
  }



  // _handleSpeakerPressed は BaseGameScreen が自動実装
}