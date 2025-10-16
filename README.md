# Monster Academy - 教育ゲームアプリ

子供向けの数学学習ゲームアプリケーションです。カウンティング、比較、フラッシュカード、迷路、パズルなど様々なゲームを通じて楽しく学習できます。

## 🎮 搭載ゲーム

- **数字カウンティングゲーム** - 数字を数える練習
- **比較ゲーム** - 大小比較の学習
- **フラッシュカードゲーム** - 音声付き学習カード
- **迷路ゲーム** - 論理的思考力を育成
- **パズルゲーム** - 問題解決能力を向上

## 🌍 対応プラットフォーム

- **Windows** (Windows 10/11)
- **macOS** (macOS 10.15+)
- **iOS** (iOS 11.0+)
- **Android** (Android 5.0+)
- **Web** (Chrome, Safari, Firefox)
- **Linux** (Ubuntu 18.04+)

## 📁 プロジェクト構成

```
monaka2/
├── external/                    # 外部ライブラリ
│   └── flutter/                # Flutter SDK (ローカル)
├── flutter_app/                # メインFlutterアプリケーション
│   ├── lib/                    # Dartソースコード
│   │   ├── main.dart          # アプリエントリーポイント
│   │   ├── core/               # コア機能
│   │   │   ├── constants.dart  # 定数定義
│   │   │   └── debug_logger.dart # デバッグログ機能
│   │   └── ui/                 # UIコンポーネント
│   │       ├── components/     # 共通コンポーネント
│   │       ├── debug/          # デバッグ画面
│   │       └── games/          # ゲーム画面
│   │           ├── counting_game/     # 数字カウンティング
│   │           ├── comparison_game/   # 比較ゲーム
│   │           ├── flashcard/         # フラッシュカード
│   │           ├── maze/              # 迷路ゲーム
│   │           └── puzzle/            # パズルゲーム
│   ├── assets/                 # 画像・音声ファイル
│   ├── android/                # Android固有設定
│   ├── ios/                    # iOS固有設定
│   ├── web/                    # Web固有設定
│   ├── windows/                # Windows固有設定
│   ├── macos/                  # macOS固有設定
│   └── linux/                  # Linux固有設定
├── tools/                      # 開発ツール
│   └── mcp/                    # MCPサーバー
│       ├── cipher_mcp_server.py    # 会話履歴管理
│       └── serena_mcp_server.py    # コード実行支援
├── scripts/                    # ビルドスクリプト
├── docs/                       # ドキュメント
└── .claude_code_config.json    # MCP設定
```

## 🚀 開発環境セットアップ

### 必要な環境

- **Flutter SDK** (external/flutter に配置済み)
- **Dart SDK** (Flutter に含まれる)
- **プラットフォーム別SDK**:
  - Windows: Visual Studio 2022
  - macOS: Xcode 14+
  - iOS: Xcode 14+ + Apple Developer アカウント
  - Android: Android Studio + Android SDK
  - Linux: GTK+3 開発ライブラリ

### Flutter環境の確認

```bash
# Flutter の状態確認
external/flutter/bin/flutter doctor

# 依存関係のインストール
cd flutter_app
../external/flutter/bin/flutter pub get
```

### プラットフォーム別ビルド

#### Windows
```bash
cd flutter_app
../external/flutter/bin/flutter build windows --release
```

#### macOS
```bash
cd flutter_app
../external/flutter/bin/flutter build macos --release
```

#### iOS
```bash
cd flutter_app
../external/flutter/bin/flutter build ios --release
```

#### Android
```bash
cd flutter_app
../external/flutter/bin/flutter build apk --release
```

#### Web
```bash
cd flutter_app
../external/flutter/bin/flutter build web --release
```

#### Linux
```bash
cd flutter_app
../external/flutter/bin/flutter build linux --release
```

### 開発サーバーの起動

```bash
cd flutter_app
../external/flutter/bin/flutter run
```

デバイス選択:
- `-d windows` - Windows
- `-d macos` - macOS  
- `-d chrome` - Web
- `-d android` - Android (エミュレータ/実機)
- `-d ios` - iOS (シミュレータ/実機)

## 🏗️ アプリケーション アーキテクチャ

### 階層構造

```
UI Layer (Flutter Widgets)
    ↓
Game Logic Layer
    ↓
Core Services Layer
    ↓
Platform Layer (Flutter Engine)
```

### ゲームモジュール構成

