@echo off
REM 既存プロジェクトに MCP 設定をコピーするスクリプト

if "%~1"=="" (
    echo 使用方法: copy_mcp_to_project.bat "C:\path\to\your\project"
    echo.
    echo 例: copy_mcp_to_project.bat "C:\Users\john\my-app"
    echo.
    pause
    exit /b 1
)

set "TARGET_DIR=%~1"
set "TARGET_CONFIG=%TARGET_DIR%\.claude_code_config.json"

if not exist "%TARGET_DIR%" (
    echo ❌ ディレクトリが見つかりません: %TARGET_DIR%
    pause
    exit /b 1
)

echo プロジェクト: %TARGET_DIR%
echo.

REM 既存の設定をバックアップ
if exist "%TARGET_CONFIG%" (
    echo ⚠️  既存の設定をバックアップ中...
    copy "%TARGET_CONFIG%" "%TARGET_CONFIG%.backup" >nul
)

REM MCP設定をコピー
echo 📄 MCP設定をコピー中...
copy ".claude_code_config.json" "%TARGET_CONFIG%" >nul

REM スクリプトファイルもコピー
echo 📄 ワークフロースクリプトをコピー中...
copy "mcp_workflow.py" "%TARGET_DIR%\" >nul
copy "mcp_test.py" "%TARGET_DIR%\" >nul
copy "cipher_serena_prompts.md" "%TARGET_DIR%\" >nul

if %ERRORLEVEL% EQ 0 (
    echo ✅ MCP設定がプロジェクトにコピーされました
    echo.
    echo 📍 設定場所: %TARGET_CONFIG%
    echo.
    echo 🚀 使用方法:
    echo   cd "%TARGET_DIR%"
    echo   claude-code --config .claude_code_config.json
    echo.
    echo   または:
    echo   python mcp_workflow.py "search query" "task"
) else (
    echo ❌ コピーに失敗しました
)

echo.
pause