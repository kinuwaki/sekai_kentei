import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/debug_logger.dart';

/// 間違えた問題を保存・管理するサービス
class WrongAnswerStorage {
  static const String _key = 'sekai_kentei_wrong_answers';
  static const String _tag = 'WrongAnswerStorage';

  /// 間違えた問題を追加
  static Future<void> addWrongAnswer(String question, String correctAnswer) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wrongAnswers = await getWrongAnswers();

      // 重複チェック
      final exists = wrongAnswers.any((item) => item['question'] == question);
      if (!exists) {
        wrongAnswers.add({
          'question': question,
          'correctAnswer': correctAnswer,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        });

        final jsonString = jsonEncode(wrongAnswers);
        await prefs.setString(_key, jsonString);
        Log.d('間違えた問題を追加: $question', tag: _tag);
      }
    } catch (e) {
      Log.e('間違えた問題の保存エラー: $e', tag: _tag);
    }
  }

  /// 間違えた問題のリストを取得
  static Future<List<Map<String, dynamic>>> getWrongAnswers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_key);

      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      Log.e('間違えた問題の読み込みエラー: $e', tag: _tag);
      return [];
    }
  }

  /// 間違えた問題の数を取得
  static Future<int> getWrongAnswerCount() async {
    final wrongAnswers = await getWrongAnswers();
    return wrongAnswers.length;
  }

  /// 間違えた問題をすべてクリア（リセット）
  static Future<void> clearWrongAnswers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
      Log.d('間違えた問題をすべてクリアしました', tag: _tag);
    } catch (e) {
      Log.e('間違えた問題のクリアエラー: $e', tag: _tag);
    }
  }

  /// 特定の問題を削除
  static Future<void> removeWrongAnswer(String question) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wrongAnswers = await getWrongAnswers();

      wrongAnswers.removeWhere((item) => item['question'] == question);

      final jsonString = jsonEncode(wrongAnswers);
      await prefs.setString(_key, jsonString);
      Log.d('間違えた問題を削除: $question', tag: _tag);
    } catch (e) {
      Log.e('間違えた問題の削除エラー: $e', tag: _tag);
    }
  }
}