```dart
main.dart (アプリエントリーポイント)
    ↓
ui/
├── components/         # 共通UIコンポーネント
│   ├── game_header.dart
│   ├── question_display.dart
│   └── success_effect.dart
├── debug/             # デバッグ機能
│   ├── debug_menu_screen.dart
│   └── debug_overlay.dart
└── games/             # ゲーム画面
    ├── counting_game/
    ├── comparison_game/
    ├── flashcard/
    ├── maze/
    └── puzzle/
```

## 🎯 主要機能

### ゲームロジック

- **CountingGameLogic**: 数字カウンティングゲームの制御
- **ComparisonGameLogic**: 比較ゲームの制御  
- **FlashcardLogic**: フラッシュカード学習の制御
- **MazeLogic**: 迷路ゲームの制御
- **PuzzleLogic**: パズルゲームの制御

### コア機能

- **DebugLogger**: 統合ログシステム
- **Constants**: アプリ全体の定数管理
- **TTSService**: 音声合成サービス（Web/ネイティブ対応）

### UI コンポーネント

- **GameHeader**: ゲーム共通ヘッダー
- **QuestionDisplay**: 問題表示コンポーネント
- **SuccessEffect**: 成功エフェクト表示

## 🔧 開発ガイド

### 新しいゲームの追加

1. `flutter_app/lib/ui/games/new_game/` ディレクトリを作成
2. 以下のファイルを実装:
   ```
   new_game/
   ├── new_game_logic.dart      # ゲームロジック
   ├── new_game_screen.dart     # UI画面
   └── new_game_settings_screen.dart # 設定画面
   ```
3. `main.dart` にルートを追加

### MCPサーバーの使用

本プロジェクトには開発支援用のMCPサーバーが含まれています：

- **Cipher MCP Server**: 過去の会話履歴や設計判断を検索・取得
- **Serena MCP Server**: コード修正・実行支援

設定ファイル: `.claude_code_config.json`

### コード品質の維持

```bash
# コード解析
cd flutter_app
../external/flutter/bin/flutter analyze

# テスト実行
../external/flutter/bin/flutter test

# フォーマット
../external/flutter/bin/flutter format lib/
```

## 🐛 トラブルシューティング

### Flutter関連

**Flutter SDK が見つからない**
```bash
# Flutter の状態確認
external/flutter/bin/flutter doctor

# パスの確認
echo $PATH  # Linux/macOS
set PATH   # Windows
```

**依存関係の問題**
```bash
cd flutter_app
../external/flutter/bin/flutter clean
../external/flutter/bin/flutter pub get
```

### プラットフォーム固有

**Windows**
- Visual Studio 2022がインストールされていることを確認
- Windows SDKが最新であることを確認

**macOS/iOS**
```bash
# Xcode Command Line Tools のインストール
xcode-select --install

# iOS開発の場合
sudo xcode-select --switch /Applications/Xcode.app
```

**Android**
- Android Studio と Android SDK がインストールされていることを確認
- `flutter doctor` でAndroid toolchainを確認

**Linux**
```bash
# 必要なライブラリのインストール
sudo apt update
sudo apt install libgtk-3-dev pkg-config
```

### ビルドエラー

**Gradle エラー (Android)**
```bash
cd flutter_app/android
./gradlew clean
cd ..
../external/flutter/bin/flutter build apk
```

**Podfile エラー (iOS)**
```bash
cd flutter_app/ios
rm Podfile.lock
pod install
```

## 📊 テクニカル仕様

### 使用技術

- **Flutter**: 3.33.0+
- **Dart**: 3.6.0+
- **状態管理**: Riverpod 2.6.1
- **音声合成**: flutter_tts 4.2.3
- **音声再生**: audioplayers 6.5.0
- **パス操作**: path_provider 2.1.5

### サポート対象

- **最小バージョン**:
  - iOS: 11.0+
  - Android: API Level 21 (Android 5.0)+
  - Windows: Windows 10+
  - macOS: 10.15+
  - Web: Chrome 57+, Safari 11+, Firefox 52+

## 🤝 コントリビューション

1. Issues でバグ報告や機能要望を作成
2. フォークしてfeatureブランチを作成
3. 新機能やバグ修正を実装
4. テストを追加・実行
5. プルリクエストを送信

### 開発ガイドライン

- コードスタイル: `flutter format` を使用
- テスト: 新機能には必ずテストを追加
- コミットメッセージ: 明確で簡潔な説明を記載

## 📖 参考リンク

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Guide](https://dart.dev/guides)
- [Riverpod Documentation](https://riverpod.dev/)
- [Material Design Guidelines](https://m3.material.io/)

## 📄 ライセンス

このプロジェクトはMITライセンスの下で公開されています。