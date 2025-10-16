import '../game_session/game_models.dart';
import '../game_session/game_configs.dart';

/// ゲーム設定カタログエクスポーター
class LessonExporter {
  /// 各ゲームタイプのConfigインスタンスを保持
  static final Map<GameType, GameConfig> _gameConfigs = {
    GameType.counting: const CountingConfig(range: '1-5'),
    GameType.comparison: const ComparisonConfig(displayType: 'dots', range: '1-10', optionCount: 2),
    GameType.writing: const WritingConfig(sequence: ['tracing'], characterId: 'あ', categoryId: 'hiragana'),
    GameType.oddEven: const OddEvenConfig(targetType: 'odd', range: '0-9'),
    GameType.sizeComparison: const SizeComparisonConfig(comparisonChoice: 'largest'),
    GameType.numberRecognition: const NumberRecognitionConfig(targetNumbers: [1]),
    GameType.puzzle: const PuzzleConfig(),
    GameType.shapeMatching: const ShapeMatchingConfig(),
    GameType.figureOrientation: const FigureOrientationConfig(),
    GameType.tsumikiCounting: const TsumikiCountingConfig(mode: 'imageToNumber', range: '1-3'),
    GameType.wordGame: const WordGameConfig(mode: 'pictureToText'),
  };

  /// ゲーム設定選択肢ツリーを出力
  static Map<String, dynamic> exportGameSettingsCatalog() {
    final games = <String, dynamic>{};

    for (final entry in _gameConfigs.entries) {
      final gameType = entry.key;
      final config = entry.value;

      games['${gameType.name}.v1'] = {
        'displayName': config.displayName,
        'description': config.description,
        'hasSettings': config.hasSettings,
        'options': config.availableOptions,
        'defaultConfig': config.defaultConfig,
      };
    }

    return {
      'meta': {
        'version': '2.0',
        'generatedAt': DateTime.now().toIso8601String(),
        'description': 'ゲームタイプ設定カタログ - GUI選択用（GameConfigベース）',
      },
      'games': games,
    };
  }
  
  
}