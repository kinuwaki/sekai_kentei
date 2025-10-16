/// ゲーム設定の基底クラス
abstract class GameSettings {
  const GameSettings();
  /// タイプ識別子（スキーマ版番号込み）例: "counting.v1", "comparison.v2"
  String get typeId;
  
  /// バリデーション結果
  List<ValidationIssue> validate();
  
  /// JSON出力（永続化用）
  Map<String, dynamic> toJson();
  
  /// ツリー構造出力（UI/運用者向け整形ビュー）
  Map<String, dynamic> toTreeStructure();
  
  /// 推定プレイ時間（秒）
  int get estimatedDurationSec;
  
  /// 難易度スコア（0-100）
  int get difficultyScore;
  
  /// タグリスト（"intro", "digits", "advanced" など）
  List<String> get tags;
}

/// バリデーション問題の詳細
class ValidationIssue {
  final ValidationLevel level;
  final String field;
  final String message;
  final dynamic actualValue;
  final dynamic expectedValue;

  const ValidationIssue({
    required this.level,
    required this.field,
    required this.message,
    this.actualValue,
    this.expectedValue,
  });

  @override
  String toString() => '[$level] $field: $message';
}

enum ValidationLevel {
  fatal,  // 実行不可
  warn,   // 軽微な問題
}

/// ゲーム設定ファクトリ
class GameSettingsFactory {
  static final Map<String, GameSettings Function(Map<String, dynamic>)> _builders = {};
  
  /// ビルダー登録
  static void register(String typeId, GameSettings Function(Map<String, dynamic>) builder) {
    _builders[typeId] = builder;
  }
  
  /// YAML から設定作成
  static GameSettings fromYaml(String typeId, Map<String, dynamic> yaml) {
    final builder = _builders[typeId];
    if (builder == null) {
      throw UnsupportedError('Unknown game type: $typeId');
    }
    return builder(yaml);
  }
  
  /// 登録済みタイプ一覧
  static List<String> get registeredTypes => _builders.keys.toList();
}