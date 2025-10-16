import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/figure_orientation_models.dart';
import '../base/common_game_phase.dart';
import 'modern_figure_orientation_logic.dart';
import 'widgets/figure_tile_widget.dart';
import '../base/base_game_screen.dart';
import '../../components/success_effect.dart';

class FigureOrientationGameScreen extends BaseGameScreen<
    FigureOrientationSettings,
    FigureOrientationState,
    ModernFigureOrientationLogic> {
  const FigureOrientationGameScreen({
    super.key,
    super.initialSettings,
  });

  @override
  FigureOrientationGameScreenState createState() => FigureOrientationGameScreenState();
}

class FigureOrientationGameScreenState extends BaseGameScreenState<
    FigureOrientationGameScreen, FigureOrientationSettings, FigureOrientationState, ModernFigureOrientationLogic> {

  @override
  String get gameTitle => 'ずけいのむき';

  @override
  FigureOrientationState watchState(WidgetRef ref) =>
      ref.watch(modernFigureOrientationLogicProvider);

  @override
  ModernFigureOrientationLogic readLogic(WidgetRef ref) =>
      ref.read(modernFigureOrientationLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(FigureOrientationState state) {
    return state.phase.toGameUiPhase;
  }

  @override
  FigureOrientationSettings? settingsOf(FigureOrientationState s) => s.settings;

  @override
  int? scoreOf(FigureOrientationState s) => s.session?.correctCount;

  @override
  int totalQuestionsOf(FigureOrientationSettings settings) => settings.questionCount;

  @override
  String getSettingsDisplayName(FigureOrientationSettings settings) => settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFFF0F8FF), // 水色のグラデーション（上）
      Color(0xFFE6F3FF), // 水色のグラデーション（下）
    ];
  }

  @override
  String? getQuestionText(FigureOrientationState state) {
    return state.canAnswer && state.session != null
        ? state.session!.currentProblem?.questionText
        : null;
  }

  @override
  String? getProgressText(FigureOrientationState state) {
    return state.session != null && state.settings != null
        ? '${(state.session!.index) + 1}/${state.settings!.questionCount}'
        : null;
  }

  @override
  Widget buildSettingsView(BuildContext context, void Function(FigureOrientationSettings) onStart) {
    // 設定画面をスキップして自動的に開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final defaultSettings = FigureOrientationSettings(
        range: FigureOrientationRange.medium,  // ふつう（000-012を使用）
        questionCount: 5,  // 5問固定
      );
      onStart(defaultSettings);
    });
    
    // ローディング画面を表示
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          const Text(
            'ゲームを じゅんび しています...',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildPlayingView(BuildContext context, FigureOrientationState state, ModernFigureOrientationLogic logic) {

    return Stack(
      children: [
        // 背景グラデーション
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF0F8FF), Color(0xFFE6F3FF)],
            ),
          ),
        ),

        // メインコンテンツ（BaseGameScreenで既にSafeAreaされているので不要）
        Center(
          child: state.session?.currentProblem?.options.isEmpty ?? true
              ? const CircularProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: state.session!.currentProblem!.options
                      .asMap()
                      .entries
                      .map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    // フィードバック表示中のみ選択状態を表示
                    final showingFeedback = state.phase == CommonGamePhase.feedbackOk ||
                                           state.phase == CommonGamePhase.feedbackNg;
                    final isSelected = showingFeedback && state.lastResult?.selectedIndex == index;

                    return FigureAnswerButton(
                      option: option,
                      isSelected: isSelected,
                      showResult: showingFeedback,
                      onPressed: state.canAnswer
                          ? () => logic.answerQuestion(index)
                          : null,
                    );
                  }).toList(),
                ),
        ),

        // 成功エフェクト
        if (state.phase == CommonGamePhase.feedbackOk)
          const SuccessEffect(),
      ],
    );
  }

}