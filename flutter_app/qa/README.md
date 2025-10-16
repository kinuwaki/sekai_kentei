# 自立型ビジュアルQAエージェント

Claude Vision を使った、**観測→思考→操作→レポート**の自動QAエージェント。

## 特徴

- **セレクタ依存しない**: テキスト/aria-label/座標ベースでUI操作
- **インターフェイス変更に強い**: 見た目が変わっても内容で判断
- **完全自動**: スクショ→Claude判断→クリック→結果記録を自動ループ
- **詳細レポート**: 各ステップのスクショ、オーバーレイ、JSONL ログを生成

## アーキテクチャ

```
Observe (観測)
  ↓ スクショ + DOM解析（ボタン/リンク/入力欄）
Decide (思考)
  ↓ Claude Vision API → 次のアクションJSON
Act (操作)
  ↓ Playwright でクリック/入力/スクロール
Report (記録)
  ↓ オーバーレイ画像 + JSONL + Markdown レポート
```

## セットアップ

### 1. 依存パッケージインストール（完了済み）

```bash
npm install
npx playwright install chromium
```

### 2. 環境変数設定

```bash
cp .env.example .env
# .env を編集して ANTHROPIC_API_KEY を設定
```

Anthropic API Key は [console.anthropic.com](https://console.anthropic.com/) から取得してください。

## 使い方

### Flutter Web を固定ポートで起動

```bash
# ターミナル A
cd ..
flutter run -d web-server --web-port=8080 --web-hostname=localhost
```

### QA エージェント実行

```bash
# ターミナル B
node agent.mjs --url http://localhost:8080
```

#### オプション

| オプション | デフォルト | 説明 |
|-----------|----------|------|
| `--url` | `http://localhost:8080` | テスト対象URL |
| `--dev` | `true` | ブラウザを表示するか（headless=false） |
| `--maxSteps` | `80` | 最大ステップ数 |
| `--out` | `./runs` | レポート出力ディレクトリ |

### 実行例

```bash
# 開発モード（ブラウザ表示あり）
node agent.mjs --dev

# ヘッドレスモード
node agent.mjs --dev=false

# 最大ステップ数を変更
node agent.mjs --maxSteps=100
```

## 出力

実行すると `runs/run-YYYY-MM-DDTHH-MM-SS/` に以下が生成されます：

```
runs/
└── run-2025-10-04T12-34-56/
    ├── step-001.png           # 各ステップのスクショ
    ├── step-002.png
    ├── ...
    ├── overlay-001.png        # UI候補＋クリック位置の注釈付き
    ├── overlay-002.png
    ├── ...
    ├── events.jsonl           # 1行1イベントのログ
    └── report.md              # 問題ごとのレポート（Markdown）
```

### events.jsonl の例

```jsonl
{"ts":"2025-10-04T12:34:56.789Z","problem":1,"step":1,"event":"step","action":{"action":"click","target":{"x":422,"y":195},"reason_short":"Start game"},"outcome":"progress","screenshot":"step-001.png","overlay":"overlay-001.png"}
{"ts":"2025-10-04T12:34:58.123Z","problem":1,"step":2,"event":"step","action":{"action":"click","target":{"x":300,"y":250},"reason_short":"Select answer"},"outcome":"correct","screenshot":"step-002.png","overlay":"overlay-002.png"}
```

### report.md の例

```markdown
# Visual QA Report
- URL: http://localhost:8080
- Run: run-2025-10-04T12-34-56

|Step|Problem|Outcome|Overlay|
|---:|---:|---|---|
|1|1|progress|![](overlay-001.png)|
|2|1|correct|![](overlay-002.png)|
|3|2|progress|![](overlay-003.png)|
```

## 仕組み

### 1. 観測（Observe）

- Playwright で画面のスクリーンショットを取得
- DOM から「押せそうな要素」を抽出：
  - `button`, `[role="button"]`, `a[href]`, `input[type="button|submit"]`, `[tabindex]`
- 各要素の以下を記録：
  - テキスト（`innerText`）
  - aria-label
  - role
  - 座標（bounding box）

### 2. 思考（Decide）

Claude Vision API に送信：
- スクリーンショット画像（base64）
- UI候補のJSON
- 現在の状態（正解/不正解/進行中）

Claude が次のアクションをJSON形式で返す：

```json
{
  "action": "click",
  "target": { "x": 300, "y": 250 },
  "reason_short": "Select correct answer"
}
```

### 3. 操作（Act）

Playwright で実際に操作：
- `click`: 指定座標をクリック
- `type`: テキスト入力
- `scroll`: スクロール
- `wait`: 短時間待機
- `finish`: テスト完了
- `fail`: テスト失敗

### 4. 記録（Report）

- オーバーレイ画像生成（UI候補の枠＋クリック位置）
- JSONL に1行追加
- 正解/不正解を判定して問題番号をインクリメント

## カスタマイズ

### 語彙の追加（agent.mjs の `LABELS`）

インターフェイスで使われる語彙を追加することで、検出精度が上がります：

```javascript
const LABELS = {
  start:  ['スタート','はじめる','開始','PLAY','Start','Go','はじめ'],
  next:   ['つぎ','次へ','Next','Continue','すすむ','OK','つづける'],
  back:   ['もどる','戻る','Back','ホーム','Home','Exit'],
  correct:['正解','やった','Great','Correct','クリア','Clear'],
  wrong:  ['不正解','ちがう','Wrong','Miss','もういちど','Retry'],
};
```

### プロンプトの調整（`SYSTEM_PROMPT`）

Claude に与える指示を調整することで、動作をカスタマイズできます。

## トラブルシューティング

### Claude API エラー

```
Error: API key not found
```

→ `.env` ファイルに `ANTHROPIC_API_KEY` が設定されているか確認

### ブラウザが起動しない

```
browserType.launch: Executable doesn't exist
```

→ `npx playwright install chromium` を実行

### 同じ画面でループする

エージェントは簡易的なスタック検出を実装していますが、完璧ではありません。
`--maxSteps` を調整するか、`LABELS` に語彙を追加してください。

## 拡張案

- **問題ごとレポートの充実**: 正解/不正解の根拠、選択肢画像、回答時間、成功率
- **スキルモジュール**: 数の比較/大小/ひらがな選択などをルールベースで解く
- **フロー定義**: `flows/*.json` に画面遷移を宣言的に記述
- **CI統合**: GitHub Actions で自動実行

## ライセンス

このプロジェクトの一部です。
