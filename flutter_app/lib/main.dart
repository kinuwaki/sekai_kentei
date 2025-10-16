import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'config/app_config.dart';
import 'ui/home/landscape_home.dart';
import 'ui/games/daily_challenge_screen.dart';
import 'ui/onboarding/app_initializer.dart';
import 'core/lesson/game_settings_registry.dart';
import 'services/user_data_manager.dart';
import 'services/pwa_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // 設定ファイルを読み込み
    await initializeConfig();

    // ゲーム設定レジストリを初期化
    GameSettingsRegistry.initialize();

    // ユーザーデータマネージャーを初期化（エラー時はスキップ）
    try {
      await UserDataManager().initialize();
    } catch (e) {
      debugPrint('UserDataManager initialization failed: $e');
    }

    // PWAサービスを初期化（Web版のみ）
    if (kIsWeb) {
      try {
        await PWAService().initialize();
      } catch (e) {
        debugPrint('PWAService initialization failed: $e');
      }
    }
  } catch (e) {
    debugPrint('Main initialization failed: $e');
  }

  // 横固定
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // ゲームらしく全画面
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const ProviderScope(child: MiniGameApp()));
}

class MiniGameApp extends StatelessWidget {
  const MiniGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'もんすたーあかでみー',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'NotoSansJP',
      ),
      home: const AppInitializer(),
      routes: {
        '/daily_challenge': (context) => const DailyChallengeScreen(),
      },
    );
  }
}