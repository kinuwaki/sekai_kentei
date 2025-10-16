import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// 進捗管理システム
class ProgressManager {
  static const String _progressKey = 'lesson_progress';
  static const String _historyKey = 'lesson_history';
  static const int _progressVersion = 1;
  
  /// 現在の進捗を取得
  static Future<ProgressState> loadProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final progressJson = prefs.getString(_progressKey);
      
      if (progressJson == null) {
        return ProgressState.initial();
      }
      
      final data = jsonDecode(progressJson) as Map<String, dynamic>;
      return ProgressState.fromJson(data);
    } catch (e) {
      // 読み込みエラー時は初期状態を返す
      return ProgressState.initial();
    }
  }
  
  /// 進捗を保存
  static Future<void> saveProgress(ProgressState state) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final progressJson = jsonEncode(state.toJson());
      await prefs.setString(_progressKey, progressJson);
    } catch (e) {
      // 保存エラーは無視（次回の保存で回復する可能性）
    }
  }
  
  /// カテゴリ完了をマーク
  static Future<ProgressState> markCategoryComplete(
    ProgressState currentState, 
    String category,
  ) async {
    final newState = currentState.markComplete(category);
    await saveProgress(newState);
    return newState;
  }
  
  /// 次のレッスンに進む
  static Future<ProgressState> advanceToNextLesson(ProgressState currentState) async {
    final newState = currentState.advanceLesson();
    await saveProgress(newState);
    
    // 履歴に記録
    await _addHistory(HistoryEntry(
      day: currentState.currentDay,
      completedAt: DateTime.now(),
      completedCategories: currentState.completedCategories.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList(),
    ));
    
    return newState;
  }
  
  /// プレイ履歴を追加
  static Future<void> _addHistory(HistoryEntry entry) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString(_historyKey) ?? '[]';
      final history = (jsonDecode(historyJson) as List)
          .map((e) => HistoryEntry.fromJson(e as Map<String, dynamic>))
          .toList();
      
      history.add(entry);
      
      // 履歴が100件を超えたら古いものを削除
      if (history.length > 100) {
        history.removeAt(0);
      }
      
      final updatedJson = jsonEncode(history.map((e) => e.toJson()).toList());
      await prefs.setString(_historyKey, updatedJson);
    } catch (e) {
      // 履歴保存エラーは無視
    }
  }
  
  /// プレイ履歴を取得
  static Future<List<HistoryEntry>> loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString(_historyKey) ?? '[]';
      return (jsonDecode(historyJson) as List)
          .map((e) => HistoryEntry.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }
  
  /// 進捗をリセット（デバッグ用）
  static Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_progressKey);
    await prefs.remove(_historyKey);
  }
}

/// 進捗状態
class ProgressState {
  final int progressVersion;
  final int currentDay;
  final Map<String, bool> completedCategories;
  final DateTime lastPlayedAt;
  
  const ProgressState({
    required this.progressVersion,
    required this.currentDay,
    required this.completedCategories,
    required this.lastPlayedAt,
  });
  
  /// 初期状態
  factory ProgressState.initial() {
    return ProgressState(
      progressVersion: 1,
      currentDay: 1,
      completedCategories: {
        'chie': false,
        'kazu': false,
        'moji': false,
      },
      lastPlayedAt: DateTime.now(),
    );
  }
  
  /// JSONから復元
  factory ProgressState.fromJson(Map<String, dynamic> json) {
    return ProgressState(
      progressVersion: json['progressVersion'] as int? ?? 1,
      currentDay: json['currentDay'] as int,
      completedCategories: Map<String, bool>.from(json['completedCategories']),
      lastPlayedAt: DateTime.parse(json['lastPlayedAt'] as String),
    );
  }
  
  /// JSONに変換
  Map<String, dynamic> toJson() {
    return {
      'progressVersion': progressVersion,
      'currentDay': currentDay,
      'completedCategories': completedCategories,
      'lastPlayedAt': lastPlayedAt.toIso8601String(),
    };
  }
  
  /// レッスンが完了しているか
  bool get isLessonComplete {
    return completedCategories.values.every((completed) => completed);
  }
  
  /// カテゴリ完了をマーク
  ProgressState markComplete(String category) {
    final newCompleted = Map<String, bool>.from(completedCategories);
    newCompleted[category] = true;
    
    return ProgressState(
      progressVersion: progressVersion,
      currentDay: currentDay,
      completedCategories: newCompleted,
      lastPlayedAt: DateTime.now(),
    );
  }
  
  /// 次のレッスンに進む
  ProgressState advanceLesson() {
    return ProgressState(
      progressVersion: progressVersion,
      currentDay: currentDay + 1,
      completedCategories: {
        'chie': false,
        'kazu': false,
        'moji': false,
      },
      lastPlayedAt: DateTime.now(),
    );
  }
  
  /// 完了したカテゴリ数
  int get completedCount {
    return completedCategories.values.where((completed) => completed).length;
  }
  
  /// 進捗率（0.0 - 1.0）
  double get progressRatio {
    return completedCount / completedCategories.length;
  }
}

/// プレイ履歴エントリ
class HistoryEntry {
  final int day;
  final DateTime completedAt;
  final List<String> completedCategories;
  
  const HistoryEntry({
    required this.day,
    required this.completedAt,
    required this.completedCategories,
  });
  
  factory HistoryEntry.fromJson(Map<String, dynamic> json) {
    return HistoryEntry(
      day: json['day'] as int,
      completedAt: DateTime.parse(json['completedAt'] as String),
      completedCategories: List<String>.from(json['completedCategories']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'completedAt': completedAt.toIso8601String(),
      'completedCategories': completedCategories,
    };
  }
}