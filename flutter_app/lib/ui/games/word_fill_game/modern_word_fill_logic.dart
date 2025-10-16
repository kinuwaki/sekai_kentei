import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/debug_logger.dart';
import '../../../services/vocabulary_image_service.dart';
import 'models/word_fill_models.dart';
import '../base/common_game_phase.dart';
import '../base/answer_handler_mixin.dart';
import '../writing_game/advanced_character_judge.dart';
import '../writing_game/writing_game_models.dart';

/// 単語穴埋めゲームロジック
class ModernWordFillLogic extends StateNotifier<WordFillState>
    with AnswerHandlerMixin {
  static const String _tag = 'WordFillGame';
  final math.Random _random = math.Random();

  // 使用可能な単語リスト
  static const List<String> _availableWords = [
    'あいす', 'あさがお', 'あり', 'うきわ', 'うさぎ', 'うでどけい', 'うま', 'えび',
    'えんぴつ', 'おたま', 'おにぎり', 'かたつむり', 'きうい', 'きゃべつ', 'きりん', 'くるま',
    'こっぷ', 'さいころ', 'じてんしゃ', 'しんかんせん', 'すずめ', 'すにーかー', 'すぷーん', 'ぞう',
    'らけっと', 'たんぽぽ', 'ちゅーりっぷ', 'ちりとり', 'とまと', 'とらくたー', 'にんじん', 'はさみ',
    'ばす', 'ばなな', 'ひこうき', 'ふうせん', 'ふぉーく', 'ぶどう', 'ふね', 'ふらいぱん',
    'ほうき', 'ほうちょう', 'ぼーる', 'ほっちきす', 'みかん', 'めがね', 'めろん', 'もみじ',
    'やかん', 'らいおん', 'りんご', 'れもん', 'れんこん',
  ];

  ModernWordFillLogic()
      : super(const WordFillState(phase: CommonGamePhase.ready)) {
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
    state = state.copyWith(phase: CommonGamePhase.questioning);
  }

  // ---- BaseGameScreen互換プロパティ ----
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  // ---- ゲーム制御 ----

  /// ゲーム開始
  void startGame(WordFillSettings settings) {
    Log.d('Starting game: ${settings.displayName}', tag: _tag);

    final initialResults = List<bool?>.filled(settings.questionCount, null);
    final firstProblem = _generateProblem();

    state = WordFillState(
      phase: CommonGamePhase.questioning,
      settings: settings,
      session: WordFillSession(
        index: 0,
        total: settings.questionCount,
        results: initialResults,
        currentProblem: firstProblem,
      ),
      epoch: state.epoch + 1,
    );
  }

  /// 手書き入力をクリア
  void clearInput() {
    final session = state.session;
    if (session == null) return;

    state = state.copyWith(
      session: session.copyWith(userInput: ''),
    );
  }

  /// 手書き認識結果を処理
  Future<void> submitRecognition(RecognitionResult result) async {
    if (!state.canAnswer || state.session?.currentProblem == null) {
      return;
    }

    final currentEpoch = state.epoch;
    final session = state.session!;
    final problem = session.currentProblem!;

    Log.d('Submit recognition (epoch: $currentEpoch)', tag: _tag);

    // 処理中状態に変更
    state = state.copyWith(
      phase: CommonGamePhase.processing,
      epoch: currentEpoch,
    );

    // 文字判定
    final judgment = AdvancedCharacterJudge.judge(
      targetChar: problem.blankChar,
      result: result,
      scriptType: ScriptType.hiragana,
    );

    Log.d('Judgment result: ${judgment.isAccepted}', tag: _tag);

    if (judgment.isAccepted) {
      await _handleCorrectAnswer(currentEpoch);
    } else {
      await _handleWrongAnswer(currentEpoch);
    }
  }

  /// 正解処理
  Future<void> _handleCorrectAnswer(int epoch) async {
    final session = state.session!;

    // この問題で間違えていなければ完全正解
    final updatedResults = List<bool?>.from(session.results);
    final isPerfect = session.wrongAttempts == 0;
    updatedResults[session.index] = isPerfect;

    Log.d('Correct answer for question ${session.index + 1}: wrongAttempts=${session.wrongAttempts}, perfect=$isPerfect',
        tag: _tag);

    await handleCorrectAnswer(
      epoch: epoch,
      updateState: () {
        state = state.copyWith(
          phase: CommonGamePhase.feedbackOk,
          session: session.copyWith(results: updatedResults),
        );
      },
    );
  }

  /// 不正解処理
  Future<void> _handleWrongAnswer(int epoch) async {
    final session = state.session!;

    Log.d('Wrong answer for question ${session.index + 1}, attempts: ${session.wrongAttempts + 1}', tag: _tag);

    // 1回まで許容（2回目は次へ）
    final newWrongAttempts = session.wrongAttempts + 1;
    final allowRetry = newWrongAttempts < 2;

    // resultsを更新（再挑戦不可なら）
    final updatedResults = List<bool?>.from(session.results);
    if (!allowRetry) {
      updatedResults[session.index] = false;
    }

    await handleWrongAnswer(
      epoch: epoch,
      allowRetry: allowRetry,
      updateState: () {
        state = state.copyWith(
          phase: CommonGamePhase.feedbackNg,
          session: session.copyWith(
            wrongAttempts: newWrongAttempts,
            userInput: '', // 入力をクリア
            results: updatedResults,
          ),
        );
      },
    );
  }

  /// 次の問題または完了
  Future<void> _autoAdvance() async {
    state = state.copyWith(phase: CommonGamePhase.transitioning);

    await Future.delayed(const Duration(milliseconds: 350));

    final session = state.session!;
    if (session.isLast) {
      // ゲーム完了
      state = state.copyWith(phase: CommonGamePhase.completed);
      Log.d('Game completed - score: ${session.correctCount}/${session.total}',
          tag: _tag);
    } else {
      // 次の問題（wrongAttemptsリセット）
      final nextProblem = _generateProblem();
      final nextSession = WordFillSession(
        index: session.index + 1,
        total: session.total,
        results: session.results,
        currentProblem: nextProblem,
        wrongAttempts: 0, // リセット
      );

      Log.d('Advancing to question ${nextSession.index + 1}', tag: _tag);

      state = state.copyWith(
        phase: CommonGamePhase.questioning,
        session: nextSession,
      );
    }
  }

  /// 問題生成
  WordFillProblem _generateProblem() {
    // ランダムな単語を選択
    final word = _availableWords[_random.nextInt(_availableWords.length)];

    // ランダムな位置に空欄を作成
    final blankIndex = _random.nextInt(word.length);

    final imagePath = VocabularyImageService.getImagePath(word);

    Log.d('Generated problem: word=$word, blankIndex=$blankIndex', tag: _tag);

    return WordFillProblem(
      word: word,
      blankIndex: blankIndex,
      imagePath: imagePath,
    );
  }

  /// ゲームリセット
  void resetGame() {
    Log.d('Resetting game', tag: _tag);
    state = const WordFillState(phase: CommonGamePhase.ready);
  }
}

/// プロバイダー
final modernWordFillLogicProvider =
    StateNotifierProvider.autoDispose<ModernWordFillLogic, WordFillState>((ref) {
  return ModernWordFillLogic();
});
