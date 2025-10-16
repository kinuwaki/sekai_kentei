@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

echo ========================================
echo VOICEVOX 音声生成システム起動
echo ========================================
echo.

:: VOICEVOXのパスを設定（必要に応じて変更してください）
set VOICEVOX_PATH=C:\Users\jason\AppData\Local\Programs\VOICEVOX\VOICEVOX.exe
set VOICEVOX_PATH_ALT=C:\Program Files\VOICEVOX\VOICEVOX.exe

:: VOICEVOXが起動しているか確認
echo [1/4] VOICEVOXの状態を確認中...
curl -s http://127.0.0.1:50021/version > nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ VOICEVOXは既に起動しています
) else (
    echo VOICEVOXを起動します...
    
    :: VOICEVOXの実行ファイルを探す
    if exist "%VOICEVOX_PATH%" (
        start "" "%VOICEVOX_PATH%"
    ) else if exist "%VOICEVOX_PATH_ALT%" (
        start "" "%VOICEVOX_PATH_ALT%"
    ) else (
        echo.
        echo ⚠ VOICEVOXが見つかりません！
        echo 以下のいずれかの場所にVOICEVOXをインストールしてください：
        echo   - %VOICEVOX_PATH%
        echo   - %VOICEVOX_PATH_ALT%
        echo.
        echo または、このファイルを編集してVOICEVOX_PATHを正しく設定してください。
        echo.
        echo VOICEVOXは以下からダウンロードできます：
        echo https://voicevox.hiroshiba.jp/
        echo.
        pause
        exit /b 1
    )
    
    :: VOICEVOXの起動を待つ
    echo VOICEVOXの起動を待っています...
    :wait_voicevox
    timeout /t 2 > nul
    curl -s http://127.0.0.1:50021/version > nul 2>&1
    if %errorlevel% neq 0 goto wait_voicevox
    echo ✓ VOICEVOXが起動しました
)

echo.
echo [2/4] TTSサーバーを起動中...

:: 既存のTTSサーバーを確認
curl -s http://127.0.0.1:8000/health > nul 2>&1
if %errorlevel% equ 0 (
    echo ✓ TTSサーバーは既に起動しています
    goto check_files
)

:: TTSサーバーを新しいウィンドウで起動
start "TTS Server" /min cmd /k "cd /d %~dp0 && python tts_server.py"

:: TTSサーバーの起動を待つ
echo TTSサーバーの起動を待っています...
:wait_tts
timeout /t 2 > nul
curl -s http://127.0.0.1:8000/health > nul 2>&1
if %errorlevel% neq 0 goto wait_tts
echo ✓ TTSサーバーが起動しました

:check_files
echo.
echo [3/4] 音声ファイルの状態を確認中...
echo.

:: 不足ファイルをチェック
python "%~dp0generate_voice_assets.py" --list > temp_check.txt 2>&1
type temp_check.txt

:: 不足ファイルがあるか確認（行数で判定）
:: 出力が10行より多ければ不足ファイルあり
for /f %%a in ('type temp_check.txt ^| find /v "" ^| find /c /v ""') do set LINE_COUNT=%%a
if %LINE_COUNT% gtr 10 (
    set HAS_MISSING=1
) else (
    set HAS_MISSING=0
)

:: 判定結果に基づいて処理
if %HAS_MISSING% equ 1 (
    echo.
    echo [4/4] 不足している音声ファイルを生成します（%LINE_COUNT% 行の出力を検出）
    echo.
    set /p GENERATE="音声ファイルを生成しますか？ (Y/N): "
    if /i "!GENERATE!"=="Y" (
        echo.
        echo 音声ファイルを生成中...
        python "%~dp0generate_voice_assets.py"
        echo.
        echo ✅ 音声ファイルの生成が完了しました！
    ) else (
        echo.
        echo 生成をスキップしました。
        echo 後で以下のコマンドで生成できます：
        echo   python tools\voicevox\generate_voice_assets.py
    )
) else (
    echo.
    echo ✅ すべての音声ファイルが存在します！
)

:: 一時ファイルを削除
del temp_check.txt 2> nul

echo.
echo ========================================
echo 処理完了
echo ========================================
echo.
echo TTSサーバーは以下で稼働中です：
echo   http://127.0.0.1:8000
echo.
echo 音声ファイルの再生成が必要な場合：
echo   python tools\voicevox\generate_voice_assets.py
echo.
echo TTSサーバーを停止するには、開いているコマンドウィンドウを閉じてください。
echo.
pause