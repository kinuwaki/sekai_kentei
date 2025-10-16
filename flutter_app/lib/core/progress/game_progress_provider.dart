import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ゲーム完了状態を管理するプロバイダー
final gameProgressProvider = StateNotifierProvider<GameProgressNotifier, GameProgress>((ref) {
  return GameProgressNotifier();
});

/// ゲーム完了状態
class GameProgress {
  final Map<String, GameCompletionData> completedGames;

  const GameProgress({
    this.completedGames = const {},
  });

  GameProgress copyWith({
    Map<String, GameCompletionData>? completedGames,
  }) {
    return GameProgress(
      completedGames: completedGames ?? this.completedGames,
    );
  }

  /// 特定のゲームが完了しているかどうか
  bool isGameCompleted(String gameKey) {
    return completedGames.containsKey(gameKey);
  }

  /// 特定のゲームの完了データを取得
  GameCompletionData? getCompletionData(String gameKey) {
    return completedGames[gameKey];
  }
}

/// ゲーム完了データ
class GameCompletionData {
  final double scoreRatio; // 正答率 (0.0-1.0)
  final DateTime completedAt;

  const GameCompletionData({
    required this.scoreRatio,
    required this.completedAt,
  });

  /// メダルレベルを取得
  MedalLevel get medalLevel {
    if (scoreRatio >= 1.0) return MedalLevel.gold;
    if (scoreRatio >= 0.8) return MedalLevel.silver;
    return MedalLevel.bronze;
  }

  Map<String, dynamic> toJson() {
    return {
      'scoreRatio': scoreRatio,
      'completedAt': completedAt.millisecondsSinceEpoch,
    };
  }

  factory GameCompletionData.fromJson(Map<String, dynamic> json) {
    return GameCompletionData(
      scoreRatio: (json['scoreRatio'] as num).toDouble(),
      completedAt: DateTime.fromMillisecondsSinceEpoch(json['completedAt'] as int),
    );
  }
}

/// メダルレベル
enum MedalLevel {
  gold,   // 全問正解 (左側)
  silver, // 0.8以上 (真ん中)
  bronze, // 0.8未満 (右側)
}

/// ゲーム進捗状況管理
class GameProgressNotifier extends StateNotifier<GameProgress> {
  GameProgressNotifier() : super(const GameProgress()) {
    _loadProgress();
  }

  /// 進捗状況をローカルストレージから読み込み
  Future<void> _loadProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final completedGames = <String, GameCompletionData>{};

      // 各ゲームキーについて個別に読み込み（もじも追加）
      for (final gameKey in ['ちえ', 'かず', 'もじ']) {
        final scoreRatio = prefs.getDouble('game_${gameKey}_score');
        final completedAt = prefs.getInt('game_${gameKey}_completed');

        if (scoreRatio != null && completedAt != null) {
          completedGames[gameKey] = GameCompletionData(
            scoreRatio: scoreRatio,
            completedAt: DateTime.fromMillisecondsSinceEpoch(completedAt),
          );
        }
      }

      state = GameProgress(completedGames: completedGames);
    } catch (e) {
      // 読み込みエラーの場合は初期状態のまま
    }
  }

  /// 進捗状況をローカルストレージに保存
  Future<void> _saveProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      for (final entry in state.completedGames.entries) {
        await prefs.setDouble('game_${entry.key}_score', entry.value.scoreRatio);
        await prefs.setInt('game_${entry.key}_completed', entry.value.completedAt.millisecondsSinceEpoch);
      }
    } catch (e) {
      // 保存エラーは無視（次回読み込み時に前の状態が復元される）
    }
  }

  /// ゲーム完了を記録（常に最高スコアを保持）
  Future<void> markGameCompleted(String gameKey, double scoreRatio) async {
    print('DEBUG: markGameCompleted - gameKey: $gameKey, scoreRatio: $scoreRatio');

    final newCompletedGames = Map<String, GameCompletionData>.from(state.completedGames);
    final existingData = newCompletedGames[gameKey];

    // 既存のスコアがない、または新しいスコアの方が高い場合のみ更新
    if (existingData == null || scoreRatio > existingData.scoreRatio) {
      final completionData = GameCompletionData(
        scoreRatio: scoreRatio,
        completedAt: DateTime.now(),
      );
      newCompletedGames[gameKey] = completionData;
      print('DEBUG: New best score! Previous: ${existingData?.scoreRatio}, New: $scoreRatio');

      state = state.copyWith(completedGames: newCompletedGames);
      print('DEBUG: State updated - completedGames: ${state.completedGames}');
      await _saveProgress();
      print('DEBUG: Progress saved to SharedPreferences');
    } else {
      print('DEBUG: Score $scoreRatio not better than existing ${existingData.scoreRatio}, not updating');
    }
  }

  /// 進捗をリセット（デバッグ用）
  Future<void> resetProgress() async {
    state = const GameProgress();
    await _saveProgress();
  }
}