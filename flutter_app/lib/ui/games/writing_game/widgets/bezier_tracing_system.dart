import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../data/hiragana_data.dart';

/// ベジェカーブセグメント
class BezierSegment {
  final Offset start;
  final Offset control1;
  final Offset control2;
  final Offset end;
  
  const BezierSegment({
    required this.start,
    required this.control1,
    required this.control2,
    required this.end,
  });
  
  /// ベジェカーブ上の点を取得 (t: 0.0-1.0)
  Offset getPoint(double t) {
    final u = 1.0 - t;
    final tt = t * t;
    final uu = u * u;
    final uuu = uu * u;
    final ttt = tt * t;
    
    return start * uuu +
           control1 * (3 * uu * t) +
           control2 * (3 * u * tt) +
           end * ttt;
  }
  
  /// ベジェカーブの接線ベクトルを取得
  Offset getTangent(double t) {
    final u = 1.0 - t;
    final uu = u * u;
    final tt = t * t;
    
    return (control1 - start) * (3 * uu) +
           (control2 - control1) * (6 * u * t) +
           (end - control2) * (3 * tt);
  }
  
  /// 点からベジェカーブまでの最短距離を計算
  double distanceToPoint(Offset point) {
    double minDistance = double.infinity;
    const int samples = 50;
    
    for (int i = 0; i <= samples; i++) {
      final t = i / samples;
      final curvePoint = getPoint(t);
      final distance = (point - curvePoint).distance;
      if (distance < minDistance) {
        minDistance = distance;
      }
    }
    
    return minDistance;
  }
  
  /// より精密な点からベジェカーブまでの最短距離とt値を計算
  DistanceResult findClosestPoint(Offset point) {
    double minDistance = double.infinity;
    double bestT = 0.0;
    const int samples = 150; // サンプル数を増やして精度向上
    
    // まず粗い検索
    for (int i = 0; i <= samples; i++) {
      final t = i / samples;
      final curvePoint = getPoint(t);
      final distance = (point - curvePoint).distance;
      if (distance < minDistance) {
        minDistance = distance;
        bestT = t;
      }
    }
    
    // より精密な検索（bestTの周辺を3段階で検索）
    for (int level = 0; level < 2; level++) {
      final searchRange = (1.0 / samples) / math.pow(2, level);
      final startT = math.max(0.0, bestT - searchRange);
      final endT = math.min(1.0, bestT + searchRange);
      const int precisionSamples = 30;
      
      for (int i = 0; i <= precisionSamples; i++) {
        final t = startT + (endT - startT) * i / precisionSamples;
        final curvePoint = getPoint(t);
        final distance = (point - curvePoint).distance;
        if (distance < minDistance) {
          minDistance = distance;
          bestT = t;
        }
      }
    }
    
    return DistanceResult(distance: minDistance, t: bestT, point: getPoint(bestT));
  }
}

/// 距離計算結果
class DistanceResult {
  final double distance;
  final double t;
  final Offset point;
  
  const DistanceResult({
    required this.distance,
    required this.t,
    required this.point,
  });
}

/// ベジェカーブストローク
class BezierStroke {
  final List<BezierSegment> segments;
  final double strokeWidth;
  
  const BezierStroke({
    required this.segments,
    this.strokeWidth = 8.0,
  });
  
  /// ストローク全体の長さを概算
  double get approximateLength {
    double totalLength = 0.0;
    for (final segment in segments) {
      // ベジェカーブの長さを線形近似で計算
      const int samples = 10;
      for (int i = 0; i < samples; i++) {
        final t1 = i / samples;
        final t2 = (i + 1) / samples;
        final p1 = segment.getPoint(t1);
        final p2 = segment.getPoint(t2);
        totalLength += (p2 - p1).distance;
      }
    }
    return totalLength;
  }
  
  /// 点からストロークまでの最短距離を計算
  DistanceResult findClosestPoint(Offset point) {
    double minDistance = double.infinity;
    DistanceResult bestResult = DistanceResult(
      distance: minDistance,
      t: 0.0,
      point: segments.first.start,
    );
    
    for (int i = 0; i < segments.length; i++) {
      final result = segments[i].findClosestPoint(point);
      if (result.distance < minDistance) {
        minDistance = result.distance;
        // 全体のt値に正確に変換：セグメントのベースt値 + セグメント内のt値
        final globalT = (i + result.t) / segments.length;
        bestResult = DistanceResult(
          distance: result.distance,
          t: globalT,
          point: result.point,
        );
      }
    }
    
    return bestResult;
  }
  
