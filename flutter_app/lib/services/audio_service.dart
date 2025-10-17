import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/debug_logger.dart';

/// 音声再生サービス（Riverpod管理）
class AudioService {
  static const String _tag = 'AudioService';
  final AudioPlayer _player;

  AudioService() : _player = AudioPlayer();

  /// 正解音を再生
  Future<void> playCorrect() async {
    try {
      await _player.stop();
      await _player.play(AssetSource('audio/pinpon.mp3'));
      Log.d('正解音を再生', tag: _tag);
    } catch (e) {
      Log.e('正解音の再生エラー: $e', tag: _tag);
    }
  }

  /// 不正解音を再生
  Future<void> playIncorrect() async {
    try {
      await _player.stop();
      await _player.play(AssetSource('audio/buzzer.mp3'));
      Log.d('不正解音を再生', tag: _tag);
    } catch (e) {
      Log.e('不正解音の再生エラー: $e', tag: _tag);
    }
  }

  /// 音声プレイヤーを破棄
  Future<void> dispose() async {
    await _player.dispose();
  }
}

/// AudioService Provider
final audioServiceProvider = Provider<AudioService>((ref) {
  final service = AudioService();
  ref.onDispose(() {
    service.dispose();
  });
  return service;
});
