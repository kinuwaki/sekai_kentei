#!/bin/bash

# シミュレーターのUDIDを取得（起動中のシミュレーター）
SIMULATOR_ID=$(xcrun simctl list devices | grep "Booted" | grep -o -E "\([A-F0-9-]+\)" | tr -d "()")

if [ -z "$SIMULATOR_ID" ]; then
  echo "❌ 起動中のシミュレーターが見つかりません"
  echo "シミュレーターを起動してからもう一度実行してください"
  exit 1
fi

echo "📱 シミュレーターUDID: $SIMULATOR_ID"

# Bundle IDを取得
BUNDLE_ID="com.example.flutterApp"
echo "📦 Bundle ID: $BUNDLE_ID"

# 通知を送信
echo "📬 通知を送信中..."
xcrun simctl push "$SIMULATOR_ID" "$BUNDLE_ID" test_notification.apns

if [ $? -eq 0 ]; then
  echo "✅ 通知を送信しました！"
  echo "通知をタップしてアプリを開き、画面遷移を確認してください"
else
  echo "❌ 通知の送信に失敗しました"
fi
