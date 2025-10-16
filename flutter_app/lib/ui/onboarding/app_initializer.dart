import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../games/daily_challenge_screen.dart';
import '../../services/sekai_kentei_csv_loader.dart';

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
      // 問題データをプリロード（起動時に一括ロード）
      debugPrint('問題データをプリロード中...');
      final loader = SekaiKenteiCsvLoader();
      await loader.loadQuestions();
      debugPrint('問題データのプリロード完了');

      // 少し待ってから判定（スプラッシュ的な効果）
      await Future.delayed(const Duration(milliseconds: 300));

      if (!mounted) return;

      // 直接クイズモード選択画面へ遷移
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DailyChallengeScreen()),
      );
    } catch (e) {
      debugPrint('App initialization failed: $e');
      // エラーの場合もクイズモード選択画面へ
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DailyChallengeScreen()),
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
              '世界検定４級',
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