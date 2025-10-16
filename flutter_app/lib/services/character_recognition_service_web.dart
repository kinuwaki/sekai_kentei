import 'dart:async';
import 'dart:js_util' as jsu;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';

import '../core/debug_logger.dart';
import '../ui/games/writing_game/writing_game_models.dart';
import 'character_recognition_service_interface.dart';

CharacterRecognizer getRecognizer() {
  Log.d('CharacterRecognizer: Using WebCharacterRecognizer (ONNX Runtime Web + MNIST)');
  return WebCharacterRecognizer();
}

// === Web版の認識器（old-school dart:js版） ===
class WebCharacterRecognizer implements CharacterRecognizer {
  static bool _initialized = false;

  // 1) JS が本当に読めてるか（globalThis経由で確実にアクセス）
  bool get isJsWired =>
    jsu.hasProperty(jsu.globalThis, '__MNIST_WIRED__') &&
    jsu.getProperty(jsu.globalThis, '__MNIST_WIRED__') == true;

  // 2) ORT がいるか（globalThis経由で確実にアクセス）
  bool get isOrtPresent =>
    jsu.hasProperty(jsu.globalThis, 'ort') && jsu.getProperty(jsu.globalThis, 'ort') != null;

  // 3) 初期化待ち
  Future<void> ensureMnistReady() async {
    if (!jsu.hasProperty(jsu.globalThis, 'mnistReady')) {
      throw Exception('mnistReady is not on window (mnist_ocr.js not loaded yet?)');
    }
    final promise = jsu.getProperty(jsu.globalThis, 'mnistReady');
    await jsu.promiseToFuture<void>(promise);
  }

  // 4) 推論
  Future<Map<String, dynamic>> predictDigit(Float32List data28x28) async {
    await ensureMnistReady();
    // JSの Float32Array を生成して渡す（型を厳密に）
    final float32Ctor = jsu.getProperty(jsu.globalThis, 'Float32Array');
    final jsTyped = jsu.callConstructor(float32Ctor, [data28x28]);
    final result = await jsu.promiseToFuture<Object?>(jsu.callMethod(jsu.globalThis, 'predictDigit28x28', [jsTyped]));
    final r = jsu.dartify(result) as Map;
    return {'digit': r['digit'], 'score': r['score'], 'margin': r['margin']};
  }

