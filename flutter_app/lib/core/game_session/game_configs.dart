import 'game_models.dart';
import '../../ui/games/counting_game/models/counting_models.dart';
import '../../ui/games/comparison_game/models/comparison_models.dart';
import '../../ui/games/writing_game/writing_game_models.dart';

/// かずかぞえゲーム用設定
class CountingConfig implements GameConfig {
  final String range; // "1-5" など
  final int? optionCount; // 将来用（選択肢数など）

  const CountingConfig({
    required this.range,
    this.optionCount,
  });

  @override
  GameType get type => GameType.counting;

  @override
  String get displayName => '数える (Counting)';

  @override
  String get description => '数を数える基本的なゲーム';

  @override
  Map<String, dynamic> get availableOptions => {
    'range': ['1-5', '5-10', '1-10'],
  };

  @override
  Map<String, dynamic> get defaultConfig => {
    'range': '1-5',
  };

  @override
  bool get hasSettings => true;

  @override
  Map<String, dynamic> toJson() => {
    'range': range,
    'optionCount': optionCount,
  };
  
  static CountingConfig fromJson(Map<String, dynamic> json) => CountingConfig(
    range: json['range'],
    optionCount: json['optionCount'],
  );
  
  /// 既存のCountingGameSettingsに変換
  CountingGameSettings toCountingSettings() => CountingGameSettings(
    range: _parseCountingRange(range),
    questionCount: 1, // Orchestratorが管理するため1問ずつ
  );
  
  /// String から CountingRange への変換
  static CountingRange _parseCountingRange(String range) {
    switch (range) {
      case '1-5':
        return CountingRange.range1to5;
      case '5-10':
        return CountingRange.range5to10;
      case '1-10':
        return CountingRange.range1to10;
      default:
        throw ArgumentError('Unsupported counting range: $range');
    }
  }
}

/// おおきいちいさいゲーム用設定
class ComparisonConfig implements GameConfig {
  final String displayType; // "dots" | "digits"
  final String range;    // "1-10"
  final int optionCount; // 2/3/4

  const ComparisonConfig({
    required this.displayType,
    required this.range,
    required this.optionCount,
  });

  @override
  GameType get type => GameType.comparison;

  @override
  String get displayName => '比較する (Comparison)';

  @override
  String get description => '数の大小を比較するゲーム';

  @override
  Map<String, dynamic> get availableOptions => {
    'displayType': ['dots', 'digits'],
    'range': [
      '1-5', '5-10', '10-20', '20-30', '30-40', '40-50',
      '50-60', '60-70', '70-80', '80-90', '90-100',
      '1-20', '20-50', '50-100', '100-120', '1-50', '1-120'
    ],
    'optionCount': [2, 3, 4],
  };

  @override
  Map<String, dynamic> get defaultConfig => {
    'displayType': 'dots',
    'range': '1-10',
    'optionCount': 2,
  };

  @override
  bool get hasSettings => true;

  @override
  Map<String, dynamic> toJson() => {
    'displayType': displayType,
    'range': range,
    'optionCount': optionCount,
  };

  static ComparisonConfig fromJson(Map<String, dynamic> json) => ComparisonConfig(
    displayType: json['displayType'] ?? 'dots',
    range: json['range'],
    optionCount: json['optionCount'],
  );
  
  /// 既存のComparisonGameSettingsに変換
  ComparisonGameSettings toComparisonSettings() => ComparisonGameSettings(
    displayType: displayType == 'dots' ? ComparisonDisplayType.dots : ComparisonDisplayType.digits,
    range: _parseComparisonRange(range),
    optionCount: optionCount,
    questionCount: 1, // Orchestratorが管理するため1問ずつ
  );
  
