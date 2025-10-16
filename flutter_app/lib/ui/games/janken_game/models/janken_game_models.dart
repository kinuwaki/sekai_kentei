import '../../base/common_game_phase.dart';

/// じゃんけんの手
enum JankenHand {
  rock,     // グー
  paper,    // パー
  scissors; // チョキ

  String get displayName {
    switch (this) {
      case JankenHand.rock:
        return 'グー';
      case JankenHand.paper:
        return 'パー';
      case JankenHand.scissors:
        return 'チョキ';
    }
  }

  String get emoji {
    switch (this) {
      case JankenHand.rock:
        return '✊';
      case JankenHand.paper:
        return '✋';
      case JankenHand.scissors:
        return '✌️';
    }
  }
}

/// ゲームモード
enum JankenGameMode {
  win,  // かつ
  lose, // まける
  mix;  // ミックス

  String get displayName {
    switch (this) {
      case JankenGameMode.win:
        return 'かつ';
      case JankenGameMode.lose:
        return 'まける';
      case JankenGameMode.mix:
        return 'ミックス';
    }
  }

  String get questionPrefix {
    switch (this) {
      case JankenGameMode.win:
        return 'かつには';
      case JankenGameMode.lose:
        return 'まけるには';
      case JankenGameMode.mix:
        return ''; // ミックスモードでは動的に決定
    }
  }
}

/// ゲームの設定（即開始ゲーム）
class JankenGameSettings {
  final JankenGameMode mode;
  final int questionCount;

  const JankenGameSettings({
    required this.mode,
    this.questionCount = 3,
  });

  String get displayName => 'じゃんけん ${mode.displayName}（$questionCount問）';
}

/// じゃんけんゲームの問題データ
class JankenProblem {
  final JankenHand exampleHand;        // 左側のお手本
  final List<JankenHand> choices;      // 右側の選択肢（3つ）
  final int correctAnswerIndex;        // 正解のインデックス
  final String questionText;           // TTS用の質問文
  final JankenGameMode modeForThisProblem; // この問題のモード（ミックス時用）

  const JankenProblem({
    required this.exampleHand,
    required this.choices,
    required this.correctAnswerIndex,
    required this.questionText,
    required this.modeForThisProblem,
  });

  JankenProblem copyWith({
    JankenHand? exampleHand,
    List<JankenHand>? choices,
    int? correctAnswerIndex,
    String? questionText,
    JankenGameMode? modeForThisProblem,
  }) {
    return JankenProblem(
      exampleHand: exampleHand ?? this.exampleHand,
      choices: choices ?? this.choices,
      correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
      questionText: questionText ?? this.questionText,
      modeForThisProblem: modeForThisProblem ?? this.modeForThisProblem,
    );
  }
}

/// じゃんけんゲームのセッション（問題進行状況）
class JankenSession {
  final int index;                    // 0-based
  final int total;
  final JankenProblem current;
  final List<bool?> results;          // 各問題の結果（未回答null、完全正解true、不完全正解false）
  final int wrongAttempts;            // 現在の問題での誤答回数
  final List<JankenHand> handSequence; // グー・チョキ・パーの出題順序

  const JankenSession({
    required this.index,
    required this.total,
    required this.current,
    required this.results,
    this.wrongAttempts = 0,
    required this.handSequence,
  });

  bool get isLast => index + 1 >= total;
  int get score => results.where((r) => r == true).length;

  JankenSession next(JankenProblem nextProblem) => copyWith(
        index: index + 1,
        current: nextProblem,
        wrongAttempts: 0,
      );

  JankenSession copyWith({
    int? index,
    int? total,
    JankenProblem? current,
    List<bool?>? results,
    int? wrongAttempts,
    List<JankenHand>? handSequence,
  }) {
    return JankenSession(
      index: index ?? this.index,
      total: total ?? this.total,
      current: current ?? this.current,
      results: results ?? this.results,
      wrongAttempts: wrongAttempts ?? this.wrongAttempts,
      handSequence: handSequence ?? this.handSequence,
    );
  }
}

/// じゃんけんゲームの統合状態
class JankenState {
  final CommonGamePhase phase;
  final JankenGameSettings? settings;
  final JankenSession? session;
  final int epoch; // 非同期競合ガード用

  const JankenState({
    required this.phase,
    this.settings,
    this.session,
    this.epoch = 0,
  });

  // UI用の派生プロパティ

  /// 回答選択可能か
  bool get canAnswer => phase == CommonGamePhase.questioning;

  /// 処理中（何らかの入力をブロック）
  bool get isProcessing =>
      phase == CommonGamePhase.processing ||
      phase == CommonGamePhase.transitioning;

  /// 成功エフェクト表示中
  bool get showSuccessEffect => phase == CommonGamePhase.feedbackOk;

  /// 間違いエフェクト表示中
  bool get showWrongEffect => phase == CommonGamePhase.feedbackNg;

  /// ゲーム進行度
  double get progress =>
      session != null && session!.total > 0
          ? session!.index / session!.total
          : 0.0;

  /// 問題文（BaseGameScreenのTTS用）
  String? get questionText => session?.current.questionText;

  /// ゲーム完了済み
  bool get isCompleted => phase == CommonGamePhase.completed;

  /// 全問正解かどうか（完了した問題が全て完全正解）
  bool get isPerfect =>
      session != null &&
      session!.results.take(session!.index + 1).every((r) => r == true);

  /// 現在までに間違えたことがあるか
  bool get hadAnyWrongAnswer =>
      session != null && session!.results.contains(false);

  JankenState copyWith({
    CommonGamePhase? phase,
    JankenGameSettings? settings,
    JankenSession? session,
    int? epoch,
  }) {
    return JankenState(
      phase: phase ?? this.phase,
      settings: settings ?? this.settings,
      session: session ?? this.session,
      epoch: epoch ?? this.epoch,
    );
  }
}
