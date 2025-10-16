import 'package:flutter/material.dart';
import 'unified_writing_canvas_widget.dart';

/// キャンバスデザインのプリセット集
class CanvasDesignPresets {
  // 共通のデザイン要素
  static const double _defaultBorderRadius = 12.0;
  static const Color _canvasWhite = Colors.white;
  static final Color _lightGrayBackground = Colors.grey.shade50;
  // 他のゲームと同じ水色背景
  static const Color _lightBlueBackground = Color(0xFFF0F8FF);

  // 共通のペン設定
  static const double standardStrokeWidth = 12.0;  // 数字認識ゲームの太さを標準に
  static const Color standardStrokeColor = Colors.black;

  /// 文字練習ゲーム用（統一されたストローク太さ）
  static const CanvasCustomization writingGame = CanvasCustomization(
    showGradient: true,        // グラデーション背景
    showShadow: true,          // シャドウあり
    showExternalButtons: true, // 外部ボタンあり
    borderRadius: 16.0,        // 大きめの角丸
    strokeWidth: standardStrokeWidth, // 統一されたペン太さ
    strokeColor: standardStrokeColor, // 統一されたペン色
  );

  /// 数字認識ゲーム用（水色背景）
  static CanvasCustomization numberRecognitionGame({
    required double width,
    required double height,
  }) => CanvasCustomization(
    backgroundColor: _lightBlueBackground, // 他のゲームと同じ水色背景
    showGradient: false,                   // グラデーション無効
    showShadow: false,                     // シャドウ無効
    showExternalButtons: false,            // 外部ボタン無効
    canvasWidth: width,
    canvasHeight: height,
    canvasMargin: EdgeInsets.zero,
    borderRadius: _defaultBorderRadius,
    strokeWidth: standardStrokeWidth,      // 統一されたペン太さ
    strokeColor: standardStrokeColor,      // 統一されたペン色
  );

  /// 自由描画用（最小限のデザイン）
  static const CanvasCustomization freeDrawing = CanvasCustomization(
    backgroundColor: _canvasWhite,         // 純白背景
    showGradient: false,                   // グラデーション無効
    showShadow: false,                     // シャドウ無効
    showExternalButtons: true,             // 外部ボタンあり
    borderRadius: _defaultBorderRadius,
    strokeWidth: standardStrokeWidth,      // 統一されたペン太さ
    strokeColor: standardStrokeColor,      // 統一されたペン色
  );

  /// その他のゲーム用（バランス型）
  static CanvasCustomization otherGames({
    bool showShadow = false,
    bool showExternalButtons = true,
    Color? backgroundColor,
  }) => CanvasCustomization(
    backgroundColor: backgroundColor ?? _lightGrayBackground,
    showGradient: false,
    showShadow: showShadow,
    showExternalButtons: showExternalButtons,
    borderRadius: _defaultBorderRadius,
    strokeWidth: standardStrokeWidth,      // 統一されたペン太さ
    strokeColor: standardStrokeColor,      // 統一されたペン色
  );
}