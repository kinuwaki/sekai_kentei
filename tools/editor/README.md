# 世界遺産検定4級 問題エディター

CSV形式の問題データをJSON形式に変換し、Google Driveの画像を管理するGUIツールです。

## 機能

- ✅ CSVファイルの読み込み
- ✅ 問題一覧の表示・プレビュー
- ✅ Google Drive画像のプレビュー
- ✅ 画像のローカル保存（`flutter_app/assets/images/quiz/`）
- ✅ JSON形式でエクスポート

## セットアップ

```bash
cd tools/editor
pip install -r requirements.txt
```

## 使い方

```bash
python quiz_editor.py
```

## 画像URL形式

Google DriveのファイルURLをそのまま貼り付けてください：

```
https://drive.google.com/file/d/FILE_ID/view?usp=sharing
```

ツールが自動的にダイレクトダウンロードURLに変換します。

## JSONフォーマット

```json
{
  "version": "1.0",
  "totalQuestions": 150,
  "questions": [
    {
      "id": "q1",
      "question": "問題文",
      "choices": ["選択肢1", "選択肢2", "選択肢3"],
      "correctAnswer": "正解",
      "explanation": "解説",
      "theme": "テーマ",
      "imagePath": "assets/images/quiz/q1.jpg"
    }
  ]
}
```

## 出力先

- **JSON**: `flutter_app/assets/quiz/世界遺産検定4級150問.json`
- **画像**: `flutter_app/assets/images/quiz/*.jpg`
