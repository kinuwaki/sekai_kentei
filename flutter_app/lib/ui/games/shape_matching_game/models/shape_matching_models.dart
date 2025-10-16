import 'package:freezed_annotation/freezed_annotation.dart';
import '../../base/common_game_phase.dart';

part 'shape_matching_models.freezed.dart';

// 図形の形
enum GeoShape {
  star('ほし'),
  triangle('さんかく'),
  circle('まる'),
  square('しかく'),
  pentagon('ごかっけい');

  final String displayName;
  const GeoShape(this.displayName);
}

// 図形のバリアント（通常/二重）
enum GeoVariant {
  plain(''),  // ふつう
  double_('にじゅう');  // 二重

  final String displayName;
  const GeoVariant(this.displayName);
}

// 図形の色
enum GeoColor {
  red('あか', 0xFFD96A57),
  blue('あお', 0xFF7EB6E6),
  yellow('きいろ', 0xFFF3C25B),
  green('みどり', 0xFF6DB393);

  final String displayName;
  final int colorValue;
  const GeoColor(this.displayName, this.colorValue);
}

// タイルハイライト状態
enum TileHighlight { 
  none, 
  correct,  // 正解（緑枠）
  wrong,    // 不正解（赤枠）
}

// タイル仕様
@freezed
abstract class TileSpec with _$TileSpec {
  const factory TileSpec({
    required GeoShape shape,
    required GeoVariant variant,
    required GeoColor color,
  }) = _TileSpec;

  const TileSpec._();

  // TTS用の読み上げテキスト
  String get ttsText {
    final variantText = variant == GeoVariant.double_ ? 'にじゅう' : '';
    final colorText = color.displayName;
    final shapeText = shape.displayName;
    
    if (variant == GeoVariant.double_) {
      return '$colorTextの$variantText$shapeText';
    } else {
      return '$colorTextの$shapeText';
    }
  }

  // 一致判定
  bool matches(TileSpec other) {
    return shape == other.shape && 
           variant == other.variant && 
           color == other.color;
  }
}

// レベル設定
@freezed
abstract class ShapeMatchingSettings with _$ShapeMatchingSettings {
  const factory ShapeMatchingSettings({
    @Default(4) int rows,
    @Default(4) int cols,
    @Default(4) int targetCountMin,
    @Default(6) int targetCountMax,
    @Default(3) int questionCount,
    @Default(0) int seed,  // 0 = ランダム
  }) = _ShapeMatchingSettings;

  const ShapeMatchingSettings._();

  // グリッドのマス数
  int get totalCells => rows * cols;

  // 表示名
  String get displayName => '$rows×$colsグリッド（$questionCount問）';
}

// 問題
@freezed
abstract class ShapeMatchingProblem with _$ShapeMatchingProblem {
  const factory ShapeMatchingProblem({
    required TileSpec target,  // お手本
    required List<TileSpec> grid,  // グリッドのタイル
    required Set<int> answerIndices,  // 正解のインデックス
    required String questionText,  // TTS用
  }) = _ShapeMatchingProblem;

  const ShapeMatchingProblem._();

  // 指定インデックスのタイルを取得
  TileSpec? getTileAt(int index) {
    if (index >= 0 && index < grid.length) {
      return grid[index];
    }
    return null;
  }

  // 正解判定
  bool isCorrectAnswer(Set<int> selectedIndices) {
    return selectedIndices.length == answerIndices.length &&
           selectedIndices.containsAll(answerIndices);
  }
}

// 回答結果
@freezed
abstract class ShapeMatchingResult with _$ShapeMatchingResult {
  const factory ShapeMatchingResult({
    required Set<int> selectedIndices,
    required Set<int> correctIndices,
    required bool isCorrect,
    @Default(false) bool isPerfect,  // 一発正解
    @Default(0) int attemptCount,
  }) = _ShapeMatchingResult;

  const ShapeMatchingResult._();

  // 誤選択のインデックス（赤枠表示用）
  Set<int> get wrongSelections => selectedIndices.difference(correctIndices);

  // 見落としのインデックス（緑枠表示用）
  Set<int> get missedCorrects => correctIndices.difference(selectedIndices);
}

// セッション
@freezed
abstract class ShapeMatchingSession with _$ShapeMatchingSession {
  const factory ShapeMatchingSession({
    required int index,  // 現在の問題番号（0-based）
    required int total,  // 総問題数
    required List<bool?> results,  // 結果配列（null=未回答）
    ShapeMatchingProblem? currentProblem,
    @Default(0) int wrongAttempts,  // 不正解回数
    @Default({}) Set<int> selectedTiles,  // 選択中のタイル
    @Default({}) Set<int> correctlySelectedTiles,  // 正解済みの選択タイル
  }) = _ShapeMatchingSession;

  const ShapeMatchingSession._();

  // 完了判定
  bool get isCompleted => index >= total;
  
  // 正解数
  int get correctCount => results.where((r) => r == true).length;
  
  // 不正解数
  int get incorrectCount => results.where((r) => r == false).length;

  // 進捗
  double get progress => total > 0 ? index / total : 0.0;

  // 進捗テキスト
  String get progressText => '${index + 1}/$total';
}


// ゲーム状態
@freezed
abstract class ShapeMatchingState with _$ShapeMatchingState {
  const factory ShapeMatchingState({
    @Default(CommonGamePhase.ready) CommonGamePhase phase,
    ShapeMatchingSettings? settings,
    ShapeMatchingSession? session,
    ShapeMatchingResult? lastResult,
    @Default(0) int epoch,  // 競合状態防止
  }) = _ShapeMatchingState;

  const ShapeMatchingState._();

  // UI向けの派生プロパティ
  bool get canAnswer => phase == CommonGamePhase.questioning && (session?.selectedTiles.isNotEmpty ?? false);
  bool get isProcessing => phase == CommonGamePhase.processing || phase == CommonGamePhase.transitioning;
  double get progress => session?.progress ?? 0.0;
  String? get questionText => session?.currentProblem?.questionText;

  // タイル選択可能か
  bool get canSelectTiles => phase == CommonGamePhase.questioning;

  // 答え合わせボタン表示（常時表示）
  bool get showCheckButton => phase == CommonGamePhase.questioning;
}