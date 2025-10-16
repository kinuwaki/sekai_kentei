import 'package:flutter/material.dart';

/// 共通の描画パスデータ
class DrawingPath {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;
  final DateTime timestamp;

  DrawingPath({
    required this.points,
    this.color = Colors.black,
    this.strokeWidth = 12.0,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  DrawingPath copyWith({
    List<Offset>? points,
    Color? color,
    double? strokeWidth,
    DateTime? timestamp,
  }) {
    return DrawingPath(
      points: points ?? this.points,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DrawingPath &&
        other.points.length == points.length &&
        other.color == color &&
        other.strokeWidth == strokeWidth;
  }

  @override
  int get hashCode {
    return Object.hash(points.length, color, strokeWidth);
  }
}

/// 共通の描画データコンテナ
class DrawingData {
  final List<DrawingPath> paths;
  final Size canvasSize;

  const DrawingData({
    required this.paths,
    required this.canvasSize,
  });

  bool get isEmpty => paths.isEmpty;

  DrawingData clear() => DrawingData(paths: [], canvasSize: canvasSize);

  DrawingData addPath(DrawingPath path) {
    return DrawingData(
      paths: [...paths, path],
      canvasSize: canvasSize,
    );
  }

  DrawingData removePath(int index) {
    if (index < 0 || index >= paths.length) return this;
    final newPaths = List<DrawingPath>.from(paths);
    newPaths.removeAt(index);
    return DrawingData(
      paths: newPaths,
      canvasSize: canvasSize,
    );
  }

  DrawingData copyWith({
    List<DrawingPath>? paths,
    Size? canvasSize,
  }) {
    return DrawingData(
      paths: paths ?? this.paths,
      canvasSize: canvasSize ?? this.canvasSize,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DrawingData &&
        other.paths.length == paths.length &&
        other.canvasSize == canvasSize;
  }

  @override
  int get hashCode {
    return Object.hash(paths.length, canvasSize);
  }
}

/// 描画モード
enum DrawingMode {
  free,      // 自由描画
  tracing,   // なぞり描画
  guided,    // ガイド付き描画
}

/// 描画設定
class DrawingConfig {
  final double strokeWidth;
  final Color strokeColor;
  final Color backgroundColor;
  final DrawingMode mode;
  final bool showGuides;
  final bool enableUndo;
  final int maxUndoSteps;

  const DrawingConfig({
    this.strokeWidth = 12.0,
    this.strokeColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.mode = DrawingMode.free,
    this.showGuides = false,
    this.enableUndo = true,
    this.maxUndoSteps = 10,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DrawingConfig &&
        other.strokeWidth == strokeWidth &&
        other.strokeColor == strokeColor &&
        other.backgroundColor == backgroundColor &&
        other.mode == mode &&
        other.showGuides == showGuides &&
        other.enableUndo == enableUndo &&
        other.maxUndoSteps == maxUndoSteps;
  }

  @override
  int get hashCode {
    return Object.hash(
      strokeWidth,
      strokeColor,
      backgroundColor,
      mode,
      showGuides,
      enableUndo,
      maxUndoSteps,
    );
  }

  DrawingConfig copyWith({
    double? strokeWidth,
    Color? strokeColor,
    Color? backgroundColor,
    DrawingMode? mode,
    bool? showGuides,
    bool? enableUndo,
    int? maxUndoSteps,
  }) {
    return DrawingConfig(
      strokeWidth: strokeWidth ?? this.strokeWidth,
      strokeColor: strokeColor ?? this.strokeColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      mode: mode ?? this.mode,
      showGuides: showGuides ?? this.showGuides,
      enableUndo: enableUndo ?? this.enableUndo,
      maxUndoSteps: maxUndoSteps ?? this.maxUndoSteps,
    );
  }
}