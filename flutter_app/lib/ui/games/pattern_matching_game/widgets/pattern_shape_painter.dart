import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/pattern_matching_models.dart';

/// パターン図形描画用ペインター
class PatternShapePainter extends CustomPainter {
  final PatternSpec spec;
  final bool isSelected;
  final bool isEmptyBox; // 赤枠の空欄かどうか

  static const Color strokeColor = Color(0xFF6B6456); // 濃いグレー
  static const double strokeWidth = 3.0;
  static const double selectedStrokeWidth = 6.0;
  static const Color selectedColor = Color(0xFF4A90E2); // 選択時の青
  static const Color emptyBoxColor = Color(0xFFE53935); // 空欄の赤

  PatternShapePainter({
    required this.spec,
    this.isSelected = false,
    this.isEmptyBox = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final shortestSide = math.min(size.width, size.height);
    final shapeSize = shortestSide * 0.7; // 余白を考慮

    // 背景（選択状態や空欄表示）
    _drawBackground(canvas, size);

    // 図形を描画
    _drawShape(canvas, center, shapeSize);
  }

  void _drawBackground(Canvas canvas, Size size) {
    // 選択枠や空欄枠を描画
    if (isEmptyBox || isSelected) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = selectedStrokeWidth;

      if (isEmptyBox) {
        paint.color = emptyBoxColor;
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
    final isFilled = spec.fillType == PatternFillType.filled;
    final isDouble = spec.fillType == PatternFillType.double_;
    final isOutline = spec.fillType == PatternFillType.outline;

    // 塗りつぶし用ペイント（常に色を付ける）
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // 枠線用ペイント
    final strokePaint = Paint()
      ..color = isOutline ? strokeColor : strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    switch (spec.shape) {
      case PatternShape.circle:
        _drawCircle(canvas, center, size, fillPaint, strokePaint, isFilled, isDouble, isOutline);
        break;
      case PatternShape.triangle:
        _drawTriangle(canvas, center, size, fillPaint, strokePaint, isFilled, isDouble, isOutline);
        break;
      case PatternShape.square:
        _drawSquare(canvas, center, size, fillPaint, strokePaint, isFilled, isDouble, isOutline);
        break;
      case PatternShape.star:
        _drawStar(canvas, center, size, fillPaint, strokePaint, isFilled, isDouble, isOutline);
        break;
    }
  }

  void _drawCircle(Canvas canvas, Offset center, double size, Paint fillPaint,
      Paint strokePaint, bool isFilled, bool isDouble, bool isOutline) {
    final radius = size / 2;

    // 常に塗りつぶす
    canvas.drawCircle(center, radius, fillPaint);

    // 枠線を描画
    canvas.drawCircle(center, radius, strokePaint);

    // 二重の場合は内側の円も描画
    if (isDouble) {
      final innerRadius = radius * 0.6;
      final innerFillPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, innerRadius, innerFillPaint);
      canvas.drawCircle(center, innerRadius, strokePaint);
    }
  }

  void _drawTriangle(Canvas canvas, Offset center, double size, Paint fillPaint,
      Paint strokePaint, bool isFilled, bool isDouble, bool isOutline) {
    final radius = size / 2;
    final path = Path();

    // 正三角形の頂点（上向き）
    final points = [
      Offset(center.dx, center.dy - radius), // 頂点
      Offset(center.dx - radius * math.cos(math.pi / 6),
          center.dy + radius * math.sin(math.pi / 6)), // 左下
      Offset(center.dx + radius * math.cos(math.pi / 6),
          center.dy + radius * math.sin(math.pi / 6)), // 右下
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.close();

    // 常に塗りつぶす
    canvas.drawPath(path, fillPaint);

    // 枠線を描画
    canvas.drawPath(path, strokePaint);

    // 二重の場合は内側の三角形も描画
    if (isDouble) {
      final innerRadius = radius * 0.6;
      final innerPath = Path();
      final innerPoints = [
        Offset(center.dx, center.dy - innerRadius),
        Offset(center.dx - innerRadius * math.cos(math.pi / 6),
            center.dy + innerRadius * math.sin(math.pi / 6)),
        Offset(center.dx + innerRadius * math.cos(math.pi / 6),
            center.dy + innerRadius * math.sin(math.pi / 6)),
      ];
      innerPath.moveTo(innerPoints[0].dx, innerPoints[0].dy);
      for (int i = 1; i < innerPoints.length; i++) {
        innerPath.lineTo(innerPoints[i].dx, innerPoints[i].dy);
      }
      innerPath.close();
      final innerFillPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawPath(innerPath, innerFillPaint);
      canvas.drawPath(innerPath, strokePaint);
    }
  }

  void _drawSquare(Canvas canvas, Offset center, double size, Paint fillPaint,
      Paint strokePaint, bool isFilled, bool isDouble, bool isOutline) {
    final rect = Rect.fromCenter(center: center, width: size, height: size);

    // 常に塗りつぶす
    canvas.drawRect(rect, fillPaint);

    // 枠線を描画
    canvas.drawRect(rect, strokePaint);

    // 二重の場合は内側の四角形も描画
    if (isDouble) {
      final innerRect = Rect.fromCenter(center: center, width: size * 0.6, height: size * 0.6);
      final innerFillPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawRect(innerRect, innerFillPaint);
      canvas.drawRect(innerRect, strokePaint);
    }
  }

  void _drawStar(Canvas canvas, Offset center, double size, Paint fillPaint,
      Paint strokePaint, bool isFilled, bool isDouble, bool isOutline) {
    final outerRadius = size / 2;
    final innerRadius = outerRadius * 0.44;
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

    // 常に塗りつぶす
    canvas.drawPath(path, fillPaint);

    // 枠線を描画
    canvas.drawPath(path, strokePaint);

    // 二重の場合は内側の星も描画
    if (isDouble) {
      final innerOuterRadius = outerRadius * 0.6;
      final innerInnerRadius = innerRadius * 0.6;
      final innerPath = Path();
      for (int i = 0; i < numPoints * 2; i++) {
        final angle = (i * math.pi / numPoints) - math.pi / 2;
        final radius = i.isEven ? innerOuterRadius : innerInnerRadius;
        final point = Offset(
          center.dx + radius * math.cos(angle),
          center.dy + radius * math.sin(angle),
        );
        if (i == 0) {
          innerPath.moveTo(point.dx, point.dy);
        } else {
          innerPath.lineTo(point.dx, point.dy);
        }
      }
      innerPath.close();
      final innerFillPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawPath(innerPath, innerFillPaint);
      canvas.drawPath(innerPath, strokePaint);
    }
  }

  @override
  bool shouldRepaint(PatternShapePainter oldDelegate) {
    return spec != oldDelegate.spec ||
        isSelected != oldDelegate.isSelected ||
        isEmptyBox != oldDelegate.isEmptyBox;
  }
}

/// パターン図形ウィジェット
class PatternShapeWidget extends StatelessWidget {
  final PatternSpec spec;
  final double size;
  final bool isSelected;
  final bool isEmptyBox;
  final VoidCallback? onTap;

  const PatternShapeWidget({
    Key? key,
    required this.spec,
    this.size = 72,
    this.isSelected = false,
    this.isEmptyBox = false,
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
          painter: PatternShapePainter(
            spec: spec,
            isSelected: isSelected,
            isEmptyBox: isEmptyBox,
          ),
        ),
      ),
    );
  }
}
