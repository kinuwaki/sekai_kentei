import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import '../../../core/debug_logger.dart';
import '../../../services/character_recognition_service.dart';
import '../../components/drawing/drawing_models.dart';
import 'writing_game_models.dart';
import 'writing_session_controller.dart';

typedef ModeCompleted = void Function(ModeResult result);
typedef ModeErrorHandler = void Function(Object error, StackTrace stackTrace);

/// 単一モード実行ユニット
class WritingSingleModeLogic {
  final WritingMode mode;
  final String character;
  final CharacterRecognizer _recognitionService = getRecognizer();
  
  ModeCompleted? _onCompleted;
  ModeErrorHandler? _onError;
  bool _disposed = false;
  bool _isRunning = false;
  
  // 描画データ
  DrawingData _drawingData = const DrawingData(paths: [], canvasSize: Size(300, 300));
  
  // なぞりがき用
  int _currentStrokeIndex = 0;
  bool _isAnimatingStrokes = false;

  WritingSingleModeLogic({
    required this.mode,
    required this.character,
  });

  /// モード実行開始
  Future<void> run({
    required ModeCompleted onCompleted,
    required ModeErrorHandler onError,
  }) async {
    if (_disposed || _isRunning) return;

    _onCompleted = onCompleted;
    _onError = onError;
    _isRunning = true;

    Log.d('WritingSingleMode: Starting ${mode.displayName} for character "$character"');

    try {
      await _recognitionService.initialize();
      
      switch (mode) {
        case WritingMode.tracing:
          _startTracingMode();
          break;
        case WritingMode.tracingFree:
          _startTracingFreeMode();
          break;
        case WritingMode.freeWrite:
          _startFreeWriteMode();
          break;
      }
    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
    }
  }

  /// なぞりがきモード開始
  void _startTracingMode() {
    Log.d('WritingSingleMode: Starting tracing mode for "$character"');
    _isAnimatingStrokes = true;
    _currentStrokeIndex = 0;
    // 実際のなぞりがきは SmoothTracingWidget の onEndDrawing で完了判定される
  }

  /// なぞりがき２モード開始  
  void _startTracingFreeMode() {
    Log.d('WritingSingleMode: Starting tracing free mode for "$character"');
    // 自由なぞりがき開始
  }

  /// じゆうがきモード開始
  void _startFreeWriteMode() {
    Log.d('WritingSingleMode: Starting free write mode for "$character"');
    // 自由書き開始
  }

  /// 描画データ更新（SmoothTracingWidget.onDrawingDataChanged から）
  void updateDrawingData(DrawingData drawingData) {
    if (_disposed) return;
    _drawingData = drawingData;
    Log.d('WritingSingleMode: Drawing data updated with ${drawingData.paths.length} paths');
  }

  /// 実際の描画完了時に呼ばれる（SmoothTracingWidget.onEndDrawing から）
  void onDrawingCompleted() {
    if (_disposed || !_isRunning) return;

    Log.d('WritingSingleMode: Drawing completed for ${mode.displayName}');

    // モードに応じた処理
    switch (mode) {
      case WritingMode.tracing:
      case WritingMode.tracingFree:
        // なぞりがき系は自動完了
        _completeMode(success: true);
        break;
      case WritingMode.freeWrite:
        // じゆうがきは文字認識を実行
        _recognizeDrawing();
        break;
    }
  }

  /// ストローク完了処理（現在は使用されていない - 将来の拡張用）
  void _onStrokeComplete() {
    if (_disposed) return;

    _currentStrokeIndex++;
    Log.d('WritingSingleMode: Stroke ${_currentStrokeIndex} completed');
    
    // 実際の完了判定は onDrawingCompleted() で行う
  }

  /// 描画パス追加
  void addDrawingPath(List<Offset> points) {
    if (_disposed || !_isRunning) return;

    final newPath = DrawingPath(
      points: points,
      color: Colors.blue,
      strokeWidth: 4.0,
    );

    _drawingData = _drawingData.copyWith(
      paths: [..._drawingData.paths, newPath],
    );
  }

  /// 描画クリア
  void clearDrawing() {
    if (_disposed) return;
    _drawingData = _drawingData.copyWith(paths: []);
  }

  /// 描画完了（なぞりがき２・じゆうがき用）
  void completeDrawing() {
    if (_disposed || !_isRunning) return;
    
    Log.d('WritingSingleMode: Drawing completed for ${mode.displayName}');
    
    if (_drawingData.paths.isEmpty) {
      Log.w('WritingSingleMode: No drawing data, considering as failed');
      _completeMode(success: false);
      return;
    }

    switch (mode) {
      case WritingMode.tracing:
        // なぞりがきは自動完了
        break;
      case WritingMode.tracingFree:
        _completeMode(success: true);
        break;
      case WritingMode.freeWrite:
        _recognizeDrawing();
        break;
    }
  }

  /// 文字認識実行
  Future<void> _recognizeDrawing() async {
    if (_disposed) return;

    try {
      Log.d('WritingSingleMode: Starting character recognition for "$character"');
      
      // 描画を画像に変換
      final imageData = await _convertDrawingToImage(_drawingData);
      
      // 文字認識実行
      final result = await _recognitionService.recognize(
        imageData, 
        type: RecognitionType.hiragana,
      );
      
      Log.d('WritingSingleMode: Recognition result: "${result.recognizedCharacter}" (confidence: ${result.confidence})');
      
      // 正解判定
      final isCorrect = result.recognizedCharacter.toLowerCase() == character.toLowerCase();
      _completeMode(success: isCorrect, score: result.confidence);
      
    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
    }
  }

  /// 描画を画像に変換
  Future<Uint8List> _convertDrawingToImage(DrawingData drawing) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = drawing.canvasSize;

    // 白い背景
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.white,
    );

    // 描画パスを描く
    for (final path in drawing.paths) {
      final paint = Paint()
        ..color = path.color
        ..strokeWidth = path.strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final uiPath = Path();
      for (int i = 0; i < path.points.length; i++) {
        if (i == 0) {
          uiPath.moveTo(path.points[i].dx, path.points[i].dy);
        } else {
          uiPath.lineTo(path.points[i].dx, path.points[i].dy);
        }
      }
      canvas.drawPath(uiPath, paint);
    }

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    
    return byteData!.buffer.asUint8List();
  }

  /// モード完了
  void _completeMode({required bool success, double? score}) {
    if (_disposed || !_isRunning) return;

    _isRunning = false;
    Log.d('WritingSingleMode: Mode ${mode.displayName} completed - success: $success, score: $score');

    final result = ModeResult(
      success: success,
      score: score,
    );

    _onCompleted?.call(result);
  }

  /// エラー処理
  void _handleError(Object error, StackTrace stackTrace) {
    if (_disposed) return;
    
    _isRunning = false;
    Log.e('WritingSingleMode: Error in ${mode.displayName}: $error');
    _onError?.call(error, stackTrace);
  }

  /// 現在の描画データを取得
  DrawingData get drawingData => _drawingData;

  /// なぞりがき状態
  bool get isAnimatingStrokes => _isAnimatingStrokes;
  int get currentStrokeIndex => _currentStrokeIndex;

  /// リソース解放
  void dispose() {
    if (_disposed) return;
    
    _disposed = true;
    _isRunning = false;
    Log.d('WritingSingleMode: Disposed ${mode.displayName} logic for "$character"');
  }
}