  /// String から ComparisonRange への変換
  static ComparisonRange _parseComparisonRange(String range) {
    switch (range) {
      case '1-5':
        return ComparisonRange.range1to5;
      case '5-10':
        return ComparisonRange.range5to10;
      case '10-20':
        return ComparisonRange.range10to20;
      case '20-30':
        return ComparisonRange.range20to30;
      case '30-40':
        return ComparisonRange.range30to40;
      case '40-50':
        return ComparisonRange.range40to50;
      case '50-60':
        return ComparisonRange.range50to60;
      case '60-70':
        return ComparisonRange.range60to70;
      case '70-80':
        return ComparisonRange.range70to80;
      case '80-90':
        return ComparisonRange.range80to90;
      case '90-100':
        return ComparisonRange.range90to100;
      case '50-100':
        return ComparisonRange.range50to100;
      case '100-120':
        return ComparisonRange.range100to120;
      case '1-120':
        return ComparisonRange.range1to120;
      case '1-20':
        return ComparisonRange.range1to20;
      case '20-50':
        return ComparisonRange.range20to50;
      case '1-50':
        return ComparisonRange.range1to50;
      default:
        throw ArgumentError('Unsupported comparison range: $range');
    }
  }
}

/// かきれんしゅうゲーム用設定
class WritingConfig implements GameConfig {
  final List<String> sequence; // ["tracing", "tracingFree", "freeWrite"]
  final String characterId; // 文字ID
  final String categoryId; // カテゴリID

  const WritingConfig({
    required this.sequence,
    required this.characterId,
    required this.categoryId,
  });

  @override
  GameType get type => GameType.writing;

  @override
  String get displayName => '文字を書く (Writing)';

  @override
  String get description => 'ひらがな・カタカナ・漢字の書き取り練習';

  @override
  Map<String, dynamic> get availableOptions => {
    'categoryId': ['hiragana', 'katakana', 'kanji'],
    'characterId': [
      'あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ',
      'さ', 'し', 'す', 'せ', 'そ', 'た', 'ち', 'つ', 'て', 'と',
      'な', 'に', 'ぬ', 'ね', 'の', 'は', 'ひ', 'ふ', 'へ', 'ほ',
      'ま', 'み', 'む', 'め', 'も', 'や', 'ゆ', 'よ',
      'ら', 'り', 'る', 'れ', 'ろ', 'わ', 'を', 'ん'
    ],
    'sequence': [
      ['tracing'],
      ['tracingFree'],
      ['freeWrite'],
      ['tracing', 'tracingFree'],
      ['tracing', 'freeWrite'],
      ['tracingFree', 'freeWrite'],
      ['tracing', 'tracingFree', 'freeWrite'],
    ],
  };

  @override
  Map<String, dynamic> get defaultConfig => {
    'categoryId': 'hiragana',
    'sequence': ['tracing'],
    'characterId': 'あ',
  };

  @override
  bool get hasSettings => true;

  @override
  Map<String, dynamic> toJson() => {
    'sequence': sequence,
    'characterId': characterId,
    'categoryId': categoryId,
  };
  
  static WritingConfig fromJson(Map<String, dynamic> json) => WritingConfig(
    sequence: List<String>.from(json['sequence']),
    characterId: json['characterId'],
    categoryId: json['categoryId'],
  );
  
  /// WritingModeのリストに変換
  List<WritingMode> get writingModes => sequence
    .map((s) => WritingMode.values.byName(s))
    .toList();
  
  /// 既存のWritingGameSettingsに変換（文字データが必要）
  WritingGameSettings toWritingSettings(CharacterData character) => WritingGameSettings(
    category: CharacterCategory.values.byName(categoryId),
    mode: writingModes.first, // 最初のモード
    character: character,
  );
}

/// きすう・ぐうすうゲーム用設定
class OddEvenConfig implements GameConfig {
  final String targetType; // "odd" | "even"
  final String range; // "0-9", "10-19" など

  const OddEvenConfig({
    required this.targetType,
    required this.range,
  });

  @override
  GameType get type => GameType.oddEven;

  @override
  String get displayName => 'きすう・ぐうすう (Odd/Even)';

  @override
  String get description => '数字が奇数か偶数かを判定するゲーム';

  @override
  Map<String, dynamic> get availableOptions => {
    'targetType': ['odd', 'even'],
    'range': ['0-9', '10-19', '20-29', '30-39', '40-49', '50-59', '60-69', '70-79', '80-89', '90-99', '100-109', '110-119'],
  };

