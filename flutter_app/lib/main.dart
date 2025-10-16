import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui/games/daily_challenge_screen.dart';
import 'ui/onboarding/app_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 縦固定
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
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
      title: '世界検定４級',
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