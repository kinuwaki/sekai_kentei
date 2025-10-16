import 'game_settings_base.dart';

class ShapeMatchingGameSettingsUnified extends GameSettings {
  final int questionCount;

  const ShapeMatchingGameSettingsUnified({
    required this.questionCount,
  });

  @override
  String get typeId => "shape_matching.v1";

  @override
  List<ValidationIssue> validate() {
    final issues = <ValidationIssue>[];

    if (questionCount < 1 || questionCount > 15) {
      issues.add(ValidationIssue(
        level: ValidationLevel.fatal,
        field: 'questionCount',
        message: '問題数は1-15の範囲で設定してください',
      ));
    }


    return issues;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'typeId': typeId,
      'questionCount': questionCount,
    };
  }

  @override
  Map<String, dynamic> toTreeStructure() {
    return {
      'displayName': 'かたちさがし',
      'description': '同じ形を見つけるマッチングゲーム',
      'settings': {
        'questionCount': questionCount,
      }
    };
  }

  @override
  int get estimatedDurationSec => questionCount * 8;

  @override
  int get difficultyScore => 25;

  @override
  List<String> get tags => ['visual', 'matching', 'shapes'];

  static Map<String, dynamic> get optionsTree => {
    'questionCount': [3, 5, 8, 10, 15],
    'defaultConfig': {
      'questionCount': 5,
    }
  };
}

