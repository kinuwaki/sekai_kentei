
/// 問題の種類
enum ProblemType {
  smaller,  // より小さい数
  larger,   // より大きい数
}

/// 数字認識ゲームの問題データ
class NumberProblem {
  final int baseNumber;     // 基準の数（例：8）
  final int difference;     // 差分（例：3）
  final int correctAnswer;  // 正解（例：5）
  final ProblemType type;   // 問題の種類

  const NumberProblem({
    required this.baseNumber,
    required this.difference,
    required this.correctAnswer,
    required this.type,
  });

  factory NumberProblem.generate({
    int difference = 3, 
    ProblemType type = ProblemType.smaller,
  }) {
    late final int baseNumber;
    late final int correctAnswer;
    
    if (type == ProblemType.smaller) {
      // N - k >= 0 を満たすような基準の数を生成（3-10範囲）
      final minBase = difference;
      final maxBase = 10;
      baseNumber = minBase + (DateTime.now().millisecondsSinceEpoch % (maxBase - minBase + 1));
      correctAnswer = baseNumber - difference;
    } else {
      // N + k <= 10 を満たすような基準の数を生成（0-7範囲）
      final minBase = 0;
      final maxBase = 10 - difference;
      baseNumber = minBase + (DateTime.now().millisecondsSinceEpoch % (maxBase - minBase + 1));
      correctAnswer = baseNumber + difference;
    }
    
    return NumberProblem(
      baseNumber: baseNumber,
      difference: difference,
      correctAnswer: correctAnswer,
      type: type,
    );
  }

  String get questionText {
    switch (type) {
      case ProblemType.smaller:
        return '$baseNumber より $difference つちいさいかずをかきましょう';
      case ProblemType.larger:
        return '$baseNumber より $difference つおおきいかずをかきましょう';
    }
  }

}

/// ゲームの状態
enum GameState {
  ready,      // 準備状態
  playing,    // プレイ中
  completed,  // ゲーム完了
}

/// 解答の結果
class AnswerResult {
  final int? recognizedNumber;  // 認識された数字（null=認識失敗）
  final bool isCorrect;         // 正解かどうか
  final int correctAnswer;      // 正解の数字

  const AnswerResult({
    required this.recognizedNumber,
    required this.isCorrect,
    required this.correctAnswer,
  });
}

/// ゲームセッションのデータ
class GameSession {
  final List<NumberProblem> problems;
  final List<AnswerResult?> results;
  final int currentQuestionIndex;
  final GameState state;
  final bool showSuccessEffect;
  final bool hadWrongAnswer;

  const GameSession({
    required this.problems,
    required this.results,
    required this.currentQuestionIndex,
    required this.state,
    this.showSuccessEffect = false,
    this.hadWrongAnswer = false,
  });

  factory GameSession.start({
    int problemCount = 3, 
    int difference = 3, 
    ProblemType problemType = ProblemType.smaller,
  }) {
    final problems = <NumberProblem>[];
    final usedNumbers = <int>{};
    
    // 重複しない問題を生成
    while (problems.length < problemCount) {
      final problem = NumberProblem.generate(
        difference: difference,
        type: problemType,
      );
      if (!usedNumbers.contains(problem.baseNumber)) {
        problems.add(problem);
        usedNumbers.add(problem.baseNumber);
      }
    }

    return GameSession(
      problems: problems,
      results: List.filled(problemCount, null),
      currentQuestionIndex: 0,
      state: GameState.ready,
    );
  }

  NumberProblem get currentProblem => problems[currentQuestionIndex];
  
  bool get isLastQuestion => currentQuestionIndex >= problems.length - 1;
  
  bool get isCompleted => state == GameState.completed;
  
  int get correctCount => results.where((r) => r?.isCorrect == true).length;
  
  double get accuracy => results.isEmpty ? 0.0 : correctCount / results.length;

  GameSession copyWith({
    List<NumberProblem>? problems,
    List<AnswerResult?>? results,
    int? currentQuestionIndex,
    GameState? state,
    bool? showSuccessEffect,
    bool? hadWrongAnswer,
  }) {
    return GameSession(
      problems: problems ?? this.problems,
      results: results ?? this.results,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      state: state ?? this.state,
      showSuccessEffect: showSuccessEffect ?? this.showSuccessEffect,
      hadWrongAnswer: hadWrongAnswer ?? this.hadWrongAnswer,
    );
  }

  GameSession withAnswer(AnswerResult result) {
    final newResults = List<AnswerResult?>.from(results);
    newResults[currentQuestionIndex] = result;
    
    return copyWith(
      results: newResults,
      state: GameState.playing,
      showSuccessEffect: result.isCorrect,
      hadWrongAnswer: !result.isCorrect,
    );
  }

  GameSession toNextQuestion() {
    if (isLastQuestion) {
      return copyWith(
        state: GameState.completed,
        showSuccessEffect: false,
        hadWrongAnswer: false,
      );
    } else {
      return copyWith(
        currentQuestionIndex: currentQuestionIndex + 1,
        state: GameState.playing,
        showSuccessEffect: false,
        hadWrongAnswer: false,
      );
    }
  }

  GameSession toPlaying() => copyWith(state: GameState.playing);
}

/// 数字認識の設定
class RecognitionConfig {
  // iOS Vision用設定
  static const String iosLanguage = 'en-US';
  static const bool usesLanguageCorrection = false;
  
  // Tesseract.js用設定  
  static const String tesseractLang = 'eng';
  static const String charWhitelist = '0123456789';
  static const int psm = 7; // Treat the image as a single text line
  
  // 画像前処理設定
  static const int maxImageSize = 1500;
  static const double binarizationThreshold = 0.5;
}

// 共通描画ウィジェットを使用するため、DrawingPathとDrawingDataを削除
// 代わりに ../../components/drawing/drawing_models.dart の定義を使用