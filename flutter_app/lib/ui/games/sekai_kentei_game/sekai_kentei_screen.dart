import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../base/base_game_screen.dart';
import '../base/common_game_phase.dart';
import '../../components/success_effect.dart';
import 'models/sekai_kentei_models.dart';
import 'modern_sekai_kentei_logic.dart';

class SekaiKenteiScreen extends BaseGameScreen<SekaiKenteiSettings, SekaiKenteiState, ModernSekaiKenteiLogic> {
  const SekaiKenteiScreen({
    super.key,
    super.initialSettings,
  });

  @override
  BaseGameScreenState<SekaiKenteiScreen, SekaiKenteiSettings, SekaiKenteiState, ModernSekaiKenteiLogic>
      createState() => _SekaiKenteiScreenState();
}

class _SekaiKenteiScreenState extends BaseGameScreenState<
    SekaiKenteiScreen,
    SekaiKenteiSettings,
    SekaiKenteiState,
    ModernSekaiKenteiLogic> {

  @override
  String get gameTitle => '世界遺産検定4級クイズ';

  @override
  SekaiKenteiState watchState(WidgetRef ref) =>
      ref.watch(modernSekaiKenteiLogicProvider);

  @override
  ModernSekaiKenteiLogic readLogic(WidgetRef ref) =>
      ref.read(modernSekaiKenteiLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(SekaiKenteiState s) {
    return s.phase.toGameUiPhase;
  }

  @override
  SekaiKenteiSettings? settingsOf(SekaiKenteiState s) => s.settings;

  @override
  int? scoreOf(SekaiKenteiState s) {
    if (s.session == null) return null;
    return s.session!.correctCount;
  }

  @override
  int totalQuestionsOf(SekaiKenteiSettings settings) => settings.questionCount;

  @override
  String getSettingsDisplayName(SekaiKenteiSettings settings) => settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFFE3F2FD), // 薄い青（上）
      Color(0xFFBBDEFB), // 薄い青（下）
    ];
  }

  @override
  String? getQuestionText(SekaiKenteiState state) {
    return state.questionText;
  }

  @override
  String? getProgressText(SekaiKenteiState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }

  @override
  Widget buildSettingsView(BuildContext context, void Function(SekaiKenteiSettings) onStart) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '世界遺産検定4級クイズ',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'テーマを選んで開始',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF424242),
              ),
            ),
            const SizedBox(height: 48),

            // 3つのテーマボタン
            ...QuizTheme.values.map((theme) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildThemeButton(
                theme: theme,
                onPressed: () {
                  onStart(SekaiKenteiSettings(theme: theme));
                },
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeButton({
    required QuizTheme theme,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5B9BD5),
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        ),
        child: Text(
          theme.displayName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget buildPlayingView(BuildContext context, SekaiKenteiState state, ModernSekaiKenteiLogic logic) {
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
              colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 問題文エリア
                    _buildQuestionArea(problem, screenSize),
                    const SizedBox(height: 32),

                    // 四択選択肢（縦並び）
                    _buildVerticalOptions(
                      problem,
                      session,
                      state,
                      logic,
                      screenSize,
                    ),
                  ],
                ),
              ),
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

  Widget _buildQuestionArea(SekaiKenteiProblem problem, Size screenSize) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF5B9BD5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '問題',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            problem.question,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalOptions(
    SekaiKenteiProblem problem,
    SekaiKenteiSession session,
    SekaiKenteiState state,
    ModernSekaiKenteiLogic logic,
    Size screenSize,
  ) {
    return Column(
      children: List.generate(problem.options.length, (index) {
        final option = problem.options[index];
        final isCorrect = index == problem.correctIndex;
        final showResult = state.phase == CommonGamePhase.feedbackOk ||
                         state.phase == CommonGamePhase.feedbackNg;
        final isSelected = state.lastResult?.selectedIndex == index;

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildOptionButton(
            option: option,
            index: index,
            isCorrect: isCorrect,
            showResult: showResult,
            isSelected: isSelected,
            canAnswer: state.canAnswer,
            onTap: () => logic.answerQuestion(index),
          ),
        );
      }),
    );
  }

  Widget _buildOptionButton({
    required String option,
    required int index,
    required bool isCorrect,
    required bool showResult,
    required bool isSelected,
    required bool canAnswer,
    required VoidCallback onTap,
  }) {
    Color backgroundColor = const Color(0xFFF5F5F5);
    Color borderColor = const Color(0xFFBDBDBD);
    Color textColor = const Color(0xFF424242);

    if (showResult) {
      if (isCorrect) {
        backgroundColor = const Color(0xFFC8E6C9);
        borderColor = const Color(0xFF4CAF50);
        textColor = const Color(0xFF2E7D32);
      } else if (isSelected) {
        backgroundColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFF44336);
        textColor = const Color(0xFFC62828);
      }
    }

    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: canAnswer ? onTap : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: borderColor,
              width: showResult && (isCorrect || isSelected) ? 3 : 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            option,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
