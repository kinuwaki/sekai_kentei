import 'package:freezed_annotation/freezed_annotation.dart';
import '../../base/common_game_phase.dart';

part 'odd_even_models.freezed.dart';

enum OddEvenType {
  odd,
  even,
}

extension OddEvenTypeExtension on OddEvenType {
  String get displayName {
    switch (this) {
      case OddEvenType.odd:
        return 'きすう';
      case OddEvenType.even:
        return 'ぐうすう';
    }
  }

  String get questionText {
    switch (this) {
      case OddEvenType.odd:
        return 'きすうをぜんぶさがそう';
      case OddEvenType.even:
        return 'ぐうすうをぜんぶさがそう';
    }
  }

  bool matches(int number) {
    switch (this) {
      case OddEvenType.odd:
        return number % 2 != 0;
      case OddEvenType.even:
        return number % 2 == 0;
    }
  }
}

enum OddEvenRange {
  range0to9,
  range10to19,
  range20to29,
  range30to39,
  range40to49,
  range50to59,
  range60to69,
  range70to79,
  range80to89,
  range90to99,
  range100to109,
  range110to119,
}

extension OddEvenRangeExtension on OddEvenRange {
  String get displayName {
    switch (this) {
      case OddEvenRange.range0to9:
        return '0-9';
      case OddEvenRange.range10to19:
        return '10-19';
      case OddEvenRange.range20to29:
        return '20-29';
      case OddEvenRange.range30to39:
        return '30-39';
      case OddEvenRange.range40to49:
        return '40-49';
      case OddEvenRange.range50to59:
        return '50-59';
      case OddEvenRange.range60to69:
        return '60-69';
      case OddEvenRange.range70to79:
        return '70-79';
      case OddEvenRange.range80to89:
        return '80-89';
      case OddEvenRange.range90to99:
        return '90-99';
      case OddEvenRange.range100to109:
        return '100-109';
      case OddEvenRange.range110to119:
        return '110-119';
    }
  }

  int get minValue {
    switch (this) {
      case OddEvenRange.range0to9:
        return 0;
      case OddEvenRange.range10to19:
        return 10;
      case OddEvenRange.range20to29:
        return 20;
      case OddEvenRange.range30to39:
        return 30;
      case OddEvenRange.range40to49:
        return 40;
      case OddEvenRange.range50to59:
        return 50;
      case OddEvenRange.range60to69:
        return 60;
      case OddEvenRange.range70to79:
        return 70;
      case OddEvenRange.range80to89:
        return 80;
      case OddEvenRange.range90to99:
        return 90;
      case OddEvenRange.range100to109:
        return 100;
      case OddEvenRange.range110to119:
        return 110;
    }
  }

  int get maxValue {
    switch (this) {
      case OddEvenRange.range0to9:
        return 9;
      case OddEvenRange.range10to19:
        return 19;
      case OddEvenRange.range20to29:
        return 29;
      case OddEvenRange.range30to39:
        return 39;
      case OddEvenRange.range40to49:
        return 49;
      case OddEvenRange.range50to59:
        return 59;
      case OddEvenRange.range60to69:
        return 69;
      case OddEvenRange.range70to79:
        return 79;
      case OddEvenRange.range80to89:
        return 89;
      case OddEvenRange.range90to99:
        return 99;
      case OddEvenRange.range100to109:
        return 109;
      case OddEvenRange.range110to119:
        return 119;
    }
  }
}

enum OddEvenGridSize {
  grid10, // 10個の数字用（ランダム配置）
}

extension OddEvenGridSizeExtension on OddEvenGridSize {
  String get displayName {
    switch (this) {
      case OddEvenGridSize.grid10:
        return '10こ';
    }
  }

  int get columns {
    switch (this) {
      case OddEvenGridSize.grid10:
        return 10; // ランダム配置なので実際は使用しない
    }
  }

  int get rows {
    switch (this) {
      case OddEvenGridSize.grid10:
        return 1; // ランダム配置なので実際は使用しない
    }
  }

  int get totalCount => columns * rows;
}

@freezed
abstract class OddEvenSettings with _$OddEvenSettings {
  const factory OddEvenSettings({
    @Default(OddEvenType.odd) OddEvenType targetType,
    @Default(OddEvenRange.range0to9) OddEvenRange range,
    @Default(OddEvenGridSize.grid10) OddEvenGridSize gridSize,
    @Default(false) bool randomTargetType,
    @Default(3) int questionCount,
  }) = _OddEvenSettings;

  const OddEvenSettings._();


  String get displayName {
    final typeText = randomTargetType ? 'ランダム' : targetType.displayName;
    return '$typeText・${range.displayName}・${gridSize.displayName}';
  }
}

@freezed
abstract class OddEvenProblem with _$OddEvenProblem {
  const factory OddEvenProblem({
    required OddEvenType targetType,
    required List<int> numbers,
    required Set<int> correctIndices,
    required String questionText,
  }) = _OddEvenProblem;

  const OddEvenProblem._();

}

@freezed
abstract class OddEvenSession with _$OddEvenSession {
  const factory OddEvenSession({
    required int index,
    required int total,
    required List<bool?> results,
    OddEvenProblem? currentProblem,
    @Default(0) int wrongAnswers,
    @Default(0) int wrongAttempts,
    @Default({}) Set<int> selectedIndices,
    @Default({}) Set<int> correctlySelectedIndices,  // 正解済みの選択
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _OddEvenSession;

  const OddEvenSession._();


  bool get isCompleted => index >= total;
  int get correctCount => results.where((r) => r == true).length;
  int get incorrectCount => results.where((r) => r == false).length;
  double get progress => total > 0 ? index / total : 0.0;

  Duration? get totalTime {
    if (startedAt == null) return null;
    final endTime = completedAt ?? DateTime.now();
    return endTime.difference(startedAt!);
  }
}

@freezed
abstract class AnswerResult with _$AnswerResult {
  const factory AnswerResult({
    required Set<int> selectedIndices,
    required Set<int> correctIndices,
    required bool isCorrect,
    required bool isPerfect,
    required int correctSelections,
    required int missedSelections,
    required int wrongSelections,
  }) = _AnswerResult;

  const AnswerResult._();

}

@freezed
abstract class OddEvenState with _$OddEvenState {
  const factory OddEvenState({
    @Default(CommonGamePhase.ready) CommonGamePhase phase,
    OddEvenSettings? settings,
    OddEvenSession? session,
    AnswerResult? lastResult,
    @Default(0) int epoch,
  }) = _OddEvenState;

  const OddEvenState._();


  bool get canAnswer => phase == CommonGamePhase.questioning;
  bool get isProcessing =>
      phase == CommonGamePhase.processing || phase == CommonGamePhase.transitioning;
  double get progress => session?.progress ?? 0.0;
  String? get questionText => session?.currentProblem?.questionText;
  bool get isCompleted => phase == CommonGamePhase.completed;
}