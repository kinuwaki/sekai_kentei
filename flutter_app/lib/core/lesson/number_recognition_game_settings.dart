import 'game_settings_base.dart';

class NumberRecognitionGameSettingsUnified extends GameSettings {
  final List<int> targetNumbers;
  final NumberRecognitionMode mode;
  final int repetitions;

  const NumberRecognitionGameSettingsUnified({
    required this.targetNumbers,
    required this.mode,
    required this.repetitions,
  });

  @override
  String get typeId => "number_recognition.v1";

  @override
  List<ValidationIssue> validate() {
    final issues = <ValidationIssue>[];

    if (targetNumbers.isEmpty) {
      issues.add(ValidationIssue(
        level: ValidationLevel.fatal,
        field: 'targetNumbers',
        message: '対象数字リストが空です',
      ));
    }

    if (targetNumbers.any((n) => n < 0 || n > 9)) {
      issues.add(ValidationIssue(
        level: ValidationLevel.fatal,
        field: 'targetNumbers',
        message: '数字は0-9の範囲で指定してください',
      ));
    }

    if (repetitions < 1 || repetitions > 10) {
      issues.add(ValidationIssue(
        level: ValidationLevel.fatal,
        field: 'repetitions',
        message: '繰り返し回数は1-10の範囲で設定してください',
      ));
    }

    return issues;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'typeId': typeId,
      'targetNumbers': targetNumbers,
      'mode': mode.toString().split('.').last,
      'repetitions': repetitions,
    };
  }

  @override
  Map<String, dynamic> toTreeStructure() {
    return {
      'displayName': 'すうじをかこう',
      'description': '数字の形を覚えて正しく書く練習ゲーム',
      'settings': {
        'targetNumbers': targetNumbers,
        'mode': mode.toString().split('.').last,
        'repetitions': repetitions,
      }
    };
  }

  @override
  int get estimatedDurationSec => targetNumbers.length * repetitions * 30;

  @override
  int get difficultyScore {
    final complexNumbers = targetNumbers.where((n) => [4, 6, 8, 9].contains(n)).length;
    return 40 + (complexNumbers * 5);
  }

  @override
  List<String> get tags => ['writing', 'numbers', 'motor_skills'];

  static Map<String, dynamic> get optionsTree => {
    'targetNumbers': [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8, 9],
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    ],
    'mode': ['trace', 'freeWrite', 'recognition'],
    'repetitions': [1, 2, 3, 5],
    'defaultConfig': {
      'targetNumbers': [0, 1, 2],
      'mode': 'trace',
      'repetitions': 2,
    }
  };
}

enum NumberRecognitionMode { trace, freeWrite, recognition }