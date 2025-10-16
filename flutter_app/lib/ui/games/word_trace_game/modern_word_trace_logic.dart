import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/debug_logger.dart';
import '../base/common_game_phase.dart';
import '../base/answer_handler_mixin.dart';
import 'models/word_trace_models.dart';
import 'word_trace_problem_generator.dart';

final modernWordTraceLogicProvider =
    StateNotifierProvider.autoDispose<ModernWordTraceLogic, WordTraceState>((ref) {
  return ModernWordTraceLogic();
});

class ModernWordTraceLogic extends StateNotifier<WordTraceState>
    with AnswerHandlerMixin {
  static const String _tag = 'WordTraceGame';

  ModernWordTraceLogic()
      : super(const WordTraceState(phase: CommonGamePhase.ready)) {
    Log.d('Created new instance', tag: _tag);
  }

  // ---- AnswerHandlerMixin実装 ----
  @override
  String get gameTitle => _tag;

  @override
  bool checkEpoch(int epoch) => state.epoch == epoch;

  @override
  Future<void> proceedToNext() => _autoAdvance();

  @override
  void returnToQuestioning() {
    if (state.session == null) return;
    state = state.copyWith(
      phase: CommonGamePhase.questioning,
      session: state.session!.copyWith(selectedPath: []),
    );
  }

  // ---- BaseGameScreen互換プロパティ ----
  String? get questionText => state.questionText;
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  // ---- ゲーム制御 ----

  void resetGame() {
    Log.d('Resetting game', tag: _tag);
    state = const WordTraceState(phase: CommonGamePhase.ready);
  }

  void startGame(WordTraceSettings settings) {
    Log.d('Starting game: ${settings.displayName}', tag: _tag);

    final problems = WordTraceProblemGenerator.generateProblems(settings.questionCount);
    if (problems.isEmpty) {
      Log.w('No problems generated', tag: _tag);
      return;
    }

    final initialResults = List<bool?>.filled(settings.questionCount, null);

    state = WordTraceState(
      phase: CommonGamePhase.displaying,
      settings: settings,
      session: WordTraceSession(
        index: 0,
        total: settings.questionCount,
        results: initialResults,
        currentProblem: problems[0],
        selectedPath: [],
      ),
      epoch: state.epoch + 1,
    );

    Log.d('First problem: ${problems[0].targetWord}', tag: _tag);
    _enterQuestioning();
  }

  void _enterQuestioning() {
    state = state.copyWith(phase: CommonGamePhase.questioning);
  }

  void selectChar(CharPosition position) {
    if (!state.canSelectChar || state.session == null) return;

    final session = state.session!;
    final problem = session.currentProblem;
    if (problem == null) return;

    final newPath = List<CharPosition>.from(session.selectedPath);

    // 既に選択済みの文字を再度選択した場合（ドラッグ中）
    final existingIndex = newPath.indexWhere((p) => p.x == position.x && p.y == position.y);
    if (existingIndex != -1) {
      // その位置以降を削除（その位置自体は残す）
      newPath.removeRange(existingIndex + 1, newPath.length);
    } else {
      // 正解パスの次の文字かチェック
      if (!_isNextCorrectChar(newPath, position, problem.correctPath)) {
        return; // 正解パスでない文字は選択できない
      }

      // 隣接チェック
      if (newPath.isEmpty || _isAdjacent(newPath.last, position)) {
        newPath.add(position);
      } else {
        return; // 隣接していない場合は追加しない
      }
    }

    state = state.copyWith(
      session: session.copyWith(selectedPath: newPath),
    );

    // 正解パスを完成させたら自動的に正解
    if (newPath.length == problem.correctPath.length) {
      if (_checkPathCorrect(newPath, problem.correctPath)) {
        checkAnswer();
      }
    }
  }

  void tapChar(CharPosition position) {
    if (!state.canSelectChar || state.session == null) return;

    final session = state.session!;
    final problem = session.currentProblem;
    if (problem == null) return;

    final newPath = List<CharPosition>.from(session.selectedPath);

    // 既に選択済みの文字をタップした場合
    final existingIndex = newPath.indexWhere((p) => p.x == position.x && p.y == position.y);
    if (existingIndex != -1) {
      // その位置の文字自体も削除（その位置から削除）
      newPath.removeRange(existingIndex, newPath.length);
    } else {
      // 正解パスの次の文字かチェック
      if (!_isNextCorrectChar(newPath, position, problem.correctPath)) {
        return; // 正解パスでない文字は選択できない
      }

      // 隣接チェック
      if (newPath.isEmpty || _isAdjacent(newPath.last, position)) {
        newPath.add(position);
      } else {
        return; // 隣接していない場合は追加しない
      }
    }

    state = state.copyWith(
      session: session.copyWith(selectedPath: newPath),
    );

    // 正解パスを完成させたら自動的に正解
    if (newPath.length == problem.correctPath.length) {
      if (_checkPathCorrect(newPath, problem.correctPath)) {
        checkAnswer();
      }
    }
  }

  bool _isAdjacent(CharPosition from, CharPosition to) {
    final dx = (from.x - to.x).abs();
    final dy = (from.y - to.y).abs();
    // 縦横のみ許可（斜め禁止）
    return (dx == 1 && dy == 0) || (dx == 0 && dy == 1);
  }

  // 正解パスの次の文字かチェック
  bool _isNextCorrectChar(List<CharPosition> currentPath, CharPosition position, List<CharPosition> correctPath) {
    final nextIndex = currentPath.length;
    if (nextIndex >= correctPath.length) return false;

    final nextCorrect = correctPath[nextIndex];
    return position.x == nextCorrect.x && position.y == nextCorrect.y;
  }

  void clearPath() {
    if (state.session == null) return;

    state = state.copyWith(
      session: state.session!.copyWith(selectedPath: []),
    );
  }

  void checkAnswer() {
    if (state.session == null) return;

    final session = state.session!;
    final problem = session.currentProblem;
    if (problem == null) return;

    final currentEpoch = state.epoch;

    // パスが正解と一致するかチェック
    final isCorrect = _checkPathCorrect(session.selectedPath, problem.correctPath);

    if (isCorrect) {
      Log.d('Correct answer!', tag: _tag);

      handleCorrectAnswer(
        epoch: currentEpoch,
        updateState: () {
          final updatedResults = List<bool?>.from(session.results);
          updatedResults[session.index] = true;

          state = state.copyWith(
            phase: CommonGamePhase.feedbackOk,
            session: session.copyWith(results: updatedResults),
          );
        },
      );
    } else {
      Log.d('Wrong answer', tag: _tag);

      // 正解部分までのパスを計算
      final correctPartialPath = _getCorrectPartialPath(session.selectedPath, problem.correctPath);
      final newWrongAttempts = session.wrongAttempts + 1;

      handleWrongAnswer(
        epoch: currentEpoch,
        updateState: () {
          final updatedResults = List<bool?>.from(session.results);
          updatedResults[session.index] = false;

          state = state.copyWith(
            phase: CommonGamePhase.feedbackNg,
            session: session.copyWith(
              results: updatedResults,
              wrongAttempts: newWrongAttempts,
              selectedPath: correctPartialPath,
            ),
          );
        },
        // 2回間違えたら次に進む
        allowRetry: newWrongAttempts < 2,
      );
    }
  }

  // 正解部分までのパスを返す
  List<CharPosition> _getCorrectPartialPath(List<CharPosition> selected, List<CharPosition> correct) {
    final correctPart = <CharPosition>[];

    for (int i = 0; i < selected.length && i < correct.length; i++) {
      if (selected[i].x == correct[i].x && selected[i].y == correct[i].y) {
        correctPart.add(selected[i]);
      } else {
        break;
      }
    }

    return correctPart;
  }

  bool _checkPathCorrect(List<CharPosition> selected, List<CharPosition> correct) {
    if (selected.length != correct.length) return false;

    for (int i = 0; i < selected.length; i++) {
      if (selected[i].x != correct[i].x || selected[i].y != correct[i].y) {
        return false;
      }
    }
    return true;
  }

  Future<void> _autoAdvance() async {
    if (!mounted || state.session == null || state.settings == null) return;

    final session = state.session!;
    final settings = state.settings!;

    await waitForTransition();

    if (session.isLast) {
      Log.d('Game finished', tag: _tag);
      state = state.copyWith(phase: CommonGamePhase.completed);
      return;
    }

    final nextIndex = session.index + 1;
    final problems = WordTraceProblemGenerator.generateProblems(settings.questionCount);

    if (nextIndex < problems.length) {
      Log.d('Moving to question ${nextIndex + 1}', tag: _tag);

      state = state.copyWith(
        phase: CommonGamePhase.displaying,
        session: WordTraceSession(
          index: nextIndex,
          total: settings.questionCount,
          results: session.results,
          currentProblem: problems[nextIndex],
          selectedPath: [],
        ),
        epoch: state.epoch + 1,
      );

      _enterQuestioning();
    }
  }
}
