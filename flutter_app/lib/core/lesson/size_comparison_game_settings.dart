import 'game_settings_base.dart';

class SizeComparisonGameSettingsUnified extends GameSettings {
  final int questionCount;
  final SizeComparisonMode mode;
  final List<String> objects;

  const SizeComparisonGameSettingsUnified({
    required this.questionCount,
    required this.mode,
    required this.objects,
  });

  @override
  String get typeId => "size_comparison.v1";

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

    if (objects.isEmpty) {
      issues.add(ValidationIssue(
        level: ValidationLevel.fatal,
        field: 'objects',
        message: 'オブジェクトリストが空です',
      ));
    }

    return issues;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'typeId': typeId,
      'questionCount': questionCount,
      'mode': mode.toString().split('.').last,
      'objects': objects,
    };
  }

  @override
  Map<String, dynamic> toTreeStructure() {
    return {
      'displayName': 'なんばんめにおおきい・ちいさい',
      'description': '複数のオブジェクトの大小を順序立てて比較するゲーム',
      'settings': {
        'questionCount': questionCount,
        'mode': mode.toString().split('.').last,
        'objects': objects,
      }
    };
  }

  @override
  int get estimatedDurationSec => questionCount * 15;

  @override
  int get difficultyScore {
    final modeScore = {
      SizeComparisonMode.largest: 40,
      SizeComparisonMode.smallest: 45,
      SizeComparisonMode.middle: 60,
    }[mode] ?? 50;

    return modeScore;
  }

  @override
  List<String> get tags => ['visual', 'comparison', 'ordering'];

  static Map<String, dynamic> get optionsTree => {
    'questionCount': [3, 5, 8, 10],
  };
}

enum SizeComparisonMode { largest, smallest, middle }