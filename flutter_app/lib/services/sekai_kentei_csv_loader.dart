import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import '../core/debug_logger.dart';

/// 世界遺産検定CSVファイルから問題を読み込むサービス
class SekaiKenteiCsvLoader {
  static const String _tag = 'SekaiKenteiCsvLoader';
  static const String _csvPath = 'assets/quiz/世界遺産検定4級150問.csv';

  static final SekaiKenteiCsvLoader _instance = SekaiKenteiCsvLoader._internal();
  factory SekaiKenteiCsvLoader() => _instance;
  SekaiKenteiCsvLoader._internal();

  List<QuizQuestion>? _cachedQuestions;

  /// CSVファイルから問題を読み込む
  Future<List<QuizQuestion>> loadQuestions() async {
    if (_cachedQuestions != null) {
      Log.d('キャッシュから問題を返します', tag: _tag);
      return _cachedQuestions!;
    }

    try {
      Log.d('CSVファイルを読み込み中: $_csvPath', tag: _tag);
      final csvString = await rootBundle.loadString(_csvPath);
      final lines = const LineSplitter().convert(csvString);

      if (lines.isEmpty) {
        throw Exception('CSVファイルが空です');
      }

      // ヘッダー行をスキップ
      final dataLines = lines.skip(1);
      final questions = <QuizQuestion>[];

      for (final line in dataLines) {
        if (line.trim().isEmpty) continue;

        try {
          final question = _parseCsvLine(line);
          questions.add(question);
        } catch (e) {
          Log.w('問題の解析に失敗: $line', tag: _tag);
          Log.w('エラー: $e', tag: _tag);
        }
      }

      Log.d('${questions.length}問の問題を読み込みました', tag: _tag);
      _cachedQuestions = questions;
      return questions;
    } catch (e) {
      Log.e('CSVファイルの読み込みに失敗: $e', tag: _tag);
      throw Exception('問題データの読み込みに失敗しました: $e');
    }
  }

  /// CSV行をパースして問題オブジェクトに変換
  QuizQuestion _parseCsvLine(String line) {
    final fields = _parseCsvFields(line);

    if (fields.length < 8) {
      throw Exception('CSVフィールドが不足しています: ${fields.length}');
    }

    final id = fields[0];
    final question = fields[1];
    final choice1 = fields[2];
    final choice2 = fields[3];
    final choice3 = fields[4];
    final correctAnswer = fields[5];
    final explanation = fields[6];
    final theme = fields[7];

    return QuizQuestion(
      id: id,
      question: question,
      choices: [choice1, choice2, choice3],
      correctAnswer: correctAnswer,
      explanation: explanation,
      theme: theme,
    );
  }

  /// CSVフィールドを解析（カンマとダブルクォートを適切に処理）
  List<String> _parseCsvFields(String line) {
    final fields = <String>[];
    var current = StringBuffer();
    var inQuotes = false;

    for (var i = 0; i < line.length; i++) {
      final char = line[i];

      if (char == '"') {
        if (inQuotes && i + 1 < line.length && line[i + 1] == '"') {
          // エスケープされたダブルクォート
          current.write('"');
          i++;
        } else {
          // クォートの開始/終了
          inQuotes = !inQuotes;
        }
      } else if (char == ',' && !inQuotes) {
        // フィールドの区切り
        fields.add(current.toString());
        current = StringBuffer();
      } else {
        current.write(char);
      }
    }

    // 最後のフィールドを追加
    fields.add(current.toString());

    return fields;
  }

  /// テーマで問題をフィルタリング
  List<QuizQuestion> filterByTheme(List<QuizQuestion> questions, String theme) {
    return questions.where((q) => q.theme == theme).toList();
  }

  /// ランダムに問題を取得
  List<QuizQuestion> getRandomQuestions(
    List<QuizQuestion> questions,
    int count, {
    Random? random,
  }) {
    final rng = random ?? Random();
    final shuffled = List<QuizQuestion>.from(questions)..shuffle(rng);
    return shuffled.take(count).toList();
  }
}

/// 問題データクラス
class QuizQuestion {
  final String id;
  final String question;
  final List<String> choices; // 3つの不正解選択肢
  final String correctAnswer; // 正解の選択肢
  final String explanation;
  final String theme;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.choices,
    required this.correctAnswer,
    required this.explanation,
    required this.theme,
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
}
