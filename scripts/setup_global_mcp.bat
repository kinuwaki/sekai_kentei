@echo off
REM グローバル MCP 設定セットアップスクリプト
REM すべてのプロジェクトで Cipher + Serena を使用可能にします

echo ================================
echo グローバル MCP セットアップ
echo ================================
echo.

REM ユーザーのホームディレクトリを取得
set "HOME_DIR=%USERPROFILE%"
set "CLAUDE_CONFIG_DIR=%HOME_DIR%\.claude-code"
set "GLOBAL_CONFIG=%CLAUDE_CONFIG_DIR%\config.json"

echo Claude Code設定ディレクトリ: %CLAUDE_CONFIG_DIR%
echo.

REM 設定ディレクトリを作成
if not exist "%CLAUDE_CONFIG_DIR%" (
    echo 📁 Claude Code設定ディレクトリを作成中...
    mkdir "%CLAUDE_CONFIG_DIR%"
)

REM 既存のグローバル設定をバックアップ
if exist "%GLOBAL_CONFIG%" (
    echo ⚠️  既存のグローバル設定をバックアップ中...
    copy "%GLOBAL_CONFIG%" "%GLOBAL_CONFIG%.backup.%date:~-4,4%%date:~-10,2%%date:~-7,2%" >nul
)

REM グローバル設定ファイルを作成
echo 📝 グローバル MCP 設定を作成中...
(
echo {
echo   "mcpServers": {
echo     "cipher": {
echo       "command": "cipher",
echo       "args": ["--mcp"],
echo       "description": "Cipher MCP server for retrieving past conversations and design decisions"
echo     },
echo     "serena": {
echo       "command": "uv", 
echo       "args": ["run", "serena-mcp-server"],
echo       "description": "Serena MCP server for code modification and execution"
echo     }
echo   },
echo   "defaultMcpServers": ["cipher", "serena"]
echo }
) > "%GLOBAL_CONFIG%"

if %ERRORLEVEL% EQ 0 (
    echo ✅ グローバル設定が作成されました: %GLOBAL_CONFIG%
) else (
    echo ❌ グローバル設定の作成に失敗しました
    exit /b 1
)

echo.
echo ================================
echo ✅ グローバルセットアップ完了！
echo ================================
echo.
echo 📍 設定場所: %GLOBAL_CONFIG%
echo.
echo 🚀 使用方法:
echo   どのディレクトリからでも以下のコマンドが使用可能:
echo   claude-code
echo.
echo   または特定のプロジェクトで:
echo   cd your-project
echo   claude-code
echo.
echo 💡 プロジェクト固有の設定が必要な場合:
echo   プロジェクトディレクトリに .claude_code_config.json を作成
echo   （グローバル設定を上書きします）
echo.
pause