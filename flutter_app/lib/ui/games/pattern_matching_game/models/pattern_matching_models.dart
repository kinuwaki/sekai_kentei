import 'package:freezed_annotation/freezed_annotation.dart';
import '../../base/common_game_phase.dart';

part 'pattern_matching_models.freezed.dart';

// 図形の種類
enum PatternShape {
  circle('まる'),
  triangle('さんかく'),
  square('しかく'),
  star('ほし');

  final String displayName;
  const PatternShape(this.displayName);
}

// 図形の色
enum PatternColor {
  red('あか', 0xFFD96A57),
  blue('あお', 0xFF7EB6E6),
  orange('だいだい', 0xFFF3C25B),
  green('みどり', 0xFF6DB393),
  brown('ちゃいろ', 0xFFB57C5B),
  purple('むらさき', 0xFF9B8BC5);

  final String displayName;
  final int colorValue;
  const PatternColor(this.displayName, this.colorValue);
}

// 図形の種類（塗りつぶし/枠線のみ/二重）
enum PatternFillType {
  filled('ぬりつぶし'),
  outline('わくせん'),
  double_('にじゅう');

  final String displayName;
  const PatternFillType(this.displayName);
}

// 図形の仕様
@freezed
abstract class PatternSpec with _$PatternSpec {
  const factory PatternSpec({
    required PatternShape shape,
    required PatternColor color,
    @Default(PatternFillType.filled) PatternFillType fillType,
  }) = _PatternSpec;

  const PatternSpec._();

  // TTS用テキスト
  String get ttsText {
    final fillText = fillType == PatternFillType.outline ? 'わくだけの' : '';
    return '${color.displayName}の$fillText${shape.displayName}';
  }

  // 一致判定
  bool matches(PatternSpec other) {
    return shape == other.shape &&
           color == other.color &&
           fillType == other.fillType;
  }
}

// ゲーム設定
@freezed
abstract class PatternMatchingSettings with _$PatternMatchingSettings {
  const factory PatternMatchingSettings({
    @Default(5) int questionCount,
    @Default(0) int seed, // 0 = ランダム
  }) = _PatternMatchingSettings;

  const PatternMatchingSettings._();

  String get displayName => 'きそくせいゲーム（$questionCount問）';
}

// 問題データ
@freezed
abstract class PatternMatchingProblem with _$PatternMatchingProblem {
  const factory PatternMatchingProblem({
    required List<PatternSpec?> sequence,      // 9個の図形（?の位置はnull）
    required int questionMarkIndex,            // ?の位置
    required List<PatternSpec> choices,        // 選択肢3個
    required int correctAnswerIndex,           // 正解のインデックス（0-2）
    required String questionText,              // TTS用
  }) = _PatternMatchingProblem;

  const PatternMatchingProblem._();

  // 正解判定
  bool isCorrectAnswer(int selectedIndex) {
    return selectedIndex == correctAnswerIndex;
  }

  // 正解の図形を取得
  PatternSpec get correctAnswer => choices[correctAnswerIndex];
}

// セッション
@freezed
abstract class PatternMatchingSession with _$PatternMatchingSession {
  const factory PatternMatchingSession({
    required int index,                    // 現在の問題番号（0-based）
    required int total,                    // 総問題数
    required List<bool?> results,          // 結果配列（null=未回答, true=完璧, false=不完璧）
    PatternMatchingProblem? currentProblem,
    @Default(0) int wrongAttempts,         // 不正解回数
  }) = _PatternMatchingSession;

  const PatternMatchingSession._();

  bool get isCompleted => index >= total;
  int get correctCount => results.where((r) => r == true).length;
  int get incorrectCount => results.where((r) => r == false).length;
  double get progress => total > 0 ? index / total : 0.0;
  String get progressText => '${index + 1}/$total';
}

// ゲーム状態
@freezed
abstract class PatternMatchingState with _$PatternMatchingState {
  const factory PatternMatchingState({
    @Default(CommonGamePhase.ready) CommonGamePhase phase,
    PatternMatchingSettings? settings,
    PatternMatchingSession? session,
    @Default(0) int epoch,  // 競合状態防止
  }) = _PatternMatchingState;

  const PatternMatchingState._();

  // UI向けの派生プロパティ
  bool get canAnswer => phase == CommonGamePhase.questioning;
  bool get isProcessing => phase == CommonGamePhase.processing || phase == CommonGamePhase.transitioning;
  double get progress => session?.progress ?? 0.0;
  String? get questionText => session?.currentProblem?.questionText;
  bool get isCompleted => phase == CommonGamePhase.completed;
  bool get isPerfect => session != null &&
      session!.results.take(session!.index + (phase == CommonGamePhase.completed ? 0 : 1)).every((r) => r == true);
}
