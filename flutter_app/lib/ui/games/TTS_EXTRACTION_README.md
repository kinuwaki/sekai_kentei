# ゲーム内TTSテキスト動的抽出システム

このシステムは、Flutter アプリ内の全ゲームで使用される音声テキスト（TTS）を動的に抽出・管理するための包括的なソリューションです。

## 🎯 システム概要

手動でのテキストリスト管理ではなく、**実際のFlutterコードベースから自動的に音声テキストを抽出**する完全な動的システムです。

### 主な機能

1. **自動テキスト抽出**: 各ゲームのモデルクラスから `getQuestionText()` や `questionText` プロパティを特定・抽出
2. **動的パターン解析**: 実行時に生成される可能性のある全てのテキストパターンを解析
3. **包括的カバレッジ**: 9つの主要ゲーム全てのTTSテキストを網羅
4. **多様な出力形式**: JSON、CSV、Dart定数、人間が読みやすい形式での出力をサポート
5. **重複排除と頻度分析**: テキストの重複を検出し、使用頻度を分析

## 📁 ファイル構成

```
flutter_app/lib/ui/games/
├── tts_text_extractor.dart          # 基本抽出システム
├── advanced_tts_analyzer.dart       # 高度解析システム
├── game_tts_text_generator.dart     # 統合生成システム
├── tts_text_demo.dart              # デモ・テスト実行ウィジェット
└── TTS_EXTRACTION_README.md        # このファイル
```

## 🚀 クイックスタート

### 基本的な使用方法

```dart
import 'package:your_app/ui/games/game_tts_text_generator.dart';

// 全ゲームのTTSテキストを生成
final data = await GameTTSTextGenerator.generateAllTTSTexts();

// 結果の確認
print('総テキスト数: ${data.allTexts.length}');
print('ゲーム数: ${data.gameSpecificTexts.keys.length}');

// 特定のゲームのみ抽出
final countingData = await GameTTSTextGenerator.generateGameTTSTexts('Counting');
```

### デモアプリの実行

```dart
import 'package:your_app/ui/games/tts_text_demo.dart';

// デモウィジェットを表示
runApp(MaterialApp(
  home: TTSTextExtractionDemo(),
));
```

## 🎮 対応ゲーム一覧

| ゲーム | 抽出対象 | 動的テキスト例 |
|--------|----------|----------------|
| **数字認識ゲーム** | `NumberProblem.prompt` | "1 を書いてください", "9 を書いてください" |
| **数かぞえゲーム** | `CountingProblem.questionText` | "ドットは いくつかな？" |
| **比較ゲーム** | `ComparisonProblem.questionText` | "いちばん おおきい ばんごうは どれかな？" |
| **サイズ比較ゲーム** | `SizeComparisonProblem.questionText` | "にばんめに ちいさいのは どれかな？" |
| **奇数偶数ゲーム** | `OddEvenType.questionText` | "きすうを ぜんぶ さがそう" |
| **図形マッチングゲーム** | `TileSpec.ttsText` | "あかのほし", "にじゅうあおのまる" |
| **図形向きゲーム** | `FigureOrientationProblem.questionText` | "ただしい むきは どれかな？" |
| **パズルゲーム** | `PuzzleProblem.questionText` | "ただしいくみあわせをえらんでください" |
| **ライティングゲーム** | 動的生成 | "「あ」を なぞって かこう", "「か」を かいてみよう" |

## 🔧 API リファレンス

### GameTTSTextGenerator

メインの統合生成システム

```dart
class GameTTSTextGenerator {
  // 全ゲームのTTSテキストを生成
  static Future<GeneratedTTSData> generateAllTTSTexts({
    TTSGenerationOptions options = const TTSGenerationOptions(),
  });
  
  // 特定ゲームのTTSテキストを生成
  static Future<GeneratedTTSData> generateGameTTSTexts(String gameType);
  
  // 各種フォーマットでエクスポート
  static Future<void> exportTTSTexts(GeneratedTTSData data, {
    required String basePath,
    bool exportJson = true,
    bool exportReadable = true,
    bool exportCsv = true,
    bool exportDart = true,
  });
}
```

### TTSGenerationOptions

生成オプションの設定

```dart
class TTSGenerationOptions {
  final bool includeStaticTexts;    // 静的テキストを含める
  final bool includeDynamicTexts;   // 動的テキストを含める
  final bool sortAlphabetically;    // アルファベット順でソート
  final bool includeFrequency;      // 使用頻度を含める
  final List<String>? gameTypeFilter; // 特定ゲームのみに制限
}
```

### GeneratedTTSData

生成されたデータの構造

