#!/bin/bash
echo "Running Game Automation Tests..."
echo

# パッケージの取得
echo "Installing dependencies..."
flutter pub get

# 統合テストの実行
echo
echo "Starting integration tests..."
echo "This will test all 11 games automatically."
echo

# Webプラットフォームでの統合テスト実行
flutter test integration_test/game_automation_test.dart --platform chrome

echo
echo "Tests completed!"