import '../../ui/games/counting_game/models/counting_models.dart';
import 'game_settings_base.dart';

/// 数かぞえゲーム設定（基底クラス対応版）
class CountingGameSettingsUnified extends GameSettings {
  final CountingRange range;
  final int questionCount;
  final List<String> shapes;

  const CountingGameSettingsUnified({
    required this.range,
    required this.questionCount,
    this.shapes = const ['circle'],
  });

  /// 選択肢ツリー定義
  static Map<String, dynamic> get optionsTree {
    // CountingRangeから全ての範囲を自動取得
    final allRanges = CountingRange.values.map((r) => r.displayName).toList();

    return {
      'range': allRanges,
      'questionCount': [3, 5, 8, 10],
      'defaultConfig': {
        'range': allRanges.isNotEmpty ? allRanges.first : '1-5',
        'questionCount': 3,
      },
    };
  }

  @override
  String get typeId => 'counting.v1';

  @override
  List<ValidationIssue> validate() {
    final issues = <ValidationIssue>[];

    // 問題数チェック
    if (questionCount < 1 || questionCount > 10) {
      issues.add(ValidationIssue(
        level: ValidationLevel.warn,
        field: 'questionCount',
        message: '問題数は1-10の範囲が推奨です',
        actualValue: questionCount,
        expectedValue: '1-10',
      ));
    }

    // 形状チェック
    const validShapes = ['circle', 'square', 'star'];
    for (final shape in shapes) {
      if (!validShapes.contains(shape)) {
        issues.add(ValidationIssue(
          level: ValidationLevel.fatal,
          field: 'shapes',
          message: '不正な形状です: $shape',
          actualValue: shape,
          expectedValue: validShapes,
        ));
      }
    }

    return issues;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'typeId': typeId,
      'range': range.displayName,
      'questionCount': questionCount,
      'shapes': shapes,
    };
  }

  @override
  Map<String, dynamic> toTreeStructure() {
    return {
      'ゲームタイプ': '数かぞえ',
      '範囲': range.displayName,
      '問題数': questionCount,
      '使用する形': shapes.join(', '),
      '詳細': {
        '最小値': range.minValue,
        '最大値': range.maxValue,
        '推定時間': '${estimatedDurationSec}秒',
        '難易度': difficultyScore,
      },
    };
  }

  @override
  int get estimatedDurationSec => questionCount * 15; // 1問15秒想定

  @override
  int get difficultyScore {
    int base = 0;
    switch (range) {
      case CountingRange.range1to5:
        base = 10;
        break;
      case CountingRange.range5to10:
        base = 20;
        break;
      case CountingRange.range1to10:
        base = 25;
        break;
    }
    return base + questionCount * 2;
  }

  @override
  List<String> get tags => ['counting', range.displayName, ...shapes];

  /// 既存のCountingGameSettingsに変換
  CountingGameSettings toCountingGameSettings() {
    return CountingGameSettings(
      range: range,
      questionCount: questionCount,
    );
  }

  /// YAMLから作成
  factory CountingGameSettingsUnified.fromYaml(Map<String, dynamic> yaml) {
    // 範囲文字列をenumに変換
    CountingRange range;
    switch (yaml['range'] as String) {
      case '1-5':
        range = CountingRange.range1to5;
        break;
      case '5-10':
        range = CountingRange.range5to10;
        break;
      case '1-10':
        range = CountingRange.range1to10;
        break;
      default:
        range = CountingRange.range1to5;
    }

    return CountingGameSettingsUnified(
      range: range,
      questionCount: yaml['questionCount'] as int,
      shapes: List<String>.from(yaml['shapes'] as List? ?? ['circle']),
    );
  }
}