import 'game_settings_base.dart';

class TsumikiCountingGameSettingsUnified extends GameSettings {
  final int questionCount;
  final String range;
  final TsumikiCountingMode mode;

  const TsumikiCountingGameSettingsUnified({
    required this.questionCount,
    required this.range,
    required this.mode,
  });

  @override
  String get typeId => "tsumiki_counting.v1";

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

    if (!['1-3', '2-5', '3-7', '4-9'].contains(range)) {
      issues.add(ValidationIssue(
        level: ValidationLevel.fatal,
        field: 'range',
        message: '範囲は1-3, 2-5, 3-7, 4-9のいずれかを指定してください',
      ));
    }

    return issues;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'typeId': typeId,
      'questionCount': questionCount,
      'range': range,
      'mode': mode.toString().split('.').last,
    };
  }

  @override
  Map<String, dynamic> toTreeStructure() {
    return {
      'displayName': 'つみき',
      'description': 'つみきの画像を見て数を数えるゲーム',
      'settings': {
        'questionCount': questionCount,
        'range': range,
        'mode': mode.toString().split('.').last,
      }
    };
  }

  @override
  int get estimatedDurationSec => questionCount * 12;

  @override
  int get difficultyScore {
    final rangeScore = {
      '1-3': 20,
      '2-5': 40,
      '3-7': 60,
      '4-9': 80,
    }[range] ?? 40;

    return rangeScore + (mode == TsumikiCountingMode.numberToImage ? 10 : 0);
  }

  @override
  List<String> get tags => ['math', 'counting', 'visual'];

  static Map<String, dynamic> get optionsTree => {
    'questionCount': [3, 5, 8, 10],
    'range': ['1-3', '2-5', '3-7', '4-9'],
    'mode': ['imageToNumber', 'numberToImage'],
    'defaultConfig': {
      'questionCount': 5,
      'range': '2-5',
      'mode': 'imageToNumber',
    }
  };
}

enum TsumikiCountingMode { imageToNumber, numberToImage }