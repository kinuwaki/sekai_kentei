import 'dart:async';
import 'dart:io' show Platform;
import 'dart:typed_data';

import 'package:flutter/material.dart' show Offset;

import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart' as ml;
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart' as ink;

import '../core/debug_logger.dart';
import '../ui/games/writing_game/writing_game_models.dart';
import 'character_recognition_service_interface.dart';

CharacterRecognizer getRecognizer() {
  if (Platform.isIOS || Platform.isAndroid) {
    Log.d('CharacterRecognizer: Using AndroidCharacterRecognizer (Google ML Kit Digital Ink)');
    return AndroidCharacterRecognizer();
  } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    Log.d('CharacterRecognizer: Using WindowsCharacterRecognizer (Development Mock)');
    return WindowsCharacterRecognizer();
  } else {
    throw UnsupportedError('このプラットフォームは未対応です');
  }
}

// === iOS版の認識器（Apple Vision Framework） ===
class IOSCharacterRecognizer implements CharacterRecognizer {
  static const MethodChannel _channel = MethodChannel('apple_vision_text_recognition');
  bool _isInitialized = false;
  
  @override
  Future<void> initialize() async {
    try {
      Log.d('IOSCharacterRecognizer: Initializing Apple Vision Framework...');
      
      final result = await _channel.invokeMethod('initialize', {
        'supportedLanguages': ['ja', 'en'], // 日本語と英語をサポート
        'recognitionLevel': 'accurate', // accurate または fast
        'usesLanguageCorrection': true, // 言語補正を有効
      });
      
      if (result['success'] == true) {
        _isInitialized = true;
        Log.d('IOSCharacterRecognizer: Apple Vision Framework initialized successfully');
        Log.d('IOSCharacterRecognizer: Supported languages: ${result['supportedLanguages']}');
      } else {
        throw Exception('Apple Vision Framework initialization failed: ${result['error']}');
      }
    } catch (e) {
      Log.e('IOSCharacterRecognizer: Initialization failed: $e');
      _isInitialized = false;
      rethrow;
    }
  }
  