  /// JS の準備完了を待つ（ホットリスタート対応）
  Future<void> waitForJsReady({Duration timeout = const Duration(seconds: 5)}) async {
    final completer = Completer<void>();
    final start = DateTime.now();

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final wired = jsu.hasProperty(jsu.globalThis, '__MNIST_WIRED__') &&
                    jsu.getProperty(jsu.globalThis, '__MNIST_WIRED__') == true;
      if (wired) {
        timer.cancel();
        completer.complete();
      } else if (DateTime.now().difference(start) > timeout) {
        timer.cancel();
        completer.completeError('JS not ready after $timeout');
      }
    });

    return completer.future;
  }

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      Log.d('WebCharacterRecognizer: Starting initialization...');
      
      if (kIsWeb) {
        // ホットリスタート対応：JSの準備完了を待つ
        Log.d('WebCharacterRecognizer: Waiting for JS to be ready...');
        await waitForJsReady();
        
        // 基本動作の可視化
        Log.d('WebCharacterRecognizer: isJsWired = $isJsWired');
        Log.d('WebCharacterRecognizer: isOrtPresent = $isOrtPresent');
        
        if (!isJsWired) {
          throw Exception('isJsWired=false → mnist_ocr.js が未ロード（パス or 順序 or 404）');
        }
        
        if (!isOrtPresent) {
          throw Exception('isOrtPresent=false → ort.min.js 未ロード（順序 or 404）');
        }
        
        // 初期化待ち
        await ensureMnistReady();
        
        Log.d('WebCharacterRecognizer: MNIST initialization completed successfully');
      }
      
      _initialized = true;
    } catch (e) {
      Log.e('WebCharacterRecognizer: Initialization failed: $e');
      
      // エラー詳細を確認
      try {
        final error = jsu.getProperty(jsu.globalThis, '__MNIST_INIT_ERROR');
        if (error != null) {
          final errorInfo = jsu.dartify(error) as Map?;
          Log.e('WebCharacterRecognizer: Init error details: $errorInfo');
        }
      } catch (_) {}
      
      rethrow;
    }
  }

  @override
  Future<RecognitionResult> recognize(Uint8List imageData, {RecognitionType type = RecognitionType.hiragana}) async {
    try {
      Log.d('WebCharacterRecognizer: recognize called with type=$type');
      await initialize();
      
      if (type == RecognitionType.numbers) {
        // 数字認識（MNIST + ONNX Runtime）
        return await _recognizeNumberWithONNX(imageData);
      } else {
        // ひらがな認識（フォールバック）
        return _createFallbackResult('Web版は数字のみ対応');
      }
    } catch (e) {
      Log.e('WebCharacterRecognizer: Recognition failed: $e');
      return _createFallbackResult('認識エラー: $e');
    }
  }

  Future<RecognitionResult> _recognizeNumberWithONNX(Uint8List imageData) async {
    try {
      Log.d('WebCharacterRecognizer: Starting MNIST number recognition');
      
      // 画像を28x28のFloat32Listに変換
      final data28x28 = await _prepareImageForMNIST(imageData);
      
      // JS側で推論実行
      final result = await predictDigit(data28x28);
      
      final digit = result['digit'] as int;
      final score = (result['score'] as num).toDouble();
      final margin = (result['margin'] as num).toDouble();
      
      Log.d('WebCharacterRecognizer: MNIST result - digit: $digit, score: $score, margin: $margin');
      
      // 信頼度の閾値でフィルタリング
      if (score < 0.5 || margin < 0.1) {
        Log.d('WebCharacterRecognizer: Low confidence - score: $score, margin: $margin');
        return _createFallbackResult('認識に失敗しました');
      }
      
      return RecognitionResult(
        text: digit.toString(),
        confidence: score,
        isRecognized: true,
        candidates: [
          RecognizedCandidate(
            text: digit.toString(),
            confidence: score,
            rank: 1,
          ),
        ],
      );
    } catch (e) {
      Log.e('WebCharacterRecognizer: MNIST recognition error: $e');
      return _createFallbackResult('数字認識エラー: $e');
    }
  }

  Future<Float32List> _prepareImageForMNIST(Uint8List imageData) async {
    // PNG/JPEGをデコードして画像オブジェクトを取得
    final codec = await ui.instantiateImageCodec(imageData);
    final frame = await codec.getNextFrame();
    final image = frame.image;
    
    // 元画像のサイズ
    final width = image.width;
    final height = image.height;
    
    Log.d('WebCharacterRecognizer: Original image size: ${width}x$height');
    
    // 28x28にリサイズ
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    final paint = ui.Paint()..filterQuality = ui.FilterQuality.high;
    
    // 28x28に描画
    canvas.drawImageRect(
      image,
      ui.Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
      const ui.Rect.fromLTWH(0, 0, 28, 28),
      paint,
    );
    
    final picture = recorder.endRecording();
    final resized = await picture.toImage(28, 28);
    
    // ピクセルデータを取得
    final byteData = await resized.toByteData(format: ui.ImageByteFormat.rawRgba);
    if (byteData == null) {
      throw Exception('Failed to get pixel data');
    }
    
    // RGBA -> グレースケール変換 & 正規化
    final pixels = byteData.buffer.asUint8List();
    final float32Data = Float32List(28 * 28);
    
    for (int i = 0; i < 28 * 28; i++) {
      final pixelIndex = i * 4; // RGBA
      final r = pixels[pixelIndex];
      final g = pixels[pixelIndex + 1];
      final b = pixels[pixelIndex + 2];
      final a = pixels[pixelIndex + 3];
      
      // グレースケール変換（アルファチャンネルを考慮）
      final gray = (0.299 * r + 0.587 * g + 0.114 * b) * (a / 255.0);
      
      // MNISTは黒背景・白文字なので反転して正規化
      float32Data[i] = gray / 255.0;
    }
    
    return float32Data;
  }

  RecognitionResult _createFallbackResult(String message) {
    return RecognitionResult(
      text: '',
      confidence: 0.0,
      isRecognized: false,
      candidates: [],
      debugInfo: message,
    );
  }

  @override
  void dispose() {
    // Web版では特にリソース解放は不要
  }
}