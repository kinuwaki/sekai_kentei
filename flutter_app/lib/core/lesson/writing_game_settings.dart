import '../../ui/games/writing_game/writing_game_models.dart';
import '../../ui/games/writing_game/writing_practice_settings.dart';
import 'game_settings_base.dart';

/// 書き練習ゲーム設定（基底クラス対応版）
class WritingGameSettingsUnified extends GameSettings {
  final String category;
  final List<String> characters;
  final List<int> sequence;

  const WritingGameSettingsUnified({
    required this.category,
    required this.characters,
    required this.sequence,
  });

  /// 選択肢ツリー定義
  static const Map<String, dynamic> optionsTree = {
    'category': {
      'hiragana': {
        'displayName': 'ひらがな',
        'characters': [
          'あ', 'い', 'う', 'え', 'お',
          'か', 'き', 'く', 'け', 'こ',
          'さ', 'し', 'す', 'せ', 'そ',
          'た', 'ち', 'つ', 'て', 'と',
          'な', 'に', 'ぬ', 'ね', 'の',
          'は', 'ひ', 'ふ', 'へ', 'ほ',
          'ま', 'み', 'む', 'め', 'も',
          'や', 'ゆ', 'よ',
          'ら', 'り', 'る', 'れ', 'ろ',
          'わ', 'を', 'ん'
        ],
      },
      'katakana': {
        'displayName': 'カタカナ',
        'characters': [
          'ア', 'イ', 'ウ', 'エ', 'オ',
          'カ', 'キ', 'ク', 'ケ', 'コ',
          'サ', 'シ', 'ス', 'セ', 'ソ',
          'タ', 'チ', 'ツ', 'テ', 'ト',
          'ナ', 'ニ', 'ヌ', 'ネ', 'ノ',
          'ハ', 'ヒ', 'フ', 'ヘ', 'ホ',
          'マ', 'ミ', 'ム', 'メ', 'モ',
          'ヤ', 'ユ', 'ヨ',
          'ラ', 'リ', 'ル', 'レ', 'ロ',
          'ワ', 'ヲ', 'ン'
        ],
      },
      'kanji': {
        'displayName': '漢字',
        'characters': [
          '一', '二', '三', '四', '五',
          '六', '七', '八', '九', '十',
          '大', '小', '上', '下', '中',
          '人', '日', '月', '火', '水',
          '木', '金', '土', '山', '川'
        ],
      }
    },
    'sequencePatterns': [
      [1, 0, 0],
      [2, 1, 1],
      [1, 2, 1],
      [3, 2, 2],
      [2, 3, 2],
      [1, 1, 1]
    ],
    'defaultConfig': {
      'category': 'hiragana',
      'characters': ['あ'],
      'sequence': [1, 0, 0],
    },
  };

  @override
  String get typeId => 'writing.v1';

