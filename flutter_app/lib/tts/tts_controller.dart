import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/debug_logger.dart';
import 'tts_service.dart';
import 'tts_provider.dart';

/// TTS状態（不変）
@immutable
class TtsState {
  const TtsState({
    this.isSpeaking = false,
    this.lastSpoken,
    this.lastError,
  });
  
  final bool isSpeaking;
  final String? lastSpoken;
  final String? lastError;
  
  TtsState copyWith({
    bool? isSpeaking,
    String? lastSpoken,
    String? lastError,
  }) {
    return TtsState(
      isSpeaking: isSpeaking ?? this.isSpeaking,
      lastSpoken: lastSpoken ?? this.lastSpoken,
      lastError: lastError,  // nullを明示的に設定可能
    );
  }
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TtsState &&
          runtimeType == other.runtimeType &&
          isSpeaking == other.isSpeaking &&
          lastSpoken == other.lastSpoken &&
          lastError == other.lastError;
  
  @override
  int get hashCode =>
      isSpeaking.hashCode ^ lastSpoken.hashCode ^ lastError.hashCode;
      
  @override
  String toString() => 
      'TtsState(isSpeaking: $isSpeaking, lastSpoken: $lastSpoken, lastError: $lastError)';
}

/// TTS Controller - 状態管理とサービス統合
class TtsController extends Notifier<TtsState> {
  late final TtsService _tts;
  StreamSubscription<bool>? _speakingSubscription;

  @override
  TtsState build() {
    // 依存注入：サービスを取得（生成はしない）
    _tts = ref.read(ttsServiceProvider);
    
    // TTS発話状態変更の監視
    _speakingSubscription = _tts.speakingChanges.listen(
      (isSpeaking) {
        if (state.isSpeaking != isSpeaking) {
          Log.d('TtsController: Speaking state changed to $isSpeaking', tag: 'TTS');
          state = state.copyWith(isSpeaking: isSpeaking);
        }
      },
      onError: (error) {
        Log.e('TtsController: Speaking stream error: $error', tag: 'TTS');
        state = state.copyWith(lastError: 'Speaking stream error: $error');
      },
    );
    
    // Providerが破棄される時のクリーンアップ
    ref.onDispose(() {
      _speakingSubscription?.cancel();
    });
    
    // 初期状態（サービスの現在状態を反映）
    return TtsState(
      isSpeaking: _tts.isSpeaking,
    );
  }

  /// 基本音声再生
  Future<void> speak(String text, {Function? onComplete}) async {
    if (text.isEmpty) return;
    
    try {
      Log.d('TtsController: Speaking: "$text"', tag: 'TTS');
      state = state.copyWith(lastSpoken: text, lastError: null);
      await _tts.speak(text, onComplete: onComplete);
    } catch (e) {
      Log.e('TtsController: Speak failed: $e', tag: 'TTS');
      state = state.copyWith(lastError: 'Speak failed: $e');
      rethrow;
    }
  }

  /// コンテキスト付き音声再生（エラー表示あり）
  Future<void> playTTS(BuildContext context, String text, {Function? onComplete}) async {
    if (text.isEmpty) return;
    
    try {
      Log.d('TtsController: Playing TTS: "$text"', tag: 'TTS');
      state = state.copyWith(lastSpoken: text, lastError: null);
      await _tts.playTTS(context, text, onComplete: onComplete);
    } catch (e) {
      Log.e('TtsController: PlayTTS failed: $e', tag: 'TTS');
      state = state.copyWith(lastError: 'PlayTTS failed: $e');
      rethrow;
    }
  }

  /// 音声停止
  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (e) {
      Log.e('TtsController: Stop failed: $e', tag: 'TTS');
      state = state.copyWith(lastError: 'Stop failed: $e');
      rethrow;
    }
  }

  // ========== 互換API（既存呼び出しを置き換えやすく） ==========
  
  Future<void> speakNumber(int number, {Function? onComplete}) async {
    await _tts.speakNumber(number, onComplete: onComplete);
  }
  
  Future<void> speakComparison(String text, {Function? onComplete}) async {
    await _tts.speakComparison(text, onComplete: onComplete);
  }
  
  Future<void> speakWritingInstruction(String character, {Function? onComplete}) async {
    await _tts.speakWritingInstruction(character, onComplete: onComplete);
  }
  
  Future<void> speakSequence(List<String> texts, {Function? onComplete}) async {
    await _tts.speakSequence(texts, onComplete: onComplete);
  }
  
  // ========== プリロード機能 ==========
  
  Future<void> preloadText(String text, {int speaker = 0}) async {
    await _tts.preloadText(text, speaker: speaker);
  }
  
  Future<void> preloadTexts(List<String> texts, {int speaker = 0}) async {
    await _tts.preloadTexts(texts, speaker: speaker);
  }
  
  // ========== 状態取得 ==========
  
  Set<String> getMissingFiles() => _tts.getMissingFiles();
  String generateMissingFilesReport() => _tts.generateMissingFilesReport();
}

/// TTS Controller Provider
final ttsControllerProvider = NotifierProvider<TtsController, TtsState>(() {
  return TtsController();
});

/// 簡単アクセス用プロバイダー
final isTtsSpeakingProvider = Provider<bool>((ref) {
  return ref.watch(ttsControllerProvider).isSpeaking;
});

final ttsHasErrorProvider = Provider<bool>((ref) {
  final state = ref.watch(ttsControllerProvider);
  return state.lastError != null;
});

final ttsErrorMessageProvider = Provider<String?>((ref) {
  return ref.watch(ttsControllerProvider).lastError;
});