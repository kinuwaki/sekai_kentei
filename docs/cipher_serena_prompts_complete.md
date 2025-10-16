# Cipher + Serena 完全プロンプト例集

このドキュメントでは、CipherとSerenaのMCPサーバーを順番に使用するための詳細なプロンプト例とコマンドを提供します。

## 🔄 基本的なワークフロー

### 1. 段階的実行（推奨）

```
# Step 1: Cipherで過去の情報を検索
/mcp__cipher__recall query="認証システム設計" category="design" limit=3

# Step 2: 上記結果を確認後、Serenaで実装
/mcp__serena__modify_code file_path="src/auth.py" changes=[{"line_start": 10, "line_end": 15, "new_content": "# Cipherの結果に基づく改善されたJWT実装\ndef generate_jwt_token(user_id: str) -> str:\n    # 以前の設計判断: セキュリティを重視\n    return jwt.encode({...}, secret_key, algorithm='HS256')"}]
```

### 2. 一連のプロンプト（詳細指示）

```
Cipherを使って「データベーススキーマ設計」について過去の議論を検索し、
その結果を基にSerenaで現在のユーザーテーブルを以下の原則で更新してください：
1. 正規化の原則に従う
2. パフォーマンスを考慮したインデックス設計
3. セキュリティ要件の遵守

検索後は、具体的なテーブル修正のSQL文を生成し、実行してください。
```

## 📚 カテゴリ別プロンプト例

### 🎨 設計判断の参照

```
# アーキテクチャ設計
Cipherで「マイクロサービス アーキテクチャ」の過去の決定事項を調べ、
Serenaでサービス分割の実装を以下の方針で進めてください：
- 過去の議論で決定された境界に従う
- 既存のデータベース制約を考慮
- 段階的な移行計画を実装

# API設計
/mcp__cipher__recall query="REST API 設計規約" category="design"
↓ 
/mcp__serena__modify_code file_path="api/endpoints.py" [結果に基づく修正]
```

### 🔧 リファクタリングの参照

```
# 過去のリファクタリング手法を適用
Cipherで「コード品質改善」「リファクタリング」について検索し、
過去に成功した手法をSerenaで現在のコードベースに適用してください：

1. まず過去の成功事例を調査
2. 現在のコードの問題点を特定
3. 段階的なリファクタリング計画を実行
4. テストを実行して品質を確認

対象ファイル: src/legacy_module.py
```

### 🐛 バグ修正の履歴参照

```
# 類似バグの解決策を参照
/mcp__cipher__search_conversations keywords=["メモリリーク", "パフォーマンス問題"] date_from="2024-01-01"
↓
/mcp__serena__execute_command command="python profile_memory.py" 
↓
/mcp__serena__modify_code [過去の解決策に基づく修正]
```

### 🚀 新機能開発

```
# 既存の実装パターンを参照
Cipherで「ユーザー認証」「セッション管理」の実装について過去の議論を検索し、
Serenaで新しいログイン機能を以下の要件で実装してください：

要件:
- 多要素認証対応
- セッションタイムアウト機能
- セキュリティログ記録

過去の設計原則を踏襲し、一貫性のある実装を行ってください。
```

## 🛠️ 実践的なコマンド例

### フル自動化ワークフロー

```bash
# Python スクリプトで完全自動化
python cipher_serena_workflow.py "認証システム設計" "JWT実装の改善" "design"
python cipher_serena_workflow.py "データベース最適化" "インデックス追加" "architecture"
python cipher_serena_workflow.py "バグ修正手順" "メモリリーク対応" "bug-fix"
```

### 段階的実行（Claude Code内）

```
# 1. 検索フェーズ
Cipherで以下を検索してください：
- クエリ: "REST API セキュリティ"
- カテゴリ: design
- 結果数: 5

# 2. 実装フェーズ（検索結果確認後）
Serenaで以下を実行してください：
- ファイル: api/security.py
- タスク: 認証ミドルウェアの実装
- 参考: 上記Cipherの検索結果

# 3. テストフェーズ
Serenaでテストを実行してください：
- テストパス: tests/api/
- フレームワーク: pytest
- 詳細出力: 有効
```

