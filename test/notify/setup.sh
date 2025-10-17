#!/bin/bash
set -e

echo "📦 iOSシミュレーター プッシュ通知テスト環境セットアップ"
echo ""

# プロジェクトルートディレクトリ
PROJECT_ROOT="/Users/shinichikinuwaki/Desktop/sekai_kentei/flutter_app"
cd "$PROJECT_ROOT"

# 1. Xcodeプロジェクトを開く
echo "✅ Step 1/3: Xcodeプロジェクトを開いています..."
open ios/Runner.xcworkspace

echo ""
echo "⚠️  Xcodeで以下の設定を行ってください（1分で完了）:"
echo "   1. Runnerプロジェクトを選択"
echo "   2. 'Signing & Capabilities' タブを開く"
echo "   3. '+ Capability' ボタンをクリック"
echo "   4. 'Push Notifications' を検索して追加"
echo ""
read -p "設定が完了したらEnterキーを押してください..."

# 2. アプリをビルド＆実行
echo ""
echo "✅ Step 2/3: アプリをビルド＆シミュレーターで起動しています..."
flutter run &
FLUTTER_PID=$!

echo ""
echo "⏳ アプリの起動を待っています（30秒）..."
sleep 30

# 3. 準備完了
echo ""
echo "✅ Step 3/3: セットアップ完了！"
echo ""
echo "🎉 テスト準備完了！次のステップ:"
echo "   1. シミュレーターでアプリが起動しているか確認"
echo "   2. ホーム画面に戻す (Cmd+Shift+H)"
echo "   3. 次のコマンドで通知を送信:"
echo ""
echo "      cd test/notify && ./test.sh"
echo ""
