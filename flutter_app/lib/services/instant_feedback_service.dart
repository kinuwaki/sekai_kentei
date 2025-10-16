import 'package:audioplayers/audioplayers.dart';
import '../core/debug_logger.dart';

/// 即座のフィードバック音声サービス
/// 間違えたボタンを押した瞬間にbuzzer音を再生
class InstantFeedbackService {
  static final InstantFeedbackService _instance = InstantFeedbackService._internal();
  factory InstantFeedbackService() => _instance;
  InstantFeedbackService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();

  /// 間違い時の即座のブッブー音を再生
  /// ボタンを押した瞬間に呼び出す
  Future<void> playWrongAnswerFeedback() async {
    try {
      await _audioPlayer.play(AssetSource('audio/buzzer.mp3'));
      Log.d('Playing instant buzzer feedback', tag: 'InstantFeedback');
    } catch (e) {
      Log.e('Failed to play instant buzzer: $e', tag: 'InstantFeedback');
      // 音声ファイルが見つからない場合はサイレントに続行
    }
  }

  /// 正解時の即座のフィードバック（オプション）
  /// 必要に応じて使用
  Future<void> playCorrectAnswerFeedback() async {
    try {
      await _audioPlayer.play(AssetSource('audio/pinpon.mp3'));
      Log.d('Playing instant pinpon feedback', tag: 'InstantFeedback');
    } catch (e) {
      Log.e('Failed to play instant pinpon: $e', tag: 'InstantFeedback');
      // 音声ファイルが見つからない場合はサイレントに続行
    }
  }

  /// リソース解放
  void dispose() {
    _audioPlayer.dispose();
  }
}