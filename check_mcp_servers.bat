@echo off
echo === MCP Server Status Check ===
echo.

echo [1] Checking Dart MCP Server...
dart mcp-server --help 2>&1 | findstr /C:"mcp-server" >nul
if %ERRORLEVEL% EQU 0 (
    echo √ Dart MCP Server: OK
) else (
    echo × Dart MCP Server: Not found or not configured
)
echo.

echo [2] Checking Filesystem MCP Server...
npm list -g @modelcontextprotocol/server-filesystem >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo √ Filesystem Server: OK (installed globally)
) else (
    echo × Filesystem Server: Not found
)
echo.

echo [3] Checking Git MCP Server...
python -m mcp_server_git --help >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo √ Git Server: OK
) else (
    echo × Git Server: Not found
)
echo.

echo === Configuration Check ===
if exist "%APPDATA%\Claude\claude_desktop_config.json" (
    echo √ Config file exists at: %APPDATA%\Claude\claude_desktop_config.json
    echo.
    echo Configuration content:
    echo ------------------------------
    type "%APPDATA%\Claude\claude_desktop_config.json"
    echo.
    echo ------------------------------
) else (
    echo × Config file not found at: %APPDATA%\Claude\claude_desktop_config.json
)
echo.

echo === Installed Versions ===
echo Node.js: 
node --version
echo NPM: 
npm --version  
echo Python:
python --version
echo Dart:
dart --version
echo.

echo Press any key to exit...
pause >nul