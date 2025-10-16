import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/tts_offline_service.dart';
import 'tts_service.dart';

/// TTS Service Provider - ProviderスコープでSingleton管理
/// 
/// 唯一の正規生成点。テスト時はoverrideWithValueでモック差し替え可能。
/// 
/// 使用例:
/// ```dart
/// // 本番
/// final tts = ref.read(ttsServiceProvider);
/// 
/// // テスト
/// final container = ProviderContainer(overrides: [
///   ttsServiceProvider.overrideWithValue(FakeTtsService()),
/// ]);
/// ```
final ttsServiceProvider = Provider<TtsService>((ref) {
  final service = TTSOfflineService.createForProvider(); // 唯一の正規生成点
  ref.onDispose(() => service.dispose()); // Providerスコープ終了時にリソース解放
  return service; // ProviderScope単位でSingleton
});