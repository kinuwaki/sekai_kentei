@echo off
echo Running Game Automation Tests...
echo.

REM パッケージの取得
echo Installing dependencies...
flutter pub get

REM 統合テストの実行
echo.
echo Starting integration tests...
echo This will test all 13 games automatically.
echo.

REM Webプラットフォームでの統合テスト実行
flutter test integration_test/game_automation_test.dart --platform chrome

echo.
echo Tests completed!
pause