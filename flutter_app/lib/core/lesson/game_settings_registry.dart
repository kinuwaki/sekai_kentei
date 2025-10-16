import 'game_settings_base.dart';
import 'counting_game_settings.dart';
import 'comparison_game_settings.dart';
import 'writing_game_settings.dart';

/// ゲーム設定レジストリの初期化
class GameSettingsRegistry {
  static bool _initialized = false;
  
  /// レジストリを初期化（アプリ起動時に一度だけ呼ぶ）
  static void initialize() {
    if (_initialized) return;
    
    // 各ゲームタイプを登録
    GameSettingsFactory.register(
      'counting.v1',
      (yaml) => CountingGameSettingsUnified.fromYaml(yaml),
    );
    
    GameSettingsFactory.register(
      'comparison.v1', 
      (yaml) => ComparisonGameSettingsUnified.fromYaml(yaml),
    );
    
    GameSettingsFactory.register(
      'writing.v1',
      (yaml) => WritingGameSettingsUnified.fromYaml(yaml),
    );
    
    _initialized = true;
  }
  
  /// 登録状態をリセット（テスト用）
  static void reset() {
    _initialized = false;
  }
}