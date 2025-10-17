import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import '../core/debug_logger.dart';
import 'quiz_data_loader.dart';

/// 世界遺産検定JSONファイルから問題を読み込むサービス
class SekaiKenteiJsonLoader implements QuizDataLoader {
  static const String _tag = 'SekaiKenteiJsonLoader';
  static const String _jsonPath = 'assets/quiz/世界遺産検定4級150問.json';

  static final SekaiKenteiJsonLoader _instance = SekaiKenteiJsonLoader._internal();
  factory SekaiKenteiJsonLoader() => _instance;
  SekaiKenteiJsonLoader._internal();

  List<QuizQuestion>? _cachedQuestions;

  /// JSONファイルから問題を読み込む
  @override
  Future<List<QuizQuestion>> loadQuestions() async {
    if (_cachedQuestions != null) {
      Log.d('キャッシュから問題を返します', tag: _tag);
      return _cachedQuestions!;
    }

    try {
      Log.d('JSONファイルを読み込み中: $_jsonPath', tag: _tag);
      final jsonString = await rootBundle.loadString(_jsonPath);
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

      final questionsJson = jsonData['questions'] as List<dynamic>;
      final questions = questionsJson
          .map((json) => QuizQuestion.fromJson(json as Map<String, dynamic>))
          .toList();

      Log.d('${questions.length}問の問題を読み込みました', tag: _tag);
      _cachedQuestions = questions;
      return questions;
    } catch (e) {
      Log.e('JSONファイルの読み込みに失敗: $e', tag: _tag);
      throw Exception('問題データの読み込みに失敗しました: $e');
    }
  }

  /// テーマでフィルタリング
  @override
  List<QuizQuestion> filterByTheme(List<QuizQuestion> questions, String themeName) {
    final filtered = questions.where((q) => q.theme == themeName).toList();
    Log.d('テーマ「$themeName」でフィルタリング: ${filtered.length}問', tag: _tag);
    return filtered;
  }

  /// ランダムに問題を選択
  @override
  List<QuizQuestion> selectRandom(
    List<QuizQuestion> questions,
    int count, {
    Random? random,
  }) {
    final rng = random ?? Random();
    final shuffled = List<QuizQuestion>.from(questions)..shuffle(rng);
    return shuffled.take(count).toList();
  }
}
