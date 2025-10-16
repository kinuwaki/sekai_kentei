import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'number_recognition_game_models.dart';
import '../../components/drawing/drawing_models.dart';
import '../../../services/character_recognition_service.dart';
import '../../../core/debug_logger.dart';

/// 数字認識ゲームのロジックを管理するクラス
class NumberRecognitionGameLogic extends ChangeNotifier {
  GameSession _session = GameSession.start();
  DrawingData _drawingData = const DrawingData(paths: [], canvasSize: Size(300, 200));
  bool _isProcessing = false;
  bool _isAutoAdvancing = false; // 自動進行中フラグ
  String? _lastError;

  GameSession get session => _session;
  DrawingData get drawingData => _drawingData;
  bool get isProcessing => _isProcessing || _isAutoAdvancing; // 自動進行中も処理中として扱う
  String? get lastError => _lastError;

  /// ゲームを開始（内部実装）
  void _startGameInternal({
    int problemCount = 3, 
    int difference = 3, 
    ProblemType problemType = ProblemType.smaller,
  }) {
    _session = GameSession.start(
      problemCount: problemCount, 
      difference: difference,
      problemType: problemType,
    ).toPlaying(); // 即座にプレイ状態にする
    _clearDrawing();
    _lastError = null;
    notifyListeners();
  }

  /// ゲームをリセット（BaseGameScreen互換）
  void resetGame() {
    _session = GameSession.start().toPlaying(); // 即座にプレイ状態にする
    _clearDrawing();
    _isProcessing = false;
    _lastError = null;
    notifyListeners();
  }

  /// ゲームを開始（BaseGameScreen互換）
  void startGame(dynamic settings) {
    // 動的型チェックでsettingsの内容を確認
    if (settings != null && settings.runtimeType.toString().contains('NumberRecognition')) {
      try {
        final problemCount = (settings as dynamic).problemCount ?? 3;
        final problemType = (settings as dynamic).problemType ?? ProblemType.smaller;
        _startGameInternal(
          problemCount: problemCount,
          problemType: problemType,
        );
      } catch (e) {
        // エラー時はデフォルトで開始
        _startGameInternal();
      }
    } else {
      // フォールバック: デフォルト値で開始
      _startGameInternal();
    }
  }


  /// ゲームを開始状態に戻す
  void startPlaying() {
    _session = _session.toPlaying();
    notifyListeners();
  }

  /// 成功エフェクトを隠す
  void hideSuccessEffect() {
    _session = _session.copyWith(showSuccessEffect: false);
    notifyListeners();
  }


  /// 描画データをクリア
  void _clearDrawing() {
    _drawingData = _drawingData.clear();
  }

  /// 描画データをクリア（公開メソッド）
  void clearDrawing() {
    _clearDrawing();
    notifyListeners();
  }

  /// キャンバスサイズを設定
  void setCanvasSize(Size size) {
    _drawingData = DrawingData(paths: _drawingData.paths, canvasSize: size);
    notifyListeners();
  }

  /// 描画パスを追加
  void addDrawingPath(DrawingPath path) {
    if (_isAutoAdvancing || _session.state != GameState.playing) return; // 自動進行中は描画を無効化
    _drawingData = _drawingData.addPath(path);
    notifyListeners();
  }

  /// テンキーで数字を入力（他のゲームと統一された進行）
  void inputNumber(int number) {
    if (_isProcessing || _isAutoAdvancing || _session.state != GameState.playing) return;

    final result = AnswerResult(
      recognizedNumber: number,
      isCorrect: number == _session.currentProblem.correctAnswer,
      correctAnswer: _session.currentProblem.correctAnswer,
    );

    _session = _session.withAnswer(result);
    notifyListeners();
    
    // 他のゲームと同じように遅延後に自動進行
    _autoAdvanceAfterDelay(result.isCorrect);
  }

  /// 自動進行（他のゲームと統一）
  void _autoAdvanceAfterDelay(bool isCorrect) async {
    if (_isAutoAdvancing) return; // 既に自動進行中の場合は重複実行を防ぐ
    
    _isAutoAdvancing = true;
    notifyListeners(); // 手書きを無効化
    
    final delay = isCorrect ? 1500 : 2000; // 間違いの場合は少し長く
    await Future.delayed(Duration(milliseconds: delay));
    
    if (_session.isLastQuestion) {
      // 最後の問題の場合はゲーム完了
      _session = _session.copyWith(state: GameState.completed);
    } else {
      // 次の問題へ自動進行
      _session = _session.toNextQuestion();
      _clearDrawing(); // 次の問題用に描画をクリア
    }
    
    _isAutoAdvancing = false;
    notifyListeners();
  }

