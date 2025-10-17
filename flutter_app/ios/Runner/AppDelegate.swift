import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // リモート通知の登録（シミュレーター用）
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate

      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: { _, _ in }
      )
    } else {
      let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      application.registerUserNotificationSettings(settings)
    }

    application.registerForRemoteNotifications()

    GeneratedPluginRegistrant.register(with: self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // リモート通知の受信（デバイストークン）
  override func application(_ application: UIApplication,
                            didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
    let token = tokenParts.joined()
    print("✅ Device Token: \(token)")
  }

  override func application(_ application: UIApplication,
                            didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("❌ Failed to register for remote notifications: \(error.localizedDescription)")
  }

  // フォアグラウンドで通知を受信した時
  override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       willPresent notification: UNNotification,
                                       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo
    print("📬 Foreground notification received: \(userInfo)")

    // フォアグラウンドでも通知を表示
    if #available(iOS 14.0, *) {
      completionHandler([[.banner, .sound, .badge]])
    } else {
      completionHandler([[.alert, .sound, .badge]])
    }
  }

  // 通知をタップした時
  override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       didReceive response: UNNotificationResponse,
                                       withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    print("👆 Notification tapped: \(userInfo)")

    // Flutter側にpayloadを渡す（カスタムデータがある場合）
    if let customData = userInfo["customData"] as? [String: Any],
       let questionId = customData["questionId"] as? String {
      // FlutterMethodChannelを使ってFlutter側に通知
      if let controller = window?.rootViewController as? FlutterViewController {
        let channel = FlutterMethodChannel(name: "com.example.flutter_app/notification",
                                          binaryMessenger: controller.binaryMessenger)
        let payload = "{\"qid\":\"\(questionId)\"}"
        channel.invokeMethod("onNotificationTapped", arguments: payload)
      }
    }

    completionHandler()
  }
}
