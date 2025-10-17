# 世界検定４級 - World Heritage Quiz Grade 4

世界遺産検定4級の学習用クイズアプリケーションです。150問の4択問題を通じて、世界遺産の基礎知識を楽しく学習できます。

## 🎮 機能

- **世界遺産クイズ** - 150問の4択問題（CSV形式で管理）
- **デイリーチャレンジ** - 毎日異なる問題セット
- **復習モード** - 間違えた問題を重点的に学習
- **テストモード選択** - 自分のペースで学習可能
- **音声フィードバック** - 正解・不正解時の効果音

## 🌍 対応プラットフォーム

- **iOS** (iOS 11.0+)
- **Android** (Android 5.0+)
- **Web** (Chrome, Safari, Firefox)
- **Windows** (Windows 10/11)
- **macOS** (macOS 10.15+)
- **Linux** (Ubuntu 18.04+)

## 📁 プロジェクト構成

```
sekai_kentei/
├── flutter_app/                # メインFlutterアプリケーション
│   ├── lib/                    # Dartソースコード
│   │   ├── main.dart          # アプリエントリーポイント
│   │   └── ui/                 # UIコンポーネント
│   │       ├── components/     # 共通コンポーネント
│   │       ├── onboarding/     # 初期化処理
│   │       └── games/          # ゲーム画面
│   │           ├── base/              # 基本クラス
│   │           ├── sekai_kentei_game/ # 世界遺産クイズゲーム
│   │           ├── daily_challenge_screen.dart
│   │           ├── review_screen.dart
│   │           └── test_mode_selection_screen.dart
│   ├── assets/                 # 画像・音声・問題ファイル
│   │   ├── quiz/              # クイズ問題（CSV）
│   │   ├── audio/             # 効果音
│   │   └── images/            # 画像アセット
│   ├── android/                # Android固有設定
│   ├── ios/                    # iOS固有設定
│   ├── web/                    # Web固有設定
│   ├── windows/                # Windows固有設定
│   ├── macos/                  # macOS固有設定
│   └── linux/                  # Linux固有設定
├── assets/                     # 共有アセット
├── scripts/                    # ビルドスクリプト
├── docs/                       # ドキュメント
└── external/                   # 外部ライブラリ
    └── flutter/                # Flutter SDK (ローカル)
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

### 主要コンポーネント

```dart
main.dart (アプリエントリーポイント)
    ↓
ui/
├── components/         # 共通UIコンポーネント
├── onboarding/         # アプリ初期化
└── games/              # ゲーム画面
    ├── base/                          # 基本クラス
    ├── sekai_kentei_game/             # クイズゲームロジック
    │   ├── models/                    # データモデル
    │   ├── modern_sekai_kentei_logic.dart
    │   └── sekai_kentei_screen.dart
    ├── daily_challenge_screen.dart    # デイリーチャレンジ
    ├── review_screen.dart             # 復習モード
    └── test_mode_selection_screen.dart # テストモード選択
```

## 🎯 主要機能

### クイズシステム

- **CSV形式の問題管理**: 150問の世界遺産問題を`assets/quiz/世界遺産検定4級150問.csv`で管理
- **4択問題形式**: 各問題に3つの誤答と1つの正解
- **テーマ分類**: 「世界遺産の基礎知識」などテーマ別に問題を分類
- **解説機能**: 各問題に詳しい解説を表示

### 学習モード

- **デイリーチャレンジ**: 毎日異なる問題セットで学習
- **復習モード**: 間違えた問題を重点的に復習
- **テストモード**: 自分のペースで問題に取り組む

### UI/UX

- **縦固定画面**: スマートフォンでの学習に最適化
- **全画面表示**: ゲーム感覚で集中して学習
- **音声フィードバック**: 正解・不正解時の効果音で即座にフィードバック

## 🔧 開発ガイド

### 問題の追加・編集

`flutter_app/assets/quiz/世界遺産検定4級150問.csv`を編集します：

```csv
id,question,choice1,choice2,choice3,correctAnswer,explanation,theme
q1,世界遺産の持つ価値は？,顕著な経済的価値,顕著な観光的価値,顕著な歴史的価値,顕著な普遍的価値,解説文,世界遺産の基礎知識
```

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

- **Flutter**: 3.8.1+
- **Dart**: 3.8.1+
- **状態管理**: Riverpod 2.4.9
- **音声再生**: audioplayers 6.0.0
- **データ永続化**: shared_preferences 2.5.3

### サポート対象

- **最小バージョン**:
  - iOS: 11.0+
  - Android: API Level 21 (Android 5.0)+
  - Windows: Windows 10+
  - macOS: 10.15+
  - Web: Chrome 57+, Safari 11+, Firefox 52+

## 📖 参考リンク

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Guide](https://dart.dev/guides)
- [Riverpod Documentation](https://riverpod.dev/)
- [Material Design Guidelines](https://m3.material.io/)
- [世界遺産検定公式サイト](https://www.sekaken.jp/)

## 📄 ライセンス

このプロジェクトはMITライセンスの下で公開されています。
