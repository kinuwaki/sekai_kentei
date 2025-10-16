# VOICEVOX音声生成システム (V2.0)

次世代の自動音声生成システム。設定ベースの管理、テンプレートエンジン、Dartコード解析、CI/CD統合を実現。

## 🚀 クイックスタート

**最も簡単な方法**：プロジェクトルートから実行

```bash
generate_voices.bat
```

これだけで以下が自動実行されます：
1. 新しい動的テキスト生成システムの実行
2. VOICEVOXサーバーの起動（未起動の場合）
3. TTSサーバーの起動
4. 不足音声ファイルの自動検出・生成

## 📋 セットアップ

### 必須要件

1. **VOICEVOX**: [公式サイト](https://voicevox.hiroshiba.jp/)からインストール
2. **Python依存パッケージ**:
   ```bash
   pip install fastapi uvicorn requests pydub pyyaml
   ```
3. **ffmpeg**: MP3変換用
   - Windows: [ffmpeg公式サイト](https://ffmpeg.org/download.html)
   - Mac: `brew install ffmpeg`
   - Linux: `sudo apt-get install ffmpeg`

## 💻 基本的な使用方法

### パターン1: 完全自動化（推奨）

```bash
cd tools/voicevox
python automated_voice_pipeline.py
```
- サーバー自動起動
- 不足ファイル自動検出
- 音声ファイル自動生成
- エラー時の自動リトライ

### パターン2: 従来通りの使用

```bash
cd tools/voicevox
python generate_voice_assets.py --list     # 不足ファイル確認
python generate_voice_assets.py           # 音声生成
```

## 🎨 新機能：ゲームテキストの追加

### 設定ファイルでテキスト追加

`game_text_configs.py` を編集：

```python
GAME_TEXT_CONFIGS['新しいゲーム'] = {
    'static_texts': [
        "新しい問題です",
        "どちらが正解？"
    ],
    'templates': {
        'basic': ["どちらが {比較}？"],
        'numbered': ["{順位} {比較}のは？"]
    },
    'variables': {
        '比較': ['大きい', '小さい', '多い', '少ない'],
        '順位': ['いちばん', 'にばんめに', 'さんばんめに']
    }
}
```

### テンプレートエンジンの活用

**条件付きテキスト**:
```python
template = "[two_options:どちらが大きい？|いちばん大きいのは？]"
# 条件に応じて異なるテキストを生成
```

**変数展開**:
```python
template = "{rank} {comparison}のは？"
variables = {
    'rank': ['いちばん', 'にばんめに'],
    'comparison': ['大きい', '小さい']
}
# → "いちばん大きいのは？", "にばんめに小さいのは？" など4パターン生成
```

## 📊 分析・デバッグコマンド

### システム状態確認

```bash
cd tools/voicevox

# サーバー状態チェック
python automated_voice_pipeline.py check

# 不足ファイル詳細分析
python automated_voice_pipeline.py analyze

# 新旧システム比較
python compare_text_systems.py

# Dartコード解析
python dart_code_analyzer.py
```

### テストコマンド

```bash
# 設定ファイル単体テスト
python game_text_configs.py

# テンプレートエンジンテスト  
python text_template_engine.py

# 統合システムテスト
python simple_unified_extractor.py
```

## 🔧 高度な使用方法

### 個別コンポーネントの使用

```bash
# テンプレートベースの生成のみ
python text_template_engine.py

# Dartコードからテキスト抽出のみ  
python dart_code_analyzer.py

# 設定ファイルからの生成のみ
python game_text_configs.py
```

### CI/CD統合

GitHub Actions ワークフロー生成：
```bash
python automated_voice_pipeline.py workflow
```

生成されたファイル: `.github/workflows/voice-generation.yml`

## 📁 システムアーキテクチャ

```
tools/voicevox/
├── 🎯 メインシステム
│   ├── generate_voice_assets.py      # 統合エントリーポイント（互換性保持）
│   ├── tts_server.py                 # VOICEVOXプロキシサーバー
│   └── automated_voice_pipeline.py   # 完全自動化パイプライン
├── 🏗️ テキスト生成エンジン
│   ├── game_text_configs.py         # 設定ベースのテキスト管理
│   ├── text_template_engine.py      # 高機能テンプレートエンジン
│   └── dart_code_analyzer.py        # Dartコード自動解析
├── 🔄 統合・互換性
│   ├── simple_unified_extractor.py  # 統合テキスト抽出システム
│   └── compare_text_systems.py      # 新旧システム比較ツール
└── 📄 ドキュメント
    └── README.md                     # このファイル
```

## 🎵 音声ファイル仕様

- **保存場所**: `flutter_app/assets/voice/`
- **ファイル形式**: MP3 (128kbps)
- **命名規則**: `{テキスト30文字}_{MD5ハッシュ6文字}.mp3`
- **音量**: +6dB調整済み（最適化済み）

## ⚡ パフォーマンス

- **テキスト生成**: 122個のユニークテキスト（重複自動除去）
- **処理時間**: ~3秒（テキスト生成）、~5分（音声生成）
- **メモリ使用量**: ~50MB（通常時）
- **並列処理**: サポート（複数ファイル同時生成）

## 🚨 トラブルシューティング

### システムエラーの場合

```bash
# 基本システムで動作確認
cd tools/voicevox
python game_text_configs.py

# それでもエラーの場合は従来バッチファイル
cd ../..
generate_voices.bat
```

### 音声生成エラーの場合

1. **サーバー確認**: `python automated_voice_pipeline.py check`
2. **手動起動**: `start_voicevox_server.bat`
3. **依存関係**: `pip install requests pydub`

### ファイルが見つからない場合

```bash
python generate_voice_assets.py --list    # 不足ファイル一覧
python generate_voice_assets.py --json    # JSON形式で詳細確認
```

## 📈 システムの特徴

### ✅ メリット

- **自動化**: 手動メンテナンス不要
- **拡張性**: 新ゲーム追加が設定ファイル編集だけ
- **安全性**: フォールバック機能で安定動作
- **効率性**: 重複除去・テンプレート展開で大量生成

### 🔄 互換性

- **100%後方互換**: 既存の`generate_voices.bat`がそのまま動作
- **段階的移行**: エラー時は自動的に基本システムにフォールバック
- **API互換**: 既存のFlutterアプリはそのまま動作

---

**🎉 最新の自動音声生成システムで、効率的なゲーム開発を！**