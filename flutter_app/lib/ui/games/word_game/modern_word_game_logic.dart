import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/instant_feedback_service.dart';
import '../base/common_game_phase.dart';
import 'models/word_game_models.dart';

class ModernWordGameLogic extends StateNotifier<WordGameState> {
  static const String _tag = 'WordGameLogic';
  final Random _random = Random();

  ModernWordGameLogic() : super(const WordGameState());

  /// テスト環境かどうかを判定
  bool _isTestEnvironment() {
    try {
      return Zone.current[#flutter.test] != null ||
             (Platform.environment['FLUTTER_TEST'] == 'true');
    } catch (e) {
      return false; // エラーが発生した場合は通常環境とみなして音声を有効にする
    }
  }

  String? get questionText => state.questionText;
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  void startGame(WordGameSettings settings) {
    debugPrint('[$_tag] ゲーム開始: ${settings.displayName}');
    
    final firstProblem = _generateProblem(settings, 0);
    final session = WordGameSession(
      index: 0,
      total: settings.questionCount,
      results: List.filled(settings.questionCount, null),
      currentProblem: firstProblem,
    );

    state = state.copyWith(
      phase: CommonGamePhase.displaying,
      settings: settings,
      session: session,
      epoch: state.epoch + 1,
    );

    _autoAdvance();
  }

  Future<void> answerQuestion(int selectedIndex) async {
    if (!state.canAnswer || state.session?.currentProblem == null) return;
    
    final currentEpoch = state.epoch;
    debugPrint('[$_tag] 回答: $selectedIndex (epoch: $currentEpoch)');

    state = state.copyWith(
      phase: CommonGamePhase.processing,
      epoch: currentEpoch,
    );

    final problem = state.session!.currentProblem!;
    final isCorrect = selectedIndex == problem.correctIndex;
    final result = AnswerResult(
      selectedIndex: selectedIndex,
      correctIndex: problem.correctIndex,
      isCorrect: isCorrect,
      isPerfect: isCorrect && state.session!.wrongAnswers == 0,
    );

    // フィードバック効果音（テスト環境では無効化）
    if (!_isTestEnvironment()) {
      try {
        if (isCorrect) {
          await InstantFeedbackService().playCorrectAnswerFeedback();
        } else {
          await InstantFeedbackService().playWrongAnswerFeedback();
        }
      } catch (e) {
        debugPrint('[$_tag] フィードバック音声エラー: $e');
      }
    }

    if (isCorrect) {
      await _handleCorrectAnswer(result, currentEpoch);
    } else {
      await _handleWrongAnswer(result, currentEpoch);
    }
  }

  Future<void> _handleCorrectAnswer(AnswerResult result, int epoch) async {
    if (!mounted || state.epoch != epoch) return;
    
    state = state.copyWith(
      phase: CommonGamePhase.feedbackOk,
      lastResult: result,
    );

    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted || state.epoch != epoch) return;

    _proceedToNext(result.isPerfect);
  }

  Future<void> _handleWrongAnswer(AnswerResult result, int epoch) async {
    if (!mounted || state.epoch != epoch) return;
    
    state = state.copyWith(
      phase: CommonGamePhase.feedbackNg,
      lastResult: result,
      session: state.session?.copyWith(
        wrongAnswers: state.session!.wrongAnswers + 1,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted || state.epoch != epoch) return;

    // 間違えたら即座に次の問題へ
    _proceedToNext(false);
  }

  void _proceedToNext(bool isPerfect) {
    final session = state.session!;
    final newResults = List<bool?>.from(session.results);
    newResults[session.index] = isPerfect;

    if (session.index + 1 >= session.total) {
      state = state.copyWith(
        phase: CommonGamePhase.completed,
        session: session.copyWith(results: newResults),
      );
    } else {
      final nextProblem = _generateProblem(state.settings!, session.index + 1);
      state = state.copyWith(
        phase: CommonGamePhase.transitioning,
        lastResult: null, // 次の問題に進む時にクリア
        session: session.copyWith(
          index: session.index + 1,
          results: newResults,
          currentProblem: nextProblem,
          wrongAnswers: 0,
        ),
      );
      _autoAdvance();
    }
  }

  Future<void> _autoAdvance() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    if (state.phase == CommonGamePhase.displaying || state.phase == CommonGamePhase.transitioning) {
      state = state.copyWith(phase: CommonGamePhase.questioning);
    }
  }

  WordGameProblem _generateProblem(WordGameSettings settings, int index) {
    final scriptType = settings.mode.scriptType;
    final availableWords = List<String>.from(VocabularyImages.getItems(scriptType));
    availableWords.shuffle(_random);

    final correctWord = availableWords[0];
    final distractors = availableWords.skip(1).take(3).toList(); // 常に3つの間違い選択肢

    final options = [correctWord, ...distractors];
    options.shuffle(_random);

    final correctIndex = options.indexOf(correctWord);

    return WordGameProblem(
      word: correctWord,
      imagePath: VocabularyImages.getImagePath(correctWord, scriptType),
      options: options,
      correctIndex: correctIndex,
      questionType: settings.questionType,
      scriptType: scriptType,
    );
  }

  void reset() {
    debugPrint('[$_tag] ゲームリセット');
    state = const WordGameState();
  }

  void resetGame() {
    debugPrint('[$_tag] ゲームリセット');
    state = const WordGameState();
  }

  void skipToCompletion() {
    if (state.session != null) {
      state = state.copyWith(
        phase: CommonGamePhase.completed,
      );
    }
  }
}

final modernWordGameLogicProvider = StateNotifierProvider<ModernWordGameLogic, WordGameState>((ref) {
  return ModernWordGameLogic();
});