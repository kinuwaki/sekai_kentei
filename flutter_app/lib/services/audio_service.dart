import 'package:audioplayers/audioplayers.dart';
import '../core/debug_logger.dart';

/// 音声再生サービス
class AudioService {
  static const String _tag = 'AudioService';
  static final AudioPlayer _player = AudioPlayer();

  /// 正解音を再生
  static Future<void> playCorrect() async {
    try {
      await _player.stop();
      await _player.play(AssetSource('audio/pinpon.mp3'));
      Log.d('正解音を再生', tag: _tag);
    } catch (e) {
      Log.e('正解音の再生エラー: $e', tag: _tag);
    }
  }

  /// 不正解音を再生
  static Future<void> playIncorrect() async {
    try {
      await _player.stop();
      await _player.play(AssetSource('audio/buzzer.mp3'));
      Log.d('不正解音を再生', tag: _tag);
    } catch (e) {
      Log.e('不正解音の再生エラー: $e', tag: _tag);
    }
  }

  /// 音声プレイヤーを破棄
  static Future<void> dispose() async {
    await _player.dispose();
  }
}
