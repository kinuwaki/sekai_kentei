import 'dart:math';
import 'package:flutter/material.dart';

class DotLayoutService {
  static final DotLayoutService _instance = DotLayoutService._internal();
  factory DotLayoutService() => _instance;
  DotLayoutService._internal();

  /// ドットの最適なサイズを計算（コンテナサイズに基づく）
  double calculateDotSize(double containerWidth, double containerHeight, int dotCount) {
    // コンテナの面積からドットサイズを推定
    final containerArea = containerWidth * containerHeight;
    final areaPerDot = containerArea / dotCount;
    
    // ドットが重ならないように、適切なサイズを計算
    // 面積の30%をドットで使用し、残りを余白とする
    final dotArea = areaPerDot * 0.3;
    final dotRadius = sqrt(dotArea / pi);
    
    // 最小・最大サイズを制限
    final minSize = 15.0;
    final maxSize = min(containerWidth, containerHeight) * 0.15; // コンテナの15%まで
    
    return dotRadius.clamp(minSize, maxSize);
  }

  /// ランダムなドット位置を生成（改良版）
  List<Offset> generateDotPositions({
    required int count,
    required double containerWidth,
    required double containerHeight,
    int? seed,
    double? customDotRadius,
  }) {
    final random = Random(seed ?? count * 1000);
    final positions = <Offset>[];
    
    // ドットサイズを計算または使用
    final dotRadius = customDotRadius ?? calculateDotSize(containerWidth, containerHeight, count);
    
    // 最小距離（ドット同士が重ならないように）
    final minDistance = dotRadius * 2.1;
    
    // マージン（コンテナの端から離す）
    final margin = dotRadius + 5.0;
    final effectiveWidth = containerWidth - 2 * margin;
    final effectiveHeight = containerHeight - 2 * margin;
    
    // 配置可能エリアが小さすぎる場合の処理
    if (effectiveWidth <= 0 || effectiveHeight <= 0) {
      return _generateFallbackPositions(count, containerWidth, containerHeight, dotRadius);
    }
    
    for (int i = 0; i < count; i++) {
      int attempts = 0;
      bool placed = false;
      
      while (attempts < 200 && !placed) { // 試行回数を増加
        final x = margin + random.nextDouble() * effectiveWidth;
        final y = margin + random.nextDouble() * effectiveHeight;
        final newPosition = Offset(x, y);
        
        // 他のドットとの距離をチェック
        bool tooClose = false;
        for (final existingPosition in positions) {
          if ((newPosition - existingPosition).distance < minDistance) {
            tooClose = true;
            break;
          }
        }
        
        if (!tooClose) {
          positions.add(newPosition);
          placed = true;
        }
        attempts++;
      }
      
      // 配置に失敗した場合はフォールバック
      if (!placed) {
        positions.addAll(_generateFallbackPositions(
          count - positions.length,
          containerWidth,
          containerHeight,
          dotRadius,
          existingPositions: positions,
        ));
        break;
      }
    }
    
    return positions;
  }

  /// グリッド状のドット位置を生成（フォールバック用）
  List<Offset> _generateFallbackPositions(
    int count,
    double containerWidth,
    double containerHeight,
    double dotRadius, {
    List<Offset>? existingPositions,
  }) {
    final positions = <Offset>[];
    
    // グリッドの列数を計算
    final cols = sqrt(count).ceil();
    final rows = (count / cols).ceil();
    
    final cellWidth = containerWidth / cols;
    final cellHeight = containerHeight / rows;
    
    int placed = 0;
    for (int row = 0; row < rows && placed < count; row++) {
      for (int col = 0; col < cols && placed < count; col++) {
        final x = (col + 0.5) * cellWidth;
        final y = (row + 0.5) * cellHeight;
        positions.add(Offset(x, y));
        placed++;
      }
    }
    
    return positions;
  }

  /// グリッド状のドット位置を生成（整列表示用）
  List<Offset> generateGridDotPositions({
    required int count,
    required double containerWidth,
    required double containerHeight,
    double? customDotRadius,
  }) {
    final dotRadius = customDotRadius ?? calculateDotSize(containerWidth, containerHeight, count);
    
    // 最適な列数を計算
    final aspectRatio = containerWidth / containerHeight;
    final cols = (sqrt(count * aspectRatio)).ceil();
    final rows = (count / cols).ceil();
    
    final dotSpacing = dotRadius * 2.5;
    final gridWidth = cols * dotSpacing;
    final gridHeight = rows * dotSpacing;
    
    // グリッドをコンテナの中央に配置
    final startX = (containerWidth - gridWidth) / 2 + dotRadius;
    final startY = (containerHeight - gridHeight) / 2 + dotRadius;
    
    final positions = <Offset>[];
    int placed = 0;
    
    for (int row = 0; row < rows && placed < count; row++) {
      for (int col = 0; col < cols && placed < count; col++) {
        final x = startX + col * dotSpacing;
        final y = startY + row * dotSpacing;
        positions.add(Offset(x, y));
        placed++;
      }
    }
    
    return positions;
  }

  /// ドットサイズに基づく推奨コンテナサイズを計算
  Size calculateRecommendedContainerSize(int dotCount, double dotRadius) {
    final cols = sqrt(dotCount).ceil();
    final rows = (dotCount / cols).ceil();
    
    final spacing = dotRadius * 2.5;
    final margin = dotRadius + 10.0;
    
    final width = cols * spacing + margin * 2;
    final height = rows * spacing + margin * 2;
    
    return Size(width, height);
  }
}