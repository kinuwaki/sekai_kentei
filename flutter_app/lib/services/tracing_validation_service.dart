import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import '../ui/games/writing_game/writing_game_models.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class TracingValidationService {
  // 許容誤差（ピクセル単位）
  static const double _toleranceDistance = 30.0;
  
  // 最小完了率（ストロークの何%を正確になぞる必要があるか）
  static const double _minCompletionRatio = 0.7;

  /// なぞりがきの判定を行う
  /// [userDrawing] ユーザーの描画
  /// [targetPaths] 目標とするSVGパス文字列のリスト
  /// [canvasSize] キャンバスサイズ
  /// [character] 対象文字（スケーリング判定用）
  ValidationResult validateTracing({
    required Drawing userDrawing,
    required List<String> targetPaths,
    required Size canvasSize,
    required String character,
  }) {
    if (userDrawing.isEmpty) {
      return ValidationResult(
        isValid: false,
        completedStrokes: 0,
        totalStrokes: targetPaths.length,
        accuracy: 0.0,
        feedback: '文字を書いてください',
      );
    }

    // 目標パスをFlutter Pathに変換
    final convertedPaths = _convertSvgPaths(targetPaths, canvasSize, character);
    if (convertedPaths.isEmpty) {
      return ValidationResult(
        isValid: false,
        completedStrokes: 0,
        totalStrokes: targetPaths.length,
        accuracy: 0.0,
        feedback: 'パスの変換に失敗しました',
      );
    }

    // 各ストロークの判定
    int completedStrokes = 0;
    double totalAccuracy = 0.0;
    List<String> strokeFeedback = [];

    for (int i = 0; i < convertedPaths.length; i++) {
      final targetPath = convertedPaths[i];
      final strokeResult = _validateStroke(userDrawing, targetPath, i);
      
      if (strokeResult.isCompleted) {
        completedStrokes++;
      }
      
      totalAccuracy += strokeResult.accuracy;
      strokeFeedback.add(strokeResult.feedback);
    }

    final overallAccuracy = totalAccuracy / convertedPaths.length;
    final isValid = completedStrokes >= convertedPaths.length && 
                   overallAccuracy >= _minCompletionRatio;

    return ValidationResult(
      isValid: isValid,
      completedStrokes: completedStrokes,
      totalStrokes: convertedPaths.length,
      accuracy: overallAccuracy,
      feedback: _generateFeedback(isValid, completedStrokes, convertedPaths.length, strokeFeedback),
    );
  }

  /// 書き順チェック付きストローク判定
  StrokeOrderValidationResult validateStrokeOrder({
    required Drawing userDrawing,
    required List<String> targetPaths,
    required Size canvasSize,
    required String character,
    required int expectedStrokeIndex,
  }) {
    if (userDrawing.isEmpty) {
      return StrokeOrderValidationResult(
        isCurrentStrokeValid: false,
        completedStrokes: 0,
        totalStrokes: targetPaths.length,
        accuracy: 0.0,
        feedback: '文字を書いてください',
        currentStrokeIndex: 0,
      );
    }

    final convertedPaths = _convertSvgPaths(targetPaths, canvasSize, character);
    if (convertedPaths.isEmpty || expectedStrokeIndex >= convertedPaths.length) {
      return StrokeOrderValidationResult(
        isCurrentStrokeValid: false,
        completedStrokes: 0,
        totalStrokes: targetPaths.length,
        accuracy: 0.0,
        feedback: 'パスの変換に失敗しました',
        currentStrokeIndex: 0,
      );
    }

    // 現在のストロークが正しい順番（expectedStrokeIndex）に対応するかチェック
    final targetPath = convertedPaths[expectedStrokeIndex];
    final strokeResult = _validateStroke(userDrawing, targetPath, expectedStrokeIndex);
    
    // 書き順チェック: 現在のストロークインデックスが期待値と一致するか
    final isCorrectOrder = userDrawing.strokes.length - 1 == expectedStrokeIndex;
    final isStrokeValid = strokeResult.isCompleted && isCorrectOrder;

    return StrokeOrderValidationResult(
      isCurrentStrokeValid: isStrokeValid,
      completedStrokes: expectedStrokeIndex + (isStrokeValid ? 1 : 0),
      totalStrokes: convertedPaths.length,
      accuracy: strokeResult.accuracy,
      feedback: _generateStrokeOrderFeedback(expectedStrokeIndex + 1, isStrokeValid, strokeResult.accuracy),
      currentStrokeIndex: expectedStrokeIndex,
    );
  }

  /// SVGパス文字列をFlutter Pathに変換
  List<Path> _convertSvgPaths(List<String> pathStrings, Size canvasSize, String character) {
    final paths = <Path>[];
    
    for (final pathString in pathStrings) {
      try {
        final path = parseSvgPathData(pathString);
        
        // スケーリング
        final matrix = Matrix4.identity();
        final scaleFactor = _getScaleFactor(canvasSize, character, pathString);
        matrix.scale(scaleFactor, scaleFactor, 1.0);
        
        final scaledPath = path.transform(matrix.storage);
        paths.add(scaledPath);
      } catch (e) {
        // パースエラーは無視
        continue;
      }
    }
    
    return paths;
  }

  /// スケールファクターを決定
  double _getScaleFactor(Size canvasSize, String character, String pathString) {
    if (character == 'あ' && pathString.contains('174,258')) {
      return canvasSize.width / 1024; // AnimCJK
    } else if (character == '1' && pathString.contains('200,80')) {
      return canvasSize.width / 400;  // カスタム数字
    }
    return canvasSize.width / 400; // デフォルト
  }

  /// 個別ストロークの判定
  StrokeValidationResult _validateStroke(Drawing userDrawing, Path targetPath, int strokeIndex) {
    if (userDrawing.strokes.length <= strokeIndex) {
      return StrokeValidationResult(
        isCompleted: false,
        accuracy: 0.0,
        feedback: '${strokeIndex + 1}画目を書いてください',
      );
    }

    final userStroke = userDrawing.strokes[strokeIndex];
    final targetMetrics = targetPath.computeMetrics().toList();
    
    if (targetMetrics.isEmpty) {
      return StrokeValidationResult(
        isCompleted: false,
        accuracy: 0.0,
        feedback: 'パスが無効です',
      );
    }

    final targetMetric = targetMetrics.first;
    // final targetLength = targetMetric.length; // 今は使用しないがFutureのために保持
    
    // ユーザーストロークの各点を目標パスと比較
    int validPoints = 0;
    final userPoints = userStroke.points;
    
    for (final userPoint in userPoints) {
      final closestDistance = _findClosestDistanceToPath(userPoint, targetMetric);
      if (closestDistance <= _toleranceDistance) {
        validPoints++;
      }
    }

    final accuracy = userPoints.isNotEmpty ? validPoints / userPoints.length : 0.0;
    final isCompleted = accuracy >= _minCompletionRatio;

    return StrokeValidationResult(
      isCompleted: isCompleted,
      accuracy: accuracy,
      feedback: _generateStrokeFeedback(strokeIndex + 1, accuracy, isCompleted),
    );
  }

  /// 点から目標パスまでの最短距離を求める
  double _findClosestDistanceToPath(Offset point, ui.PathMetric pathMetric) {
    double minDistance = double.infinity;
    final pathLength = pathMetric.length;
    const sampleCount = 100; // パス上のサンプル点数
    
    for (int i = 0; i <= sampleCount; i++) {
      final t = i / sampleCount;
      final tangent = pathMetric.getTangentForOffset(t * pathLength);
      
      if (tangent != null) {
        final pathPoint = tangent.position;
        final distance = _calculateDistance(point, pathPoint);
        minDistance = math.min(minDistance, distance);
      }
    }
    
    return minDistance;
  }

  /// 2点間の距離を計算
  double _calculateDistance(Offset p1, Offset p2) {
    final dx = p1.dx - p2.dx;
    final dy = p1.dy - p2.dy;
    return math.sqrt(dx * dx + dy * dy);
  }

  /// ストローク別フィードバック生成
  String _generateStrokeFeedback(int strokeNumber, double accuracy, bool isCompleted) {
    if (isCompleted) {
      return '$strokeNumber画目: 良く書けました！';
    } else if (accuracy > 0.4) {
      return '$strokeNumber画目: もう少し正確になぞってください';
    } else {
      return '$strokeNumber画目: 線をなぞって書いてください';
    }
  }

  /// 書き順フィードバック生成
  String _generateStrokeOrderFeedback(int strokeNumber, bool isValid, double accuracy) {
    if (isValid) {
      return '$strokeNumber画目: よくできました！';
    } else if (accuracy > 0.4) {
      return '$strokeNumber画目をもう少し正確になぞってください';
    } else {
      return '$strokeNumber画目から始めてください';
    }
  }

  /// 全体フィードバック生成
  String _generateFeedback(bool isValid, int completedStrokes, int totalStrokes, List<String> strokeFeedback) {
    if (isValid) {
      return 'よくできました！正しく書けています。';
    } else if (completedStrokes == 0) {
      return '文字をなぞって書いてみましょう。';
    } else {
      return '$completedStrokes/$totalStrokes 画完了。${strokeFeedback.where((f) => f.contains('もう少し')).isNotEmpty ? '線に沿って正確になぞってください。' : '残りの画も書いてください。'}';
    }
  }
}

/// 検証結果
class ValidationResult {
  final bool isValid;
  final int completedStrokes;
  final int totalStrokes;
  final double accuracy;
  final String feedback;

  ValidationResult({
    required this.isValid,
    required this.completedStrokes,
    required this.totalStrokes,
    required this.accuracy,
    required this.feedback,
  });
}

/// ストローク別検証結果
class StrokeValidationResult {
  final bool isCompleted;
  final double accuracy;
  final String feedback;

  StrokeValidationResult({
    required this.isCompleted,
    required this.accuracy,
    required this.feedback,
  });
}

/// 書き順検証結果
class StrokeOrderValidationResult {
  final bool isCurrentStrokeValid;
  final int completedStrokes;
  final int totalStrokes;
  final double accuracy;
  final String feedback;
  final int currentStrokeIndex;

  StrokeOrderValidationResult({
    required this.isCurrentStrokeValid,
    required this.completedStrokes,
    required this.totalStrokes,
    required this.accuracy,
    required this.feedback,
    required this.currentStrokeIndex,
  });
}