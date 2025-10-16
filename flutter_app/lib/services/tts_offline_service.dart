import 'dart:convert';
import 'dart:async';
import 'package:crypto/crypto.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/debug_logger.dart';
import '../tts/tts_service.dart';

class TTSOfflineService implements TtsService {
  static final TTSOfflineService _instance = TTSOfflineService._internal();
  factory TTSOfflineService() {
    // レガシー使用検出（開発環境でのみ）
    assert(() {
      throw FlutterError(
        '❌ LEGACY TTS USAGE DETECTED!\n'
        'TTSOfflineService() should not be used directly.\n'
        'Use ttsServiceProvider instead:\n'
        '  • ref.read(ttsControllerProvider.notifier).speak(text)\n'
        '  • ref.watch(ttsControllerProvider).isSpeaking\n'
        '\n'
        'Migration guide: Replace all direct TTSOfflineService usage with TtsController.'
      );
    }());
    return _instance;
  }
  
  /// 正規の生成点（Providerからのみ使用）
  TTSOfflineService._internal();
  
  /// Provider専用ファクトリメソッド
  static TTSOfflineService createForProvider() {
    return TTSOfflineService._internal();
  }

  final AudioPlayer _player = AudioPlayer();
  final StreamController<bool> _speakingController = StreamController<bool>.broadcast();
  bool _isInitialized = false;
  Function? _onComplete;
  bool _isPlaying = false;
  
  // 欠落している音声ファイルのログ
  final Set<String> _missingFiles = <String>{};
  
  // プリロード済み音声ファイルのキャッシュ
  final Map<String, bool> _preloadedFiles = <String, bool>{};

  /// TtsService インターフェース実装
  @override
  Stream<bool> get speakingChanges => _speakingController.stream;
  
  @override
  bool get isSpeaking => _isPlaying;
  
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      Log.d('TTSOfflineService: Initializing');
      
      // AudioPlayerの設定
      _player.onPlayerComplete.listen((event) {
        Log.d('TTS: Completed playing');
        _isPlaying = false;
        _speakingController.add(false); // 発話状態変更を通知
        if (_onComplete != null) {
          _onComplete!();
          _onComplete = null;
        }
      });
      
      _player.onPlayerStateChanged.listen((state) {
        if (state == PlayerState.playing) {
          Log.d('TTS: Started playing');
          if (!_isPlaying) {
            _isPlaying = true;
            _speakingController.add(true); // 発話状態変更を通知
          }
        } else if (state == PlayerState.stopped || state == PlayerState.completed) {
          if (_isPlaying) {
            _isPlaying = false;
            _speakingController.add(false); // 発話状態変更を通知
          }
        }
      });

      _isInitialized = true;
      Log.d('TTSOfflineService: Initialized successfully');
      
