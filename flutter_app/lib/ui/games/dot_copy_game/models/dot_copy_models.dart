import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import '../../base/common_game_phase.dart';

part 'dot_copy_models.freezed.dart';

/// ドット座標（グリッド座標: 0始まり）
@freezed
abstract class DotPosition with _$DotPosition {
  const factory DotPosition({
    required int x,
    required int y,
  }) = _DotPosition;

  const DotPosition._();

  @override
  String toString() => '($x,$y)';
}

/// 線分（2つのドットを結ぶ）
@freezed
abstract class LineSegment with _$LineSegment {
  const factory LineSegment({
    required DotPosition start,
    required DotPosition end,
  }) = _LineSegment;

  const LineSegment._();

  /// 線分を正規化（常にstartが小さい座標になるように）
  LineSegment normalize() {
    if (start.y < end.y || (start.y == end.y && start.x < end.x)) {
      return this;
    }
    return LineSegment(start: end, end: start);
  }
}

/// 難易度
enum DotCopyDifficulty {
  easy('かんたん', 1, 8), // 辺数1-8（固定パターン）
  normal('ふつう', 7, 14), // 辺数7-14（プロシージュアル、斜め線禁止）
  hard('むずかしい', 10, 20); // 辺数10-20（プロシージュアル、斜め線あり）

  final String displayName;
  final int minEdges;
  final int maxEdges;

  const DotCopyDifficulty(this.displayName, this.minEdges, this.maxEdges);
}

/// ゲーム設定
@freezed
abstract class DotCopySettings with _$DotCopySettings {
  const factory DotCopySettings({
    @Default(3) int gridSize,
    @Default(5) int questionCount,
    @Default(DotCopyDifficulty.easy) DotCopyDifficulty difficulty,
  }) = _DotCopySettings;

  const DotCopySettings._();

  String get displayName => '$gridSize×$gridSize ${difficulty.displayName}（$questionCount問）';
}

/// 問題（お手本の図形）
@freezed
abstract class DotCopyProblem with _$DotCopyProblem {
  const factory DotCopyProblem({
    required int gridSize,
    required List<LineSegment> patternLines,
    @Default('おてほんとおなじずをかきましょう') String questionText,
  }) = _DotCopyProblem;

  const DotCopyProblem._();

  /// 線分の数
  int get lineCount => patternLines.length;
}

/// ゲームセッション
@freezed
abstract class DotCopySession with _$DotCopySession {
  const factory DotCopySession({
    required int index,
    required int total,
    required List<bool?> results,
    DotCopyProblem? currentProblem,
    @Default([]) List<LineSegment> drawnLines,
    DotPosition? selectedDot,
    Offset? dragPosition,
    @Default(0) int wrongAttempts,
  }) = _DotCopySession;

  const DotCopySession._();

  bool get isCompleted => index >= total;
  bool get isLast => index + 1 >= total;
  int get correctCount => results.where((r) => r == true).length;
  int get score => correctCount;
}

/// ゲーム状態
@freezed
abstract class DotCopyState with _$DotCopyState {
  const factory DotCopyState({
    @Default(CommonGamePhase.ready) CommonGamePhase phase,
    DotCopySettings? settings,
    DotCopySession? session,
    @Default(0) int epoch, // 競合状態防止
  }) = _DotCopyState;

  const DotCopyState._();

  // UI向けの派生プロパティ
  bool get canAnswer => phase == CommonGamePhase.questioning;
  bool get canDrawLine => phase == CommonGamePhase.questioning;
  bool get isProcessing =>
      phase == CommonGamePhase.processing ||
      phase == CommonGamePhase.transitioning;
  double get progress =>
      session != null ? session!.index / session!.total : 0.0;
  String? get questionText => session?.currentProblem?.questionText;

  /// 正解判定ボタンを表示するか
  bool get showCheckButton => phase == CommonGamePhase.questioning;
}