  @override
  Future<RecognitionResult> recognize(Uint8List imageData, {RecognitionType type = RecognitionType.hiragana}) async {
    try {
      Log.d('IOSCharacterRecognizer: Starting recognition process for type: $type');
      
      if (!_isInitialized) {
        await initialize();
      }
      
      if (!_isInitialized) {
        return _createFallbackResult('Apple Vision Framework が初期化されていません');
      }
      
      Log.d('IOSCharacterRecognizer: Preparing image data (${imageData.length} bytes)');
      
      // Apple Vision Framework で認識を実行
      final result = await _channel.invokeMethod('recognizeText', {
        'imageData': imageData,
        'recognitionType': type.name,
        'customWords': _getCustomWordsForType(type), // タイプ別カスタム単語
        'minimumTextHeight': 0.03, // 最小文字高さ（画像の3%）
      });
      
      Log.d('IOSCharacterRecognizer: Native recognition completed');
      Log.d('IOSCharacterRecognizer: Raw result: $result');
      
      if (result['success'] != true) {
        final error = result['error'] ?? 'Unknown error';
        Log.w('IOSCharacterRecognizer: Recognition failed: $error');
        return _createFallbackResult('認識エラー: $error');
      }
      
      final recognizedTexts = result['recognizedTexts'] as List<dynamic>? ?? [];
      Log.d('IOSCharacterRecognizer: Found ${recognizedTexts.length} text candidates');
      
      if (recognizedTexts.isEmpty) {
        Log.w('IOSCharacterRecognizer: No text detected in image');
        return _createFallbackResult('文字が検出されませんでした');
      }
      
      // 認識結果を処理
      final candidates = <RecognizedCandidate>[];
      for (int i = 0; i < recognizedTexts.length; i++) {
        final textData = recognizedTexts[i] as Map<dynamic, dynamic>;
        final text = textData['text'] as String? ?? '';
        final confidence = (textData['confidence'] as num?)?.toDouble() ?? 0.0;
        
        if (text.isNotEmpty && _isValidForType(text, type)) {
          candidates.add(RecognizedCandidate(
            text: text,
            confidence: confidence,
            rank: i + 1,
          ));
          Log.d('IOSCharacterRecognizer: Candidate ${i + 1}: "$text" (confidence: ${confidence.toStringAsFixed(3)})');
        }
      }
      
      if (candidates.isEmpty) {
        Log.w('IOSCharacterRecognizer: No valid candidates for type $type');
        return _createFallbackResult('${type.name}文字が認識できませんでした');
      }
      
      // 信頼度でソート
      candidates.sort((a, b) => b.confidence.compareTo(a.confidence));
      final bestCandidate = candidates.first;
      
      Log.i('IOSCharacterRecognizer: Best result: "${bestCandidate.text}" (confidence: ${bestCandidate.confidence.toStringAsFixed(3)})');
      
      return RecognitionResult(
        text: bestCandidate.text,
        confidence: bestCandidate.confidence,
        isRecognized: true,
        candidates: candidates.take(5).toList(),
      );
    } catch (e) {
      Log.e('IOSCharacterRecognizer: Recognition failed with exception: $e');
      return _createFallbackResult('認識エラー: $e');
    }
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
  
  List<String> _getCustomWordsForType(RecognitionType type) {
    switch (type) {
      case RecognitionType.numbers:
        return ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
      case RecognitionType.hiragana:
        return ['あ', 'い', 'う', 'え', 'お', 'か', 'き', 'く', 'け', 'こ', 'さ', 'し', 'す', 'せ', 'そ', 'た', 'ち', 'つ', 'て', 'と', 'な', 'に', 'ぬ', 'ね', 'の', 'は', 'ひ', 'ふ', 'へ', 'ほ', 'ま', 'み', 'む', 'め', 'も', 'や', 'ゆ', 'よ', 'ら', 'り', 'る', 'れ', 'ろ', 'わ', 'を', 'ん'];
      case RecognitionType.katakana:
        return ['ア', 'イ', 'ウ', 'エ', 'オ', 'カ', 'キ', 'ク', 'ケ', 'コ', 'サ', 'シ', 'ス', 'セ', 'ソ', 'タ', 'チ', 'ツ', 'テ', 'ト', 'ナ', 'ニ', 'ヌ', 'ネ', 'ノ', 'ハ', 'ヒ', 'フ', 'ヘ', 'ホ', 'マ', 'ミ', 'ム', 'メ', 'モ', 'ヤ', 'ユ', 'ヨ', 'ラ', 'リ', 'ル', 'レ', 'ロ', 'ワ', 'ヲ', 'ン'];
    }
  }
  
  bool _isValidForType(String text, RecognitionType type) {
    if (text.isEmpty) return false;
    
    switch (type) {
      case RecognitionType.numbers:
        return RegExp(r'^[0-9]+$').hasMatch(text);
      case RecognitionType.hiragana:
        return RegExp(r'^[あ-ん]+$').hasMatch(text);
      case RecognitionType.katakana:
        return RegExp(r'^[ア-ン]+$').hasMatch(text);
    }
  }
  
  @override
  void dispose() {
    _isInitialized = false;
    Log.d('IOSCharacterRecognizer: Disposed');
  }
}

// === Android版の認識器（Google ML Kit） ===
class AndroidCharacterRecognizer implements CharacterRecognizer {
  ml.TextRecognizer? _textRecognizer;
  ink.DigitalInkRecognizer? _inkRecognizer;
  ink.DigitalInkRecognizerModelManager? _modelManager;
  bool _isModelReady = false;

  @override
  Future<void> initialize() async {
    try {
      Log.d('AndroidCharacterRecognizer: Initializing...');

      // Model Managerを初期化
      _modelManager = ink.DigitalInkRecognizerModelManager();

      // モデルの確認とダウンロード
      await _ensureModelReady();

      // Digital Ink Recognition（手書き専用）を初期化
      _inkRecognizer = ink.DigitalInkRecognizer(languageCode: 'ja');

      Log.d('AndroidCharacterRecognizer: Initialization completed');
    } catch (e) {
      Log.e('AndroidCharacterRecognizer: Initialization failed: $e');
      rethrow;
    }
  }

