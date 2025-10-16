import 'dart:typed_data';

import '../ui/games/writing_game/writing_game_models.dart';

// === 認識タイプ列挙 ===
enum RecognitionType {
  numbers,    // 数字認識（0-9）
  hiragana,   // ひらがな認識（あ-ん）
  katakana,   // カタカナ認識（ア-ン）
}

// === 抽象クラス ===
abstract class CharacterRecognizer {
  Future<RecognitionResult> recognize(Uint8List imageData, {RecognitionType type = RecognitionType.hiragana});
  Future<void> initialize();
  void dispose();
}