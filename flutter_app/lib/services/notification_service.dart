import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'sekai_kentei_json_loader.dart';
import 'quiz_data_loader.dart';

/// 毎朝8時にランダム問題を通知するサービス
class NotificationService {
  static const String _tag = 'NotificationService';
  static const int _dailyNotificationId = 1001;
  static const String _channelId = 'daily_quiz';
  static const String _channelName = 'Daily Quiz';
  static const String _channelDescription = '毎朝8時のデイリー問題通知';

  final FlutterLocalNotificationsPlugin _plugin;
  final QuizDataLoader _dataLoader;

  NotificationService({
    FlutterLocalNotificationsPlugin? plugin,
    QuizDataLoader? dataLoader,
  })  : _plugin = plugin ?? FlutterLocalNotificationsPlugin(),
        _dataLoader = dataLoader ?? SekaiKenteiJsonLoader();

  /// 通知プラグインを初期化
  Future<void> initialize({
    required Function(String? payload) onNotificationTap,
  }) async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (response) {
        onNotificationTap(response.payload);
      },
      onDidReceiveBackgroundNotificationResponse: _notificationTapBackground,
    );

    debugPrint('[$_tag] 通知プラグイン初期化完了');
  }

  /// iOS通知権限をリクエスト
  Future<bool> requestIOSPermissions() async {
    final iosPlugin = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();

    if (iosPlugin == null) return true; // iOS以外はスキップ

    final granted = await iosPlugin.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint('[$_tag] iOS通知権限: ${granted ?? false}');
    return granted ?? false;
  }

  /// 翌朝8:00にランダム問題の通知を1件だけ予約
  Future<void> scheduleNextMorning() async {
    try {
      // 1. ランダム問題を選択
      final questions = await _dataLoader.loadQuestions();
      if (questions.isEmpty) {
        debugPrint('[$_tag] 問題データが空のため通知をスケジュールできません');
        return;
      }

      final random = Random();
      final randomQuestion = questions[random.nextInt(questions.length)];

      // 2. 翌朝8:00を計算
      final now = tz.TZDateTime.now(tz.local);
      var target = tz.TZDateTime(tz.local, now.year, now.month, now.day, 8, 0);

      // 今日の8:00を過ぎていたら明日の8:00にする
      if (!target.isAfter(now)) {
        target = target.add(const Duration(days: 1));
      }

      debugPrint('[$_tag] 次回通知時刻: $target');

      // 3. payloadに問題IDと問題文の一部を格納
      final payload = jsonEncode({
        'qid': randomQuestion.id,
        'question': randomQuestion.question,
        'theme': randomQuestion.theme,
      });

      // 4. 通知詳細設定
      const androidDetails = AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.high,
        priority: Priority.high,
        ticker: '世界検定4級 デイリー問題',
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      // 5. 通知を予約（固定IDで上書き）
      final questionPreview = randomQuestion.question.length > 40
          ? '${randomQuestion.question.substring(0, 40)}...'
          : randomQuestion.question;

      await _plugin.zonedSchedule(
        _dailyNotificationId,
        '世界検定4級 - 本日の問題',
        questionPreview,
        target,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
      );

      debugPrint('[$_tag] 通知スケジュール完了: ID=${randomQuestion.id}, 時刻=$target');
    } catch (e, stackTrace) {
      debugPrint('[$_tag] 通知スケジュールエラー: $e');
      debugPrint('[$_tag] $stackTrace');
    }
  }

  /// スケジュール済み通知をすべてキャンセル
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
    debugPrint('[$_tag] すべての通知をキャンセルしました');
  }

  /// 特定の通知をキャンセル
  Future<void> cancelDailyNotification() async {
    await _plugin.cancel(_dailyNotificationId);
    debugPrint('[$_tag] デイリー通知をキャンセルしました');
  }

  /// スケジュール済み通知の一覧を取得（デバッグ用）
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _plugin.pendingNotificationRequests();
  }
}

/// バックグラウンド通知タップハンドラ（Androidで必須）
@pragma('vm:entry-point')
void _notificationTapBackground(NotificationResponse response) {
  // バックグラウンドでは最小限の処理のみ
  debugPrint('[NotificationService] バックグラウンドタップ: ${response.payload}');
}
