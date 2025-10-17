import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'ui/onboarding/app_initializer.dart';
import 'ui/daily_quiz/daily_quiz_screen.dart';
import 'services/notification_service.dart';

// グローバルナビゲーションキー（通知タップ時の画面遷移用）
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// NotificationServiceのグローバルインスタンス
final notificationService = NotificationService();

// iOSのリモート通知用Method Channel
const MethodChannel _notificationChannel = MethodChannel('com.example.flutter_app/notification');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // タイムゾーン初期化
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.local);

  // 通知サービス初期化
  await notificationService.initialize(
    onNotificationTap: (payload) {
      if (payload != null) {
        _handleNotificationTap(payload);
      }
    },
  );

  // iOS通知権限リクエスト
  await notificationService.requestIOSPermissions();

  // iOSのリモート通知（xcrun simctl push）用のMethod Channelをセットアップ
  _notificationChannel.setMethodCallHandler((call) async {
    if (call.method == 'onNotificationTapped') {
      final String? payload = call.arguments as String?;
      if (payload != null) {
        debugPrint('[main] iOS remote notification tapped: $payload');
        _handleNotificationTap(payload);
      }
    }
  });

  // 縦固定
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ゲームらしく全画面
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const ProviderScope(child: MiniGameApp()));
}

/// 通知タップ時のハンドラ
void _handleNotificationTap(String payload) {
  debugPrint('[main] 通知タップ: $payload');

  // payloadをパースして画面遷移
  try {
    final data = Map<String, dynamic>.from(
      const JsonDecoder().convert(payload) as Map,
    );
    final questionId = data['qid'] as String?;

    if (questionId != null) {
      // デイリー問題画面へ遷移
      navigatorKey.currentState?.pushNamed(
        '/daily-quiz',
        arguments: {'questionId': questionId},
      );
    }
  } catch (e) {
    debugPrint('[main] payload解析エラー: $e');
  }
}

class MiniGameApp extends StatelessWidget {
  const MiniGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '世界検定４級',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'NotoSansJP',
      ),
      home: const AppInitializer(),
      routes: {
        '/daily-quiz': (context) => const DailyQuizScreen(),
      },
    );
  }
}

