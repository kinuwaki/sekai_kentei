#!/usr/bin/env python3
"""
世界遺産検定4級 問題エディター

機能:
- CSVファイルを読み込み
- 問題を一覧表示・プレビュー
- Google Driveの画像URLをプレビュー
- 画像をローカルに保存
- JSONファイルにエクスポート
"""

import csv
import json
import os
import tkinter as tk
from tkinter import ttk, messagebox, filedialog
from pathlib import Path
import urllib.request
import urllib.parse
from PIL import Image, ImageTk
import io

# パス設定
SCRIPT_DIR = Path(__file__).parent
PROJECT_ROOT = SCRIPT_DIR.parent.parent
CSV_PATH = PROJECT_ROOT / "flutter_app/assets/quiz/世界遺産検定4級150問.csv"
JSON_OUTPUT_PATH = PROJECT_ROOT / "flutter_app/assets/quiz/世界遺産検定4級150問.json"
IMAGE_DIR = PROJECT_ROOT / "flutter_app/assets/images/quiz"


class QuizQuestion:
    """問題データクラス"""
    def __init__(self, data):
        self.id = data.get('id', '')
        self.question = data.get('question', '')
        self.choice1 = data.get('choice1', '')
        self.choice2 = data.get('choice2', '')
        self.choice3 = data.get('choice3', '')
        self.correct_answer = data.get('correctAnswer', '')
        self.explanation = data.get('explanation', '')
        self.theme = data.get('theme', '')
        self.image_url = data.get('imageUrl', '')  # 新規追加フィールド
        self.image_path = data.get('imagePath', '')  # ローカル画像パス

    def to_dict(self):
        """JSON用の辞書に変換"""
        return {
            'id': self.id,
            'question': self.question,
            'choices': [self.choice1, self.choice2, self.choice3],
            'correctAnswer': self.correct_answer,
            'explanation': self.explanation,
            'theme': self.theme,
            'imagePath': self.image_path if self.image_path else None,
        }


