import '../core/debug_logger.dart';
import 'character_recognition_service_interface.dart';

CharacterRecognizer getRecognizer() {
  Log.e('CharacterRecognizer: Stub implementation - platform not supported');
  throw UnsupportedError('このプラットフォームは未対応です');
}