import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../components/drawing/drawing_models.dart';
import '../../base/common_game_phase.dart';

part 'number_models.freezed.dart';

/// 数字認識ゲームの問題データ
@freezed
abstract class NumberProblem with _$NumberProblem {
  const factory NumberProblem({
    required int correct,
    required String prompt,
  }) = _NumberProblem;
}

/// 数字認識ゲームのセッション（問題進行状況）
@freezed
abstract class NumberSession with _$NumberSession {
  const factory NumberSession({
    required int index,               // 0-based
    required int total,
    required NumberProblem current,
  }) = _NumberSession;
  
  const NumberSession._();
  
  bool get isLast => index + 1 >= total;
  
  NumberSession next(NumberProblem nextProblem) =>
      copyWith(index: index + 1, current: nextProblem);
}

/// 回答結果
@freezed
abstract class AnswerResult with _$AnswerResult {
  const factory AnswerResult({
    required int recognizedNumber,
    required bool isCorrect,
    required int correctAnswer,
  }) = _AnswerResult;
}

/// 数字認識ゲームの統合状態
@freezed
abstract class NumberState with _$NumberState {
  const factory NumberState({
    required CommonGamePhase phase,
    required NumberSession session,
    required DrawingData drawing,
    AnswerResult? lastResult,
    String? lastError,
    @Default(0) int epoch, // 非同期競合ガード用
  }) = _NumberState;
}

/// UI用の派生プロパティ
extension NumberStateX on NumberState {
  /// 手書き入力可能か
  bool get canDraw => phase == CommonGamePhase.questioning;
  
  /// テンキー入力可能か
  bool get canInput => phase == CommonGamePhase.questioning;
  
  /// 処理中（何らかの入力をブロック）
  bool get isProcessing =>
      phase == CommonGamePhase.processing || phase == CommonGamePhase.transitioning;
  
  /// 成功エフェクト表示中
  bool get showSuccessEffect => phase == CommonGamePhase.feedbackOk;
  
  /// 間違いエフェクト表示中（赤枠等）
  bool get showWrongEffect => phase == CommonGamePhase.feedbackNg;
  
  /// ゲーム進行度
  double get progress => session.total > 0 ? session.index / session.total : 0.0;
  
  /// 問題文（BaseGameScreenのTTS用）
  String? get questionText => session.current.prompt;
  
  /// ゲーム完了済み
  bool get isCompleted => phase == CommonGamePhase.completed;
}