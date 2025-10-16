# Cipher + Serena MCP セットアップガイド

このドキュメントでは、CipherとSerenaの両方をMCPサーバーとしてClaude Codeに登録し、過去の会話や設計判断を参照してコード修正を実行するワークフローを設定する方法を説明します。

## 📁 セットアップファイル一覧

```
D:\monaka\
├── .claude_code_config.json     # Claude Code MCP設定ファイル (プロジェクト用)
├── mcp_workflow.py              # Cipher → Serena ワークフロースクリプト  
├── mcp_test.py                  # MCP サーバーテストスクリプト
├── cipher_serena_prompts.md     # プロンプト例集
├── setup_mcp.bat               # プロジェクト用セットアップスクリプト
├── setup_global_mcp.bat        # グローバル設定セットアップスクリプト
├── copy_mcp_to_project.bat     # 他プロジェクトへの設定コピースクリプト
├── example_workflow.py         # 具体的なワークフロー例
└── README_MCP_Setup.md         # このファイル
```

## 🚀 クイックスタート

### オプション1: グローバル設定（推奨）
すべてのプロジェクトでCipher + Serenaを使用可能にします：

```batch
# Windowsの場合
setup_global_mcp.bat
```

### オプション2: プロジェクトごとの設定

```batch
# 現在のプロジェクトのみ
setup_mcp.bat

# 他のプロジェクトに設定をコピー
copy_mcp_to_project.bat "C:\path\to\your\project"

# または手動でテスト
python mcp_test.py
```

### 2. 手動セットアップ

```bash
# 1. 依存関係のインストール
# Cipher (事前にインストール済みと仮定)
cipher --version

# uv パッケージマネージャーのインストール
curl -LsSf https://astral.sh/uv/install.sh | sh

# Serena MCP サーバーのインストール
uv add serena-mcp-server

# 2. Claude Code の起動
claude-code --config .claude_code_config.json
```

## ⚙️ 設定ファイル

### `.claude_code_config.json`

```json
{
  "mcpServers": {
    "cipher": {
      "command": "cipher",
      "args": ["--mcp"],
      "description": "Cipher MCP server for retrieving past conversations and design decisions"
    },
    "serena": {
      "command": "uv",
      "args": ["run", "serena-mcp-server"],
      "description": "Serena MCP server for code modification and execution"
    }
  }
}
```

## 🔄 基本的なワークフロー

### 1. Cipher で過去の情報を検索 → Serena で実装

```bash
# ワークフロースクリプトを使用
python mcp_workflow.py "認証システム設計" "OAuth2ログイン機能の実装"
```

### 2. Claude Code内でのプロンプト例

```
Cipherを使って「データベーススキーマ設計」について過去の議論を検索し、
その結果を基にSerenaで現在のユーザーテーブルを更新してください。
```

### 3. 段階的な実行

```
# Step 1
@cipher 「APIセキュリティ」について過去の議論を検索してください

# Step 2 (Cipherの結果を受けて)
@serena 上記の検索結果を参考に、JWTトークンの実装を改善してください
```

## 📚 プロンプト例

詳細なプロンプト例については `cipher_serena_prompts.md` を参照してください。

### よく使用されるパターン

1. **設計判断の参照**
   ```
   Cipherで「[機能名]」の設計について過去の決定事項を調べ、
   Serenaでその原則に従って実装してください
   ```

2. **バグ修正の履歴参照** 
   ```
   Cipherで「[エラー内容]」に関する過去の解決策を探し、
   同様の手法でSerenaで現在の問題を修正してください
   ```

3. **アーキテクチャ変更**
   ```
   Cipherで「マイクロサービス移行」の議論を調査し、
   Serenaで段階的な移行計画を実装してください
   ```

## 🧪 テストと確認

### セットアップの確認

```bash
# 全体的なテスト
python mcp_test.py

# 個別のサーバーテスト
cipher --help
uv run serena-mcp-server --help
```

### 実際のワークフロー例の実行

```bash
# 具体的な例を実行
python example_workflow.py
```

## 🔧 トラブルシューティング

### よくある問題

1. **Cipher が見つからない**
   ```
   ❌ Cipher command not found
   💡 Cipher をインストールし、PATH に追加してください
   ```

2. **Serena MCP サーバーが起動しない**
   ```
   ❌ Serena MCP server failed
   💡 uv add serena-mcp-server を実行してください
   ```

3. **Claude Code が MCP サーバーを認識しない**
   ```
   ❌ MCP servers not loaded
   💡 .claude_code_config.json の構文を確認してください
   ```

### デバッグ用コマンド

```bash
# 設定ファイルの構文確認
python -m json.tool .claude_code_config.json

# MCP サーバーの個別テスト
cipher --mcp
uv run serena-mcp-server --help

# Claude Code の詳細ログ
claude-code --verbose --config .claude_code_config.json
```

## 🚀 高度な使用方法

### 1. カスタムワークフロースクリプト

`mcp_workflow.py` をベースに、プロジェクト固有のワークフローを作成できます。

### 2. CI/CD との統合

```yaml
# .github/workflows/mcp-workflow.yml
name: MCP Workflow
on: [push]
jobs:
  cipher-serena-workflow:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run MCP workflow
        run: python mcp_workflow.py "CI improvement" "update test automation"
```

### 3. プロジェクト固有の設定

```json
{
  "mcpServers": {
    "cipher": {
      "command": "cipher", 
      "args": ["--mcp", "--project", "my-project"],
      "env": {
        "CIPHER_CONFIG": "/path/to/cipher/config"
      }
    },
    "serena": {
      "command": "uv",
      "args": ["run", "serena-mcp-server", "--workspace", "./src"],
      "workingDirectory": "/path/to/project"
    }
  }
}
```

## 📖 参考資料

- [Claude Code MCP Documentation](https://docs.anthropic.com/en/docs/claude-code/mcp)
- `cipher_serena_prompts.md` - 詳細なプロンプト例集
- `example_workflow.py` - 具体的な実装例

## 🤝 サポート

問題が発生した場合：

1. `python mcp_test.py` を実行して設定を確認
2. `cipher_serena_prompts.md` でプロンプト例を確認  
3. ログファイルを確認してエラーの詳細を調査

---

**注意**: このセットアップは Cipher と Serena が適切にインストールされていることを前提としています。各ツールの公式ドキュメントも併せて参照してください。