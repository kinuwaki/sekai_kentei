import 'dart:math';

/// 問題データクラス
class QuizQuestion {
  final String id;
  final String question;
  final List<String> choices; // 3つの不正解選択肢
  final String correctAnswer; // 正解の選択肢
  final String explanation;
  final String theme;
  final String? imagePath; // 画像パス（任意）

  QuizQuestion({
    required this.id,
    required this.question,
    required this.choices,
    required this.correctAnswer,
    required this.explanation,
    required this.theme,
    this.imagePath,
  });

  /// 4択の選択肢を生成（不正解3つ + 正解1つをシャッフル）
  List<String> generateOptions({Random? random}) {
    final rng = random ?? Random();
    final options = [...choices, correctAnswer];
    options.shuffle(rng);
    return options;
  }

  /// 正解のインデックスを取得（シャッフル後の選択肢から）
  int getCorrectIndex(List<String> shuffledOptions) {
    return shuffledOptions.indexOf(correctAnswer);
  }

  @override
  String toString() {
    return 'QuizQuestion(id: $id, question: $question, theme: $theme)';
  }

  /// JSON形式からQuizQuestionを生成
  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] as String,
      question: json['question'] as String,
      choices: (json['choices'] as List<dynamic>).cast<String>(),
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String? ?? '',
      theme: json['theme'] as String,
      imagePath: json['imagePath'] as String?,
    );
  }

  /// QuizQuestionをJSON形式に変換
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'choices': choices,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'theme': theme,
      'imagePath': imagePath,
    };
  }
}

/// 問題データローダーの抽象インターフェース
abstract class QuizDataLoader {
  /// すべての問題を読み込む
  Future<List<QuizQuestion>> loadQuestions();

  /// テーマでフィルタリング
  List<QuizQuestion> filterByTheme(List<QuizQuestion> questions, String themeName);

  /// ランダムに問題を選択
  List<QuizQuestion> selectRandom(List<QuizQuestion> questions, int count, {Random? random});
}