  /// t値（0.0-1.0）からストローク上の点を取得
  Offset getPointAt(double t) {
    if (segments.isEmpty) return Offset.zero;
    
    t = t.clamp(0.0, 1.0);
    
    if (t >= 1.0) {
      return segments.last.end;
    }
    
    // 全体の長さを基準にしたt値を各セグメントに分散
    final totalSegments = segments.length;
    final segmentIndex = (t * totalSegments).floor().clamp(0, totalSegments - 1);
    final localT = (t * totalSegments) - segmentIndex;
    
    return segments[segmentIndex].getPoint(localT);
  }
  
  /// PathをFlutterのPathオブジェクトに変換
  Path toPath() {
    final path = Path();
    
    if (segments.isEmpty) return path;
    
    path.moveTo(segments.first.start.dx, segments.first.start.dy);
    
    for (final segment in segments) {
      path.cubicTo(
        segment.control1.dx,
        segment.control1.dy,
        segment.control2.dx,
        segment.control2.dy,
        segment.end.dx,
        segment.end.dy,
      );
    }
    
    return path;
  }
}

/// SVGパスからベジェカーブへの変換器
class SmoothPathGenerator {
  /// SVGパス文字列からベジェストロークを生成（スケーリング付き）
  static BezierStroke fromSvgPath(String pathData, Size targetSize) {
    final points = _parseSvgPath(pathData);
    if (points.length < 2) {
      return BezierStroke(segments: []);
    }
    
    // スケールファクターを計算（元の実装と同じロジック）
    final scaleFactor = _determineScaleFactor(pathData, targetSize);
    
    // 制御点をスケーリング
    final scaledPoints = points.map((point) => point * scaleFactor).toList();
    
    // Catmull-Rom splineまたはベジェスプライン補間を使用
    return _createSmoothStroke(scaledPoints);
  }
  
  /// 元のSVGベースの実装と同じスケールファクター計算
  static double _determineScaleFactor(String pathData, Size size) {
    // AnimCJKデータ（ひらがな）の特徴的な座標をチェック
    // 「あ」「い」「う」「え」「お」「か」はすべて1024x1024のviewBoxを使用
    if (pathData.contains('174,258') || pathData.contains('331,137') || pathData.contains('570,440') || // あ
        pathData.contains('195,349') || pathData.contains('578,373') || // い（調整済み）
        pathData.contains('400,113') || pathData.contains('213,423') || // う（正しいデータ）
        pathData.contains('197,436') || pathData.contains('618,334') || // え（正しいデータ）
        pathData.contains('111.6,323.2') || pathData.contains('287,100') || pathData.contains('710,189') || // お
        pathData.contains('104,461') || pathData.contains('354,131') || pathData.contains('649,283')) { // か
      return size.width / 1024; // AnimCJKデータは1024x1024
    } else if (pathData.contains('200,80')) {
      return size.width / 400;  // 数字は400x400
    } else {
      return size.width / 1024;  // デフォルトもAnimCJK用に変更
    }
  }
  
  /// SVGパス文字列から制御点のリストを抽出
  static List<Offset> _parseSvgPath(String pathData) {
    final points = <Offset>[];
    final parts = pathData.split(RegExp(r'[ML,\s]+'));
    
    for (int i = 1; i < parts.length; i += 2) {
      if (i + 1 < parts.length) {
        final x = double.tryParse(parts[i]);
        final y = double.tryParse(parts[i + 1]);
        if (x != null && y != null) {
          points.add(Offset(x, y));
        }
      }
    }
    
    return points;
  }
  
  /// 制御点からスムーズなベジェストロークを作成
  static BezierStroke _createSmoothStroke(List<Offset> points) {
    if (points.length < 2) {
      return BezierStroke(segments: []);
    }
    
    if (points.length == 2) {
      // 2点の場合は直線をベジェカーブとして表現
      final segment = BezierSegment(
        start: points[0],
        control1: points[0] + (points[1] - points[0]) * 0.33,
        control2: points[0] + (points[1] - points[0]) * 0.67,
        end: points[1],
      );
      return BezierStroke(segments: [segment]);
    }
    
    final segments = <BezierSegment>[];
    
    // Catmull-Rom splineベースのベジェカーブ生成
    for (int i = 0; i < points.length - 1; i++) {
      final p0 = i > 0 ? points[i - 1] : points[i];
      final p1 = points[i];
      final p2 = points[i + 1];
      final p3 = i < points.length - 2 ? points[i + 2] : points[i + 1];
      
      // Catmull-Rom制御点を計算
      final tension = 0.5; // スムーズネスの調整
      final control1 = p1 + (p2 - p0) * tension * 0.33;
      final control2 = p2 - (p3 - p1) * tension * 0.33;
      
      segments.add(BezierSegment(
        start: p1,
        control1: control1,
        control2: control2,
        end: p2,
      ));
    }
    
    return BezierStroke(segments: segments);
  }
}