## 🎯 特定用途向けプロンプト

### CI/CD改善

```
# CI/CDパイプラインの改善
Cipherで「CI/CD」「自動テスト」「デプロイメント」について検索し、
過去のベストプラクティスを基にSerenaで以下を改善してください：

1. .github/workflows/ci.yml の最適化
2. テスト自動化の強化
3. デプロイメント手順の簡素化

検索 → 分析 → 実装の順で進めてください。
```

### セキュリティ強化

```
# セキュリティ監査結果を参照
/mcp__cipher__recall query="セキュリティ脆弱性" category="all" limit=10
↓
Serenaで以下のセキュリティ強化を実装：
- 入力検証の追加
- SQLインジェクション対策
- XSS対策の強化
- セキュリティヘッダーの設定
```

### パフォーマンス最適化

```
# 過去の最適化事例を活用
Cipherで「パフォーマンス改善」「最適化」について検索し、
Serenaで以下の最適化を段階的に実行してください：

対象: データベースクエリ最適化
- 実行計画の分析
- インデックスの追加/修正
- クエリの書き換え
- 結果のベンチマーク測定
```

## 🔍 トラブルシューティング用プロンプト

### エラー解決

```
# 類似エラーの解決策を検索
現在発生している以下のエラーについて：
エラー: "ModuleNotFoundError: No module named 'custom_auth'"

Cipherで類似エラーの過去の解決策を検索し、
Serenaで適切な修正を実行してください。

検索キーワード: ["ModuleNotFoundError", "import error", "依存関係"]
```

### 設定の最適化

```
# 設定ファイルの最適化
/mcp__cipher__search_conversations project="current" keywords=["config", "settings", "環境変数"]
↓
Serenaで設定ファイルを最適化：
- config/settings.py
- docker-compose.yml  
- .env.example

過去の設定パターンと一貫性を保ってください。
```

## 📝 カスタムプロンプトテンプレート

### テンプレート1: 設計 → 実装

```
Cipherで「{検索キーワード}」について過去の{カテゴリ}を検索し、
その結果を参考にSerenaで以下を実装してください：

目標: {実装目標}
ファイル: {対象ファイル}
要件: 
- {要件1}
- {要件2}
- {要件3}

実装後はテストを実行し、結果を確認してください。
```

### テンプレート2: 問題解決

```
現在の問題: {問題の説明}

Cipherで類似問題の解決策を検索し、
Serenaで以下の手順で対応してください：

1. 問題の詳細調査
2. 過去の解決策の適用
3. テスト実行による確認
4. 必要に応じた追加修正

検索キーワード: [{キーワード1}, {キーワード2}, {キーワード3}]
```

## 🚀 高度な使用例

### バッチ処理

```python
# 複数タスクの連続実行
tasks = [
    ("認証システム", "JWT実装", "design"),
    ("データベース設計", "テーブル正規化", "architecture"),
    ("API設計", "エンドポイント整理", "refactoring")
]

for search_query, task_desc, category in tasks:
    result = await workflow.run_full_workflow(search_query, task_desc, category)
    print(f"完了: {task_desc}")
```

### 条件分岐ワークフロー

```
# 検索結果に応じた条件分岐
/mcp__cipher__recall query="ユーザー管理" category="all"

検索結果が5件以上の場合:
→ 最新の3件の結果を使用してSerenaで実装

検索結果が5件未満の場合:
→ 全ての結果を使用し、追加で「認証」で検索してから実装

実装後は必ずテストを実行してください。
```

---

## 💡 使用のコツ

1. **段階的実行**: 一度にすべてを実行せず、Cipher → 結果確認 → Serena の順で進める
2. **具体的な指示**: ファイル名、関数名、実装要件を明確に指定する
3. **過去の知識活用**: Cipherの検索結果を必ず確認してから実装に進む
4. **テスト重視**: Serenaでの実装後は必ずテストを実行する
5. **継続的改善**: ワークフローの結果を記録し、次回に活用する