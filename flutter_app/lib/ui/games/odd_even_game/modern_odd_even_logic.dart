import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/odd_even_models.dart';
import '../base/common_game_phase.dart';
import '../base/answer_handler_mixin.dart';

class ModernOddEvenLogic extends StateNotifier<OddEvenState>
    with AnswerHandlerMixin {
  static const String _tag = 'OddEvenLogic';
  final Random _random = Random(DateTime.now().millisecondsSinceEpoch);

  ModernOddEvenLogic() : super(const OddEvenState());

  // ---- AnswerHandlerMixin実装 ----
  @override
  String get gameTitle => _tag;

  @override
  bool checkEpoch(int epoch) => state.epoch == epoch;

  @override
  Future<void> proceedToNext() => _proceedToNext(false);

  @override
  void returnToQuestioning() {
    // 正解選択は保持、それ以外はクリア
    final session = state.session;
    if (session != null) {
      state = state.copyWith(
        phase: CommonGamePhase.questioning,
        lastResult: null,
        session: session.copyWith(
          selectedIndices: session.correctlySelectedIndices,
        ),
      );
    }
  }

  String? get questionText => state.questionText;
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  void startGame(OddEvenSettings settings) {
    debugPrint('[$_tag] ゲーム開始: ${settings.displayName}');
    
    final firstProblem = _generateProblem(settings, 0);
    final session = OddEvenSession(
      index: 0,
      total: settings.questionCount,
      results: List.filled(settings.questionCount, null),
      currentProblem: firstProblem,
      startedAt: DateTime.now(),
    );

    state = state.copyWith(
      phase: CommonGamePhase.displaying,
      settings: settings,
      session: session,
      epoch: state.epoch + 1,
    );

    _enterQuestioning();
  }

  void toggleNumber(int index) {
    if (!state.canAnswer || state.session?.currentProblem == null) return;

    final currentIndices = Set<int>.from(state.session!.selectedIndices);
    if (currentIndices.contains(index)) {
      currentIndices.remove(index);
    } else {
      currentIndices.add(index);
    }

    state = state.copyWith(
      session: state.session!.copyWith(
        selectedIndices: currentIndices,
      ),
    );
  }

  Future<void> checkAnswer() async {
    if (!state.canAnswer || state.session?.currentProblem == null) return;

    final currentEpoch = state.epoch + 1;
    debugPrint('[$_tag] 答え合わせ (epoch: $currentEpoch)');

    state = state.copyWith(
      phase: CommonGamePhase.processing,
      epoch: currentEpoch,
    );

    final problem = state.session!.currentProblem!;
    final selectedIndices = state.session!.selectedIndices;
    final correctIndices = problem.correctIndices;

    final correctSelections = selectedIndices.intersection(correctIndices).length;
    final missedSelections = correctIndices.difference(selectedIndices).length;
    final wrongSelections = selectedIndices.difference(correctIndices).length;

    final isCorrect = missedSelections == 0 && wrongSelections == 0;
    final isPerfect = isCorrect && state.session!.wrongAttempts == 0;

    final result = AnswerResult(
      selectedIndices: selectedIndices,
      correctIndices: correctIndices,
      isCorrect: isCorrect,
      isPerfect: isPerfect,
      correctSelections: correctSelections,
      missedSelections: missedSelections,
      wrongSelections: wrongSelections,
    );

    if (isCorrect) {
      await _handleCorrectAnswer(result, currentEpoch);
    } else {
      await _handleWrongAnswer(result, currentEpoch);
    }
  }

  void resetSelection() {
    if (!state.canAnswer) return;
    
    state = state.copyWith(
      session: state.session?.copyWith(
        selectedIndices: {},
        correctlySelectedIndices: {},
      ),
    );
  }

  void restart() {
    if (state.settings != null) {
      startGame(state.settings!);
    }
  }

  void resetGame() {
    // 状態を初期化（ゲームを再開始しない）
    state = const OddEvenState();
  }

  void goToSettings() {
    state = const OddEvenState();
  }

  Future<void> _handleCorrectAnswer(AnswerResult result, int epoch) async {
    final session = state.session!;

    // この問題で間違えていなければ完全正解（true）、間違えていれば不完全正解（false）
    final updatedResults = List<bool?>.from(session.results);
    final finalResult = session.wrongAttempts == 0;
    updatedResults[session.index] = finalResult;

    await handleCorrectAnswer(
      epoch: epoch,
      updateState: () {
        state = state.copyWith(
          phase: CommonGamePhase.feedbackOk,
          lastResult: result,
          session: session.copyWith(results: updatedResults),
        );
      },
    );
  }

  Future<void> _handleWrongAnswer(AnswerResult result, int epoch) async {
    final session = state.session!;
    final problem = session.currentProblem!;
    final updatedWrongAttempts = session.wrongAttempts + 1;

    // 正解選択を計算（選択した中で正解のもの）
    final correctlySelectedIndices = session.selectedIndices.intersection(problem.correctIndices);

    // 2回間違えたら次の問題へ（この問題は不正解扱い）
    final allowRetry = updatedWrongAttempts < 2;
    final updatedResults = List<bool?>.from(session.results);
    if (!allowRetry) {
      updatedResults[session.index] = false; // 不正解として記録
    }

    await handleWrongAnswer(
      epoch: epoch,
      allowRetry: allowRetry,
      feedbackDuration: const Duration(milliseconds: 800),
      updateState: () {
        state = state.copyWith(
          phase: CommonGamePhase.feedbackNg,
          lastResult: result,
          session: session.copyWith(
            wrongAnswers: session.wrongAnswers + 1,
            wrongAttempts: updatedWrongAttempts,
            correctlySelectedIndices: correctlySelectedIndices,
            results: updatedResults,
          ),
        );
      },
    );
  }

  Future<void> _proceedToNext(bool isPerfect) async {
    state = state.copyWith(phase: CommonGamePhase.transitioning);

    await Future.delayed(const Duration(milliseconds: 350));

    final session = state.session!;
    if (session.index + 1 >= session.total) {
      // ゲーム完了
      state = state.copyWith(
        phase: CommonGamePhase.completed,
        session: session.copyWith(
          completedAt: DateTime.now(),
        ),
      );
      debugPrint('[$_tag] ゲーム完了 - スコア: ${session.correctCount}/${session.total}');
    } else {
      // 次の問題へ
      final nextProblem = _generateProblem(state.settings!, session.index + 1);
      final nextSession = session.copyWith(
        index: session.index + 1,
        currentProblem: nextProblem,
        selectedIndices: {},
        correctlySelectedIndices: {},
        wrongAnswers: 0,
        wrongAttempts: 0,
      );

      debugPrint('[$_tag] 次の問題へ: ${nextSession.index + 1}');

      state = state.copyWith(
        phase: CommonGamePhase.displaying,
        session: nextSession,
        lastResult: null,
      );

      // 自動的に質問フェーズへ
      await _enterQuestioning();
    }
  }

  Future<void> _enterQuestioning() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (state.phase == CommonGamePhase.displaying || state.phase == CommonGamePhase.transitioning) {
      state = state.copyWith(phase: CommonGamePhase.questioning);
    }
  }

  OddEvenProblem _generateProblem(OddEvenSettings settings, int index) {
    final targetType = settings.randomTargetType
        ? (_random.nextBool() ? OddEvenType.odd : OddEvenType.even)
        : settings.targetType;

    final allNumbers = List.generate(
      settings.range.maxValue - settings.range.minValue + 1,
      (i) => settings.range.minValue + i,
    );

    // より確実にランダム化するため、複数回シャッフル
    allNumbers.shuffle(_random);
    allNumbers.shuffle(_random);
    final displayNumbers = allNumbers.take(settings.gridSize.totalCount).toList();
    
    // 表示用の数字も再度シャッフルして配置をランダム化
    displayNumbers.shuffle(_random);

    final correctIndices = <int>{};
    for (int i = 0; i < displayNumbers.length; i++) {
      if (targetType.matches(displayNumbers[i])) {
        correctIndices.add(i);
      }
    }

    return OddEvenProblem(
      targetType: targetType,
      numbers: displayNumbers,
      correctIndices: correctIndices,
      questionText: targetType.questionText,
    );
  }
}

final modernOddEvenLogicProvider = StateNotifierProvider.autoDispose<ModernOddEvenLogic, OddEvenState>((ref) {
  return ModernOddEvenLogic();
});