import 'game_settings_base.dart';

class PuzzleGameSettingsUnified extends GameSettings {
  final int questionCount;

  const PuzzleGameSettingsUnified({
    required this.questionCount,
  });

  @override
  String get typeId => "puzzle_game.v1";

  @override
  List<ValidationIssue> validate() {
    final issues = <ValidationIssue>[];

    if (questionCount < 1 || questionCount > 10) {
      issues.add(ValidationIssue(
        level: ValidationLevel.fatal,
        field: 'questionCount',
        message: '問題数は1-10の範囲で設定してください',
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
      'displayName': 'ばらばらパズル',
      'description': 'バラバラになったピースを正しい位置に配置するゲーム',
      'settings': {
        'questionCount': questionCount,
      }
    };
  }

  @override
  int get estimatedDurationSec => questionCount * 35;

  @override
  int get difficultyScore => 50;

  @override
  List<String> get tags => ['visual', 'spatial', 'problem_solving'];

  static Map<String, dynamic> get optionsTree => {
    'questionCount': [1, 2, 3, 5],
    'defaultConfig': {
      'questionCount': 2,
    }
  };
}

