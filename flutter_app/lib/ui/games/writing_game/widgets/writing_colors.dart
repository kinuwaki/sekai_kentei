import 'package:flutter/material.dart';

/// 書きゲームの共通色定数
class WritingColors {
  // キャンバス背景色
  static const Color canvasBackground = Colors.white;
  
  // 文字輪郭の背景色（薄い青）
  static final Color characterBackground = Colors.blue.shade100;
  
  // 文字輪郭の塗り色（濃い青）
  static final Color characterFill = Colors.blue.shade600;
  
  // 画面背景グラデーション
  static const List<Color> screenGradient = [
    Color(0xFF6A5ACD),
    Color(0xFF836FFF),
  ];
  
  // ボタン色
  static const Color completeButton = Colors.green;
  static const Color retryButton = Colors.orange;
  
  // 矢印色
  static final Color arrow = Colors.orange.shade600;
}