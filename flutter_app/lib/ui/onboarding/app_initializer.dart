import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../home/landscape_home.dart';
import 'user_registration_screen.dart';
import '../../config/app_config.dart';
import '../../ui/debug/debug_menu_screen.dart';
import '../../services/user_data_manager.dart';

/// アプリ初期化画面
/// 設定に応じてデバッグメニュー、初回登録、メインメニューに振り分け
class AppInitializer extends ConsumerStatefulWidget {
  const AppInitializer({super.key});

  @override
  ConsumerState<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends ConsumerState<AppInitializer> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // 少し待ってから判定（スプラッシュ的な効果）
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      // デバッグメニューへの自動遷移チェック
      bool shouldJumpToDebug = false;
      try {
        shouldJumpToDebug = appConfig.jumpToDebugOnLaunch;
      } catch (e) {
        debugPrint('AppConfig not initialized: $e');
        // 初期起動時（appConfig未初期化）はデバッグメニューに遷移
        shouldJumpToDebug = true;
      }

      if (shouldJumpToDebug) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DebugMenuScreen()),
        );
        return;
      }

      // UserDataManagerから初期設定完了状態を確認
      bool isInitialSetupCompleted = false;
      try {
        final userDataManager = UserDataManager();
        isInitialSetupCompleted = userDataManager.isInitialSetupCompleted;
      } catch (e) {
        debugPrint('UserDataManager check failed: $e');
        // エラーの場合は初期設定未完了として扱う
      }

      if (!mounted) return;

      if (!isInitialSetupCompleted) {
        // 初期設定未完了 → ユーザー登録画面
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const UserRegistrationScreen()),
        );
      } else {
        // 初期設定完了済み → メインメニュー
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeLandscape()),
        );
      }
    } catch (e) {
      debugPrint('App initialization failed: $e');
      // エラーの場合はメインメニューに遷移
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeLandscape()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              size: 120,
              color: Colors.blue,
            ),
            SizedBox(height: 24),
            Text(
              'もんすたーあかでみー',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}