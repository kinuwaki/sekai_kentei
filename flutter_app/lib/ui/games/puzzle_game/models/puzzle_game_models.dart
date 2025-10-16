import "../../base/common_game_phase.dart";
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:ui' show Rect, Image;

part 'puzzle_game_models.freezed.dart';

/// パズルピースタイプ
enum PuzzlePieceType {
  top,      // 上半分
  bottom,   // 下半分
  middle,   // 中央ダミー
}

/// パズルゲーム設定
@freezed
abstract class PuzzleGameSettings with _$PuzzleGameSettings {
  const factory PuzzleGameSettings({
    @Default(3) int questionCount,
  }) = _PuzzleGameSettings;

  const PuzzleGameSettings._();

  String get displayName => 'ばらばらパズル（$questionCount問）';
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PuzzleGameSettings &&
          runtimeType == other.runtimeType &&
          questionCount == other.questionCount;
  
  @override
  int get hashCode => questionCount.hashCode;
}

/// パズルピース情報
@freezed
abstract class PuzzlePiece with _$PuzzlePiece {
  const factory PuzzlePiece({
    required PuzzlePieceType type,
    required int imageIndex,
    required Rect uvRect,      // UV座標 (0.0〜1.0)
    required int gridPosition,  // 2x2グリッド内の位置 (0-3)
    @Default(false) bool isSelected,
  }) = _PuzzlePiece;

  const PuzzlePiece._();

  /// UV座標定義（固定値）
  static Rect getUvRect(PuzzlePieceType type) {
    switch (type) {
      case PuzzlePieceType.top:
        return const Rect.fromLTWH(0.0, 0.0, 1.0, 0.5);
      case PuzzlePieceType.bottom:
        return const Rect.fromLTWH(0.0, 0.5, 1.0, 0.5);
      case PuzzlePieceType.middle:
        return const Rect.fromLTWH(0.0, 0.25, 1.0, 0.5);
    }
  }
}

/// パズル問題
@freezed
abstract class PuzzleProblem with _$PuzzleProblem {
  const factory PuzzleProblem({
    required String imagePath,
    required int imageIndex,
    required List<PuzzlePiece> pieces,  // シャッフルされた3ピース
    required Image? fullImage,       // フル画像（お手本用）
  }) = _PuzzleProblem;

  const PuzzleProblem._();

  /// TTS用の質問文
  String get questionText => 'ただしいくみあわせを\nえらんでください';
}

/// 回答結果
@freezed
abstract class PuzzleAnswerResult with _$PuzzleAnswerResult {
  const factory PuzzleAnswerResult({
    required List<int> selectedIndices,
    required bool isCorrect,
    required bool isPerfect,
    @Default(Duration.zero) Duration timeTaken,
  }) = _PuzzleAnswerResult;
}

/// ゲームセッション
@freezed
abstract class PuzzleGameSession with _$PuzzleGameSession {
  const factory PuzzleGameSession({
    required int index,
    required int total,
    required List<bool?> results,
    PuzzleProblem? currentProblem,
    @Default(0) int wrongAnswers,
    @Default([]) List<int> selectedPieceIndices,
    @Default(Duration.zero) Duration totalTime,
    DateTime? questionStartTime,
  }) = _PuzzleGameSession;

  const PuzzleGameSession._();

  bool get isCompleted => index >= total;
  bool get isPerfect => wrongAnswers == 0;
  int get correctCount => results.where((r) => r == true).length;
  int get incorrectCount => results.where((r) => r == false).length;
  String get progressText => '${index + 1}/$total';
}

/// ゲームフェーズ

/// ゲーム状態
@freezed
abstract class PuzzleGameState with _$PuzzleGameState {
  const factory PuzzleGameState({
    @Default(CommonGamePhase.ready) CommonGamePhase phase,
    PuzzleGameSettings? settings,
    PuzzleGameSession? session,
    PuzzleAnswerResult? lastResult,
    @Default(0) int epoch,  // 競合状態防止
    @Default([]) List<Image?> preloadedImages,  // 事前読み込み画像
    String? errorMessage,
  }) = _PuzzleGameState;

  const PuzzleGameState._();

  // UI向けの派生プロパティ
  bool get canAnswer => phase == CommonGamePhase.questioning;
  bool get isProcessing => phase == CommonGamePhase.processing || phase == CommonGamePhase.transitioning;
  
  bool get isCompleted => phase == CommonGamePhase.completed;
  double get progress => session != null ? session!.index / session!.total : 0.0;
  String? get questionText => session?.currentProblem?.questionText;
  int get selectedCount => session?.selectedPieceIndices.length ?? 0;
  bool get canJudge => selectedCount == 2;
  String get progressText => session?.progressText ?? '';
}