  Future<void> _ensureModelReady() async {
    if (_isModelReady) return;

    const tag = 'ja';
    try {
      final hasModel = await _modelManager!.isModelDownloaded(tag);
      if (!hasModel) {
        Log.d('AndroidCharacterRecognizer: Downloading model: $tag');
        await _modelManager!.downloadModel(tag);
        Log.d('AndroidCharacterRecognizer: Model download completed: $tag');
      }
      _isModelReady = true;
    } catch (e) {
      Log.e('AndroidCharacterRecognizer: Model setup failed: $e');
      rethrow;
    }
  }
  
  @override
  Future<RecognitionResult> recognize(Uint8List imageData, {RecognitionType type = RecognitionType.hiragana}) async {
    // 画像認識は使わない - ストロークデータから認識する必要がある
    return _createFallbackResult('画像認識は非対応。ストロークデータを使用してください。');
  }

  /// ストロークデータから手書き文字を認識
  Future<RecognitionResult> recognizeStrokes(List<List<Offset>> strokeData, {RecognitionType type = RecognitionType.hiragana}) async {
    try {
      await initialize();

      if (_inkRecognizer == null) {
        return _createFallbackResult('Digital Ink認識器が初期化されていません');
      }

      // ストロークデータをInkオブジェクトに変換
      final strokes = <ink.Stroke>[];

      for (final stroke in strokeData) {
        final points = <ink.StrokePoint>[];

        for (int i = 0; i < stroke.length; i++) {
          final point = stroke[i];
          points.add(ink.StrokePoint(
            x: point.dx,
            y: point.dy,
            t: DateTime.now().millisecondsSinceEpoch + i,
          ));
        }

        if (points.isNotEmpty) {
          final digitalStroke = ink.Stroke();
          digitalStroke.points = points;
          strokes.add(digitalStroke);
        }
      }

      if (strokes.isEmpty) {
        return _createFallbackResult('有効なストロークデータがありません');
      }

      final digitalInk = ink.Ink();
      digitalInk.strokes = strokes;

      // Digital Ink認識実行（再試行付き）
      return await _recognizeWithRetry(digitalInk);

    } catch (e) {
      Log.e('AndroidCharacterRecognizer: Stroke recognition failed: $e');
      return _createFallbackResult('ストローク認識エラー: $e');
    }
  }

  /// 認識実行（モデル未ダウンロードエラー時に再試行）
  Future<RecognitionResult> _recognizeWithRetry(ink.Ink digitalInk) async {
    try {
      final candidates = await _inkRecognizer!.recognize(digitalInk);

      if (candidates.isEmpty) {
        return _createFallbackResult('手書き文字が認識できませんでした');
      }

      // 結果を処理
      final recognizedCandidates = <RecognizedCandidate>[];
      for (int i = 0; i < candidates.length; i++) {
        final candidate = candidates[i];
        final score = candidate.score.toDouble();
        Log.d('AndroidCharacterRecognizer: Raw candidate ${i + 1}: "${candidate.text}" score=${candidate.score} -> ${score.toStringAsFixed(6)}');
        recognizedCandidates.add(RecognizedCandidate(
          text: candidate.text,
          confidence: score,
          rank: i + 1,
        ));
      }

      final bestCandidate = recognizedCandidates.first;

      return RecognitionResult(
        text: bestCandidate.text,
        confidence: bestCandidate.confidence,
        isRecognized: true,
        candidates: recognizedCandidates,
      );

    } on PlatformException catch (e) {
      // モデル未ダウンロードエラーの場合は再ダウンロードして再試行
      if (e.message?.contains('Model has not been downloaded') ?? false) {
        Log.w('AndroidCharacterRecognizer: Model download issue detected, retrying...');

        try {
          // モデル状態をリセットして再ダウンロード
          _isModelReady = false;
          await _ensureModelReady();

          // 認識器を再初期化
          _inkRecognizer?.close();
          _inkRecognizer = ink.DigitalInkRecognizer(languageCode: 'ja');

          // 再試行
          final candidates = await _inkRecognizer!.recognize(digitalInk);

          if (candidates.isEmpty) {
            return _createFallbackResult('手書き文字が認識できませんでした（再試行後）');
          }

          // 結果を処理
          final recognizedCandidates = <RecognizedCandidate>[];
          for (int i = 0; i < candidates.length; i++) {
            final candidate = candidates[i];
            recognizedCandidates.add(RecognizedCandidate(
              text: candidate.text,
              confidence: candidate.score.toDouble(),
              rank: i + 1,
            ));
          }

          final bestCandidate = recognizedCandidates.first;

          return RecognitionResult(
            text: bestCandidate.text,
            confidence: bestCandidate.confidence,
            isRecognized: true,
            candidates: recognizedCandidates,
          );

        } catch (retryError) {
          Log.e('AndroidCharacterRecognizer: Retry failed: $retryError');
          return _createFallbackResult('モデル再ダウンロード後の認識に失敗: $retryError');
        }
      } else {
        rethrow;
      }
    }
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
    _textRecognizer?.close();
    _inkRecognizer?.close();
    _textRecognizer = null;
    _inkRecognizer = null;
    _modelManager = null;
    _isModelReady = false;
  }
}

// === Windows版の認識器（開発用モック） ===
class WindowsCharacterRecognizer implements CharacterRecognizer {
  bool _isInitialized = false;
  
