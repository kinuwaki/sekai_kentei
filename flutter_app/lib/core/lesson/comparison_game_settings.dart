import '../../ui/games/comparison_game/models/comparison_models.dart';
import 'game_settings_base.dart';

/// 比較ゲーム設定（基底クラス対応版）
class ComparisonGameSettingsUnified extends GameSettings {
  final ComparisonRange range;
  final ComparisonDisplayType displayType;
  final int optionCount;
  final ComparisonQuestionType questionType;
  final int questionCount;

  const ComparisonGameSettingsUnified({
    required this.range,
    required this.displayType,
    required this.optionCount,
    required this.questionType,
    required this.questionCount,
  });

  /// 選択肢ツリー定義  
  static Map<String, dynamic> get optionsTree {
    // ComparisonRangeから全ての範囲を自動取得
    final allRanges = ComparisonRange.values.map((r) => r.displayName).toList();
    
    return {
      'displayType': {
        'dots': {
          'displayName': 'ドット表示',
          'range': allRanges,
          'optionCount': [2, 3, 4],
          'questionType': ['fixedLargest', 'fixedSmallest', 'advanced'],
          'questionCount': [3, 5, 8, 10],
        },
        'digits': {
          'displayName': '数字表示',
          'range': allRanges,
          'optionCount': [2, 3],
          'questionType': ['fixedLargest', 'fixedSmallest', 'advanced'],
          'questionCount': [5, 8, 10],
        }
      },
      'defaultConfig': {
        'displayType': 'dots',
        'range': allRanges.isNotEmpty ? allRanges.first : '1-5',
        'optionCount': 2,
        'questionType': 'fixedLargest',
        'questionCount': 3,
      },
    };
  }

  @override
  String get typeId => 'comparison.v1';

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

    // 選択肢数チェック
    if (optionCount < 2 || optionCount > 4) {
      issues.add(ValidationIssue(
        level: ValidationLevel.fatal,
        field: 'optionCount',
        message: '選択肢数は2-4の範囲である必要があります',
        actualValue: optionCount,
        expectedValue: '2-4',
      ));
    }

    return issues;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'typeId': typeId,
      'range': range.displayName,
      'displayType': displayType.name,
      'optionCount': optionCount,
      'questionType': questionType.name,
      'questionCount': questionCount,
    };
  }

  @override
  Map<String, dynamic> toTreeStructure() {
    return {
      'ゲームタイプ': '比較ゲーム',
      '範囲': range.displayName,
      '表示形式': displayType == ComparisonDisplayType.dots ? 'ドット' : '数字',
      '選択肢数': optionCount,
      '問題タイプ': _questionTypeDisplayName,
      '問題数': questionCount,
      '詳細': {
        '最小値': range.minValue,
        '最大値': range.maxValue,
        '推定時間': '${estimatedDurationSec}秒',
        '難易度': difficultyScore,
      },
    };
  }

  String get _questionTypeDisplayName {
    switch (questionType) {
      case ComparisonQuestionType.fixedLargest:
        return '固定（大きい）';
      case ComparisonQuestionType.fixedSmallest:
        return '固定（小さい）';
      case ComparisonQuestionType.advanced:
        return '上級（ランダム）';
      default:
        return questionType.name;
    }
  }

  @override
  int get estimatedDurationSec => questionCount * 20; // 1問20秒想定

  @override
  int get difficultyScore {
    int base = _getRangeDifficulty();
    int displayBonus = displayType == ComparisonDisplayType.digits ? 10 : 0;
    int optionPenalty = optionCount * 3;
    int typeDifficulty = questionType == ComparisonQuestionType.advanced ? 15 : 0;
    
    return base + displayBonus + optionPenalty + typeDifficulty;
  }

  int _getRangeDifficulty() {
    switch (range) {
      case ComparisonRange.range1to5:
        return 10;
      case ComparisonRange.range5to10:
        return 15;
      case ComparisonRange.range10to20:
        return 25;
      case ComparisonRange.range20to30:
        return 35;
      case ComparisonRange.range30to40:
        return 45;
      default:
        return 30;
    }
  }

  @override
  List<String> get tags {
    final tagList = [
      'comparison',
      range.displayName,
      displayType.name,
      questionType.name,
    ];
    
    if (optionCount > 3) tagList.add('多選択肢');
    if (displayType == ComparisonDisplayType.digits) tagList.add('数字表示');
    
    return tagList;
  }

  /// 既存のComparisonGameSettingsに変換
  ComparisonGameSettings toComparisonGameSettings() {
    return ComparisonGameSettings(
      range: range,
      displayType: displayType,
      optionCount: optionCount,
      questionType: questionType,
      questionCount: questionCount,
    );
  }

  /// YAMLから作成
  factory ComparisonGameSettingsUnified.fromYaml(Map<String, dynamic> yaml) {
    // 範囲変換
    ComparisonRange range;
    switch (yaml['range'] as String) {
      case '1-5':
        range = ComparisonRange.range1to5;
        break;
      case '5-10':
        range = ComparisonRange.range5to10;
        break;
      case '10-20':
        range = ComparisonRange.range10to20;
        break;
      case '20-30':
        range = ComparisonRange.range20to30;
        break;
      case '30-40':
        range = ComparisonRange.range30to40;
        break;
      default:
        range = ComparisonRange.range1to5;
    }

    // 表示タイプ変換
    ComparisonDisplayType displayType;
    switch (yaml['displayType'] as String) {
      case 'dots':
        displayType = ComparisonDisplayType.dots;
        break;
      case 'digits':
        displayType = ComparisonDisplayType.digits;
        break;
      default:
        displayType = ComparisonDisplayType.dots;
    }

    // 問題タイプ変換
    ComparisonQuestionType questionType;
    switch (yaml['questionType'] as String) {
      case 'fixedLargest':
        questionType = ComparisonQuestionType.fixedLargest;
        break;
      case 'fixedSmallest':
        questionType = ComparisonQuestionType.fixedSmallest;
        break;
      case 'advanced':
        questionType = ComparisonQuestionType.advanced;
        break;
      default:
        questionType = ComparisonQuestionType.fixedLargest;
    }

    return ComparisonGameSettingsUnified(
      range: range,
      displayType: displayType,
      optionCount: yaml['optionCount'] as int,
      questionType: questionType,
      questionCount: yaml['questionCount'] as int,
    );
  }
}