  /// 手書き文字を認識して回答
  Future<void> recognizeHandwriting() async {
    if (_isProcessing || _isAutoAdvancing || _drawingData.isEmpty || _session.state != GameState.playing) {
      return;
    }

    _isProcessing = true;
    _lastError = null;
    notifyListeners();

    try {
      // 手書きデータを画像に変換
      final imageData = await _convertDrawingToImage(_drawingData);
      
      // プラットフォーム別の数字認識
      final recognizedNumber = await _recognizeNumber(imageData);
      
      final result = AnswerResult(
        recognizedNumber: recognizedNumber,
        isCorrect: recognizedNumber == _session.currentProblem.correctAnswer,
        correctAnswer: _session.currentProblem.correctAnswer,
      );

      _session = _session.withAnswer(result);
      _isProcessing = false;
      notifyListeners();
      
      // 他のゲームと同じように遅延後に自動進行
      _autoAdvanceAfterDelay(result.isCorrect);
    } catch (e) {
      _lastError = e.toString();
      debugPrint('数字認識エラー: $e');
      _isProcessing = false;
      notifyListeners();
    }
  }

  /// 描画データを画像に変換
  Future<Uint8List> _convertDrawingToImage(DrawingData drawing) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    // データ量を減らして安定性を優先
    final size = Size(400, 300);  // 適度なサイズ

    Log.d('NumberRecognition: Converting drawing to image');
    Log.d('NumberRecognition: Canvas size: ${size.width} x ${size.height}');
    Log.d('NumberRecognition: Number of paths: ${drawing.paths.length}');

    // 白い背景
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.white,
    );

    // まず全体の座標範囲を計算（全パス統合）
    double? globalMinX, globalMaxX, globalMinY, globalMaxY;
    
    for (final path in drawing.paths) {
      for (final point in path.points) {
        if (globalMinX == null || point.dx < globalMinX) globalMinX = point.dx;
        if (globalMaxX == null || point.dx > globalMaxX) globalMaxX = point.dx;
        if (globalMinY == null || point.dy < globalMinY) globalMinY = point.dy;
        if (globalMaxY == null || point.dy > globalMaxY) globalMaxY = point.dy;
      }
    }
    
    // 描画がない場合は何もしない
    if (globalMinX == null || globalMaxX == null || globalMinY == null || globalMaxY == null) {
      Log.w('NumberRecognition: No drawing found');
      return Uint8List(0);
    }
    
    Log.d('NumberRecognition: Global bounds: X($globalMinX - $globalMaxX), Y($globalMinY - $globalMaxY)');
    Log.d('NumberRecognition: Canvas bounds: X(0 - ${size.width}), Y(0 - ${size.height})');
    
    // 全体の座標範囲を基準にスケーリング係数を計算
    final sourceWidth = globalMaxX - globalMinX;
    final sourceHeight = globalMaxY - globalMinY;
    final padding = 80.0; // 800x600に合わせた大きめのパディング
    final targetWidth = size.width - padding * 2;
    final targetHeight = size.height - padding * 2;
    
    // アスペクト比を保持してスケーリング
    final scaleX = sourceWidth > 0 ? targetWidth / sourceWidth : 1.0;
    final scaleY = sourceHeight > 0 ? targetHeight / sourceHeight : 1.0;
    final scale = math.min(scaleX, scaleY);
    
    // 中央配置のためのオフセット計算
    final scaledWidth = sourceWidth * scale;
    final scaledHeight = sourceHeight * scale;
    final offsetX = (size.width - scaledWidth) / 2;
    final offsetY = (size.height - scaledHeight) / 2;
    
    Log.d('NumberRecognition: Scale factor: $scale');
    Log.d('NumberRecognition: Offset: ($offsetX, $offsetY)');

    // 描画パスを描画（統一されたスケールとオフセットを使用）
    for (int i = 0; i < drawing.paths.length; i++) {
      final path = drawing.paths[i];
      Log.d('NumberRecognition: Path $i - points: ${path.points.length}');
      
      final paint = Paint()
        ..color = Colors.black  // 確実に黒色
        ..strokeWidth = 20.0  // 800x600に合わせて極太に
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      final uiPath = Path();
      if (path.points.isNotEmpty) {
        // 統一されたスケールで正規化
        final normalizedPoints = path.points.map((point) {
          final normalizedX = (point.dx - globalMinX!) * scale + offsetX;
          final normalizedY = (point.dy - globalMinY!) * scale + offsetY;
          return Offset(normalizedX, normalizedY);
        }).toList();
        
        if (i == 0) {
          Log.d('NumberRecognition: First path normalized - first: (${normalizedPoints.first.dx.toStringAsFixed(2)}, ${normalizedPoints.first.dy.toStringAsFixed(2)}), last: (${normalizedPoints.last.dx.toStringAsFixed(2)}, ${normalizedPoints.last.dy.toStringAsFixed(2)})');
        }
        
        uiPath.moveTo(normalizedPoints.first.dx, normalizedPoints.first.dy);
        for (int j = 1; j < normalizedPoints.length; j++) {
          uiPath.lineTo(normalizedPoints[j].dx, normalizedPoints[j].dy);
        }
      }
      canvas.drawPath(uiPath, paint);
    }

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    
    if (byteData == null) {
      throw Exception('画像の変換に失敗しました');
    }
    
    return byteData.buffer.asUint8List();
  }

  /// プラットフォーム別の数字認識
  Future<int?> _recognizeNumber(Uint8List imageData) async {
    try {
      // 新しい認識サービスを使用して数字認識
      final recognitionService = getRecognizer();
      final result = await recognitionService.recognize(
        imageData, 
        type: RecognitionType.numbers,
      );
      
      // 認識結果を数字に変換
      final recognizedChar = result.recognizedCharacter;
      final number = int.tryParse(recognizedChar);
      
      if (number != null && number >= 0 && number <= 100) {
        debugPrint('数字認識成功: $recognizedChar (信頼度: ${result.confidence})');
        return number;
      } else {
        debugPrint('数字認識失敗: 無効な文字 "$recognizedChar"');
        return null;
      }
    } catch (e) {
      debugPrint('数字認識処理エラー: $e');
      return null;
    }
  }

  /// モック数字認識（デモ用）
  int? _mockNumberRecognition() {
    // 描画の複雑さから数字を推測するシンプルなロジック
    final pathCount = _drawingData.paths.length;
    final totalPoints = _drawingData.paths.fold<int>(0, (sum, path) => sum + path.points.length);
    
    if (pathCount == 0 || totalPoints < 5) {
      return null; // 描画が少なすぎる
    }

    // 描画パターンから数字を推測（簡易版）
    // 実際の実装では OCR を使用
    final complexity = totalPoints / pathCount;
    
    if (complexity < 10) {
      return 1; // シンプルな線
    } else if (complexity < 15) {
      return 7; // やや複雑
    } else if (complexity < 25) {
      return 4; // 中程度の複雑さ
    } else if (complexity < 35) {
      return 0; // 丸い形
    } else {
      return 8; // 複雑な形
    }
  }

  /// 画像の前処理
  Uint8List _preprocessImage(Uint8List imageData) {
    // 実際の実装では以下の処理を行う：
    // 1. リサイズ（長辺を1500-2000pxに）
    // 2. グレースケール変換
    // 3. 二値化
    // 4. 軽いデスキュー
    
    // ここではオリジナルをそのまま返す（モック）
    return imageData;
  }

  /// 認識結果の後処理
  int? _postprocessRecognition(String rawText) {
    // 数字以外を除去
    final cleanedText = rawText.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleanedText.isEmpty) return null;
    
    // 最初の数字を取得
    final number = int.tryParse(cleanedText.substring(0, 1));
    
    // 0-10の範囲内かチェック
    if (number != null && number >= 0 && number <= 10) {
      return number;
    }
    
    return null;
  }

}

