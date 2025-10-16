#!/usr/bin/env python3
"""
レッスンエディタGUIツール
game_settings_catalog.jsonからゲーム設定を選択して
course_4yo.ymlを編集するツール
"""

import tkinter as tk
from tkinter import ttk, messagebox, filedialog
import json
import yaml
import os
from pathlib import Path
from typing import Dict, List, Any
import copy

class LessonEditorApp:
    def __init__(self, root):
        self.root = root
        self.root.title("レッスンエディタ - course_4yo.yml 編集ツール")
        self.root.geometry("1400x800")
        
        # データ
        self.catalog = {}
        self.course_data = {}
        self.lessons = []
        self.current_lesson_index = None
        
        # パス設定
        self.base_path = Path(__file__).parent.parent
        self.catalog_path = self.base_path / "flutter_app" / "assets" / "lessons" / "game_settings_catalog.json"
        self.course_path = self.base_path / "flutter_app" / "assets" / "lessons" / "course_4yo.yml"
        
        # UI構築
        self.setup_ui()
        
        # データ読み込み
        self.load_catalog()
        self.load_course()
        
    def setup_ui(self):
        """UIを構築"""
        # メニューバー
        menubar = tk.Menu(self.root)
        self.root.config(menu=menubar)
        
        file_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="ファイル", menu=file_menu)
        file_menu.add_command(label="開く", command=self.open_course)
        file_menu.add_command(label="保存", command=self.save_course)
        file_menu.add_command(label="名前を付けて保存", command=self.save_as_course)
        file_menu.add_separator()
        file_menu.add_command(label="カタログ再読み込み", command=self.load_catalog)
        file_menu.add_separator()
        file_menu.add_command(label="終了", command=self.root.quit)
        
        # メインフレーム
        main_frame = ttk.Frame(self.root, padding="10")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # 左側：レッスンリスト
        left_frame = ttk.Frame(main_frame)
        left_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S), padx=(0, 10))
        
        ttk.Label(left_frame, text="レッスン一覧", font=("", 12, "bold")).grid(row=0, column=0, columnspan=2, pady=(0, 10))
        
        # レッスンリストボックス
        self.lesson_listbox = tk.Listbox(left_frame, width=40, height=25)
        self.lesson_listbox.grid(row=1, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        self.lesson_listbox.bind('<<ListboxSelect>>', self.on_lesson_select)
        
        # スクロールバー
        scrollbar = ttk.Scrollbar(left_frame, orient=tk.VERTICAL, command=self.lesson_listbox.yview)
        scrollbar.grid(row=1, column=1, sticky=(tk.N, tk.S))
        self.lesson_listbox.config(yscrollcommand=scrollbar.set)
        
        # ボタン
        button_frame = ttk.Frame(left_frame)
        button_frame.grid(row=2, column=0, pady=(10, 0))
        
        ttk.Button(button_frame, text="レッスン追加", command=self.add_lesson).grid(row=0, column=0, padx=2)
        ttk.Button(button_frame, text="レッスン削除", command=self.delete_lesson).grid(row=0, column=1, padx=2)
        ttk.Button(button_frame, text="上へ", command=self.move_lesson_up).grid(row=0, column=2, padx=2)
        ttk.Button(button_frame, text="下へ", command=self.move_lesson_down).grid(row=0, column=3, padx=2)
        
        # 右側：レッスン編集
        self.right_frame = ttk.Frame(main_frame)
        self.right_frame.grid(row=0, column=1, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # タブ
        self.notebook = ttk.Notebook(self.right_frame)
        self.notebook.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # 基本情報タブ
        self.info_tab = ttk.Frame(self.notebook)
        self.notebook.add(self.info_tab, text="基本情報")
        self.setup_info_tab()
        
        # ちえ（かずかぞえ）タブ
        self.chie_tab = ttk.Frame(self.notebook)
        self.notebook.add(self.chie_tab, text="ちえ（かずかぞえ）")
        self.setup_chie_tab()
        
        # かず（比較）タブ
        self.kazu_tab = ttk.Frame(self.notebook)
        self.notebook.add(self.kazu_tab, text="かず（比較）")
        self.setup_kazu_tab()
        
        # もじ（書き）タブ
        self.moji_tab = ttk.Frame(self.notebook)
        self.notebook.add(self.moji_tab, text="もじ（書き）")
        self.setup_moji_tab()
        
        # グリッドの重み設定
        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(0, weight=1)
        main_frame.columnconfigure(1, weight=1)
        main_frame.rowconfigure(0, weight=1)
        left_frame.rowconfigure(1, weight=1)
        self.right_frame.columnconfigure(0, weight=1)
        self.right_frame.rowconfigure(0, weight=1)
        
    def setup_info_tab(self):
        """基本情報タブのセットアップ"""
        frame = ttk.Frame(self.info_tab, padding="20")
        frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        ttk.Label(frame, text="レッスンタイトル:", font=("", 10, "bold")).grid(row=0, column=0, sticky=tk.W, pady=10)
        self.title_var = tk.StringVar()
        ttk.Entry(frame, textvariable=self.title_var, width=40).grid(row=0, column=1, pady=10, padx=10)
        
        ttk.Label(frame, text="Day番号:", font=("", 10, "bold")).grid(row=1, column=0, sticky=tk.W, pady=10)
        self.day_label = ttk.Label(frame, text="")
        self.day_label.grid(row=1, column=1, sticky=tk.W, pady=10, padx=10)
        
    def setup_chie_tab(self):
        """ちえタブのセットアップ"""
        frame = ttk.Frame(self.chie_tab, padding="20")
        frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N))
        
        # 範囲
        ttk.Label(frame, text="範囲:", font=("", 10, "bold")).grid(row=0, column=0, sticky=tk.W, pady=10)
        self.chie_range_var = tk.StringVar()
        self.chie_range_combo = ttk.Combobox(frame, textvariable=self.chie_range_var, width=20)
        self.chie_range_combo.grid(row=0, column=1, pady=10, padx=10)
        
        # 問題数
        ttk.Label(frame, text="問題数:", font=("", 10, "bold")).grid(row=1, column=0, sticky=tk.W, pady=10)
        self.chie_count_var = tk.StringVar()
        self.chie_count_combo = ttk.Combobox(frame, textvariable=self.chie_count_var, width=20)
        self.chie_count_combo.grid(row=1, column=1, pady=10, padx=10)
        
        # shapes（読み取り専用）
        ttk.Label(frame, text="形状:", font=("", 10, "bold")).grid(row=2, column=0, sticky=tk.W, pady=10)
        ttk.Label(frame, text="(ランダム生成)").grid(row=2, column=1, sticky=tk.W, pady=10, padx=10)
        
    def setup_kazu_tab(self):
        """かずタブのセットアップ"""
        frame = ttk.Frame(self.kazu_tab, padding="20")
        frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N))
        
        # 表示タイプ
        ttk.Label(frame, text="表示タイプ:", font=("", 10, "bold")).grid(row=0, column=0, sticky=tk.W, pady=10)
        self.kazu_display_var = tk.StringVar()
        self.kazu_display_combo = ttk.Combobox(frame, textvariable=self.kazu_display_var, width=20)
        self.kazu_display_combo.grid(row=0, column=1, pady=10, padx=10)
        self.kazu_display_combo.bind('<<ComboboxSelected>>', self.on_kazu_display_change)
        
        # 範囲
        ttk.Label(frame, text="範囲:", font=("", 10, "bold")).grid(row=1, column=0, sticky=tk.W, pady=10)
        self.kazu_range_var = tk.StringVar()
        self.kazu_range_combo = ttk.Combobox(frame, textvariable=self.kazu_range_var, width=20)
        self.kazu_range_combo.grid(row=1, column=1, pady=10, padx=10)
        
        # 選択肢数
        ttk.Label(frame, text="選択肢数:", font=("", 10, "bold")).grid(row=2, column=0, sticky=tk.W, pady=10)
        self.kazu_option_var = tk.StringVar()
        self.kazu_option_combo = ttk.Combobox(frame, textvariable=self.kazu_option_var, width=20)
        self.kazu_option_combo.grid(row=2, column=1, pady=10, padx=10)
        
        # 問題タイプ
        ttk.Label(frame, text="問題タイプ:", font=("", 10, "bold")).grid(row=3, column=0, sticky=tk.W, pady=10)
        self.kazu_type_var = tk.StringVar()
        self.kazu_type_combo = ttk.Combobox(frame, textvariable=self.kazu_type_var, width=20)
        self.kazu_type_combo.grid(row=3, column=1, pady=10, padx=10)
        
        # 問題数
        ttk.Label(frame, text="問題数:", font=("", 10, "bold")).grid(row=4, column=0, sticky=tk.W, pady=10)
        self.kazu_count_var = tk.StringVar()
        self.kazu_count_combo = ttk.Combobox(frame, textvariable=self.kazu_count_var, width=20)
        self.kazu_count_combo.grid(row=4, column=1, pady=10, padx=10)
        
    def setup_moji_tab(self):
        """もじタブのセットアップ"""
        frame = ttk.Frame(self.moji_tab, padding="20")
        frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N))
        
        # カテゴリ
        ttk.Label(frame, text="カテゴリ:", font=("", 10, "bold")).grid(row=0, column=0, sticky=tk.W, pady=10)
        self.moji_category_var = tk.StringVar()
        self.moji_category_combo = ttk.Combobox(frame, textvariable=self.moji_category_var, width=20)
        self.moji_category_combo.grid(row=0, column=1, pady=10, padx=10)
        self.moji_category_combo.bind('<<ComboboxSelected>>', self.on_moji_category_change)
        
        # 文字選択
        ttk.Label(frame, text="練習文字:", font=("", 10, "bold")).grid(row=1, column=0, sticky=(tk.W, tk.N), pady=10)
        
        # 文字選択フレーム（スクロール可能）
        char_frame = ttk.Frame(frame)
        char_frame.grid(row=1, column=1, pady=10, padx=10, sticky=(tk.W, tk.E))
        
        canvas = tk.Canvas(char_frame, height=200, width=400)
        scrollbar = ttk.Scrollbar(char_frame, orient="vertical", command=canvas.yview)
        self.char_checkboxes_frame = ttk.Frame(canvas)
        
        canvas.configure(yscrollcommand=scrollbar.set)
        canvas_frame = canvas.create_window((0, 0), window=self.char_checkboxes_frame, anchor="nw")
        
        canvas.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        scrollbar.grid(row=0, column=1, sticky=(tk.N, tk.S))
        
        self.char_checkboxes_frame.bind("<Configure>", lambda e: canvas.configure(scrollregion=canvas.bbox("all")))
        
        self.char_vars = {}
        
        # シーケンス
        ttk.Label(frame, text="練習パターン:", font=("", 10, "bold")).grid(row=2, column=0, sticky=(tk.W, tk.N), pady=10)
        self.sequence_var = tk.StringVar()
        self.sequence_frame = ttk.Frame(frame)
        self.sequence_frame.grid(row=2, column=1, pady=10, padx=10, sticky=tk.W)
        
    def load_catalog(self):
        """カタログファイルを読み込み"""
        try:
            with open(self.catalog_path, 'r', encoding='utf-8') as f:
                self.catalog = json.load(f)
            
            # コンボボックスの選択肢を設定
            if 'chie' in self.catalog:
                chie_options = self.catalog['chie']['options']
                self.chie_range_combo['values'] = chie_options.get('range', [])
                self.chie_count_combo['values'] = [str(x) for x in chie_options.get('questionCount', [])]
            
            if 'kazu' in self.catalog:
                kazu_options = self.catalog['kazu']['options']['displayType']
                self.kazu_display_combo['values'] = list(kazu_options.keys())
            
            if 'moji' in self.catalog:
                moji_options = self.catalog['moji']['options']['category']
                self.moji_category_combo['values'] = list(moji_options.keys())
                
            messagebox.showinfo("成功", "カタログを読み込みました")
        except Exception as e:
            messagebox.showerror("エラー", f"カタログ読み込みエラー: {e}")
    
    def load_course(self):
        """コースファイルを読み込み"""
        try:
            with open(self.course_path, 'r', encoding='utf-8') as f:
                self.course_data = yaml.safe_load(f)
            
            self.lessons = self.course_data.get('lessons', [])
            self.update_lesson_list()
            
            # 最初のレッスンを選択
            if self.lessons:
                self.lesson_listbox.selection_set(0)
                self.on_lesson_select(None)
                
        except FileNotFoundError:
            messagebox.showwarning("警告", "course_4yo.yml が見つかりません。新規作成します。")
            self.course_data = {
                'metadata': {
                    'title': '4歳コース',
                    'version': '1.0.0'
                },
                'lessons': []
            }
            self.lessons = []
        except Exception as e:
            messagebox.showerror("エラー", f"コース読み込みエラー: {e}")
    
    def save_course(self):
        """コースファイルを保存"""
        try:
            # 現在編集中のレッスンを保存
            if self.current_lesson_index is not None:
                self.save_current_lesson()
            
            # course_dataを更新
            self.course_data['lessons'] = self.lessons
            
            # YAMLとして保存
            with open(self.course_path, 'w', encoding='utf-8') as f:
                yaml.dump(self.course_data, f, allow_unicode=True, default_flow_style=False, sort_keys=False)
            
            messagebox.showinfo("成功", "course_4yo.yml を保存しました")
        except Exception as e:
            messagebox.showerror("エラー", f"保存エラー: {e}")
    
    def save_as_course(self):
        """名前を付けて保存"""
        filename = filedialog.asksaveasfilename(
            defaultextension=".yml",
            filetypes=[("YAML files", "*.yml"), ("All files", "*.*")]
        )
        if filename:
            try:
                # 現在編集中のレッスンを保存
                if self.current_lesson_index is not None:
                    self.save_current_lesson()
                
                # course_dataを更新
                self.course_data['lessons'] = self.lessons
                
                # YAMLとして保存
                with open(filename, 'w', encoding='utf-8') as f:
                    yaml.dump(self.course_data, f, allow_unicode=True, default_flow_style=False, sort_keys=False)
                
                messagebox.showinfo("成功", f"{filename} に保存しました")
            except Exception as e:
                messagebox.showerror("エラー", f"保存エラー: {e}")
    
    def open_course(self):
        """コースファイルを開く"""
        filename = filedialog.askopenfilename(
            filetypes=[("YAML files", "*.yml"), ("All files", "*.*")]
        )
        if filename:
            try:
                with open(filename, 'r', encoding='utf-8') as f:
                    self.course_data = yaml.safe_load(f)
                
                self.lessons = self.course_data.get('lessons', [])
                self.update_lesson_list()
                
                if self.lessons:
                    self.lesson_listbox.selection_set(0)
                    self.on_lesson_select(None)
                    
                messagebox.showinfo("成功", f"{filename} を開きました")
            except Exception as e:
                messagebox.showerror("エラー", f"ファイル読み込みエラー: {e}")
    
    def update_lesson_list(self):
        """レッスンリストを更新"""
        self.lesson_listbox.delete(0, tk.END)
        for i, lesson in enumerate(self.lessons):
            day = lesson.get('day', i + 1)
            title = lesson.get('title', f'{day}日目レッスン')
            self.lesson_listbox.insert(tk.END, f"Day {day}: {title}")
    
    def on_lesson_select(self, event):
        """レッスンが選択された時"""
        selection = self.lesson_listbox.curselection()
        if not selection:
            return
        
        # 現在のレッスンを保存
        if self.current_lesson_index is not None:
            self.save_current_lesson()
        
        # 新しいレッスンを読み込み
        self.current_lesson_index = selection[0]
        self.load_lesson_to_ui(self.lessons[self.current_lesson_index])
    
    def load_lesson_to_ui(self, lesson):
        """レッスンデータをUIに読み込み"""
        # 基本情報
        self.title_var.set(lesson.get('title', ''))
        self.day_label.config(text=str(lesson.get('day', '')))
        
        # ちえ
        chie = lesson.get('chie', {})
        self.chie_range_var.set(chie.get('range', ''))
        self.chie_count_var.set(str(chie.get('questionCount', '')))
        
        # かず
        kazu = lesson.get('kazu', {})
        self.kazu_display_var.set(kazu.get('displayType', ''))
        self.on_kazu_display_change(None)  # 選択肢を更新
        self.kazu_range_var.set(kazu.get('range', ''))
        self.kazu_option_var.set(str(kazu.get('optionCount', '')))
        self.kazu_type_var.set(kazu.get('questionType', ''))
        self.kazu_count_var.set(str(kazu.get('questionCount', '')))
        
        # もじ
        moji = lesson.get('moji', {})
        self.moji_category_var.set(moji.get('category', ''))
        self.on_moji_category_change(None)  # 文字選択肢を更新
        
        # 文字選択
        selected_chars = moji.get('characters', [])
        for char, var in self.char_vars.items():
            var.set(char in selected_chars)
        
        # シーケンス
        sequence = moji.get('sequence', [])
        if sequence:
            self.sequence_var.set(f"{sequence[0]}-{sequence[1]}-{sequence[2]}")
    
    def save_current_lesson(self):
        """現在のレッスンを保存"""
        if self.current_lesson_index is None:
            return
        
        lesson = self.lessons[self.current_lesson_index]
        
        # 基本情報
        lesson['title'] = self.title_var.get()
        
        # ちえ
        lesson['chie'] = {
            'range': self.chie_range_var.get(),
            'questionCount': int(self.chie_count_var.get()) if self.chie_count_var.get() else 3,
            'shapes': ['circle']  # ランダム生成のため固定
        }
        
        # かず
        lesson['kazu'] = {
            'range': self.kazu_range_var.get(),
            'displayType': self.kazu_display_var.get(),
            'optionCount': int(self.kazu_option_var.get()) if self.kazu_option_var.get() else 2,
            'questionType': self.kazu_type_var.get(),
            'questionCount': int(self.kazu_count_var.get()) if self.kazu_count_var.get() else 3
        }
        
        # もじ
        selected_chars = [char for char, var in self.char_vars.items() if var.get()]
        sequence_str = self.sequence_var.get()
        sequence = [1, 1, 1]  # デフォルト
        if sequence_str:
            parts = sequence_str.split('-')
            if len(parts) == 3:
                sequence = [int(p) for p in parts]
        
        lesson['moji'] = {
            'category': self.moji_category_var.get(),
            'characters': selected_chars,
            'sequence': sequence
        }
    
    def add_lesson(self):
        """レッスンを追加"""
        day = len(self.lessons) + 1
        new_lesson = {
            'day': day,
            'title': f'{day}日目レッスン',
            'chie': {
                'range': '1-5',
                'questionCount': 3,
                'shapes': ['circle']
            },
            'kazu': {
                'range': '1-5',
                'displayType': 'dots',
                'optionCount': 2,
                'questionType': 'fixedLargest',
                'questionCount': 3
            },
            'moji': {
                'category': 'hiragana',
                'characters': ['あ'],
                'sequence': [1, 1, 1]
            }
        }
        
        self.lessons.append(new_lesson)
        self.update_lesson_list()
        
        # 新しいレッスンを選択
        self.lesson_listbox.selection_clear(0, tk.END)
        self.lesson_listbox.selection_set(len(self.lessons) - 1)
        self.on_lesson_select(None)
    
    def delete_lesson(self):
        """選択中のレッスンを削除"""
        selection = self.lesson_listbox.curselection()
        if not selection:
            return
        
        if messagebox.askyesno("確認", "選択したレッスンを削除しますか？"):
            index = selection[0]
            del self.lessons[index]
            
            # day番号を振り直し
            for i, lesson in enumerate(self.lessons):
                lesson['day'] = i + 1
            
            self.current_lesson_index = None
            self.update_lesson_list()
    
    def move_lesson_up(self):
        """レッスンを上に移動"""
        selection = self.lesson_listbox.curselection()
        if not selection or selection[0] == 0:
            return
        
        index = selection[0]
        self.lessons[index], self.lessons[index - 1] = self.lessons[index - 1], self.lessons[index]
        
        # day番号を振り直し
        for i, lesson in enumerate(self.lessons):
            lesson['day'] = i + 1
        
        self.update_lesson_list()
        self.lesson_listbox.selection_set(index - 1)
    
    def move_lesson_down(self):
        """レッスンを下に移動"""
        selection = self.lesson_listbox.curselection()
        if not selection or selection[0] >= len(self.lessons) - 1:
            return
        
        index = selection[0]
        self.lessons[index], self.lessons[index + 1] = self.lessons[index + 1], self.lessons[index]
        
        # day番号を振り直し
        for i, lesson in enumerate(self.lessons):
            lesson['day'] = i + 1
        
        self.update_lesson_list()
        self.lesson_listbox.selection_set(index + 1)
    
    def on_kazu_display_change(self, event):
        """かずの表示タイプが変更された時"""
        display_type = self.kazu_display_var.get()
        if not display_type or 'kazu' not in self.catalog:
            return
        
        options = self.catalog['kazu']['options']['displayType'].get(display_type, {})
        
        self.kazu_range_combo['values'] = options.get('range', [])
        self.kazu_option_combo['values'] = [str(x) for x in options.get('optionCount', [])]
        self.kazu_type_combo['values'] = options.get('questionType', [])
        self.kazu_count_combo['values'] = [str(x) for x in options.get('questionCount', [])]
    
    def on_moji_category_change(self, event):
        """もじのカテゴリが変更された時"""
        category = self.moji_category_var.get()
        if not category or 'moji' not in self.catalog:
            return
        
        options = self.catalog['moji']['options']['category'].get(category, {})
        
        # 文字チェックボックスを再作成
        for widget in self.char_checkboxes_frame.winfo_children():
            widget.destroy()
        
        self.char_vars = {}
        characters = options.get('characters', [])
        
        for i, char in enumerate(characters):
            var = tk.BooleanVar()
            self.char_vars[char] = var
            cb = ttk.Checkbutton(self.char_checkboxes_frame, text=char, variable=var)
            cb.grid(row=i // 10, column=i % 10, padx=2, pady=2, sticky=tk.W)
        
        # シーケンスラジオボタンを再作成
        for widget in self.sequence_frame.winfo_children():
            widget.destroy()
        
        sequences = options.get('sequence', [])
        for i, seq in enumerate(sequences):
            seq_str = f"{seq[0]}-{seq[1]}-{seq[2]}"
            rb = ttk.Radiobutton(
                self.sequence_frame, 
                text=f"{seq_str} (なぞり:{seq[0]}回, なぞり2:{seq[1]}回, 自由:{seq[2]}回)",
                variable=self.sequence_var,
                value=seq_str
            )
            rb.grid(row=i, column=0, padx=5, pady=2, sticky=tk.W)

def main():
    root = tk.Tk()
    app = LessonEditorApp(root)
    root.mainloop()

if __name__ == "__main__":
    main()