/// ベジェカーブトレーシングの衝突判定
class BezierCollisionDetector {
  static const double strictTolerance = 40.0; // さらに緩く（25.0から40.0に）
  static const double defaultTolerance = 50.0; // さらに緩く（35.0から50.0に）
  static const double maxJumpThreshold = 0.05; // より大きなジャンプを許可（3%から5%に）
  
  /// 点がストロークに十分近いかチェック
  static bool isPointOnStroke(
    Offset point,
    BezierStroke stroke, {
    double tolerance = strictTolerance,
  }) {
    final result = stroke.findClosestPoint(point);
    return result.distance <= tolerance;
  }
  
  /// トレーシング進行度を計算（ジャンプ制御付き）
  static double calculateProgress(
    Offset currentPoint,
    BezierStroke stroke,
    double previousProgress, {
    double tolerance = strictTolerance,
  }) {
    final result = stroke.findClosestPoint(currentPoint);
    
    if (result.distance > tolerance) {
      return previousProgress; // 範囲外の場合は進行度を更新しない
    }
    
    // 大きなジャンプを防ぐ
    double newProgress = result.t;
    
    // 未来への大幅ジャンプを制限：現在の進行度から大きく離れた位置は無視
    if (newProgress > previousProgress + 0.2) { // 現在進行度+20%より先は無視（10%から20%に緩和）
      return previousProgress; // 進行度を変更せず維持
    }
    
    // 逆行防止：現在の進行度より前に戻れない
    newProgress = math.max(previousProgress, newProgress);
    
    // 前進制限：一度に大きく進み過ぎないように制限
    final progressDiff = newProgress - previousProgress;
    if (progressDiff > maxJumpThreshold) {
      // 大きなジャンプの場合は段階的に進行
      newProgress = previousProgress + maxJumpThreshold;
    }
    
    return newProgress.clamp(0.0, 1.0);
  }
  
  /// より寛容な開始点判定（ストローク開始時に使用）
  static bool canStartStroke(
    Offset point,
    BezierStroke stroke, {
    double tolerance = defaultTolerance,
  }) {
    final result = stroke.findClosestPoint(point);
    return result.distance <= tolerance && result.t < 0.5; // 最初の50%以内に緩和（30%から50%に）
  }
}

/// スムーズトレーシング用のカスタムペインター
/// AnimCJK輪郭データを使った書道スタイルペインター
class CalligraphyTracingPainter extends CustomPainter {
  final List<String> outlinePaths;
  final double progress;
  final int currentStrokeIndex;
  final Color fillColor;
  final Color backgroundColor;
  final String character;
  final Function(String, int) getOutlineIndicesForStroke;
  final Function(String, int) getSegmentRatios;
  final Offset? arrowPosition;
  
  // デバッグ用フレームカウンター
  static final int _debugFrameCount = 0;
  