  @override
  Map<String, dynamic> get defaultConfig => {
    'targetType': 'odd',
    'range': '0-9',
  };

  @override
  bool get hasSettings => true;

  @override
  Map<String, dynamic> toJson() => {
    'targetType': targetType,
    'range': range,
  };

  static OddEvenConfig fromJson(Map<String, dynamic> json) => OddEvenConfig(
    targetType: json['targetType'],
    range: json['range'],
  );
}

/// サイズ比較ゲーム用設定
class SizeComparisonConfig implements GameConfig {
  final String comparisonChoice; // 選択タイプ

  const SizeComparisonConfig({
    required this.comparisonChoice,
  });

  @override
  GameType get type => GameType.sizeComparison;

  @override
  String get displayName => 'なんばんめにおおきい・ちいさい (Size Comparison)';

  @override
  String get description => '複数のオブジェクトの大小を順序立てて比較するゲーム';

  @override
  Map<String, dynamic> get availableOptions => {
    'comparisonChoice': [
      'largest',        // いちばんおおきい
      'smallest',       // いちばんちいさい
      'sizeRandom',     // おおきいちいさいランダム
      'leftPosition',   // ひだりから
      'rightPosition',  // みぎから
      'positionRandom', // ひだりみぎランダム
    ],
  };

  @override
  Map<String, dynamic> get defaultConfig => {
    'comparisonChoice': 'largest',
  };

  @override
  bool get hasSettings => true;

  @override
  Map<String, dynamic> toJson() => {
    'comparisonChoice': comparisonChoice,
  };

  static SizeComparisonConfig fromJson(Map<String, dynamic> json) => SizeComparisonConfig(
    comparisonChoice: json['comparisonChoice'],
  );
}

/// 数字認識ゲーム用設定
class NumberRecognitionConfig implements GameConfig {
  final List<int> targetNumbers; // 練習する数字のリスト

  const NumberRecognitionConfig({
    required this.targetNumbers,
  });

  @override
  GameType get type => GameType.numberRecognition;

  @override
  String get displayName => 'すうじをかこう (Number Recognition)';

  @override
  String get description => '数字の形を覚えて正しく書く練習ゲーム';

  @override
  Map<String, dynamic> get availableOptions => {
    'targetNumbers': [
      [1], [2], [3], [4], [5], [6], [7], [8], [9], [0],
      [1, 2], [3, 4], [5, 6], [7, 8], [9, 0],
      [1, 2, 3], [4, 5, 6], [7, 8, 9], [0, 1, 2],
    ],
  };

  @override
  Map<String, dynamic> get defaultConfig => {
    'targetNumbers': [1],
  };

  @override
  bool get hasSettings => true;

  @override
  Map<String, dynamic> toJson() => {
    'targetNumbers': targetNumbers,
  };

  static NumberRecognitionConfig fromJson(Map<String, dynamic> json) => NumberRecognitionConfig(
    targetNumbers: List<int>.from(json['targetNumbers']),
  );
}

/// ばらばらパズルゲーム用設定（即開始）
class PuzzleConfig implements GameConfig {
  const PuzzleConfig();

  @override
  GameType get type => GameType.puzzle;

  @override
  String get displayName => 'ばらばらパズル (Puzzle)';

  @override
  String get description => 'バラバラになったピースを正しい位置に配置するゲーム';

  @override
  Map<String, dynamic> get availableOptions => {}; // 設定なし

  @override
  Map<String, dynamic> get defaultConfig => {};

  @override
  bool get hasSettings => false;

  @override
  Map<String, dynamic> toJson() => {};

  static PuzzleConfig fromJson(Map<String, dynamic> json) => const PuzzleConfig();
}

/// かたちさがしゲーム用設定（即開始）
class ShapeMatchingConfig implements GameConfig {
  const ShapeMatchingConfig();

  @override
  GameType get type => GameType.shapeMatching;

