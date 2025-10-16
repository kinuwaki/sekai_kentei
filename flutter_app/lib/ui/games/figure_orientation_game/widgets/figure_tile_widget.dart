import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // debugPrintのため
import 'dart:math' as math;
import '../models/figure_orientation_models.dart';

class FigureAnswerButton extends StatelessWidget {
  final FigureOrientationOption option;
  final VoidCallback? onPressed;
  final bool isSelected;
  final bool showResult;
  
  const FigureAnswerButton({
    super.key,
    required this.option,
    this.onPressed,
    this.isSelected = false,
    this.showResult = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 制約の有効性をチェック
        if (!constraints.hasBoundedWidth || !constraints.hasBoundedHeight ||
            constraints.maxWidth <= 0 || constraints.maxHeight <= 0) {
          // 無効な制約の場合はフォールバック
          final screenSize = MediaQuery.of(context).size;
          final fallbackSize = screenSize.width * 0.2;

          return Container(
            width: fallbackSize.toDouble(),
            height: fallbackSize.toDouble(),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              gradient: _getGradient(),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _buildTransformedImage(),
                ),
              ),
            ),
          );
        }

        // 利用可能な幅を4つの選択肢で分割し、マージンを考慮
        final availableWidth = constraints.maxWidth;
        final availableHeight = constraints.maxHeight;

        // 固定マージンを使用（動的計算によるNaN防止）
        const margin = 8.0;

        // 4つのボタンに均等に幅を分配（マージン分を差し引く）
        final totalMarginWidth = margin * 2 * 4; // 各ボタンの左右マージン
        final buttonWidth = math.max(0, (availableWidth - totalMarginWidth) / 4);

        // 正方形を保つため、高さも同じにする（ただし制約内に収める）
        final maxButtonHeight = availableHeight * 0.8;
        final buttonSize = math.max(0, math.min(buttonWidth, maxButtonHeight));

        return Container(
          width: buttonSize.toDouble(),
          height: buttonSize.toDouble(),
          margin: const EdgeInsets.symmetric(horizontal: margin),
          decoration: BoxDecoration(
            gradient: _getGradient(),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _buildTransformedImage(),
              ),
            ),
          ),
        );
      },
    );
  }

  LinearGradient _getGradient() {
    // 間違えた選択のみ赤色で表示
    if (showResult && isSelected && !option.isCorrect) {
      return const LinearGradient(
        colors: [Color(0xFFFF5252), Color(0xFFE53935)],
      );
    } else if (isSelected) {
      // 選択中は青色
      return const LinearGradient(
        colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
      );
    } else {
      // デフォルトはグレー
      return const LinearGradient(
        colors: [Color(0xFFF5F5F5), Color(0xFFE0E0E0)],
      );
    }
  }
  
  Widget _buildTransformedImage() {
    Widget imageWidget = Padding(
      padding: const EdgeInsets.all(12), // 画像の周りにパディングを追加
      child: Image.asset(
        option.imagePath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Error loading image: ${option.imagePath}, error: $error');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red.shade300,
                  size: 36,
                ),
                const SizedBox(height: 4),
                Text(
                  '画像エラー',
                  style: TextStyle(
                    color: Colors.red.shade300,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    
    // 変換を適用
    switch (option.transform) {
      case FigureTransform.normal:
        return imageWidget;
        
      case FigureTransform.rotate90:
        return Transform.rotate(
          angle: math.pi / 2,
          child: imageWidget,
        );
        
      case FigureTransform.rotate180:
        return Transform.rotate(
          angle: math.pi,
          child: imageWidget,
        );
        
      case FigureTransform.rotate270:
        return Transform.rotate(
          angle: math.pi * 3 / 2,
          child: imageWidget,
        );
        
      case FigureTransform.flipHorizontal:
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(-1.0, 1.0),
          child: imageWidget,
        );
    }
  }
}