  // 描画済みの最大オフセットを記憶（ストローク別）
  static final Map<String, double> _maxDrawnOffsets = {};
  
  
  CalligraphyTracingPainter({
    required this.outlinePaths,
    required this.progress,
    required this.currentStrokeIndex,
    required this.fillColor,
    required this.backgroundColor,
    required this.character,
    required this.getOutlineIndicesForStroke,
    required this.getSegmentRatios,
    this.arrowPosition,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final scaleFactor = size.width / 1024; // AnimCJKは1024x1024
    
    // デバッグ出力を簡略化
    
    // まず全ての文字を薄い水色で表示
    for (int i = 0; i < outlinePaths.length; i++) {
      _drawOutlinePath(canvas, outlinePaths[i], scaleFactor, backgroundColor, 1.0);
    }
    
    // 完了済みのストロークに対応する輪郭を青色で上書き描画
    for (int strokeIdx = 0; strokeIdx < currentStrokeIndex; strokeIdx++) {
      final outlineIndices = getOutlineIndicesForStroke(character, strokeIdx);
      for (int outlineIdx in outlineIndices) {
        if (outlineIdx < outlinePaths.length) {
          _drawOutlinePath(canvas, outlinePaths[outlineIdx], scaleFactor, fillColor, 1.0);
        }
      }
    }
    
    // 現在のストロークに対応する輪郭のみ描画
    final currentOutlineIndices = getOutlineIndicesForStroke(character, currentStrokeIndex);
    
    // 完了済みストロークに含まれる輪郭を除外
    final completedOutlineIndices = <int>{};
    for (int strokeIdx = 0; strokeIdx < currentStrokeIndex; strokeIdx++) {
      final indices = getOutlineIndicesForStroke(character, strokeIdx);
      completedOutlineIndices.addAll(indices);
    }
    
    
    // 現在のストロークに対応する輪郭のみ処理（完了済みは除外）
    for (int i = 0; i < currentOutlineIndices.length; i++) {
      final outlineIdx = currentOutlineIndices[i];
      
      // 既に完了済みストロークで描画された輪郭はスキップ
      if (completedOutlineIndices.contains(outlineIdx)) {
        continue;
      }
      
      if (outlineIdx < outlinePaths.length) {
        
        
        // progressが0より大きい場合のみ描画
        if (progress > 0) {
          _drawPartialOutlinePath(canvas, outlinePaths[outlineIdx], scaleFactor, fillColor, progress, segmentIndex: i, targetPosition: arrowPosition);
        }
      } else {
        // アウトラインインデックスが範囲外の場合のエラー
      }
    }
  }
  
  /// 矢印と対応する輪郭の進行度を正確に計算
  double _calculateSegmentProgress(double totalProgress, int segmentIndex, int totalSegments) {
    if (totalSegments == 1) {
      return totalProgress;
    }
    
    // 複数の輪郭がある場合の処理
    final segmentSize = 1.0 / totalSegments;
    final segmentStart = segmentIndex * segmentSize;
    final segmentEnd = (segmentIndex + 1) * segmentSize;
    
    double result;
    if (totalProgress <= segmentStart) {
      result = 0.0; // まだこのセグメントの開始前
    } else if (totalProgress >= segmentEnd) {
      result = 1.0; // このセグメントは完了
    } else {
      result = (totalProgress - segmentStart) / segmentSize;
    }
    
    
    return result;
  }
  
  /// 実際のパス長比率を使用した正確なセグメント進行度計算
  double _calculateSegmentProgressWithRatios(double totalProgress, int segmentIndex, List<double> ratios) {
    if (ratios.length == 1) {
      return totalProgress;
    }
    
    // 累積比率を計算
    double cumulativeStart = 0.0;
    for (int i = 0; i < segmentIndex; i++) {
      cumulativeStart += ratios[i];
    }
    final segmentRatio = ratios[segmentIndex];
    final cumulativeEnd = cumulativeStart + segmentRatio;
    
    
    double result;
    if (totalProgress < cumulativeStart) {
      result = 0.0;
    } else if (totalProgress >= cumulativeEnd) {
      result = 1.0;
    } else {
      result = (totalProgress - cumulativeStart) / segmentRatio;
    }
    
    // セグメント1のデバッグ情報を追加
    if (_debugFrameCount % 50 == 0 && segmentIndex == 1 && totalProgress > 0.5) {
      print('🔍 Segment 1 FOCUS: total=${totalProgress.toStringAsFixed(3)}, cumStart=${cumulativeStart.toStringAsFixed(3)}');
      print('    condition: total < cumStart? ${totalProgress < cumulativeStart}, result=${result.toStringAsFixed(3)}');
    }
    
    if (_debugFrameCount % 150 == 0) {
      print('📊 Ratio calc: total=${totalProgress.toStringAsFixed(3)}, seg=$segmentIndex');
      print('    ratios=$ratios');
      print('    cumStart=${cumulativeStart.toStringAsFixed(3)}, cumEnd=${cumulativeEnd.toStringAsFixed(3)}');
      print('    segRatio=${segmentRatio.toStringAsFixed(3)}, result=${result.toStringAsFixed(3)}');
    }
    
    return result;
  }
  
  void _drawOutlinePath(Canvas canvas, String pathData, double scaleFactor, Color color, double alpha) {
    final path = _parseAnimCJKPath(pathData, scaleFactor);
    final paint = Paint()
      ..color = color.withOpacity(alpha)
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(path, paint);
  }
  
  void _drawPartialOutlinePath(Canvas canvas, String pathData, double scaleFactor, Color color, double progress, {int? segmentIndex, Offset? targetPosition}) {
    if (progress <= 0.0) return;
    if (progress >= 1.0) {
      _drawOutlinePath(canvas, pathData, scaleFactor, color, 1.0);
      return;
    }
    
    // 輪郭をアルファマスクとして使用し、太い線をクリップ
    final outlinePath = _parseAnimCJKPath(pathData, scaleFactor);
    
    // HiraganaDataManagerから現在のストロークパスを取得
    String strokePath = '';
    final manager = HiraganaDataManager();
    if (manager.isSupported(character)) {
      final strokePaths = manager.getStrokePaths(character);
      if (currentStrokeIndex < strokePaths.length) {
        strokePath = strokePaths[currentStrokeIndex];
      }
    }
    
    // ストロークパスが取得できない場合は従来の方法にフォールバック
    if (strokePath.isEmpty) {
      strokePath = _getCorrespondingStrokePath(pathData);
    }
    
    if (strokePath.isNotEmpty) {
      // 輪郭でクリップしてから太い線を描画
      canvas.save();
      canvas.clipPath(outlinePath);
      _drawStrokeDashAnimation(canvas, strokePath, scaleFactor, color, progress, segmentIndex: segmentIndex, targetPosition: targetPosition);
      canvas.restore();
    } else {
      // フォールバック
      _drawOutlinePath(canvas, pathData, scaleFactor, color, progress);
    }
  }
  
  /// ベクトルベース描画：開始点からターゲット位置まで直接描画
  void _drawStrokeDashAnimation(Canvas canvas, String strokePath, double scaleFactor, Color color, double progress, {int? segmentIndex, Offset? targetPosition}) {
    final path = _parseStrokePath(strokePath, scaleFactor);
    // 先にリスト化してイテレータの問題を回避
    final metricsList = path.computeMetrics().toList();
    
    
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 120.0 * scaleFactor  // 80から120に増やす
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    
    Offset? paintEndPoint;
    
    for (final metric in metricsList) {
      if (targetPosition != null) {
        // ベクトルベース：ターゲット位置まで直接描画
        final startPoint = metric.getTangentForOffset(0.0)?.position ?? Offset.zero;
        final targetDistance = (targetPosition - startPoint).distance;
        final totalLength = metric.length;
        
        // ターゲット位置に最も近いパス上の点を見つける
        double closestOffset = 0.0;
        double minDistance = double.infinity;
        
        // パスを10%刻みでサンプリングして最も近い点を探す
        for (double t = 0.0; t <= 1.0; t += 0.01) {
          final testOffset = t * totalLength;
          final testPoint = metric.getTangentForOffset(testOffset)?.position;
          if (testPoint != null) {
            final distance = (testPoint - targetPosition).distance;
            if (distance < minDistance) {
              minDistance = distance;
              closestOffset = testOffset;
            }
          }
        }
        
        
        // 描画済み最大オフセットを記憶して前に戻らないようにする
        final strokeKey = '$character-$currentStrokeIndex-$segmentIndex';
        final lastMaxOffset = _maxDrawnOffsets[strokeKey] ?? 0.0;
        
        // 前に戻ることを防ぐ：新しいオフセットが前回より大きい場合のみ更新
        final actualOffset = math.max(closestOffset, lastMaxOffset);
        _maxDrawnOffsets[strokeKey] = actualOffset;
        
        // 開始点から実際のオフセットまで描画
        if (actualOffset > 0) {
          final extractedPath = metric.extractPath(0.0, actualOffset);
          canvas.drawPath(extractedPath, paint);
          paintEndPoint = metric.getTangentForOffset(actualOffset)?.position;
        }
        
        
      } else {
        // フォールバック：従来のprogress方式
        final totalLength = metric.length;
        final drawLength = totalLength * progress;
        
        if (drawLength > 0) {
          final extractedPath = metric.extractPath(0.0, drawLength);
          canvas.drawPath(extractedPath, paint);
          paintEndPoint = metric.getTangentForOffset(drawLength)?.position;
        }
      }
    }
    
    // デバッグ情報
    if (paintEndPoint != null && _debugFrameCount % 50 == 0) {
    }
  }
  
  // デバッグ用のグローバル変数
  static Offset? _lastPaintPosition;
  
  /// ストロークパスをパース（M, L, C コマンド対応）
  Path _parseStrokePath(String pathData, double scaleFactor) {
    final path = Path();
    final parts = pathData.split(RegExp(r'(?=[ML])'));
    
    for (String part in parts) {
      if (part.isEmpty) continue;
      
      final command = part[0];
      final coords = part.substring(1).trim().split(RegExp(r'[,\s]+'))
          .where((s) => s.isNotEmpty)
          .map((s) => double.tryParse(s) ?? 0.0)
          .toList();
      
      switch (command) {
        case 'M':
          if (coords.length >= 2) {
            path.moveTo(coords[0] * scaleFactor, coords[1] * scaleFactor);
          }
          // Mコマンドの後に続く座標はLコマンドとして処理
          for (int i = 2; i < coords.length; i += 2) {
            if (i + 1 < coords.length) {
              path.lineTo(coords[i] * scaleFactor, coords[i + 1] * scaleFactor);
            }
          }
          break;
        case 'L':
          for (int i = 0; i < coords.length; i += 2) {
            if (i + 1 < coords.length) {
              path.lineTo(coords[i] * scaleFactor, coords[i + 1] * scaleFactor);
            }
          }
          break;
        case 'C':
          for (int i = 0; i < coords.length; i += 6) {
            if (i + 5 < coords.length) {
              path.cubicTo(
                coords[i] * scaleFactor, coords[i + 1] * scaleFactor,
                coords[i + 2] * scaleFactor, coords[i + 3] * scaleFactor,
                coords[i + 4] * scaleFactor, coords[i + 5] * scaleFactor,
              );
            }
          }
          break;
      }
    }
    
    return path;
  }
  
  /// 実際の描画方向に沿った進行度マスクを作成
  Path _createProgressMask(String outlinePathData, double scaleFactor, double progress) {
    // AnimCJKの対応する描画パスを取得（簡易版）
    String strokePath = _getCorrespondingStrokePath(outlinePathData);
    
    // 描画パスから進行度に応じた点を取得
    final drawingPoints = _getPathPoints(strokePath, scaleFactor);
    if (drawingPoints.isEmpty) {
      // フォールバック：描画パスがない場合は単純な左右クリッピング
      final fullPath = _parseAnimCJKPath(outlinePathData, scaleFactor);
      final bounds = fullPath.getBounds();
      final clipWidth = bounds.width * progress;
      final clipRect = Rect.fromLTWH(bounds.left, bounds.top, clipWidth, bounds.height);
      return Path()..addRect(clipRect);
    }
    
    // 進行度に応じた終点を計算（より細かい制御）
    final exactProgress = drawingPoints.length * progress;
    final targetIndex = exactProgress.floor();
    final subProgress = exactProgress - targetIndex; // 0.0-1.0の小数部
    
    if (targetIndex <= 0 && subProgress <= 0) return Path();
    
    final maskPath = Path();
    final baseRadius = 60.0 * scaleFactor; // マスクの基本半径
    
    // 完全に進行した点を塗りつぶす
    for (int i = 0; i < targetIndex && i < drawingPoints.length; i++) {
      final point = drawingPoints[i];
      maskPath.addOval(Rect.fromCircle(center: point, radius: baseRadius));
      
      // 隣接点との間を補間して連続性を保つ
      if (i + 1 < drawingPoints.length) {
        final nextPoint = drawingPoints[i + 1];
        final distance = (nextPoint - point).distance;
        final steps = (distance / (baseRadius * 0.5)).ceil().clamp(2, 10);
        
        for (int step = 1; step < steps; step++) {
          final t = step / steps;
          final interpolated = Offset.lerp(point, nextPoint, t)!;
          maskPath.addOval(Rect.fromCircle(center: interpolated, radius: baseRadius * 0.9));
        }
      }
    }
    
    // 部分的に進行した最後の点（グラデーション効果）
    if (targetIndex < drawingPoints.length && subProgress > 0) {
      final currentPoint = drawingPoints[targetIndex];
      final fadeRadius = baseRadius * subProgress;
      
      // グラデーション効果のために複数の小さな円を作成
      for (double r = fadeRadius; r > 0; r -= 5 * scaleFactor) {
        final alpha = (r / fadeRadius) * 0.3; // フェード効果
        if (alpha > 0.05) {
          maskPath.addOval(Rect.fromCircle(center: currentPoint, radius: r));
        }
      }
      
      // 次の点への部分的な進行
      if (targetIndex + 1 < drawingPoints.length) {
        final nextPoint = drawingPoints[targetIndex + 1];
        final partialPoint = Offset.lerp(currentPoint, nextPoint, subProgress)!;
        maskPath.addOval(Rect.fromCircle(center: partialPoint, radius: fadeRadius));
      }
    }
    
    return maskPath;
  }
  
  /// 輪郭パスに対応するストロークパス（SVGスタイル）を取得
  String _getCorrespondingStrokePath(String outlinePathData) {
    // 輪郭パスの特徴から対応するストロークパスを判定
    
    // 「あ」のストローク
    if (outlinePathData.contains('M660 211')) {
      return 'M 174,258 251,308 440,306 697,241'; // あ の1画目
    } else if (outlinePathData.contains('M334 128')) {
      return 'M 331,137 420,185 373,388 367,632 409,728 431,777'; // あ の2画目
    } else if (outlinePathData.contains('M559 431') || outlinePathData.contains('M602 484')) {
      // 3画目：全体を1つのストロークとして扱う
      return 'M 570,440 610,484 460,727 200,836 181,682 342,556 466,514 641,499 754,520 838,606 845,763 703,869 508,922';
    }
    
    // 「い」のストローク - AnimCJKの実際のストロークパス
    else if (outlinePathData.contains('M103 237')) {
      return 'M 95,249 149,282 222,589 272,704 369,788 372,702 406,628'; // い の1画目（左側の縦線）
    } else if (outlinePathData.contains('M671 260')) {
      return 'M 678,273 754,342 836,472 867,639'; // い の2画目（右側の曲線）
    }
    
    // 「う」のストローク
    else if (outlinePathData.contains('M406 101')) {
      return 'M 400,113 654,205'; // う の1画目（上の横線）
    } else if (outlinePathData.contains('M581 343')) {
      return 'M 213,423 286,450 494,372 610,360 684,394 718,462 672,690 492,911'; // う の2画目（大きな曲線）
    }
    
    // 「え」のストローク
    else if (outlinePathData.contains('M406 101')) {
      return 'M 400,113 654,205'; // え の1画目（上の横線）
    } else if (outlinePathData.contains('M620 313')) {
      return 'M 197,436 277,460 618,334 654,363 608,380 203,762 204,804 333,709 407,692 482,722 596,836 793,835 855,853'; // え の2画目
    }
    
    // 「お」のストローク
    else if (outlinePathData.contains('M504 281')) {
      return 'M 111.6,323.2 174,363.7 327,362.1 535.2,309.4'; // お の1画目
    } else if (outlinePathData.contains('M295 89') || outlinePathData.contains('M643 503')) {
      return 'M 287,100 338,140 311,847 282,898 234,906 218,900 165,836 158,764 243,671 525,536 748,543 835,691 763,820 588,917'; // お の2画目
    } else if (outlinePathData.contains('M713 177')) {
      return 'M 710,189 794,229 868,350'; // お の3画目
    }
    
    // 「か」のストローク
    else if (outlinePathData.contains('M460 355')) {
      return 'M 104,461 154,476 413,401 492,396 544,419 572,511 409,881 319,786'; // か の1画目
    } else if (outlinePathData.contains('M350 111')) {
      return 'M 354,131 392,199 143,835'; // か の2画目
    } else if (outlinePathData.contains('M648 261')) {
      return 'M 649,283 836,441 902,626'; // か の3画目
    }
    
    return '';
  }
  
  /// パス文字列から点のリストを取得
  List<Offset> _getPathPoints(String pathData, double scaleFactor) {
    final points = <Offset>[];
    if (pathData.isEmpty) return points;
    
    final coords = pathData.replaceAll(RegExp(r'[ML,]'), ' ').trim().split(RegExp(r'\s+'));
    for (int i = 0; i < coords.length - 1; i += 2) {
      final x = double.tryParse(coords[i]);
      final y = double.tryParse(coords[i + 1]);
      if (x != null && y != null) {
        points.add(Offset(x * scaleFactor, y * scaleFactor));
      }
    }
    return points;
  }
  
  Path _parseAnimCJKPath(String pathData, double scaleFactor) {
    final path = Path();
    final commands = pathData.split(RegExp(r'(?=[MLHVCSQTAZ])'));
    
    for (String command in commands) {
      if (command.isEmpty) continue;
      
      final type = command[0];
      final coords = command.substring(1).trim().split(RegExp(r'[,\s]+'))
          .where((s) => s.isNotEmpty)
          .map((s) => double.tryParse(s) ?? 0.0)
          .toList();
      
      switch (type) {
        case 'M':
          if (coords.length >= 2) {
            path.moveTo(coords[0] * scaleFactor, coords[1] * scaleFactor);
          }
          break;
        case 'C':
          for (int i = 0; i < coords.length; i += 6) {
            if (i + 5 < coords.length) {
              path.cubicTo(
                coords[i] * scaleFactor, coords[i + 1] * scaleFactor,
                coords[i + 2] * scaleFactor, coords[i + 3] * scaleFactor,
                coords[i + 4] * scaleFactor, coords[i + 5] * scaleFactor,
              );
            }
          }
          break;
        case 'Z':
          path.close();
          break;
      }
    }
    
    return path;
  }
  
  @override
  bool shouldRepaint(CalligraphyTracingPainter oldDelegate) {
    // ストロークが変わったら該当する描画オフセットをリセット
    if (currentStrokeIndex != oldDelegate.currentStrokeIndex) {
      _maxDrawnOffsets.clear(); // 全リセット（シンプルな方法）
    }
    
    return progress != oldDelegate.progress ||
           currentStrokeIndex != oldDelegate.currentStrokeIndex ||
           fillColor != oldDelegate.fillColor;
  }
}

class SmoothTracingPainter extends CustomPainter {
  final BezierStroke stroke;
  final double progress;
  final Color strokeColor;
  final Color backgroundColor;
  final double strokeWidth;
  
