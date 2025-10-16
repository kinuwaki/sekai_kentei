/// ゲーム横断セッション管理のコアモデル
import 'game_configs.dart';

enum GameType {
  counting,
  comparison,
  writing,
  oddEven,
  sizeComparison,
  numberRecognition,
  // 即開始ゲーム（設定なし）
  puzzle,
  shapeMatching,
  figureOrientation,
  tsumikiCounting,
  wordGame,
  wordTrace,
}

/// ゲーム設定の基底インターフェース
abstract class GameConfig {
  GameType get type;
  Map<String, dynamic> toJson();

  /// 設定画面で選択可能なオプション（LessonExporter用）
  Map<String, dynamic> get availableOptions;

  /// デフォルト設定値
  Map<String, dynamic> get defaultConfig;

  /// 設定画面が必要かどうか
  bool get hasSettings;

  /// ゲーム表示名
  String get displayName;

  /// ゲーム説明
  String get description;

  /// JSON からGameConfigを復元するファクトリ
  static GameConfig fromJson(GameType type, Map<String, dynamic> json) {
    switch (type) {
      case GameType.counting:
        return CountingConfig.fromJson(json);
      case GameType.comparison:
        return ComparisonConfig.fromJson(json);
      case GameType.writing:
        return WritingConfig.fromJson(json);
      case GameType.oddEven:
        return OddEvenConfig.fromJson(json);
      case GameType.sizeComparison:
        return SizeComparisonConfig.fromJson(json);
      case GameType.numberRecognition:
        return NumberRecognitionConfig.fromJson(json);
      case GameType.puzzle:
        return PuzzleConfig.fromJson(json);
      case GameType.shapeMatching:
        return ShapeMatchingConfig.fromJson(json);
      case GameType.figureOrientation:
        return FigureOrientationConfig.fromJson(json);
      case GameType.tsumikiCounting:
        return TsumikiCountingConfig.fromJson(json);
      case GameType.wordGame:
        return WordGameConfig.fromJson(json);
      case GameType.wordTrace:
        return WordTraceConfig.fromJson(json);
    }
  }
}

/// 1つのゲームタスク（設定 + 実行回数）
class GameTask {
  final GameConfig config;
  final int repeatCount; // この設定で何問やるか

  const GameTask({
    required this.config, 
    required this.repeatCount,
  });
  
  Map<String, dynamic> toJson() => {
    'type': config.type.name,
    'config': config.toJson(),
    'repeatCount': repeatCount,
  };
  
  static GameTask fromJson(Map<String, dynamic> json) => GameTask(
    config: GameConfig.fromJson(
      GameType.values.byName(json['type']), 
      json['config'],
    ),
    repeatCount: json['repeatCount'],
  );
}

/// ゲームセッション（複数タスクの組み合わせ）
class GameSession {
  final List<GameTask> tasks;
  int _index = 0;

  GameSession(this.tasks);
  
  int get currentIndex => _index;
  GameTask get currentTask => tasks[_index];
  bool get hasNext => _index < tasks.length - 1;
  bool get isDone => _index >= tasks.length;
  int get totalTasks => tasks.length;
  
  void next() { 
    if (hasNext) _index++; 
  }
  
  void reset() {
    _index = 0;
  }
  
  /// 進捗表示用
  String get progressText => '${_index + 1}/$totalTasks';
  
  Map<String, dynamic> toJson() => {
    'tasks': tasks.map((t) => t.toJson()).toList(),
    'currentIndex': _index,
  };
  
  static GameSession fromJson(Map<String, dynamic> json) {
    final session = GameSession(
      (json['tasks'] as List)
        .map((t) => GameTask.fromJson(t))
        .toList(),
    );
    session._index = json['currentIndex'] ?? 0;
    return session;
  }
}

/// ゲーム結果
class GameResult {
  final GameType type;
  final bool correct;
  final Duration time;
  final Map<String, dynamic> meta;
  
  const GameResult({
    required this.type,
    required this.correct,
    required this.time,
    this.meta = const {},
  });
  
  Map<String, dynamic> toJson() => {
    'type': type.name,
    'correct': correct,
    'timeMs': time.inMilliseconds,
    'meta': meta,
  };
  
  static GameResult fromJson(Map<String, dynamic> json) => GameResult(
    type: GameType.values.byName(json['type']),
    correct: json['correct'],
    time: Duration(milliseconds: json['timeMs']),
    meta: json['meta'] ?? {},
  );
}