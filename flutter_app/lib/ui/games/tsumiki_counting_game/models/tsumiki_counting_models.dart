import 'package:freezed_annotation/freezed_annotation.dart';
import '../../base/common_game_phase.dart';

part 'tsumiki_counting_models.freezed.dart';

// AnswerResultの定義
@freezed
abstract class AnswerResult with _$AnswerResult {
  const factory AnswerResult({
    required int selectedIndex,
    required int correctIndex,
    required bool isCorrect,
    required bool isPerfect,
  }) = _AnswerResult;
}

enum TsumikiCountingRange {
  oneToThree(1, 3, '1-3'),
  twoToFour(2, 4, '2-4'),
  threeToFive(3, 5, '3-5'),
  fourToSix(4, 6, '4-6'),
  fiveToSeven(5, 7, '5-7'),
  sixToEight(6, 8, '6-8'),
  sevenToNine(7, 9, '7-9');

  const TsumikiCountingRange(this.minValue, this.maxValue, this.displayName);

  final int minValue;
  final int maxValue;
  final String displayName;
}

enum TsumikiCountingMode {
  imageToNumber('えから すうじ', '画像を見て正しい数字を選んでね'),
  numberToImage('すうじから え', '数字を見て正しい画像を選んでね');

  const TsumikiCountingMode(this.displayName, this.description);

  final String displayName;
  final String description;
}

@freezed
abstract class TsumikiCountingSettings with _$TsumikiCountingSettings {
  const factory TsumikiCountingSettings({
    @Default(TsumikiCountingRange.oneToThree) TsumikiCountingRange range,
    @Default(TsumikiCountingMode.imageToNumber) TsumikiCountingMode mode,
    @Default(5) int questionCount,
  }) = _TsumikiCountingSettings;

  const TsumikiCountingSettings._();

  String get displayName =>
      '${mode.displayName} ${range.displayName} ($questionCount問)';
}

@freezed
abstract class TsumikiCountingProblem with _$TsumikiCountingProblem {
  const factory TsumikiCountingProblem({
    required String questionText,       // TTS用の質問文
    required int correctAnswerIndex,    // 正解のインデックス
    required List<String> options,      // 選択肢（画像パスまたは数字文字列）
    required TsumikiCountingMode mode,  // 問題のモード
    required int blockCount,            // 正しいブロック数
    String? imagePath,                  // imageToNumberモード用の画像パス
  }) = _TsumikiCountingProblem;

  const TsumikiCountingProblem._();

  String get displayText => mode == TsumikiCountingMode.numberToImage
      ? blockCount.toString()
      : '';
}

@freezed
abstract class TsumikiCountingSession with _$TsumikiCountingSession {
  const factory TsumikiCountingSession({
    required int index,                 // 現在の問題番号 (0-based)
    required int total,                 // 総問題数
    required List<bool?> results,       // 結果配列（null=未回答, bool=完璧/不完璧）
    TsumikiCountingProblem? currentProblem,
    @Default(0) int wrongAnswers,       // 不正解回数
  }) = _TsumikiCountingSession;

  const TsumikiCountingSession._();

  bool get isCompleted => index >= total;
  int get correctCount => results.where((r) => r == true).length;
  int get incorrectCount => results.where((r) => r == false).length;
}

@freezed
abstract class TsumikiCountingState with _$TsumikiCountingState {
  const factory TsumikiCountingState({
    @Default(CommonGamePhase.ready) CommonGamePhase phase,
    TsumikiCountingSettings? settings,
    TsumikiCountingSession? session,
    AnswerResult? lastResult,
    @Default(0) int epoch,              // 競合状態防止
  }) = _TsumikiCountingState;

  const TsumikiCountingState._();

  // UI向けの派生プロパティ
  bool get canAnswer => phase == CommonGamePhase.questioning;
  bool get isProcessing => phase == CommonGamePhase.processing ||
                           phase == CommonGamePhase.transitioning;
  double get progress => session != null ? session!.index / session!.total : 0.0;
  String? get questionText => session?.currentProblem?.questionText;
}