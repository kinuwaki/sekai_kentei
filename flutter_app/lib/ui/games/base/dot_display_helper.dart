import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'common_game_widgets.dart';

/// ドット表示の共通ヘルパークラス
///
/// 各ゲーム（comparison_game, counting_game, tsumiki_counting_game）で
/// 重複していたドット表示ロジックを統一
class DotDisplayHelper {
  DotDisplayHelper._(); // private constructor to prevent instantiation

  /// ドット配置からウィジェットリストを生成（共通実装）
  ///
  /// [positions] ドットの配置座標リスト
  /// [shape] ドットの形状
  /// [color] ドットの色
  /// [size] ドットのサイズ
  ///
  /// 返値: 配置されたドットウィジェットのリスト
  static List<Widget> buildDotsFromPositions({
    required List<Offset> positions,
    required CommonDotShape shape,
    required Color color,
    required double size,
  }) {
    return positions.map((position) {
      return DotWidgetBuilder.buildDot(
        position: position,
        shape: shape,
        color: color,
        size: size,
      );
    }).toList();
  }

  /// 各ゲーム固有のDotShape enumをCommonDotShapeに変換
  ///
  /// [shape] ゲーム固有のDotShape enum（dynamic型で受け取り）
  ///
  /// 返値: CommonDotShape
  ///
  /// 例:
  /// ```dart
  /// // comparison_gameのDotShape.circle → CommonDotShape.circle
  /// final commonShape = DotDisplayHelper.convertDotShape(DotShape.circle);
  /// ```
  static CommonDotShape convertDotShape(dynamic shape) {
    // toString()で "DotShape.circle" のような文字列を取得し、最後の部分を抽出
    final shapeStr = shape.toString().split('.').last;

    switch (shapeStr) {
      case 'circle':
        return CommonDotShape.circle;
      case 'square':
        return CommonDotShape.square;
      case 'star':
        return CommonDotShape.star;
      default:
        return CommonDotShape.circle; // デフォルトは円
    }
  }

  /// ドットサイズの計算（統一ロジック）
  ///
  /// [containerWidth] コンテナの幅
  /// [containerHeight] コンテナの高さ
  /// [dotCount] ドットの個数
  /// [minSize] 最小ドットサイズ（オプション）
  /// [maxSize] 最大ドットサイズ（オプション）
  ///
  /// 返値: 計算されたドットサイズ
  static double calculateUniformDotSize({
    required double containerWidth,
    required double containerHeight,
    required List<int> allNumbers,
    double? minSize,
    double? maxSize,
  }) {
    // DotLayoutServiceを使用する場合はそちらに委譲
    // ここでは簡易計算を提供
    final maxCount = allNumbers.reduce((a, b) => a > b ? a : b);
    final area = containerWidth * containerHeight;
    final dotArea = area / (maxCount * 2.5); // 余白を考慮
    double size = math.sqrt(dotArea / 3.14159) * 2; // 円の直径

    if (minSize != null && size < minSize) size = minSize;
    if (maxSize != null && size > maxSize) size = maxSize;

    return size;
  }
}