  SmoothTracingPainter({
    required this.stroke,
    required this.progress,
    required this.strokeColor,
    required this.backgroundColor,
    this.strokeWidth = 16.0, // 8.0から16.0に増加（AnimCJK相当）
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 4.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    
    // 背景ストローク（薄い色）- 全体を表示
    final fullPath = stroke.toPath();
    canvas.drawPath(fullPath, backgroundPaint);
    
    // 進行中のストローク - BezierStrokeの座標系を直接使用して矢印と同期
    if (progress > 0.0 && stroke.segments.isNotEmpty) {
      final progressPath = Path();
      var totalProgress = 0.0;
      var currentSegmentProgress = 0.0;
      
      // プログレスに応じてベジェセグメントを描画
      for (int i = 0; i < stroke.segments.length; i++) {
        final segment = stroke.segments[i];
        final segmentWeight = 1.0 / stroke.segments.length; // 均等分割
        final segmentStart = totalProgress;
        final segmentEnd = segmentStart + segmentWeight;
        
        if (progress > segmentStart) {
          if (progress >= segmentEnd) {
            // セグメント全体を描画
            currentSegmentProgress = 1.0;
          } else {
            // セグメント部分を描画
            currentSegmentProgress = (progress - segmentStart) / segmentWeight;
          }
          
          // ベジェセグメントをパスに追加
          _addBezierSegmentToPath(progressPath, segment, currentSegmentProgress, i == 0);
        }
        
        totalProgress = segmentEnd;
        if (progress < segmentEnd) break;
      }
      
      canvas.drawPath(progressPath, paint);
    }
  }
  
  /// ベジェセグメントをパスに追加（矢印の座標系と一致）
  void _addBezierSegmentToPath(Path path, BezierSegment segment, double t, bool isFirst) {
    if (isFirst) {
      path.moveTo(segment.start.dx, segment.start.dy);
    }
    
    if (t >= 1.0) {
      // セグメント全体
      path.cubicTo(
        segment.control1.dx, segment.control1.dy,
        segment.control2.dx, segment.control2.dy,
        segment.end.dx, segment.end.dy,
      );
    } else {
      // セグメントの一部（De Casteljau's algorithm使用）
      final endPoint = segment.getPoint(t);
      final newControl1 = segment.start + (segment.control1 - segment.start) * t;
      final newControl2 = segment.control1 + (segment.control2 - segment.control1) * t;
      
      path.cubicTo(
        newControl1.dx, newControl1.dy,
        newControl2.dx, newControl2.dy,
        endPoint.dx, endPoint.dy,
      );
    }
  }
  
  @override
  bool shouldRepaint(SmoothTracingPainter oldDelegate) {
    return progress != oldDelegate.progress ||
           strokeColor != oldDelegate.strokeColor ||
           backgroundColor != oldDelegate.backgroundColor;
  }
}