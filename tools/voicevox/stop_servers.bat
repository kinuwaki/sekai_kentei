@echo off
chcp 65001 > nul

echo ========================================
echo VOICEVOX/TTSサーバー停止
echo ========================================
echo.

echo TTSサーバーを停止中...
:: ポート8000で動作しているプロセスを停止
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :8000') do (
    taskkill /f /pid %%a > nul 2>&1
)

echo VOICEVOXサーバーを停止中...
:: VOICEVOXプロセスを停止
taskkill /f /im VOICEVOX.exe > nul 2>&1

echo.
echo ✓ サーバーを停止しました
echo.
pause