```dart
class GeneratedTTSData {
  final List<String> allTexts;                    // 全テキストリスト
  final Map<String, List<String>> gameSpecificTexts; // ゲーム別テキスト
  final Map<String, int> textFrequency;           // テキスト使用頻度
  final Map<String, dynamic> metadata;           // メタデータ
  
  // 出力メソッド
  Map<String, dynamic> toJson();     // JSON形式
  String toReadableFormat();         // 人間が読みやすい形式
  String toCsv();                   // CSV形式
}
```

## 📊 出力例

### JSON形式
```json
{
  "metadata": {
    "generation_timestamp": "2025-01-15T10:30:00.000Z",
    "statistics": {
      "total_unique_texts": 247,
      "games_analyzed": 9
    }
  },
  "all_texts": [
    "0 を書いてください",
    "1 を書いてください",
    "ドットは いくつかな？"
  ],
  "game_specific_texts": {
    "NumberRecognition": ["0 を書いてください", "1 を書いてください"],
    "Counting": ["ドットは いくつかな？"]
  }
}
```

### 人間が読みやすい形式
```
=== ゲーム内音声テキスト一覧 ===
生成日時: 2025-01-15 19:30:00.000
総テキスト数: 247
ゲーム数: 9

=== 全テキスト一覧 ===
  1. 0 を書いてください
  2. 1 を書いてください
  3. ドットは いくつかな？

=== ゲーム別テキスト ===
--- NumberRecognition (20件) ---
  • 0 を書いてください
  • 1 を書いてください
  
--- Counting (1件) ---
  • ドットは いくつかな？
```

### Dart定数形式
```dart
class GameTTSConstants {
  static const List<String> allTexts = [
    '0 を書いてください',
    '1 を書いてください',
    'ドットは いくつかな？',
  ];
  
  static const List<String> numberrecognitionTexts = [
    '0 を書いてください',
    '1 を書いてください',
  ];
}
```

## 🔍 高度な機能

### パターン解析

システムは以下のパターン解析を実行します：

1. **順序・サイズ組み合わせ**: "いちばん おおきい", "にばんめに ちいさい"
2. **数字プロンプト**: 0-99の各数字に対する書字指示
3. **文字・モード組み合わせ**: 全ひらがな×練習モードの組み合わせ
4. **色・図形・バリアント組み合わせ**: 色×図形×バリアントの全組み合わせ

### 重複検出

複数のゲームで使用される共通テキストを自動検出し、使用頻度を分析します。

### フィルタリング機能

- ゲームタイプ別フィルタリング
- 静的/動的テキストの選択的抽出
- アルファベット順ソート

## 🧪 テスト・デバッグ

### デバッグモード実行

```dart
// テスト用サンプルテキスト生成
final testTexts = await GameTTSTextGenerator.generateTestTTSTexts(maxTexts: 50);

// 完全解析実行
final basicResult = GameTTSTextExtractor.extractAllTTSTexts();
final advancedResult = AdvancedTTSTextAnalyzer.performAdvancedAnalysis();
```

### ログ出力

システムは詳細なデバッグログを出力します：

```
[GameTTSExtractor] Extracting texts from NumberRecognition...
[AdvancedAnalyzer] Analyzing comparison question patterns...
[TTSGenerator] Generated 247 unique texts from 9 games
```

## 📈 パフォーマンス

- **実行時間**: 通常 < 100ms（全ゲーム解析）
- **メモリ使用量**: 解析結果約 1-2MB
- **拡張性**: 新ゲーム追加時は対応アナライザーを追加するだけ

## 🔄 システム拡張

新しいゲームを追加する場合：

1. `TTSGameAnalyzer` を継承したクラスを作成
2. `GameTTSTextExtractor._gameAnalyzers` に追加
3. 必要に応じて `AdvancedTTSTextAnalyzer` にパターン解析を追加

```dart
class NewGameTTSAnalyzer extends TTSGameAnalyzer {
  @override
  String get gameType => 'NewGame';
  
  @override
  TTSExtractionResult extractTTSTexts() {
    // 新ゲームのTTSテキスト抽出ロジック
  }
}
```

## ⚠️ 注意事項

1. **Dart reflection**: Web環境では `dart:mirrors` が使用できないため、一部機能が制限される可能性があります
2. **ファイル出力**: Web環境では直接ファイル出力ができないため、ログ出力に代替されます
3. **パフォーマンス**: 大量のテキスト生成時はメモリ使用量に注意してください

## 🤝 貢献

システムの改善や新機能の追加は以下の手順で行ってください：

1. 新しいゲームのアナライザーを追加
2. テストケースを作成
3. ドキュメントを更新
4. デモアプリで動作確認

---

**このシステムにより、手動でのテキストリスト管理から解放され、実際のコードベースと常に同期した包括的なTTSテキスト管理が実現されます。**