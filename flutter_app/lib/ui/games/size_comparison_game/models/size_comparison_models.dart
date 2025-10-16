import 'package:freezed_annotation/freezed_annotation.dart';
import '../../base/common_game_phase.dart';

part 'size_comparison_models.freezed.dart';

// 問題の種類（何番目に大きい・小さい）
enum ComparisonType {
  largest,  // 大きい
  smallest, // 小さい
}

extension ComparisonTypeExtension on ComparisonType {
  String get displayName {
    switch (this) {
      case ComparisonType.largest:
        return 'おおきい';
      case ComparisonType.smallest:
        return 'ちいさい';
    }
  }
}

// 問題の難易度
enum SizeComparisonDifficulty {
  easy,   // 1番目・2番目
  medium, // 3番目
  hard,   // 4番目・5番目
}

extension SizeComparisonDifficultyExtension on SizeComparisonDifficulty {
  String get displayName {
    switch (this) {
      case SizeComparisonDifficulty.easy:
        return 'かんたん';
      case SizeComparisonDifficulty.medium:
        return 'ふつう';
      case SizeComparisonDifficulty.hard:
        return 'むずかしい';
    }
  }
}

// アイコン情報
@freezed
abstract class IconInfo with _$IconInfo {
  const factory IconInfo({
    required String filename,  // assets/images/figures/vocabulary/<filename>.png
    required String slug,      // ファイル名（拡張子なし）
  }) = _IconInfo;

  const IconInfo._();
  
  String get assetPath => 'assets/images/figures/vocabulary/$filename';
}

// サイズ付きアイコン（問題で使用する5個のアイコン）
@freezed
abstract class SizedIcon with _$SizedIcon {
  const factory SizedIcon({
    required IconInfo iconInfo,
    required double size,
    required int sizeRank, // 1=最小, 2=2番目に小さい, ..., 5=最大
  }) = _SizedIcon;

  const SizedIcon._();
}

// 比較タイプの選択肢
enum ComparisonChoice {
  largest,         // いちばんおおきい
  smallest,        // いちばんちいさい
  sizeRandom,      // おおきいちいさいのランダム
  leftPosition,    // ひだりから○ばんめ
  rightPosition,   // みぎから○ばんめ
  positionRandom,  // ひだりみぎのランダム
}

extension ComparisonChoiceExtension on ComparisonChoice {
  String get displayName {
    switch (this) {
      case ComparisonChoice.largest:
        return 'いちばんおおきい';
      case ComparisonChoice.smallest:
        return 'いちばんちいさい';
      case ComparisonChoice.sizeRandom:
        return 'おおきいちいさい\nランダム';
      case ComparisonChoice.leftPosition:
        return 'ひだりから';
      case ComparisonChoice.rightPosition:
        return 'みぎから';
      case ComparisonChoice.positionRandom:
        return 'ひだりみぎ\nランダム';
    }
  }
}

// ゲーム設定
@freezed
abstract class SizeComparisonSettings with _$SizeComparisonSettings {
  const factory SizeComparisonSettings({
    @Default(ComparisonChoice.sizeRandom) ComparisonChoice comparisonChoice,
    @Default(4) int questionCount,
  }) = _SizeComparisonSettings;

  const SizeComparisonSettings._();

  String get displayName => '${comparisonChoice.displayName}（${questionCount}問）';
}

// 1問の問題データ
@freezed
abstract class SizeComparisonProblem with _$SizeComparisonProblem {
  const factory SizeComparisonProblem({
    required String questionText,         // TTS用の質問文
    required ComparisonType comparisonType, // 大きい or 小さい
    required int targetRank,              // 何番目（1-5）
    required List<SizedIcon> icons,       // 5個のサイズ違いアイコン（位置はシャッフル済み）
    required int correctAnswerIndex,      // 正解のインデックス（icons配列での位置）
    @Default(false) bool isPositionMode,  // 位置モード（ひだりから/みぎから）かどうか
  }) = _SizeComparisonProblem;

  const SizeComparisonProblem._();
}

// 回答結果
@freezed
abstract class AnswerResult with _$AnswerResult {
  const factory AnswerResult({
    required int selectedIndex,
    required int correctIndex,
    required bool isCorrect,
    required bool isPerfect, // 一回で正解したか
  }) = _AnswerResult;

  const AnswerResult._();
}

// ゲームセッション
@freezed
abstract class SizeComparisonSession with _$SizeComparisonSession {
  const factory SizeComparisonSession({
    required int index,                     // 現在の問題番号 (0-based)
    required int total,                     // 総問題数
    required List<bool?> results,           // 結果配列（null=未回答, bool=完璧/不完璧）
    SizeComparisonProblem? currentProblem,
    @Default(0) int wrongAnswers,           // 不正解回数
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _SizeComparisonSession;

  const SizeComparisonSession._();

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

// ゲーム状態
@freezed
abstract class SizeComparisonState with _$SizeComparisonState {
  const factory SizeComparisonState({
    @Default(CommonGamePhase.ready) CommonGamePhase phase,
    SizeComparisonSettings? settings,
    SizeComparisonSession? session,
    AnswerResult? lastResult,
    @Default(0) int epoch,              // 競合状態防止
  }) = _SizeComparisonState;

  const SizeComparisonState._();

  // UI向けの派生プロパティ
  bool get canAnswer => phase == CommonGamePhase.questioning;
  bool get isProcessing =>
      phase == CommonGamePhase.processing ||
      phase == CommonGamePhase.transitioning;
  double get progress => session?.progress ?? 0.0;
  String? get questionText => session?.currentProblem?.questionText;
  bool get isCompleted => phase == CommonGamePhase.completed;
}