      // よく使われる音声ファイルをプリロード
      _preloadCommonFiles();
    } catch (e) {
      Log.d('TTSOfflineService: Initialization failed: $e');
    }
  }
  
  /// よく使われる音声ファイルをプリロード
  Future<void> _preloadCommonFiles() async {
    // 最も使用頻度の高いテキスト
    final commonTexts = [
      // 書字練習では特定の共通音声は不要
    ];
    
    for (final text in commonTexts) {
      await _preloadAudio(text);
    }
  }
  
  /// 特定の音声ファイルをプリロード
  Future<void> _preloadAudio(String text, {int speaker = 0}) async {
    final fileName = _generateFileName(text, speaker: speaker);
    final assetPath = 'voice/$fileName';
    
    if (_preloadedFiles.containsKey(fileName)) {
      return; // 既にプリロード済み
    }
    
    try {
      // 別のAudioPlayerインスタンスでプリロードテスト
      final testPlayer = AudioPlayer();
      await testPlayer.setSource(AssetSource(assetPath));
      await testPlayer.dispose(); // テスト用なので即座に破棄
      
      _preloadedFiles[fileName] = true;
      Log.d('TTS [Preload]: Successfully validated $fileName');
    } catch (e) {
      _preloadedFiles[fileName] = false;
      // プリロード失敗はログのみ（エラー表示しない）
      Log.d('TTS [Preload]: Failed to validate $fileName - file does not exist');
    }
  }

  /// ファイル名生成（サーバー版と同じロジック）
  String _generateFileName(String text, {int speaker = 0}) {
    // テキストとspeakerIDを組み合わせてハッシュ生成
    final hashInput = '$text-speaker$speaker';
    final hash = md5.convert(utf8.encode(hashInput)).toString().substring(0, 6);
    
    // ファイル名に使えない文字を置換
    final safeText = text
        .replaceAll(RegExp(r'[\\/:*?"<>|]'), '_')
        .replaceAll(RegExp(r'\s+'), '_')
        .replaceAll('？', '_')
        .replaceAll('！', '_');
    
    // 最大長を制限（Python側と同じ30文字）
    final truncatedText = safeText.length > 30 ? safeText.substring(0, 30) : safeText;
    
    final fileName = "${truncatedText}_$hash.mp3";
    
    // デバッグ情報
    Log.d('TTS [FileName]: "$text" → "$fileName"');
    Log.d('TTS [FileName]: hashInput="$hashInput", hash="$hash", safeText="$safeText"');
    
    return fileName;
  }

  /// メイン音声再生関数（内部実装）
  Future<void> _playInternal(String text, {int speaker = 0, Function? onComplete, BuildContext? context}) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      // 既に再生中の場合は停止
      if (_isPlaying) {
        await stop();
        await Future.delayed(const Duration(milliseconds: 200));
      }

      _onComplete = onComplete;

      final fileName = _generateFileName(text, speaker: speaker);
      final assetPath = 'voice/$fileName';
      
      Log.d('TTS [Offline]: Playing text: "$text"');
      Log.d('TTS [Offline]: Filename: "$fileName"');

      // プリロード結果をチェック
      if (_preloadedFiles.containsKey(fileName) && _preloadedFiles[fileName] == false) {
        Log.d('TTS [Offline]: File was already validated as missing: $fileName');
        throw Exception('File not found (cached result)');
      }

      try {
        // プリロードされている場合でも正しいファイルを指定して再生
        Log.d('TTS [Offline]: Loading and playing audio');
        await _player.play(AssetSource(assetPath));
        
        Log.d('TTS [Offline]: Playing "$text" from assets');
      } catch (e) {
        // ファイルが見つからない場合
        if (!_missingFiles.contains(fileName)) {
          _missingFiles.add(fileName);
          Log.d('TTS [Offline]: Missing audio file: $fileName');
          Log.d('TTS [Offline]: Text: "$text"');
          Log.d('TTS [Offline]: Generate with command:');
          Log.d('    cd tools/voicevox && python generate_voice_assets.py --text "$text" --speaker $speaker');
          
          // エラー表示（コンテキストがある場合）
          if (context != null && context.mounted) {
            _showError(context, "音声ファイルが見つかりません: $fileName\n事前生成が必要です");
          }
        }
        
        // 代替処理: ハプティックフィードバック
        try {
          await HapticFeedback.selectionClick();
        } catch (_) {
          // ハプティックが使えない環境では無視
        }
      }
      
    } catch (e) {
      Log.d('❌ TTSOfflineService: Play error: $e');
      _isPlaying = false;
    }
  }

  /// 音声再生関数（エラー表示あり）
  @override
  Future<void> playTTS(BuildContext context, String text, {Function? onComplete}) async {
    await _playInternal(text, speaker: 0, onComplete: onComplete, context: context);
  }

  /// 音声再生（コンテキスト不要版 - エラー表示なし）
  @override
  Future<void> speak(String text, {Function? onComplete}) async {
    await _playInternal(text, speaker: 0, onComplete: onComplete);
  }

  /// 数値を日本語で読み上げ
  @override
  Future<void> speakNumber(int number, {Function? onComplete}) async {
    final text = getJapaneseNumber(number);
    await speak(text, onComplete: onComplete);
  }

  /// 比較問題用の読み上げ
  @override
  Future<void> speakComparison(String text, {Function? onComplete}) async {
    // 統一して話者0を使用
    await speak(text, onComplete: onComplete);
  }

  /// 連続音声再生（文字 + 指示文）
  @override
  Future<void> speakSequence(List<String> texts, {Function? onComplete}) async {
    if (texts.isEmpty) {
      onComplete?.call();
      return;
    }

    // 再帰的に次のテキストを再生
    Future<void> playNext(int index) async {
      if (index >= texts.length) {
        onComplete?.call();
        return;
      }

      await speak(
        texts[index],
        onComplete: () => playNext(index + 1),
      );
    }

    await playNext(0);
  }

  /// なぞり書き用の連続音声再生
  @override
  Future<void> speakWritingInstruction(String character, {Function? onComplete}) async {
    await speakSequence([
      character,  // まず文字名
      'を なぞって かこう'  // 次に指示文（間隔を入れて分離）
    ], onComplete: onComplete);
  }

  /// 停止
  @override
  Future<void> stop() async {
    try {
      await _player.stop();
      if (_isPlaying) {
        _isPlaying = false;
        _speakingController.add(false); // 停止状態を通知
      }
      _onComplete = null;
      Log.d('TTSOfflineService: Stopped');
    } catch (e) {
      Log.d('TTSOfflineService: Stop error: $e');
    }
  }

  /// 欠落ファイルリストを取得
  @override
  Set<String> getMissingFiles() {
    return Set<String>.from(_missingFiles);
  }

  /// 欠落ファイルの詳細レポートを生成
  @override
  String generateMissingFilesReport() {
    if (_missingFiles.isEmpty) {
      return "すべての音声ファイルが正常に見つかりました。";
    }
    
    final buffer = StringBuffer();
    buffer.writeln("=== 欠落している音声ファイル ===");
    buffer.writeln("合計: ${_missingFiles.length} ファイル");
    buffer.writeln("");
    
    for (final file in _missingFiles) {
      buffer.writeln("  - $file");
    }
    
    buffer.writeln("");
    buffer.writeln("💡 生成方法:");
    buffer.writeln("cd tools/voicevox");
    buffer.writeln("python generate_voice_assets.py");
    
    return buffer.toString();
  }

  bool get isPlaying => _isPlaying;

  String getJapaneseNumber(int number) {
    switch (number) {
      case 1: return 'いち';
      case 2: return 'に';
      case 3: return 'さん';
      case 4: return 'よん';
      case 5: return 'ご';
      case 6: return 'ろく';
      case 7: return 'なな';
      case 8: return 'はち';
      case 9: return 'きゅう';
      case 10: return 'じゅう';
      case 11: return 'じゅういち';
      case 12: return 'じゅうに';
      case 13: return 'じゅうさん';
      case 14: return 'じゅうよん';
      case 15: return 'じゅうご';
      case 16: return 'じゅうろく';
      case 17: return 'じゅうなな';
      case 18: return 'じゅうはち';
      case 19: return 'じゅうきゅう';
      case 20: return 'にじゅう';
      case 30: return 'さんじゅう';
      case 40: return 'よんじゅう';
      case 50: return 'ごじゅう';
      case 60: return 'ろくじゅう';
      case 70: return 'ななじゅう';
      case 80: return 'はちじゅう';
      case 90: return 'きゅうじゅう';
      case 100: return 'ひゃく';
      default: 
        // 21-99の複合数字を処理
        if (number > 20 && number < 100) {
          final tens = (number ~/ 10) * 10;
          final ones = number % 10;
          return getJapaneseNumber(tens) + getJapaneseNumber(ones);
        }
        return number.toString();
    }
  }

  /// エラー表示用
  void _showError(BuildContext context, String message) {
    if (!context.mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// 特定のテキストをプリロード（ゲーム開始前に呼び出し可能）
  @override
  Future<void> preloadText(String text, {int speaker = 0}) async {
    await _preloadAudio(text, speaker: speaker);
  }
  
  /// 複数のテキストを一括プリロード
  @override
  Future<void> preloadTexts(List<String> texts, {int speaker = 0}) async {
    for (final text in texts) {
      await _preloadAudio(text, speaker: speaker);
    }
  }

  @override
  Future<void> dispose() async {
    await stop();
    await _player.dispose();
    await _speakingController.close(); // StreamControllerを適切に閉じる
  }
}