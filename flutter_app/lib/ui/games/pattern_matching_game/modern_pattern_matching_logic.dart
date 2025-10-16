import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../base/common_game_phase.dart';
import '../base/answer_handler_mixin.dart';
import 'models/pattern_matching_models.dart';

/// パターンマッチングゲームのロジック
class ModernPatternMatchingLogic extends StateNotifier<PatternMatchingState>
    with AnswerHandlerMixin {
  static const String _tag = 'PatternMatchingGame';

  ModernPatternMatchingLogic()
      : super(const PatternMatchingState(phase: CommonGamePhase.ready));

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

  void startGame(PatternMatchingSettings settings) {
    final initialResults = List<bool?>.filled(settings.questionCount, null);
    final firstProblem = _generateProblem(settings, 0);

    state = PatternMatchingState(
      phase: CommonGamePhase.displaying,
      settings: settings,
      session: PatternMatchingSession(
        index: 0,
        total: settings.questionCount,
        results: initialResults,
        currentProblem: firstProblem,
      ),
      epoch: state.epoch + 1,
    );

    _enterQuestioning();
  }

  void _enterQuestioning() {
    state = state.copyWith(phase: CommonGamePhase.questioning);
  }

  // ---- 回答処理 ----

  Future<void> answerQuestion(int selectedIndex) async {
    if (!state.canAnswer || state.session?.currentProblem == null) return;

    final currentEpoch = state.epoch;
    final session = state.session!;
    final problem = session.currentProblem!;

    // 回答判定
    final isCorrect = problem.isCorrectAnswer(selectedIndex);

    // 処理中フェーズへ
    state = state.copyWith(
      phase: CommonGamePhase.processing,
      epoch: currentEpoch + 1,
    );

    if (isCorrect) {
      await _handleCorrectAnswer(currentEpoch + 1, session);
    } else {
      await _handleWrongAnswer(currentEpoch + 1, session);
    }
  }

  Future<void> _handleCorrectAnswer(int epoch, PatternMatchingSession session) async {
    // 不正解回数が0なら完璧（true）、それ以外は不完璧（false）
    final isPerfect = session.wrongAttempts == 0;
    final updatedResults = List<bool?>.from(session.results);
    updatedResults[session.index] = isPerfect;

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

  Future<void> _handleWrongAnswer(int epoch, PatternMatchingSession session) async {
    final updatedResults = List<bool?>.from(session.results);
    updatedResults[session.index] = false;

    final updatedSession = session.copyWith(
      results: updatedResults,
      wrongAttempts: session.wrongAttempts + 1,
    );

    // 再試行を許可（最大2回まで）
    final allowRetry = session.wrongAttempts < 2;

    await handleWrongAnswer(
      epoch: epoch,
      allowRetry: allowRetry,
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

    final session = state.session!;
    final settings = state.settings!;

    state = state.copyWith(phase: CommonGamePhase.transitioning);

    await waitForTransition();

    if (session.index + 1 >= session.total) {
      // ゲーム完了
      state = state.copyWith(phase: CommonGamePhase.completed);
      return;
    }

    // 次の問題へ
    final nextIndex = session.index + 1;
    final nextProblem = _generateProblem(settings, nextIndex);

    state = state.copyWith(
      phase: CommonGamePhase.displaying,
      session: PatternMatchingSession(
        index: nextIndex,
        total: settings.questionCount,
        results: session.results,
        currentProblem: nextProblem,
        wrongAttempts: 0,
      ),
      epoch: state.epoch + 1,
    );

    _enterQuestioning();
  }

  // ---- 問題生成 ----

  PatternMatchingProblem _generateProblem(
      PatternMatchingSettings settings, int index) {
    final random = math.Random(settings.seed == 0 ? null : settings.seed + index);

    // パターンのタイプを選択（3個ループ、4個ループ）
    final useThreePattern = random.nextBool();
    final patternLength = useThreePattern ? 3 : 4;

    // パターンを生成
    final pattern = _generatePattern(random, patternLength);

    // 9個のシーケンスを作成
    final sequence = <PatternSpec?>[];
    for (int i = 0; i < 9; i++) {
      sequence.add(pattern[i % patternLength]);
    }

    // ?の位置を決定（3番目以降で、パターンの途中）
    final possibleIndices = <int>[];
    for (int i = patternLength; i < 9; i++) {
      possibleIndices.add(i);
    }
    final questionMarkIndex = possibleIndices[random.nextInt(possibleIndices.length)];

    // 正解の図形を保存
    final correctAnswer = sequence[questionMarkIndex]!;
    sequence[questionMarkIndex] = null; // ?に置き換え

    // 選択肢を生成（パターン内の図形から選ぶ）
    final choices = <PatternSpec>[];

    // 正解を追加
    choices.add(correctAnswer);

    // パターン内の他の図形から選ぶ（正解以外）
    final otherPatternSpecs = pattern.where((spec) => !spec.matches(correctAnswer)).toList();

    // パターン内に十分な種類があればそこから選ぶ
    if (otherPatternSpecs.isNotEmpty) {
      for (var spec in otherPatternSpecs) {
        if (choices.length >= 3) break;
        if (!choices.any((c) => c.matches(spec))) {
          choices.add(spec);
        }
      }
    }

    // まだ3個に満たない場合は、パターン外から追加
    while (choices.length < 3) {
      final wrongAnswer = _generateDifferentSpec(random, correctAnswer);
      // 既存の選択肢と重複しないか確認
      if (!choices.any((c) => c.matches(wrongAnswer))) {
        choices.add(wrongAnswer);
      }
    }

    // 選択肢をシャッフル
    choices.shuffle(random);
    final correctAnswerIndex = choices.indexWhere((c) => c.matches(correctAnswer));

    return PatternMatchingProblem(
      sequence: sequence,
      questionMarkIndex: questionMarkIndex,
      choices: choices,
      correctAnswerIndex: correctAnswerIndex,
      questionText: 'はてなには\nなにがはいるかな',
    );
  }

  /// パターンを生成（3個または4個）
  List<PatternSpec> _generatePattern(math.Random random, int length) {
    final pattern = <PatternSpec>[];

    for (int i = 0; i < length; i++) {
      final color = PatternColor.values[random.nextInt(PatternColor.values.length)];
      final shape = PatternShape.values[random.nextInt(PatternShape.values.length)];

      // 塗りつぶし、枠線のみ、二重からランダム選択
      final fillTypeIndex = random.nextInt(3);
      final fillType = fillTypeIndex == 0
          ? PatternFillType.filled
          : fillTypeIndex == 1
              ? PatternFillType.outline
              : PatternFillType.double_;

      pattern.add(PatternSpec(shape: shape, color: color, fillType: fillType));
    }

    return pattern;
  }

  /// 異なる図形を生成
  PatternSpec _generateDifferentSpec(math.Random random, PatternSpec target) {
    PatternSpec spec;
    int attempts = 0;
    do {
      final color = PatternColor.values[random.nextInt(PatternColor.values.length)];
      final shape = PatternShape.values[random.nextInt(PatternShape.values.length)];

      // 塗りつぶし、枠線のみ、二重からランダム選択
      final fillTypeIndex = random.nextInt(3);
      final fillType = fillTypeIndex == 0
          ? PatternFillType.filled
          : fillTypeIndex == 1
              ? PatternFillType.outline
              : PatternFillType.double_;

      spec = PatternSpec(shape: shape, color: color, fillType: fillType);
      attempts++;

      // 無限ループ防止
      if (attempts > 20) break;
    } while (spec.matches(target));

    return spec;
  }
}

final modernPatternMatchingLogicProvider =
    StateNotifierProvider<ModernPatternMatchingLogic, PatternMatchingState>(
  (ref) => ModernPatternMatchingLogic(),
);
