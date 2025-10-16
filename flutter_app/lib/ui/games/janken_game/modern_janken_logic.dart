import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/janken_game_models.dart';
import '../base/common_game_phase.dart';
import '../base/answer_handler_mixin.dart';
import '../../../core/debug_logger.dart';

/// じゃんけんゲームロジック
class ModernJankenLogic extends StateNotifier<JankenState>
    with AnswerHandlerMixin {
  static const String _tag = 'JankenGame';

  ModernJankenLogic()
      : super(const JankenState(
          phase: CommonGamePhase.ready,
        ));

  // ---- BaseGameScreen用の互換インターフェース ----
  String? get questionText => state.questionText;
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

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
    state = state.copyWith(phase: CommonGamePhase.questioning);
  }

  // ---- ゲーム制御 ----

  void startGame(JankenGameSettings settings) {
    Log.d('ゲーム開始: ${settings.displayName}', tag: _tag);

    // 問題数分のnull（未回答）で初期化
    final initialResults = List<bool?>.filled(settings.questionCount, null);

    // グー・チョキ・パーの順序をシャッフルして、全ての手が1回ずつ出るようにする
    final allHands = JankenHand.values.toList()..shuffle(math.Random());

    // 最初の問題を生成
    final firstProblem = _generateProblem(settings, 0, allHands[0]);

    state = JankenState(
      phase: CommonGamePhase.displaying,
      settings: settings,
      session: JankenSession(
        index: 0,
        total: settings.questionCount,
        current: firstProblem,
        results: initialResults,
        handSequence: allHands,
      ),
      epoch: state.epoch + 1,
    );

    // 表示フェーズ後、自動的に質問フェーズへ
    _enterQuestioning();
  }

  void _enterQuestioning() {
    state = state.copyWith(phase: CommonGamePhase.questioning);
  }

  // ---- 回答処理 ----

  Future<void> answerQuestion(int selectedIndex) async {
    if (!state.canAnswer || state.session == null) return;

    final session = state.session!;
    final problem = session.current;
    final currentEpoch = state.epoch + 1;

    Log.d('回答: $selectedIndex (epoch: $currentEpoch)', tag: _tag);

    // 回答判定
    final isCorrect = selectedIndex == problem.correctAnswerIndex;

    // フェーズ遷移：処理中
    state = state.copyWith(
      phase: CommonGamePhase.processing,
      epoch: currentEpoch,
    );

    if (isCorrect) {
      await _handleCorrectAnswer(currentEpoch, session);
    } else {
      await _handleWrongAnswer(currentEpoch, session);
    }
  }

  Future<void> _handleCorrectAnswer(int epoch, JankenSession session) async {
    // この問題で間違えていなければ完全正解（true）、間違えていれば不完全正解（false）
    final updatedResults = List<bool?>.from(session.results);
    final finalResult = session.wrongAttempts == 0;
    updatedResults[session.index] = finalResult;

    // AnswerHandlerMixinの共通処理を使用
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

  Future<void> _handleWrongAnswer(int epoch, JankenSession session) async {
    // 間違いを記録
    final updatedResults = List<bool?>.from(session.results);
    updatedResults[session.index] = false;

    final updatedSession = session.copyWith(
      wrongAttempts: session.wrongAttempts + 1,
      results: updatedResults,
    );

    // AnswerHandlerMixinの共通処理を使用（2回まで再試行可能）
    await handleWrongAnswer(
      epoch: epoch,
      allowRetry: session.wrongAttempts < 2,
      updateState: () {
        state = state.copyWith(
          phase: CommonGamePhase.feedbackNg,
          session: updatedSession,
        );
      },
    );
  }

  Future<void> _autoAdvance() async {
    if (!mounted || state.session == null || state.settings == null) return;

    state = state.copyWith(phase: CommonGamePhase.transitioning);

    await waitForTransition(); // AnswerHandlerMixinの共通待機処理

    final session = state.session!;
    if (session.isLast) {
      // ゲーム完了
      Log.d('ゲーム完了', tag: _tag);
      state = state.copyWith(phase: CommonGamePhase.completed);
    } else {
      // 次の問題へ
      final nextIndex = session.index + 1;
      Log.d('次の問題へ移動: ${nextIndex + 1}', tag: _tag);

      // handSequenceから次の手を取得
      final nextHand = session.handSequence[nextIndex];
      final nextProblem = _generateProblem(state.settings!, nextIndex, nextHand);
      final nextSession = session.next(nextProblem);

      state = state.copyWith(
        phase: CommonGamePhase.displaying,
        session: nextSession,
        epoch: state.epoch + 1,
      );

      // 自動的に質問フェーズへ
      _enterQuestioning();
    }
  }

  // ---- 問題生成 ----

  JankenProblem _generateProblem(JankenGameSettings settings, int index, JankenHand exampleHand) {
    final random = math.Random();

    // この問題のモードを決定（ミックスの場合はランダム）
    final modeForThisProblem = settings.mode == JankenGameMode.mix
        ? (random.nextBool() ? JankenGameMode.win : JankenGameMode.lose)
        : settings.mode;

    // 正解の手を決定
    final correctHand = _determineCorrectHand(exampleHand, modeForThisProblem);

    // 選択肢を生成（グー、チョキ、パーの順をシャッフル）
    final allChoices = JankenHand.values.toList()..shuffle(random);
    final correctIndex = allChoices.indexOf(correctHand);

    // 質問文を生成
    final questionText = _generateQuestionText(
      exampleHand,
      modeForThisProblem,
    );

    return JankenProblem(
      exampleHand: exampleHand,
      choices: allChoices,
      correctAnswerIndex: correctIndex,
      questionText: questionText,
      modeForThisProblem: modeForThisProblem,
    );
  }

  /// 正解の手を決定
  JankenHand _determineCorrectHand(
      JankenHand exampleHand, JankenGameMode mode) {
    if (mode == JankenGameMode.win) {
      // 勝つ手
      switch (exampleHand) {
        case JankenHand.rock:
          return JankenHand.paper; // グーにはパー
        case JankenHand.paper:
          return JankenHand.scissors; // パーにはチョキ
        case JankenHand.scissors:
          return JankenHand.rock; // チョキにはグー
      }
    } else {
      // 負ける手
      switch (exampleHand) {
        case JankenHand.rock:
          return JankenHand.scissors; // グーにはチョキ
        case JankenHand.paper:
          return JankenHand.rock; // パーにはグー
        case JankenHand.scissors:
          return JankenHand.paper; // チョキにはパー
      }
    }
  }

  /// 質問文を生成
  String _generateQuestionText(JankenHand exampleHand, JankenGameMode mode) {
    // modeはこの問題の実際のモード（ミックスの場合はwin/loseに決定済み）
    if (mode == JankenGameMode.win) {
      return 'じゃんけんをして\nみほんにかってね';
    } else {
      return 'じゃんけんをして\nみほんにまけてね';
    }
  }

  // ---- BaseGameScreen互換メソッド ----

  void resetGame() {
    state = const JankenState(phase: CommonGamePhase.ready);
  }
}

/// じゃんけんゲームロジックのプロバイダー
final modernJankenLogicProvider =
    StateNotifierProvider.autoDispose<ModernJankenLogic, JankenState>((ref) {
  return ModernJankenLogic();
});
