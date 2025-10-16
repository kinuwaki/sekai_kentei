#!/bin/bash

echo "=== MCP Server Status Check ==="
echo

echo "[1] Checking Dart MCP Server..."
if dart mcp-server --help 2>&1 | grep -q "mcp-server"; then
    echo "✓ Dart MCP Server: OK"
else
    echo "✗ Dart MCP Server: Not found or not configured"
fi
echo

echo "[2] Checking Filesystem MCP Server..."
if npm list -g @modelcontextprotocol/server-filesystem >/dev/null 2>&1; then
    echo "✓ Filesystem Server: OK (installed globally)"
else
    echo "✗ Filesystem Server: Not found"
fi
echo

echo "[3] Checking Git MCP Server..."
if python -m mcp_server_git --help >/dev/null 2>&1; then
    echo "✓ Git Server: OK"
else
    echo "✗ Git Server: Not found"
fi
echo

echo "=== Configuration Check ==="
# Convert Windows path to Unix path for Git Bash
CONFIG_PATH="/c/Users/jason/AppData/Roaming/Claude/claude_desktop_config.json"
if [ -f "$CONFIG_PATH" ]; then
    echo "✓ Config file exists at: $CONFIG_PATH"
    echo
    echo "Configuration content:"
    echo "------------------------------"
    cat "$CONFIG_PATH"
    echo
    echo "------------------------------"
else
    echo "✗ Config file not found at: $CONFIG_PATH"
fi
echo

echo "=== Installed Versions ==="
echo -n "Node.js: "
node --version
echo -n "NPM: "
npm --version
echo -n "Python: "
python --version
echo -n "Dart: "
dart --version
echo

echo "Press Enter to exit..."
read