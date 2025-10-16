import 'package:freezed_annotation/freezed_annotation.dart';
import '../../base/common_game_phase.dart';
import '../../../../services/vocabulary_image_service.dart';

part 'instant_memory_models.freezed.dart';

/// 難易度
enum InstantMemoryDifficulty {
  easy('かんたん', 3, 3),      // 3個の図形
  normal('ふつう', 5, 5),     // 5個の図形
  hard('むずかしい', 7, 7);    // 7個の図形

  final String displayName;
  final int minItems;
  final int maxItems;

  const InstantMemoryDifficulty(this.displayName, this.minItems, this.maxItems);
}

/// 変化の種類
enum ChangeType {
  added,     // 1個追加
  replaced,  // 1個を別の図形に変更
}

/// 図形アイテム
@freezed
abstract class MemoryItem with _$MemoryItem {
  const factory MemoryItem({
    required String word,      // 単語
    required int id,           // 一意なID
    required double x,         // X座標（0.0-1.0の相対位置）
    required double y,         // Y座標（0.0-1.0の相対位置）
  }) = _MemoryItem;

  const MemoryItem._();

  String get imagePath => VocabularyImageService.getImagePath(word);
}

/// ゲーム設定
@freezed
abstract class InstantMemorySettings with _$InstantMemorySettings {
  const factory InstantMemorySettings({
    @Default(InstantMemoryDifficulty.easy) InstantMemoryDifficulty difficulty,
    @Default(3) int questionCount,
    @Default(8) int memorySeconds,  // 記憶時間（秒）
  }) = _InstantMemorySettings;

  const InstantMemorySettings._();

  String get displayName => '${difficulty.displayName}（$questionCount問）';
}

/// 問題
@freezed
abstract class InstantMemoryProblem with _$InstantMemoryProblem {
  const factory InstantMemoryProblem({
    required List<MemoryItem> initialItems,  // 最初の図形リスト
    required List<MemoryItem> changedItems,  // 変化後の図形リスト
    required ChangeType changeType,          // 変化の種類
    required int changedIndex,               // 変化した位置（正解）
    required String displayWord,             // 表示する単語
    @Default('どのえがあるか\n８びょうでおぼえてね') String memoryPhaseText,
    @Default('どのえがふえたかな') String addedQuestionText,
    @Default('どのえがおきかわったかな') String replacedQuestionText,
  }) = _InstantMemoryProblem;

  const InstantMemoryProblem._();

  String get questionText => changeType == ChangeType.added
      ? addedQuestionText
      : replacedQuestionText;
}

/// セッション
@freezed
abstract class InstantMemorySession with _$InstantMemorySession {
  const factory InstantMemorySession({
    required int index,
    required int total,
    required List<bool?> results,
    InstantMemoryProblem? currentProblem,
    @Default(0) int wrongAttempts,
    @Default(false) bool showingAnswer,      // 変化後の画面表示中か
  }) = _InstantMemorySession;

  const InstantMemorySession._();

  bool get isCompleted => index >= total;
  bool get isLast => index + 1 >= total;
  int get correctCount => results.where((r) => r == true).length;
  int get score => correctCount;
}

/// ゲーム状態
@freezed
abstract class InstantMemoryState with _$InstantMemoryState {
  const factory InstantMemoryState({
    @Default(CommonGamePhase.ready) CommonGamePhase phase,
    InstantMemorySettings? settings,
    InstantMemorySession? session,
    @Default(0) int epoch,
  }) = _InstantMemoryState;

  const InstantMemoryState._();

  bool get canAnswer => phase == CommonGamePhase.questioning;
  bool get isProcessing =>
      phase == CommonGamePhase.processing ||
      phase == CommonGamePhase.transitioning;
  double get progress =>
      session != null ? session!.index / session!.total : 0.0;
  String? get questionText => session?.currentProblem?.questionText;
}
