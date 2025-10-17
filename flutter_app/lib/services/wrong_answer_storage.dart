import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/debug_logger.dart';
import 'quiz_data_loader.dart';

/// 間違えた問題を保存・管理するサービス（IDベース）
class WrongAnswerStorage {
  static const String _key = 'sekai_kentei_wrong_answers_v2'; // v2で新しいフォーマット
  static const String _tag = 'WrongAnswerStorage';

  /// 間違えた問題を追加（IDベース）
  static Future<void> addWrongAnswer(String questionId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wrongAnswerIds = await getWrongAnswerIds();

      Log.d('💾 [追加前] 現在の間違えた問題ID: $wrongAnswerIds', tag: _tag);

      // 重複チェック
      if (!wrongAnswerIds.contains(questionId)) {
        wrongAnswerIds.add(questionId);

        final jsonString = jsonEncode(wrongAnswerIds);
        await prefs.setString(_key, jsonString);
        Log.d('💾 [追加] 間違えた問題を追加: $questionId', tag: _tag);
        Log.d('💾 [追加後] 保存後のID一覧: $wrongAnswerIds', tag: _tag);
      } else {
        Log.d('💾 [スキップ] すでに保存済み: $questionId', tag: _tag);
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

      Log.d('🗑️ [削除前] 現在の間違えた問題ID: $wrongAnswerIds', tag: _tag);

      final removed = wrongAnswerIds.remove(questionId);

      final jsonString = jsonEncode(wrongAnswerIds);
      await prefs.setString(_key, jsonString);

      if (removed) {
        Log.d('🗑️ [削除] 間違えた問題を削除: $questionId', tag: _tag);
        Log.d('🗑️ [削除後] 残りのID一覧: $wrongAnswerIds', tag: _tag);
      } else {
        Log.w('🗑️ [削除失敗] 見つからなかった: $questionId', tag: _tag);
      }
    } catch (e) {
      Log.e('間違えた問題の削除エラー: $e', tag: _tag);
    }
  }

  /// 旧フォーマットから新フォーマットへのマイグレーション
  /// allQuestions: 全問題データ（問題文からIDを逆引きするために必要）
  static Future<void> migrateFromOldFormat(List<QuizQuestion>? allQuestions) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      const oldKey = 'sekai_kentei_wrong_answers';
      final oldData = prefs.getString(oldKey);

      if (oldData == null || oldData.isEmpty) {
        Log.d('旧データなし - マイグレーション不要', tag: _tag);
        return;
      }

      // 旧データをパース
      final List<dynamic> decoded = jsonDecode(oldData);
      final oldWrongAnswers = decoded.cast<Map<String, dynamic>>();

      Log.d('旧データ発見: ${oldWrongAnswers.length}件', tag: _tag);

      // allQuestionsがない場合は変換できないのでクリアのみ
      if (allQuestions == null || allQuestions.isEmpty) {
        await prefs.remove(oldKey);
        Log.w('問題データなし - 旧データをクリアのみ', tag: _tag);
        return;
      }

      // 問題文からIDを逆引き
      final convertedIds = <String>[];
      for (final item in oldWrongAnswers) {
        final questionText = item['question'] as String?;
        if (questionText == null) continue;

        // 問題文でマッチング（trim して比較）
        QuizQuestion? match;
        try {
          match = allQuestions.firstWhere(
            (q) => q.question.trim() == questionText.trim(),
          );
        } catch (e) {
          match = null;
        }

        if (match != null) {
          convertedIds.add(match.id);
          Log.d('変換成功: "$questionText" → ${match.id}', tag: _tag);
        } else {
          Log.w('変換失敗（問題が見つからない）: "$questionText"', tag: _tag);
        }
      }

      // v2形式で保存
      if (convertedIds.isNotEmpty) {
        await prefs.setString(_key, jsonEncode(convertedIds));
        Log.d('v2形式で保存: ${convertedIds.length}件', tag: _tag);
      }

      // 旧データを削除
      await prefs.remove(oldKey);
      Log.d('マイグレーション完了: ${oldWrongAnswers.length}件 → ${convertedIds.length}件', tag: _tag);
    } catch (e) {
      Log.e('マイグレーションエラー: $e', tag: _tag);
    }
  }
}
