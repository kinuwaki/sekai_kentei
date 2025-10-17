import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/debug_logger.dart';

/// 間違えた問題を保存・管理するサービス（IDベース）
class WrongAnswerStorage {
  static const String _key = 'sekai_kentei_wrong_answers_v2'; // v2で新しいフォーマット
  static const String _tag = 'WrongAnswerStorage';

  /// 間違えた問題を追加（IDベース）
  static Future<void> addWrongAnswer(String questionId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wrongAnswerIds = await getWrongAnswerIds();

      // 重複チェック
      if (!wrongAnswerIds.contains(questionId)) {
        wrongAnswerIds.add(questionId);

        final jsonString = jsonEncode(wrongAnswerIds);
        await prefs.setString(_key, jsonString);
        Log.d('間違えた問題を追加: $questionId', tag: _tag);
      }
    } catch (e) {
      Log.e('間違えた問題の保存エラー: $e', tag: _tag);
    }
  }

  /// 間違えた問題IDのリストを取得
  static Future<List<String>> getWrongAnswerIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_key);

      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded.cast<String>();
    } catch (e) {
      Log.e('間違えた問題の読み込みエラー: $e', tag: _tag);
      return [];
    }
  }

  /// 間違えた問題の数を取得
  static Future<int> getWrongAnswerCount() async {
    final wrongAnswerIds = await getWrongAnswerIds();
    return wrongAnswerIds.length;
  }

  /// 間違えた問題をすべてクリア（リセット）
  static Future<void> clearWrongAnswers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
      // 旧フォーマットのデータもクリア
      await prefs.remove('sekai_kentei_wrong_answers');
      Log.d('間違えた問題をすべてクリアしました（v1/v2両方）', tag: _tag);
    } catch (e) {
      Log.e('間違えた問題のクリアエラー: $e', tag: _tag);
    }
  }

  /// 特定の問題を削除（IDベース）
  static Future<void> removeWrongAnswer(String questionId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wrongAnswerIds = await getWrongAnswerIds();

      wrongAnswerIds.remove(questionId);

      final jsonString = jsonEncode(wrongAnswerIds);
      await prefs.setString(_key, jsonString);
      Log.d('間違えた問題を削除: $questionId', tag: _tag);
    } catch (e) {
      Log.e('間違えた問題の削除エラー: $e', tag: _tag);
    }
  }

  /// 旧フォーマットから新フォーマットへのマイグレーション
  static Future<void> migrateFromOldFormat() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      const oldKey = 'sekai_kentei_wrong_answers';
      final oldData = prefs.getString(oldKey);

      if (oldData != null && oldData.isNotEmpty) {
        // 旧データが存在する場合はクリアのみ（問題文からIDへの変換は不可能）
        await prefs.remove(oldKey);
        Log.d('旧フォーマットのデータをクリアしました', tag: _tag);
      }
    } catch (e) {
      Log.e('マイグレーションエラー: $e', tag: _tag);
    }
  }
}
