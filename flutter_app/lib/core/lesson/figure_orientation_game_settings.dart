import 'game_settings_base.dart';

class FigureOrientationGameSettingsUnified extends GameSettings {
  final int questionCount;

  const FigureOrientationGameSettingsUnified({
    required this.questionCount,
  });

  @override
  String get typeId => "figure_orientation.v1";

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
      'displayName': 'ずけいむきまちがい',
      'description': '図形の向きが間違っているものを見つけるゲーム',
      'settings': {
        'questionCount': questionCount,
      }
    };
  }

  @override
  int get estimatedDurationSec => questionCount * 12;

  @override
  int get difficultyScore => 55;

  @override
  List<String> get tags => ['visual', 'spatial', 'orientation'];

  static Map<String, dynamic> get optionsTree => {
    'questionCount': [3, 5, 8, 10],
    'defaultConfig': {
      'questionCount': 5,
    }
  };
}

