import 'package:freezed_annotation/freezed_annotation.dart';
import '../../base/common_game_phase.dart';

part 'figure_orientation_models.freezed.dart';

enum FigureOrientationRange {
  easy(0, 5, 'かんたん'),      // 000-005
  medium(0, 12, 'ふつう'),     // 000-012
  hard(0, 17, 'むずかしい');   // 000-012 + 100-104 (全画像)

  const FigureOrientationRange(this.minIndex, this.maxIndex, this.displayName);
  
  final int minIndex;
  final int maxIndex;
  final String displayName;
}

@freezed
abstract class FigureOrientationSettings with _$FigureOrientationSettings {
  const factory FigureOrientationSettings({
    @Default(FigureOrientationRange.medium) FigureOrientationRange range,
    @Default(5) int questionCount,
  }) = _FigureOrientationSettings;

  const FigureOrientationSettings._();

  String get displayName => '${range.displayName}（${questionCount}問）';
}

@freezed
abstract class AnswerResult with _$AnswerResult {
  const factory AnswerResult({
    required int selectedIndex,
    required int correctIndex,
    required bool isCorrect,
    required bool isPerfect,
  }) = _AnswerResult;
}

enum FigureTransform {
  normal,
  rotate90,
  rotate180,
  rotate270,
  flipHorizontal,
}

@freezed
abstract class FigureOrientationProblem with _$FigureOrientationProblem {
  const factory FigureOrientationProblem({
    required String questionText,
    required int correctAnswerIndex,
    required List<FigureOrientationOption> options,
    required String imagePath,
  }) = _FigureOrientationProblem;
}

@freezed
abstract class FigureOrientationOption with _$FigureOrientationOption {
  const factory FigureOrientationOption({
    required String imagePath,
    required FigureTransform transform,
    required bool isCorrect,
  }) = _FigureOrientationOption;
}

@freezed
abstract class FigureOrientationSession with _$FigureOrientationSession {
  const factory FigureOrientationSession({
    required int index,
    required int total,
    required List<bool?> results,
    FigureOrientationProblem? currentProblem,
    @Default(0) int wrongAnswers,
  }) = _FigureOrientationSession;

  const FigureOrientationSession._();

  bool get isCompleted => index >= total;
  int get correctCount => results.where((r) => r == true).length;
  int get incorrectCount => results.where((r) => r == false).length;
}

@freezed
abstract class FigureOrientationState with _$FigureOrientationState {
  const factory FigureOrientationState({
    @Default(CommonGamePhase.ready) CommonGamePhase phase,
    FigureOrientationSettings? settings,
    FigureOrientationSession? session,
    AnswerResult? lastResult,
    @Default(0) int epoch,
  }) = _FigureOrientationState;

  const FigureOrientationState._();

  bool get canAnswer => phase == CommonGamePhase.questioning;
  bool get isProcessing => phase == CommonGamePhase.processing || phase == CommonGamePhase.transitioning;
  double get progress => session != null ? session!.index / session!.total : 0.0;
  String? get questionText => session?.currentProblem?.questionText;
  bool get isCompleted => phase == CommonGamePhase.completed;
  bool get isPerfect => session != null && session!.correctCount == session!.total;
}