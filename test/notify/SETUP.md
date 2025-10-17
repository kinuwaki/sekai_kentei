# プッシュ通知テスト手順書

## 📋 前提条件

- macOS + Xcode
- Flutter開発環境
- iOSシミュレーター

---

## 🚀 初回セットアップ（1回のみ）

### 1. Push Notifications機能を有効化

```bash
cd /Users/shinichikinuwaki/Desktop/sekai_kentei/test/notify
open ../../flutter_app/ios/Runner.xcworkspace
```

Xcodeが開いたら：

1. 左側のナビゲーターで **Runner** プロジェクトを選択
2. **Signing & Capabilities** タブを選択
3. **+ Capability** ボタンをクリック
4. **Push Notifications** を検索して追加
5. Xcodeを閉じる

### 2. アプリをビルド＆インストール

```bash
cd ../../flutter_app
flutter build ios --simulator
```

### 3. シミュレーターを起動＆アプリをインストール

```bash
# シミュレーターを起動（自動起動されない場合）
open -a Simulator

# アプリをインストール
SIMULATOR_ID=$(xcrun simctl list devices | grep "Booted" | head -1 | grep -o -E "\([A-F0-9-]+\)" | tr -d "()")
xcrun simctl install "$SIMULATOR_ID" build/ios/iphonesimulator/Runner.app
```

### 4. アプリを起動して通知許可

```bash
# アプリを起動
xcrun simctl launch "$SIMULATOR_ID" jp.monaka.game
```

シミュレーターに「通知を許可しますか？」ダイアログが表示されたら **許可** をタップ

---

## 📬 通知テスト（毎回）

### 1. アプリをホーム画面に戻す

- シミュレーターをクリック
- `Cmd+Shift+H` を押す（ホームボタン）

### 2. 通知を送信

```bash
cd /Users/shinichikinuwaki/Desktop/sekai_kentei/test/notify
./test.sh
```

### 3. 確認

- シミュレーターの画面上部に通知バナーが表示される
- 通知をタップ
- DailyQuizScreen（問題画面）に遷移
- 問題ID「q1」の問題が表示される

---

## 🔧 カスタマイズ

### 別の問題IDでテスト

`test_notification.apns` を編集：

```json
{
  "customData": {
    "questionId": "q18"  ← ここを変更（q1〜q26）
  }
}
```

その後 `./test.sh` を実行

---

## 🐛 トラブルシューティング

### 通知バナーが表示されない

**原因1: アプリがフォアグラウンドにいる**
- `Cmd+Shift+H` でホーム画面に戻してから `./test.sh` を再実行

**原因2: 通知許可がOFFになっている**
- シミュレーターの Settings → Notifications → flutter_app
- "Allow Notifications" をONにする

**原因3: 通知センターに届いている**
- シミュレーターの画面上部から下にスワイプ
- 通知センターを確認

### アプリが起動しない

```bash
# アプリを再インストール
cd /Users/shinichikinuwaki/Desktop/sekai_kentei/flutter_app
flutter build ios --simulator
SIMULATOR_ID=$(xcrun simctl list devices | grep "Booted" | head -1 | grep -o -E "\([A-F0-9-]+\)" | tr -d "()")
xcrun simctl install "$SIMULATOR_ID" build/ios/iphonesimulator/Runner.app
xcrun simctl launch "$SIMULATOR_ID" jp.monaka.game
```

### Bundle IDエラー

```bash
# Bundle IDを確認
grep PRODUCT_BUNDLE_IDENTIFIER ../../flutter_app/ios/Runner.xcodeproj/project.pbxproj
# → jp.monaka.game であることを確認

# test_notification.apns と test.sh が jp.monaka.game を使っているか確認
grep "Bundle\|BUNDLE" test_notification.apns test.sh
```

---

## 📝 ファイル説明

| ファイル | 説明 |
|---------|------|
| `test.sh` | 通知送信スクリプト |
| `test_notification.apns` | 通知データ（JSON） |
| `SETUP.md` | この手順書 |

---

## ℹ️ 仕組み

1. `xcrun simctl push` でシミュレーターに通知を送信
2. `AppDelegate.swift` で通知をキャッチ
3. Method Channel でFlutter側にpayload送信
4. `main.dart` で `_handleNotificationTap` を呼び出し
5. `DailyQuizScreen` に遷移（問題IDを渡す）

---

## 📌 制約

- シミュレーターのみ（実機は非対応）
- iOS 13以降
- Firebase不要（ローカルテスト専用）