class QuizEditorApp:
    def __init__(self, root):
        self.root = root
        self.root.title("世界遺産検定4級 問題エディター")
        self.root.geometry("1400x900")

        self.questions = []
        self.current_question_index = 0
        self.image_cache = {}

        self.setup_ui()
        self.load_csv()

    def setup_ui(self):
        """UI構築"""
        # メインコンテナ
        main_paned = ttk.PanedWindow(self.root, orient=tk.HORIZONTAL)
        main_paned.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)

        # 左パネル: 問題一覧
        left_frame = ttk.Frame(main_paned, width=400)
        main_paned.add(left_frame, weight=1)

        ttk.Label(left_frame, text="問題一覧", font=('', 14, 'bold')).pack(pady=5)

        # 問題リスト
        list_frame = ttk.Frame(left_frame)
        list_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)

        scrollbar = ttk.Scrollbar(list_frame)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

        self.question_listbox = tk.Listbox(
            list_frame,
            yscrollcommand=scrollbar.set,
            font=('', 10),
            selectmode=tk.SINGLE
        )
        self.question_listbox.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scrollbar.config(command=self.question_listbox.yview)
        self.question_listbox.bind('<<ListboxSelect>>', self.on_question_select)

        # 右パネル: 問題詳細
        right_frame = ttk.Frame(main_paned)
        main_paned.add(right_frame, weight=3)

        # 問題詳細エリア
        detail_frame = ttk.LabelFrame(right_frame, text="問題詳細", padding=10)
        detail_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)

        # スクロール可能なフレーム
        canvas = tk.Canvas(detail_frame)
        scrollbar_detail = ttk.Scrollbar(detail_frame, orient="vertical", command=canvas.yview)
        scrollable_frame = ttk.Frame(canvas)

        scrollable_frame.bind(
            "<Configure>",
            lambda e: canvas.configure(scrollregion=canvas.bbox("all"))
        )

        canvas.create_window((0, 0), window=scrollable_frame, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar_detail.set)

        canvas.pack(side="left", fill="both", expand=True)
        scrollbar_detail.pack(side="right", fill="y")

        # 詳細フィールド
        row = 0

        # ID
        ttk.Label(scrollable_frame, text="ID:").grid(row=row, column=0, sticky=tk.W, pady=2)
        self.id_label = ttk.Label(scrollable_frame, text="", font=('', 10, 'bold'))
        self.id_label.grid(row=row, column=1, sticky=tk.W, pady=2)
        row += 1

        # テーマ
        ttk.Label(scrollable_frame, text="テーマ:").grid(row=row, column=0, sticky=tk.W, pady=2)
        self.theme_label = ttk.Label(scrollable_frame, text="")
        self.theme_label.grid(row=row, column=1, sticky=tk.W, pady=2)
        row += 1

        # 問題文
        ttk.Label(scrollable_frame, text="問題文:").grid(row=row, column=0, sticky=tk.NW, pady=2)
        self.question_text = tk.Text(scrollable_frame, height=4, width=60, wrap=tk.WORD)
        self.question_text.grid(row=row, column=1, sticky=tk.EW, pady=2)
        row += 1

        # 選択肢
        ttk.Label(scrollable_frame, text="不正解1:").grid(row=row, column=0, sticky=tk.W, pady=2)
        self.choice1_entry = ttk.Entry(scrollable_frame, width=60)
        self.choice1_entry.grid(row=row, column=1, sticky=tk.EW, pady=2)
        row += 1

        ttk.Label(scrollable_frame, text="不正解2:").grid(row=row, column=0, sticky=tk.W, pady=2)
        self.choice2_entry = ttk.Entry(scrollable_frame, width=60)
        self.choice2_entry.grid(row=row, column=1, sticky=tk.EW, pady=2)
        row += 1

        ttk.Label(scrollable_frame, text="不正解3:").grid(row=row, column=0, sticky=tk.W, pady=2)
        self.choice3_entry = ttk.Entry(scrollable_frame, width=60)
        self.choice3_entry.grid(row=row, column=1, sticky=tk.EW, pady=2)
        row += 1

        ttk.Label(scrollable_frame, text="正解:").grid(row=row, column=0, sticky=tk.W, pady=2)
        self.correct_entry = ttk.Entry(scrollable_frame, width=60)
        self.correct_entry.grid(row=row, column=1, sticky=tk.EW, pady=2)
        row += 1

        # 解説
        ttk.Label(scrollable_frame, text="解説:").grid(row=row, column=0, sticky=tk.NW, pady=2)
        self.explanation_text = tk.Text(scrollable_frame, height=4, width=60, wrap=tk.WORD)
        self.explanation_text.grid(row=row, column=1, sticky=tk.EW, pady=2)
        row += 1

        # 画像URL
        ttk.Label(scrollable_frame, text="画像URL:").grid(row=row, column=0, sticky=tk.W, pady=2)
        self.image_url_entry = ttk.Entry(scrollable_frame, width=60)
        self.image_url_entry.grid(row=row, column=1, sticky=tk.EW, pady=2)
        row += 1

        # 画像操作ボタン
        btn_frame = ttk.Frame(scrollable_frame)
        btn_frame.grid(row=row, column=1, sticky=tk.W, pady=5)

        ttk.Button(btn_frame, text="画像プレビュー", command=self.preview_image).pack(side=tk.LEFT, padx=2)
        ttk.Button(btn_frame, text="画像をダウンロード", command=self.download_image).pack(side=tk.LEFT, padx=2)
        row += 1

        # 画像プレビューエリア
        self.image_label = ttk.Label(scrollable_frame, text="画像プレビュー")
        self.image_label.grid(row=row, column=0, columnspan=2, pady=10)
        row += 1

        # ローカル画像パス
        ttk.Label(scrollable_frame, text="ローカル画像:").grid(row=row, column=0, sticky=tk.W, pady=2)
        self.image_path_label = ttk.Label(scrollable_frame, text="未設定", foreground="gray")
        self.image_path_label.grid(row=row, column=1, sticky=tk.W, pady=2)
        row += 1

        # ボトムボタン
        bottom_frame = ttk.Frame(right_frame)
        bottom_frame.pack(fill=tk.X, padx=5, pady=5)

        ttk.Button(bottom_frame, text="JSONにエクスポート", command=self.export_json).pack(side=tk.RIGHT, padx=5)
        ttk.Button(bottom_frame, text="CSVをリロード", command=self.load_csv).pack(side=tk.RIGHT, padx=5)

    def load_csv(self):
        """CSVファイルを読み込む"""
        try:
            self.questions = []
            with open(CSV_PATH, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                for row in reader:
                    self.questions.append(QuizQuestion(row))

            self.update_question_list()
            messagebox.showinfo("成功", f"{len(self.questions)}問の問題を読み込みました")
        except Exception as e:
            messagebox.showerror("エラー", f"CSVの読み込みに失敗しました:\n{e}")

    def update_question_list(self):
        """問題一覧を更新"""
        self.question_listbox.delete(0, tk.END)
        for i, q in enumerate(self.questions):
            display_text = f"{q.id}: {q.question[:40]}..."
            self.question_listbox.insert(tk.END, display_text)

        if self.questions:
            self.question_listbox.selection_set(0)
            self.show_question(0)

    def on_question_select(self, event):
        """問題選択時のイベント"""
        selection = self.question_listbox.curselection()
        if selection:
            self.show_question(selection[0])

    def show_question(self, index):
        """問題詳細を表示"""
        if index >= len(self.questions):
            return

        self.current_question_index = index
        q = self.questions[index]

        self.id_label.config(text=q.id)
        self.theme_label.config(text=q.theme)

        self.question_text.delete('1.0', tk.END)
        self.question_text.insert('1.0', q.question)

        self.choice1_entry.delete(0, tk.END)
        self.choice1_entry.insert(0, q.choice1)

        self.choice2_entry.delete(0, tk.END)
        self.choice2_entry.insert(0, q.choice2)

        self.choice3_entry.delete(0, tk.END)
        self.choice3_entry.insert(0, q.choice3)

        self.correct_entry.delete(0, tk.END)
        self.correct_entry.insert(0, q.correct_answer)

        self.explanation_text.delete('1.0', tk.END)
        self.explanation_text.insert('1.0', q.explanation)

        self.image_url_entry.delete(0, tk.END)
        self.image_url_entry.insert(0, q.image_url)

        if q.image_path:
            self.image_path_label.config(text=q.image_path, foreground="green")
        else:
            self.image_path_label.config(text="未設定", foreground="gray")

        # 画像プレビューをクリア
        self.image_label.config(image='', text="画像プレビュー")

    def preview_image(self):
        """Google Drive画像をプレビュー"""
        url = self.image_url_entry.get().strip()
        if not url:
            messagebox.showwarning("警告", "画像URLを入力してください")
            return

        try:
            # Google DriveのダイレクトURLに変換
            direct_url = self.convert_gdrive_url(url)

            # 画像をダウンロード
            with urllib.request.urlopen(direct_url) as response:
                image_data = response.read()

            # PIL Imageとして開く
            image = Image.open(io.BytesIO(image_data))

            # リサイズ（最大400x400）
            image.thumbnail((400, 400), Image.Resampling.LANCZOS)

            # Tkinter PhotoImageに変換
            photo = ImageTk.PhotoImage(image)

            self.image_label.config(image=photo, text="")
            self.image_label.image = photo  # 参照を保持

            # キャッシュに保存
            self.image_cache[self.current_question_index] = image_data

        except Exception as e:
            messagebox.showerror("エラー", f"画像の読み込みに失敗しました:\n{e}")

    def download_image(self):
        """画像をローカルに保存"""
        url = self.image_url_entry.get().strip()
        if not url:
            messagebox.showwarning("警告", "画像URLを入力してください")
            return

        q = self.questions[self.current_question_index]

        try:
            # 画像データを取得（キャッシュまたはダウンロード）
            if self.current_question_index in self.image_cache:
                image_data = self.image_cache[self.current_question_index]
            else:
                direct_url = self.convert_gdrive_url(url)
                with urllib.request.urlopen(direct_url) as response:
                    image_data = response.read()

            # 保存先ファイル名
            image_filename = f"{q.id}.jpg"
            image_path = IMAGE_DIR / image_filename

            # 画像を保存
            IMAGE_DIR.mkdir(parents=True, exist_ok=True)
            with open(image_path, 'wb') as f:
                f.write(image_data)

            # 問題データを更新
            q.image_path = f"assets/images/quiz/{image_filename}"
            self.image_path_label.config(text=q.image_path, foreground="green")

            messagebox.showinfo("成功", f"画像を保存しました:\n{image_path}")

        except Exception as e:
            messagebox.showerror("エラー", f"画像の保存に失敗しました:\n{e}")

    def convert_gdrive_url(self, url):
        """Google DriveのURLをダイレクトダウンロードURLに変換"""
        # https://drive.google.com/file/d/FILE_ID/view?usp=sharing
        # → https://drive.google.com/uc?export=download&id=FILE_ID

        if 'drive.google.com' in url:
            if '/file/d/' in url:
                file_id = url.split('/file/d/')[1].split('/')[0]
                return f"https://drive.google.com/uc?export=download&id={file_id}"

        return url

    def export_json(self):
        """JSONファイルにエクスポート"""
        try:
            # JSON形式に変換
            json_data = {
                "version": "1.0",
                "totalQuestions": len(self.questions),
                "questions": [q.to_dict() for q in self.questions]
            }

            # JSONファイルに保存
            JSON_OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
            with open(JSON_OUTPUT_PATH, 'w', encoding='utf-8') as f:
                json.dump(json_data, f, ensure_ascii=False, indent=2)

            messagebox.showinfo("成功", f"JSONファイルを保存しました:\n{JSON_OUTPUT_PATH}")

        except Exception as e:
            messagebox.showerror("エラー", f"JSONの保存に失敗しました:\n{e}")


def main():
    root = tk.Tk()
    app = QuizEditorApp(root)
    root.mainloop()


if __name__ == "__main__":
    main()