  @override
  String get displayName => 'かたちさがし (Shape Matching)';

  @override
  String get description => '同じ形を見つけるマッチングゲーム';

  @override
  Map<String, dynamic> get availableOptions => {}; // 設定なし

  @override
  Map<String, dynamic> get defaultConfig => {};

  @override
  bool get hasSettings => false;

  @override
  Map<String, dynamic> toJson() => {};

  static ShapeMatchingConfig fromJson(Map<String, dynamic> json) => const ShapeMatchingConfig();
}

/// ずけいむきまちがいゲーム用設定（即開始）
class FigureOrientationConfig implements GameConfig {
  const FigureOrientationConfig();

  @override
  GameType get type => GameType.figureOrientation;

  @override
  String get displayName => 'ずけいむきまちがい (Figure Orientation)';

  @override
  String get description => '図形の向きが間違っているものを見つけるゲーム';

  @override
  Map<String, dynamic> get availableOptions => {}; // 設定なし

  @override
  Map<String, dynamic> get defaultConfig => {};

  @override
  bool get hasSettings => false;

  @override
  Map<String, dynamic> toJson() => {};

  static FigureOrientationConfig fromJson(Map<String, dynamic> json) => const FigureOrientationConfig();
}

/// つみき数えるゲーム用設定
class TsumikiCountingConfig implements GameConfig {
  final String mode; // "imageToNumber" | "numberToImage"
  final String range; // "1-3", "2-4", "3-5" など

  const TsumikiCountingConfig({
    required this.mode,
    required this.range,
  });

  @override
  GameType get type => GameType.tsumikiCounting;

  @override
  String get displayName => 'つみき (Block Counting)';

  @override
  String get description => 'つみきの画像を見て数を数えるゲーム';

  @override
  Map<String, dynamic> get availableOptions => {
    'mode': ['imageToNumber', 'numberToImage'], // えからすうじ、すうじからえ
    'range': ['1-3', '2-4', '3-5', '4-6', '5-7', '6-8', '7-9'],
  };

  @override
  Map<String, dynamic> get defaultConfig => {
    'mode': 'imageToNumber',
    'range': '1-3',
  };

  @override
  bool get hasSettings => true;

  @override
  Map<String, dynamic> toJson() => {
    'mode': mode,
    'range': range,
  };

  static TsumikiCountingConfig fromJson(Map<String, dynamic> json) => TsumikiCountingConfig(
    mode: json['mode'],
    range: json['range'],
  );
}

/// たんごゲーム用設定
class WordGameConfig implements GameConfig {
  final String mode; // "pictureToText" | "textToPicture"

  const WordGameConfig({
    required this.mode,
  });

  @override
  GameType get type => GameType.wordGame;

  @override
  String get displayName => 'たんご (Word Game)';

  @override
  String get description => '絵を見て正しい単語を選ぶゲーム';

  @override
  Map<String, dynamic> get availableOptions => {
    'mode': ['pictureToText', 'textToPicture'], // えをみてもじをえらぶ、もじをみてえをえらぶ
  };

  @override
  Map<String, dynamic> get defaultConfig => {
    'mode': 'pictureToText',
  };

  @override
  bool get hasSettings => true;

  @override
  Map<String, dynamic> toJson() => {
    'mode': mode,
  };

  static WordGameConfig fromJson(Map<String, dynamic> json) => WordGameConfig(
    mode: json['mode'],
  );
}

/// 文字辿りゲーム用設定（即開始）
class WordTraceConfig implements GameConfig {
  const WordTraceConfig();

  @override
  GameType get type => GameType.wordTrace;

  @override
  String get displayName => 'もじめぐり (Word Trace)';

  @override
  String get description => '文章を線で辿るゲーム';

  @override
  Map<String, dynamic> get availableOptions => {}; // 設定なし

  @override
  Map<String, dynamic> get defaultConfig => {};

  @override
  bool get hasSettings => false;

  @override
  Map<String, dynamic> toJson() => {};

  static WordTraceConfig fromJson(Map<String, dynamic> json) => const WordTraceConfig();
}