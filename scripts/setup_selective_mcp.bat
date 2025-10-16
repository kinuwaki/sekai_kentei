@echo off
REM 選択的 MCP セットアップ
REM 技術プロジェクトでのみ Cipher + Serena を有効にします

echo ================================
echo 選択的 MCP セットアップ
echo ================================
echo.
echo このスクリプトは以下を提供します：
echo ✅ 技術プロジェクト用の MCP 設定テンプレート
echo ✅ 簡単な有効化/無効化スクリプト
echo ✅ プロジェクトタイプ別の設定管理
echo.

set "TEMPLATE_DIR=%~dp0mcp_templates"
set "SCRIPTS_DIR=%~dp0mcp_scripts"

REM テンプレートディレクトリを作成
if not exist "%TEMPLATE_DIR%" mkdir "%TEMPLATE_DIR%"
if not exist "%SCRIPTS_DIR%" mkdir "%SCRIPTS_DIR%"

echo 📁 MCP テンプレートを作成中...

REM 1. 技術プロジェクト用設定
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
echo   }
echo }
) > "%TEMPLATE_DIR%\tech_project_config.json"

REM 2. ドキュメント/執筆プロジェクト用設定（MCPなし）
(
echo {
echo   "mcpServers": {},
echo   "tools": {
echo     "markdown": true,
echo     "writing_assistant": true
echo   }
echo }
) > "%TEMPLATE_DIR%\writing_project_config.json"

REM 3. 学習用プロジェクト設定（軽量）
(
echo {
echo   "mcpServers": {},
echo   "tools": {
echo     "code_review": true,
echo     "documentation": true
echo   }
echo }
) > "%TEMPLATE_DIR%\learning_project_config.json"

echo ✅ テンプレートが作成されました

REM 有効化スクリプトを作成
echo 🔧 管理スクリプトを作成中...

REM enable_mcp.bat
(
echo @echo off
echo REM 現在のプロジェクトで MCP を有効にします
echo.
echo if "%%~1"=="" ^(
echo     echo 使用方法: enable_mcp.bat [tech^|writing^|learning]
echo     echo.
echo     echo   tech     - 技術プロジェクト ^(Cipher + Serena^)
echo     echo   writing  - 執筆プロジェクト ^(MCPなし^)  
echo     echo   learning - 学習プロジェクト ^(軽量設定^)
echo     echo.
echo     pause
echo     exit /b 1
echo ^)
echo.
echo set "PROJECT_TYPE=%%~1"
echo set "TEMPLATE_DIR=%%~dp0mcp_templates"
echo set "TARGET_CONFIG=.claude_code_config.json"
echo.
echo if "%%PROJECT_TYPE%%"=="tech" ^(
echo     copy "%%TEMPLATE_DIR%%\tech_project_config.json" "%%TARGET_CONFIG%%" ^>nul
echo     echo ✅ 技術プロジェクト設定を適用しました ^(Cipher + Serena有効^)
echo ^) else if "%%PROJECT_TYPE%%"=="writing" ^(
echo     copy "%%TEMPLATE_DIR%%\writing_project_config.json" "%%TARGET_CONFIG%%" ^>nul  
echo     echo ✅ 執筆プロジェクト設定を適用しました ^(MCPなし^)
echo ^) else if "%%PROJECT_TYPE%%"=="learning" ^(
echo     copy "%%TEMPLATE_DIR%%\learning_project_config.json" "%%TARGET_CONFIG%%" ^>nul
echo     echo ✅ 学習プロジェクト設定を適用しました ^(軽量設定^)
echo ^) else ^(
echo     echo ❌ 不明なプロジェクトタイプ: %%PROJECT_TYPE%%
echo     exit /b 1
echo ^)
echo.
echo echo.
echo echo 🚀 Claude Code を起動:
echo echo   claude-code
echo.
) > "%SCRIPTS_DIR%\enable_mcp.bat"

REM disable_mcp.bat
(
echo @echo off
echo REM 現在のプロジェクトで MCP を無効にします
echo.
echo if exist ".claude_code_config.json" ^(
echo     del ".claude_code_config.json"
echo     echo ✅ MCP設定を削除しました
echo ^) else ^(
echo     echo ℹ️  MCP設定ファイルが見つかりません
echo ^)
echo.
) > "%SCRIPTS_DIR%\disable_mcp.bat"

REM check_mcp.bat  
(
echo @echo off
echo REM 現在のプロジェクトの MCP 設定を確認します
echo.
echo echo 📁 現在のディレクトリ: %%CD%%
echo.
echo if exist ".claude_code_config.json" ^(
echo     echo ✅ MCP設定ファイルが見つかりました
echo     echo.
echo     echo 📄 設定内容:
echo     type ".claude_code_config.json"
echo ^) else ^(
echo     echo ❌ MCP設定ファイルが見つかりません
echo     echo.
echo     echo 💡 MCP を有効にするには:
echo     echo   enable_mcp.bat tech      ^(技術プロジェクト^)
echo     echo   enable_mcp.bat writing   ^(執筆プロジェクト^)
echo     echo   enable_mcp.bat learning  ^(学習プロジェクト^)
echo ^)
echo.
) > "%SCRIPTS_DIR%\check_mcp.bat"

echo ✅ 管理スクリプトが作成されました

echo.
echo ================================
echo ✅ 選択的セットアップ完了！
echo ================================
echo.
echo 📍 作成されたファイル:
echo   📂 %TEMPLATE_DIR%\
echo      ├── tech_project_config.json     (技術プロジェクト用)
echo      ├── writing_project_config.json  (執筆プロジェクト用)
echo      └── learning_project_config.json (学習プロジェクト用)
echo.
echo   📂 %SCRIPTS_DIR%\
echo      ├── enable_mcp.bat   (MCP有効化)
echo      ├── disable_mcp.bat  (MCP無効化)
echo      └── check_mcp.bat    (設定確認)
echo.
echo 🚀 使用方法:
echo   1. プロジェクトディレクトリに移動
echo   2. 以下のコマンドを実行:
echo.
echo      技術プロジェクト: %SCRIPTS_DIR%\enable_mcp.bat tech
echo      執筆プロジェクト: %SCRIPTS_DIR%\enable_mcp.bat writing  
echo      学習プロジェクト: %SCRIPTS_DIR%\enable_mcp.bat learning
echo.
echo   3. Claude Code を起動: claude-code
echo.
echo 💡 PATH に追加すると便利:
echo   set PATH=%%PATH%%;%SCRIPTS_DIR%
echo.
pause