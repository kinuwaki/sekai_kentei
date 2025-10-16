# TTS (Text-to-Speech) 代替案と音声問題の解説

## Web環境での音声について

### flutter run -d chrome vs flutter run -d web-server の違い

1. **flutter run -d chrome** ✅
   - ChromeブラウザでWebアプリを直接実行
   - **音声再生可能** - flutter_ttsがWeb Speech APIを使用
   - ユーザージェスチャー後に音声が有効になる
   
2. **flutter run -d web-server** ❌
   - ローカルWebサーバーを起動してブラウザで表示
   - **音声再生不可** - セキュリティ制限によりTTSが制限される
   - ブラウザの自動再生ポリシーにより音声がブロックされる

### 推奨実行方法
```bash
flutter run -d chrome  # 音声あり（推奨）
```

### 現在の問題
- flutter_ttspパッケージのWindows CMakeビルドでパースエラー
- Error: Parse error. Expected "(", got identifier with text "install"

## 代替解決策

### 1. **Web Speech API (推奨)**
Webビルド時のみ利用可能
```dart
import 'dart:html' as html;

void speakText(String text) {
  if (html.window.speechSynthesis != null) {
    final utterance = html.SpeechSynthesisUtterance(text);
    utterance.lang = 'ja-JP';
    utterance.rate = 0.8;
    html.window.speechSynthesis!.speak(utterance);
  }
}
```

### 2. **Windows SAPI (System.Speech)**
Windows専用のネイティブ実装
```dart
import 'dart:ffi';
import 'package:ffi/ffi.dart';

// Windows System.Speech.Synthesis を使用
// 別途プラグイン作成が必要
```

### 3. **Audio ファイル再生**
事前録音した音声ファイルを使用
```dart
import 'package:audioplayers/audioplayers.dart';

final AudioPlayer audioPlayer = AudioPlayer();

void playNumberAudio(int number) {
  audioPlayer.play(AssetSource('audio/numbers/$number.mp3'));
}
```

### 4. **Google Text-to-Speech API**
クラウドベースのソリューション
```dart
import 'package:http/http.dart' as http;

Future<void> googleTTS(String text) async {
  // Google TTS API を呼び出し
  // インターネット接続が必要
}
```

## 現在の実装
現在は **HapticFeedback** で代替フィードバックを提供：
- 触覚フィードバック
- 視覚的な数字表示
- 詳細なデバッグログ

## 推奨される実装順序
1. ✅ **Haptic Feedback** (現在実装済み)
2. 🔄 **Audio Files** - 数字1-120の音声ファイルを追加
3. 🔄 **Web Speech API** - Webビルド対応
4. 🔄 **Windows SAPI** - Windows専用TTS

## ユーザーへの提案
音声読み上げが必要な場合は：
1. **短期解決策**: 音声ファイル（mp3）を準備して再生
2. **長期解決策**: プラットフォーム固有のTTS実装を検討