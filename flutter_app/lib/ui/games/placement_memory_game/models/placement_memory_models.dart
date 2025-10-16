import 'package:freezed_annotation/freezed_annotation.dart';
import '../../base/common_game_phase.dart';
import '../../../../services/vocabulary_image_service.dart';

part 'placement_memory_models.freezed.dart';

/// グリッドアイテム
@freezed
abstract class GridItem with _$GridItem {
  const factory GridItem({
    required String word,
    required int gridIndex, // 0-3 (2x2グリッド)
  }) = _GridItem;

  const GridItem._();

  String get imagePath => VocabularyImageService.getImagePath(word);
}

/// ゲーム設定
@freezed
abstract class PlacementMemorySettings with _$PlacementMemorySettings {
  const factory PlacementMemorySettings({
    @Default(3) int questionCount,
    @Default(2) int rows, // グリッドの行数
    @Default(2) int cols, // グリッドの列数
    int? itemCount, // 表示するアイテム数（nullの場合は全マス）
  }) = _PlacementMemorySettings;

  const PlacementMemorySettings._();

  String get displayName {
    final items = itemCount ?? gridSize;
    return '配置記憶（$rows×$cols、${items}こ、$questionCount問）';
  }
  int get gridSize => rows * cols;
  int get actualItemCount => itemCount ?? gridSize;
}

/// 問題
@freezed
abstract class PlacementMemoryProblem with _$PlacementMemoryProblem {
  const factory PlacementMemoryProblem({
    required List<GridItem> items, // 正解配置
  }) = _PlacementMemoryProblem;
}

/// セッション
@freezed
abstract class PlacementMemorySession with _$PlacementMemorySession {
  const factory PlacementMemorySession({
    required int index,
    required int total,
    required List<bool?> results,
    PlacementMemoryProblem? currentProblem,
    @Default(0) int wrongAttempts,
    @Default([]) List<GridItem> userPlacement, // ユーザーの配置
  }) = _PlacementMemorySession;

  const PlacementMemorySession._();

  bool get isCompleted => index >= total;
  bool get isLast => index + 1 >= total;
  int get correctCount => results.where((r) => r == true).length;
}

/// ゲーム状態
@freezed
abstract class PlacementMemoryState with _$PlacementMemoryState {
  const factory PlacementMemoryState({
    @Default(CommonGamePhase.ready) CommonGamePhase phase,
    PlacementMemorySettings? settings,
    PlacementMemorySession? session,
    @Default(0) int epoch,
    @Default(false) bool showingAnswer, // 回答フェーズか
  }) = _PlacementMemoryState;

  const PlacementMemoryState._();

  bool get canAnswer => phase == CommonGamePhase.questioning;
  bool get isProcessing =>
      phase == CommonGamePhase.processing ||
      phase == CommonGamePhase.transitioning;
  double get progress =>
      session != null ? session!.index / session!.total : 0.0;
}
