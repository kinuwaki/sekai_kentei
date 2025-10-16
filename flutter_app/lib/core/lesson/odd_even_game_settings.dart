import 'game_settings_base.dart';

class OddEvenGameSettingsUnified extends GameSettings {
  final int questionCount;
  final List<int> numbers;
  final OddEvenMode mode;

  const OddEvenGameSettingsUnified({
    required this.questionCount,
    required this.numbers,
    required this.mode,
  });

  @override
  String get typeId => "odd_even.v1";

  @override
  List<ValidationIssue> validate() {
    final issues = <ValidationIssue>[];

    if (questionCount < 1 || questionCount > 20) {
      issues.add(ValidationIssue(
        level: ValidationLevel.fatal,
        field: 'questionCount',
        message: '問題数は1-20の範囲で設定してください',
      ));
    }

    if (numbers.isEmpty) {
      issues.add(ValidationIssue(
        level: ValidationLevel.fatal,
        field: 'numbers',
        message: '数字リストが空です',
      ));
    }

    return issues;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'typeId': typeId,
      'questionCount': questionCount,
      'numbers': numbers,
      'mode': mode.toString().split('.').last,
    };
  }

  @override
  Map<String, dynamic> toTreeStructure() {
    return {
      'displayName': 'きすう・ぐうすう',
      'description': '数字が奇数か偶数かを判定するゲーム',
      'settings': {
        'questionCount': questionCount,
        'numbers': numbers,
        'mode': mode.toString().split('.').last,
      }
    };
  }

  @override
  int get estimatedDurationSec => questionCount * 8;

  @override
  int get difficultyScore => 30 + (numbers.length > 10 ? 20 : 0);

  @override
  List<String> get tags => ['math', 'classification', 'numbers'];

  static Map<String, dynamic> get optionsTree => {
    'questionCount': [3, 5, 8, 10],
    'numbers': [
      [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
      [1, 3, 5, 7, 9, 11, 13, 15, 17, 19], // 奇数のみ
      [2, 4, 6, 8, 10, 12, 14, 16, 18, 20], // 偶数のみ
    ],
    'mode': ['mixed', 'oddOnly', 'evenOnly'],
    'defaultConfig': {
      'questionCount': 5,
      'numbers': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
      'mode': 'mixed',
    }
  };
}

enum OddEvenMode { mixed, oddOnly, evenOnly }