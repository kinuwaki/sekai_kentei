@echo off
REM MCP サーバーセットアップスクリプト
REM Cipher と Serena の MCP サーバーをセットアップします

echo ================================
echo MCP サーバーセットアップ
echo ================================
echo.

REM 1. 必要な依存関係のチェック
echo [1/5] 依存関係をチェック中...

REM Cipher のチェック
cipher --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Cipher が見つかりません
    echo    Cipher をインストールしてください
    goto :error
) else (
    echo ✅ Cipher が見つかりました
)

REM uv のチェック
uv --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ uv が見つかりません
    echo    uv をインストールしてください: https://astral.sh/uv/install.sh
    goto :error
) else (
    echo ✅ uv が見つかりました
)

echo.

REM 2. Serena MCP サーバーのインストール
echo [2/5] Serena MCP サーバーをインストール中...
uv add serena-mcp-server
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Serena MCP サーバーのインストールに失敗しました
    goto :error
) else (
    echo ✅ Serena MCP サーバーがインストールされました
)

echo.

REM 3. 設定ファイルの作成
echo [3/5] Claude Code 設定ファイルを作成中...
if exist .claude_code_config.json (
    echo ⚠️  既存の設定ファイルが見つかりました
    echo    バックアップを作成します...
    copy .claude_code_config.json .claude_code_config.json.backup >nul
)

echo ✅ 設定ファイルが作成されました

echo.

REM 4. テスト実行
echo [4/5] MCP サーバーをテスト中...
python mcp_test.py
if %ERRORLEVEL% NEQ 0 (
    echo ❌ MCP サーバーのテストに失敗しました
    echo    詳細については上記の出力を確認してください
    goto :error
)

echo.

REM 5. 完了メッセージ
echo [5/5] セットアップ完了！
echo.
echo ================================
echo ✅ MCP セットアップが完了しました
echo ================================
echo.
echo 使用方法:
echo   claude-code --config .claude_code_config.json
echo.
echo または:
echo   python mcp_workflow.py "search query" "task description"
echo.
echo 詳細な使用例については cipher_serena_prompts.md を参照してください
echo.
goto :end

:error
echo.
echo ================================
echo ❌ セットアップに失敗しました
echo ================================
echo.
echo トラブルシューティング:
echo   1. 必要な依存関係がインストールされているか確認
echo   2. ネットワーク接続を確認
echo   3. 権限の問題がないか確認
echo.
echo 詳細については mcp_test.py を実行してください:
echo   python mcp_test.py
echo.
exit /b 1

:end
echo セットアップスクリプトを終了します
echo.
pause