  @override
  Future<void> initialize() async {
    try {
      Log.d('WindowsCharacterRecognizer: Initializing development mock...');
      _isInitialized = true;
      Log.d('WindowsCharacterRecognizer: Mock initialization completed');
    } catch (e) {
      Log.e('WindowsCharacterRecognizer: Initialization failed: $e');
      _isInitialized = false;
      rethrow;
    }
  }
  
  @override
  Future<RecognitionResult> recognize(Uint8List imageData, {RecognitionType type = RecognitionType.hiragana}) async {
    try {
      Log.d('WindowsCharacterRecognizer: Mock recognition process for type: $type');
      
      if (!_isInitialized) {
        await initialize();
      }
      
      if (!_isInitialized) {
        return _createFallbackResult('モック認識器が初期化されていません');
      }
      
      Log.d('WindowsCharacterRecognizer: Processing image data (${imageData.length} bytes)');
      
      // 開発用のモック結果を返す
      final mockResults = _getMockResultsForType(type);
      final candidates = <RecognizedCandidate>[];
      
      for (int i = 0; i < mockResults.length; i++) {
        final result = mockResults[i];
        candidates.add(RecognizedCandidate(
          text: result['text'] as String,
          confidence: result['confidence'] as double,
          rank: i + 1,
        ));
        Log.d('WindowsCharacterRecognizer: Mock candidate ${i + 1}: "${result['text']}" (confidence: ${result['confidence'].toStringAsFixed(3)})');
      }
      
      if (candidates.isEmpty) {
        Log.w('WindowsCharacterRecognizer: No mock candidates for type $type');
        return _createFallbackResult('${type.name}のモック結果がありません');
      }
      
      final bestCandidate = candidates.first;
      
      Log.i('WindowsCharacterRecognizer: Mock result: "${bestCandidate.text}" (confidence: ${bestCandidate.confidence.toStringAsFixed(3)})');
      
      return RecognitionResult(
        text: bestCandidate.text,
        confidence: bestCandidate.confidence,
        isRecognized: true,
        candidates: candidates.take(5).toList(),
      );
    } catch (e) {
      Log.e('WindowsCharacterRecognizer: Mock recognition failed: $e');
      return _createFallbackResult('モック認識エラー: $e');
    }
  }
  
  List<Map<String, dynamic>> _getMockResultsForType(RecognitionType type) {
    switch (type) {
      case RecognitionType.numbers:
        return [
          {'text': '5', 'confidence': 0.95},
          {'text': '3', 'confidence': 0.85},
          {'text': '8', 'confidence': 0.75},
        ];
      case RecognitionType.hiragana:
        return [
          {'text': 'あ', 'confidence': 0.92},
          {'text': 'い', 'confidence': 0.88},
          {'text': 'う', 'confidence': 0.82},
        ];
      case RecognitionType.katakana:
        return [
          {'text': 'ア', 'confidence': 0.90},
          {'text': 'イ', 'confidence': 0.86},
          {'text': 'ウ', 'confidence': 0.80},
        ];
    }
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
    _isInitialized = false;
    Log.d('WindowsCharacterRecognizer: Mock disposed');
  }
}