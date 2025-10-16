import 'game_settings_base.dart';

class WordGameSettingsUnified extends GameSettings {
  final int questionCount;
  final WordGameCategory category;
  final WordGameMode mode;

  const WordGameSettingsUnified({
    required this.questionCount,
    required this.category,
    required this.mode,
  });

  @override
  String get typeId => "word_game.v1";

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

    return issues;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'typeId': typeId,
      'questionCount': questionCount,
      'category': category.toString().split('.').last,
      'mode': mode.toString().split('.').last,
    };
  }

  @override
  Map<String, dynamic> toTreeStructure() {
    return {
      'displayName': 'たんご',
      'description': '絵を見て正しい単語を選ぶゲーム',
      'settings': {
        'questionCount': questionCount,
        'category': category.toString().split('.').last,
        'mode': mode.toString().split('.').last,
      }
    };
  }

  @override
  int get estimatedDurationSec => questionCount * 10;

  @override
  int get difficultyScore {
    final categoryScore = {
      WordGameCategory.animals: 20,
      WordGameCategory.fruits: 25,
      WordGameCategory.vehicles: 30,
      WordGameCategory.mixed: 40,
    }[category] ?? 30;

    return categoryScore;
  }

  @override
  List<String> get tags => ['language', 'vocabulary', 'recognition'];

  static Map<String, dynamic> get optionsTree => {
    'questionCount': [3, 5, 8, 10],
    'category': ['animals', 'fruits', 'vehicles', 'mixed'],
    'mode': ['imageToText', 'textToImage'],
    'defaultConfig': {
      'questionCount': 5,
      'category': 'mixed',
      'mode': 'imageToText',
    }
  };
}

enum WordGameCategory { animals, fruits, vehicles, mixed }
enum WordGameMode { imageToText, textToImage }