#!/bin/bash

echo "📬 テスト通知を送信します"
echo ""

# シミュレーターのUDIDを取得
SIMULATOR_ID=$(xcrun simctl list devices | grep "Booted" | head -1 | grep -o -E "\([A-F0-9-]+\)" | tr -d "()")

if [ -z "$SIMULATOR_ID" ]; then
  echo "❌ エラー: 起動中のシミュレーターが見つかりません"
  echo ""
  echo "解決方法:"
  echo "  1. シミュレーターを起動してください"
  echo "  2. または setup.sh を実行してください"
  exit 1
fi

echo "📱 シミュレーター: $SIMULATOR_ID"

# Bundle IDを取得（pbxprojから自動取得）
BUNDLE_ID="jp.monaka.game"
echo "📦 Bundle ID: $BUNDLE_ID"
echo ""

# 通知を送信
echo "📤 通知送信中..."
xcrun simctl push "$SIMULATOR_ID" "$BUNDLE_ID" test_notification.apns

if [ $? -eq 0 ]; then
  echo ""
  echo "✅ 通知を送信しました！"
  echo ""
  echo "次の操作:"
  echo "  1. シミュレーターの通知バナーを確認"
  echo "  2. 通知をタップ"
  echo "  3. DailyQuizScreen（問題画面）に遷移することを確認"
  echo ""
  echo "デバッグ:"
  echo "  - Xcodeのコンソールで以下のログを確認:"
  echo "    ✅ Device Token:"
  echo "    📬 Foreground notification received:"
  echo "    👆 Notification tapped:"
  echo "    [main] iOS remote notification tapped:"
else
  echo ""
  echo "❌ エラー: 通知の送信に失敗しました"
  echo ""
  echo "トラブルシューティング:"
  echo "  1. アプリが起動しているか確認"
  echo "  2. Bundle IDが正しいか確認"
  echo "  3. Xcodeで Push Notifications が有効か確認"
fi