/// 数字生成のヘルパークラス
class NumberGenerator {
  static final _random = math.Random();

  /// 指定された条件を満たす基準数を生成
  static int generateBaseNumber({
    required int difference,
    int minResult = 0,
    int maxBase = 10,
  }) {
    final minBase = difference + minResult;
    final maxValidBase = math.min(maxBase, minBase + (maxBase - minBase));
    
    if (minBase > maxValidBase) {
      throw ArgumentError('条件を満たす数を生成できません');
    }

    return minBase + _random.nextInt(maxValidBase - minBase + 1);
  }

  /// 重複しない問題セットを生成
  static List<NumberProblem> generateUniqueProblems({
    required int count,
    int difference = 3,
    int maxBase = 10,
    ProblemType type = ProblemType.smaller,
  }) {
    final problems = <NumberProblem>[];
    final usedNumbers = <int>{};
    
    int attempts = 0;
    const maxAttempts = 100;
    
    while (problems.length < count && attempts < maxAttempts) {
      attempts++;
      
      try {
        final baseNumber = generateBaseNumber(
          difference: difference,
          maxBase: maxBase,
        );
        
        if (!usedNumbers.contains(baseNumber)) {
          final correctAnswer = type == ProblemType.smaller 
              ? baseNumber - difference 
              : baseNumber + difference;
              
          problems.add(NumberProblem(
            baseNumber: baseNumber,
            difference: difference,
            correctAnswer: correctAnswer,
            type: type,
          ));
          usedNumbers.add(baseNumber);
        }
      } catch (e) {
        // 生成失敗時は次の試行へ
        continue;
      }
    }
    
    if (problems.length < count) {
      throw StateError('十分な数の問題を生成できませんでした');
    }
    
    return problems;
  }
}