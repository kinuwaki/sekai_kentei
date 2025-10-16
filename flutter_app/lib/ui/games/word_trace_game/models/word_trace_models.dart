import 'package:freezed_annotation/freezed_annotation.dart';
import '../../base/common_game_phase.dart';

part 'word_trace_models.freezed.dart';

/// 文字の位置
@freezed
abstract class CharPosition with _$CharPosition {
  const factory CharPosition({
    required int x,
    required int y,
  }) = _CharPosition;

  const CharPosition._();

  @override
  String toString() => '($x,$y)';
}

/// 問題データ
@freezed
abstract class WordTraceProblem with _$WordTraceProblem {
  const factory WordTraceProblem({
    required String targetWord,
    required List<List<String>> grid, // 6x4のグリッド
    required List<CharPosition> correctPath,
    @Default('ことばをみつけてね') String questionText,
  }) = _WordTraceProblem;
}

/// ゲーム設定
@freezed
abstract class WordTraceSettings with _$WordTraceSettings {
  const factory WordTraceSettings({
    @Default(5) int questionCount,
  }) = _WordTraceSettings;

  const WordTraceSettings._();

  String get displayName => '文字辿り（$questionCount問）';
}

/// ゲームセッション
@freezed
abstract class WordTraceSession with _$WordTraceSession {
  const factory WordTraceSession({
    required int index,
    required int total,
    required List<bool?> results,
    WordTraceProblem? currentProblem,
    @Default([]) List<CharPosition> selectedPath,
    @Default(0) int wrongAttempts,
  }) = _WordTraceSession;

  const WordTraceSession._();

  bool get isCompleted => index >= total;
  bool get isLast => index + 1 >= total;
  int get correctCount => results.where((r) => r == true).length;
  int get score => correctCount;
}

/// ゲーム状態
@freezed
abstract class WordTraceState with _$WordTraceState {
  const factory WordTraceState({
    @Default(CommonGamePhase.ready) CommonGamePhase phase,
    WordTraceSettings? settings,
    WordTraceSession? session,
    @Default(0) int epoch, // 競合状態防止
  }) = _WordTraceState;

  const WordTraceState._();

  bool get canSelectChar => phase == CommonGamePhase.questioning;
  bool get isProcessing => phase == CommonGamePhase.feedbackOk || phase == CommonGamePhase.feedbackNg;

  String? get questionText => session?.currentProblem?.questionText;
  double get progress => session != null && settings != null
      ? (session!.index + 1) / settings!.questionCount
      : 0.0;
}
