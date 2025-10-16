import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/drawing/drawing_models.dart';

/// ChatGPT提案: 描画データの独立keepAlive Provider
/// - BaseGameScreenの再構築で消えない
/// - ページ遷移でも維持される
/// - 必要に応じて永続化も追加可能

/// ストローク（筆跡）データ
class Stroke {
  final List<Offset> points;
  final Color color;
  final double width;
  final DateTime timestamp;

  Stroke({
    required this.points,
    this.color = Colors.black,
    this.width = 6.0,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Stroke copyWith({
    List<Offset>? points,
    Color? color,
    double? width,
    DateTime? timestamp,
  }) {
    return Stroke(
      points: points ?? this.points,
      color: color ?? this.color,
      width: width ?? this.width,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  /// DrawingPathに変換
  DrawingPath toDrawingPath() {
    return DrawingPath(
      points: points,
      color: color,
      strokeWidth: width,
      timestamp: timestamp,
    );
  }
}

/// 描画状態管理
class SketchState {
  final List<Stroke> strokes;
  final Size canvasSize;

  const SketchState({
    this.strokes = const [],
    this.canvasSize = const Size(300, 200),
  });

  SketchState copyWith({
    List<Stroke>? strokes,
    Size? canvasSize,
  }) {
    return SketchState(
      strokes: strokes ?? this.strokes,
      canvasSize: canvasSize ?? this.canvasSize,
    );
  }

  /// DrawingDataに変換
  DrawingData toDrawingData() {
    return DrawingData(
      paths: strokes.map((s) => s.toDrawingPath()).toList(),
      canvasSize: canvasSize,
    );
  }

  bool get isEmpty => strokes.isEmpty;
  bool get isNotEmpty => strokes.isNotEmpty;
}

/// 描画管理ノーティファイア
class SketchNotifier extends Notifier<SketchState> {
  @override
  SketchState build() {
    // 🔧 ChatGPT提案: keepAliveで画面遷移・再構築でも維持
    ref.keepAlive();
    return const SketchState();
  }

  /// ストロークを追加
  void addStroke(Stroke stroke) {
    state = state.copyWith(
      strokes: [...state.strokes, stroke],
    );
  }

  /// DrawingPathから追加（既存コンポーネント互換）
  void addDrawingPath(DrawingPath path) {
    final stroke = Stroke(
      points: path.points,
      color: path.color,
      width: path.strokeWidth,
      timestamp: path.timestamp,
    );
    addStroke(stroke);
  }

  /// 全てクリア
  void clear() {
    state = state.copyWith(strokes: []);
  }

  /// 最後のストロークを削除（Undo）
  void removeLast() {
    if (state.strokes.isNotEmpty) {
      final newStrokes = List<Stroke>.from(state.strokes)..removeLast();
      state = state.copyWith(strokes: newStrokes);
    }
  }

  /// キャンバスサイズ設定
  void setCanvasSize(Size size) {
    state = state.copyWith(canvasSize: size);
  }

  /// 描画データを取得（既存コンポーネント互換）
  DrawingData getDrawingData() {
    return state.toDrawingData();
  }
}

/// メイン描画プロバイダー
final sketchProvider = NotifierProvider<SketchNotifier, SketchState>(
  SketchNotifier.new,
);

/// 簡単アクセス用プロバイダー
final drawingDataProvider = Provider<DrawingData>((ref) {
  return ref.watch(sketchProvider).toDrawingData();
});

/// 描画が空かどうかのプロバイダー
final isDrawingEmptyProvider = Provider<bool>((ref) {
  return ref.watch(sketchProvider).isEmpty;
});