import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/shape_matching_models.dart';

// 図形描画用ペインター
class GeoShapePainter extends CustomPainter {
  final TileSpec spec;
  final bool isSelected;
  final TileHighlight highlight;

  static const Color strokeColor = Color(0xFF6B6456); // 濃いグレー
  static const double strokeWidth = 3.0;
  static const double selectedStrokeWidth = 6.0;
  static const Color selectedColor = Color(0xFF4A90E2); // 選択時の青
  static const Color correctColor = Color(0xFF4CAF50); // 正解の緑
  static const Color wrongColor = Color(0xFFE53935); // 不正解の赤

  GeoShapePainter({
    required this.spec,
    this.isSelected = false,
    this.highlight = TileHighlight.none,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final shortestSide = math.min(size.width, size.height);
    final shapeSize = shortestSide * 0.75; // 余白を考慮

    // 背景（選択状態やハイライト表示）
    _drawBackground(canvas, size);

    // 図形を描画
    _drawShape(canvas, center, shapeSize);
  }

  void _drawBackground(Canvas canvas, Size size) {
    // 選択枠やハイライト枠を描画
    if (highlight != TileHighlight.none || isSelected) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = selectedStrokeWidth;

      if (highlight == TileHighlight.correct) {
        paint.color = correctColor;
      } else if (highlight == TileHighlight.wrong) {
        paint.color = wrongColor;
      } else if (isSelected) {
        paint.color = selectedColor;
      }

      final rect = Rect.fromLTWH(2, 2, size.width - 4, size.height - 4);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(8)),
        paint,
      );
    }
  }

  void _drawShape(Canvas canvas, Offset center, double size) {
    final color = Color(spec.color.colorValue);
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    switch (spec.shape) {
      case GeoShape.star:
        _drawStar(canvas, center, size, fillPaint, strokePaint);
        break;
      case GeoShape.triangle:
        _drawTriangle(canvas, center, size, fillPaint, strokePaint);
        break;
      case GeoShape.circle:
        _drawCircle(canvas, center, size, fillPaint, strokePaint);
        break;
      case GeoShape.square:
        _drawSquare(canvas, center, size, fillPaint, strokePaint);
        break;
      case GeoShape.pentagon:
        _drawPentagon(canvas, center, size, fillPaint, strokePaint);
        break;
    }
  }

  void _drawStar(Canvas canvas, Offset center, double size, Paint fillPaint, Paint strokePaint) {
    final outerRadius = size / 2;
    final innerRadius = outerRadius * 0.44;
    
    // 外側の星を描画
    _drawStarPath(canvas, center, outerRadius, innerRadius, fillPaint, strokePaint);
    
    // 二重の場合は内側の星も描画
    if (spec.variant == GeoVariant.double_) {
      final innerFillPaint = Paint()
        ..color = _getDarkerColor(fillPaint.color)
        ..style = PaintingStyle.fill;
      
      _drawStarPath(
        canvas, 
        center, 
        outerRadius * 0.6, 
        innerRadius * 0.6, 
        innerFillPaint, 
        strokePaint
      );
    }
  }

  void _drawStarPath(Canvas canvas, Offset center, double outerRadius, double innerRadius, Paint fillPaint, Paint strokePaint) {
    final path = Path();
    const numPoints = 5;
    
    for (int i = 0; i < numPoints * 2; i++) {
      final angle = (i * math.pi / numPoints) - math.pi / 2;
      final radius = i.isEven ? outerRadius : innerRadius;
      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    
    path.close();
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  void _drawTriangle(Canvas canvas, Offset center, double size, Paint fillPaint, Paint strokePaint) {
    final radius = size / 2;
    
    // 外側の三角形
    _drawTrianglePath(canvas, center, radius, fillPaint, strokePaint);
    
    // 二重の場合
    if (spec.variant == GeoVariant.double_) {
      final innerFillPaint = Paint()
        ..color = _getDarkerColor(fillPaint.color)
        ..style = PaintingStyle.fill;
      
      _drawTrianglePath(canvas, center, radius * 0.65, innerFillPaint, strokePaint);
    }
  }

  void _drawTrianglePath(Canvas canvas, Offset center, double radius, Paint fillPaint, Paint strokePaint) {
    final path = Path();
    
    // 正三角形の頂点（上向き）
    final points = [
      Offset(center.dx, center.dy - radius), // 頂点
      Offset(center.dx - radius * math.cos(math.pi / 6), center.dy + radius * math.sin(math.pi / 6)), // 左下
      Offset(center.dx + radius * math.cos(math.pi / 6), center.dy + radius * math.sin(math.pi / 6)), // 右下
    ];
    
    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.close();
    
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  void _drawCircle(Canvas canvas, Offset center, double size, Paint fillPaint, Paint strokePaint) {
    final radius = size / 2;
    
    // 外側の円
    canvas.drawCircle(center, radius, fillPaint);
    canvas.drawCircle(center, radius, strokePaint);
    
    // 二重の場合
    if (spec.variant == GeoVariant.double_) {
      final innerFillPaint = Paint()
        ..color = _getDarkerColor(fillPaint.color)
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(center, radius * 0.6, innerFillPaint);
      canvas.drawCircle(center, radius * 0.6, strokePaint);
    }
  }

  void _drawSquare(Canvas canvas, Offset center, double size, Paint fillPaint, Paint strokePaint) {
    // 外側の正方形
    _drawSquarePath(canvas, center, size, fillPaint, strokePaint);
    
    // 二重の場合
    if (spec.variant == GeoVariant.double_) {
      final innerFillPaint = Paint()
        ..color = _getDarkerColor(fillPaint.color)
        ..style = PaintingStyle.fill;
      
      _drawSquarePath(canvas, center, size * 0.7, innerFillPaint, strokePaint);
    }
  }

  void _drawSquarePath(Canvas canvas, Offset center, double size, Paint fillPaint, Paint strokePaint) {
    final rect = Rect.fromCenter(center: center, width: size, height: size);
    canvas.drawRect(rect, fillPaint);
    canvas.drawRect(rect, strokePaint);
  }

  void _drawPentagon(Canvas canvas, Offset center, double size, Paint fillPaint, Paint strokePaint) {
    final radius = size / 2;
    
    // 外側の五角形
    _drawPentagonPath(canvas, center, radius, fillPaint, strokePaint);
    
    // 二重の場合
    if (spec.variant == GeoVariant.double_) {
      final innerFillPaint = Paint()
        ..color = _getDarkerColor(fillPaint.color)
        ..style = PaintingStyle.fill;
      
      _drawPentagonPath(canvas, center, radius * 0.72, innerFillPaint, strokePaint);
    }
  }

  void _drawPentagonPath(Canvas canvas, Offset center, double radius, Paint fillPaint, Paint strokePaint) {
    final path = Path();
    const numSides = 5;
    
    for (int i = 0; i < numSides; i++) {
      final angle = (i * 2 * math.pi / numSides) - math.pi / 2; // 頂点を上に
      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    
    path.close();
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  // 色を暗くする（二重図形の内側用）
  Color _getDarkerColor(Color color) {
    final hslColor = HSLColor.fromColor(color);
    return hslColor.withLightness((hslColor.lightness * 0.85).clamp(0.0, 1.0)).toColor();
  }

  @override
  bool shouldRepaint(GeoShapePainter oldDelegate) {
    return spec != oldDelegate.spec || 
           isSelected != oldDelegate.isSelected ||
           highlight != oldDelegate.highlight;
  }
}

// 図形ウィジェット
class GeoShapeWidget extends StatelessWidget {
  final TileSpec spec;
  final double size;
  final bool isSelected;
  final TileHighlight highlight;
  final VoidCallback? onTap;

  const GeoShapeWidget({
    Key? key,
    required this.spec,
    this.size = 72,
    this.isSelected = false,
    this.highlight = TileHighlight.none,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: CustomPaint(
          painter: GeoShapePainter(
            spec: spec,
            isSelected: isSelected,
            highlight: highlight,
          ),
        ),
      ),
    );
  }
}