  @override
  List<ValidationIssue> validate() {
    final issues = <ValidationIssue>[];

    // 文字数チェック
    if (characters.isEmpty) {
      issues.add(ValidationIssue(
        level: ValidationLevel.fatal,
        field: 'characters',
        message: '練習する文字が指定されていません',
        actualValue: characters.length,
        expectedValue: '1以上',
      ));
    }

    if (characters.length > 3) {
      issues.add(ValidationIssue(
        level: ValidationLevel.warn,
        field: 'characters',
        message: '一度に練習する文字は3文字以下が推奨です',
        actualValue: characters.length,
        expectedValue: '1-3',
      ));
    }

    // シーケンスチェック
    if (sequence.length != 3) {
      issues.add(ValidationIssue(
        level: ValidationLevel.fatal,
        field: 'sequence',
        message: 'シーケンスは3要素である必要があります [なぞり, なぞり２, 自由書き]',
        actualValue: sequence.length,
        expectedValue: '3',
      ));
    }

    for (int i = 0; i < sequence.length; i++) {
      if (sequence[i] < 0 || sequence[i] > 5) {
        issues.add(ValidationIssue(
          level: ValidationLevel.warn,
          field: 'sequence[$i]',
          message: 'シーケンス値は0-5の範囲が推奨です',
          actualValue: sequence[i],
          expectedValue: '0-5',
        ));
      }
    }

    // カテゴリチェック
    const validCategories = ['hiragana', 'numbers', 'alphabet'];
    if (!validCategories.contains(category)) {
      issues.add(ValidationIssue(
        level: ValidationLevel.warn,
        field: 'category',
        message: '未知のカテゴリです: $category',
        actualValue: category,
        expectedValue: validCategories,
      ));
    }

    return issues;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'typeId': typeId,
      'category': category,
      'characters': characters,
      'sequence': sequence,
    };
  }

  @override
  Map<String, dynamic> toTreeStructure() {
    return {
      'ゲームタイプ': '書き練習',
      'カテゴリ': _categoryDisplayName,
      '練習文字': characters.join('、'),
      'パターン': _sequenceDisplayName,
      '詳細': {
        'なぞり回数': sequence[0],
        'なぞり２回数': sequence[1],
        '自由書き回数': sequence[2],
        '総練習回数': sequence.fold(0, (sum, count) => sum + count),
        '推定時間': '${estimatedDurationSec}秒',
        '難易度': difficultyScore,
      },
    };
  }

  String get _categoryDisplayName {
    switch (category) {
      case 'hiragana':
        return 'ひらがな';
      case 'numbers':
        return '数字';
      case 'alphabet':
        return 'アルファベット';
      default:
        return category;
    }
  }

  String get _sequenceDisplayName {
    return '${sequence[0]}-${sequence[1]}-${sequence[2]}';
  }

  @override
  int get estimatedDurationSec {
    // なぞり: 20秒, なぞり２: 30秒, 自由書き: 40秒 想定
    return sequence[0] * 20 + sequence[1] * 30 + sequence[2] * 40;
  }

  @override
  int get difficultyScore {
    int base = _getCategoryDifficulty();
    int sequenceScore = sequence[0] * 5 + sequence[1] * 8 + sequence[2] * 12;
    int characterPenalty = characters.length > 1 ? (characters.length - 1) * 10 : 0;
    
    return base + sequenceScore + characterPenalty;
  }

  int _getCategoryDifficulty() {
    switch (category) {
      case 'hiragana':
        return 15;
      case 'numbers':
        return 10;
      case 'alphabet':
        return 20;
      default:
        return 15;
    }
  }

  @override
  List<String> get tags {
    final tagList = ['writing', category, _sequenceDisplayName, ...characters];
    
    if (sequence[0] > 0) tagList.add('なぞり');
    if (sequence[1] > 0) tagList.add('なぞり２');
    if (sequence[2] > 0) tagList.add('自由書き');
    
    return tagList;
  }

  /// 既存のWritingPracticeSettingsに変換
  WritingPracticeSettings toWritingPracticeSettings() {
    // シーケンス配列をWritingModeリストに変換
    final modeSequence = <WritingMode>[];
    
    // なぞりを追加
    for (int i = 0; i < sequence[0]; i++) {
      modeSequence.add(WritingMode.tracing);
    }
    // なぞり２を追加
    for (int i = 0; i < sequence[1]; i++) {
      modeSequence.add(WritingMode.tracingFree);
    }
    // 自由書きを追加
    for (int i = 0; i < sequence[2]; i++) {
      modeSequence.add(WritingMode.freeWrite);
    }
    
    return WritingPracticeSettings(
      character: characters.first, // 最初の文字のみ使用
      sequence: modeSequence,
    );
  }

  /// YAMLから作成
  factory WritingGameSettingsUnified.fromYaml(Map<String, dynamic> yaml) {
    return WritingGameSettingsUnified(
      category: yaml['category'] as String,
      characters: List<String>.from(yaml['characters'] as List),
      sequence: List<int>.from(yaml['sequence'] as List),
    );
  }
}