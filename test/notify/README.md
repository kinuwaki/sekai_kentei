# iOSシミュレーター プッシュ通知テスト

## 🚀 クイックスタート（3ステップ）

### 1. 初回セットアップ（1回のみ）

```bash
cd test/notify
./setup.sh
```

Xcodeが開くので、以下を設定:
1. Runnerプロジェクトを選択
2. `Signing & Capabilities` タブ
3. `+ Capability` → `Push Notifications` を追加
4. Enterキーを押す

### 2. アプリをホーム画面に戻す

シミュレーターで `Cmd+Shift+H` を押す

### 3. 通知を送信

```bash
./test.sh
```

通知バナーをタップ → DailyQuizScreen（問題画面）に遷移！

---

## 📁 ファイル構成

```
test/notify/
├── setup.sh              # 初回セットアップスクリプト
├── test.sh               # 通知送信スクリプト
├── test_notification.apns # 通知データ（問題ID: q1）
└── README.md             # このファイル
```

---

## 🔧 カスタマイズ

### 別の問題IDでテスト

`test_notification.apns` を編集:

```json
{
  "customData": {
    "questionId": "q18"  ← ここを変更
  }
}
```

その後 `./test.sh` を実行

---

## 🐛 トラブルシューティング

### 通知が表示されない

```bash
# Bundle IDを確認
grep PRODUCT_BUNDLE_IDENTIFIER ../../flutter_app/ios/Runner.xcodeproj/project.pbxproj

# シミュレーターの通知設定を確認
# Settings → Notifications → flutter_app → "Allow Notifications" ON
```

### 画面遷移しない

Xcodeコンソールで以下のログを確認:
- `✅ Device Token:`
- `👆 Notification tapped:`
- `[main] iOS remote notification tapped:`

ログが出ない場合:
1. `AppDelegate.swift`が正しく更新されているか
2. `main.dart`にMethod Channelが設定されているか

---

## ℹ️ 仕組み

1. **xcrun simctl push** でシミュレーターに通知を送信
2. **AppDelegate.swift** で通知をキャッチ
3. **Method Channel** でFlutter側にpayload送信
4. **main.dart** で`_handleNotificationTap`を呼び出し
5. **DailyQuizScreen** に遷移（問題IDを渡す）

---

## 📝 制約

- シミュレーターのみ（実機は非対応）
- iOS 13以降
- Firebase不要（ローカルテスト専用）
