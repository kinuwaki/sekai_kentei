#!/usr/bin/env python3
"""
世界遺産検定4級 問題エディター (PyQt6版)

機能:
- CSVファイルを読み込み
- 問題を一覧表示・プレビュー
- Google Driveの画像URLをプレビュー
- 画像をローカルに保存
- JSONファイルにエクスポート
"""

import sys
import csv
import json
from pathlib import Path
import urllib.request
from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
    QSplitter, QListWidget, QLabel, QTextEdit, QLineEdit, QPushButton,
    QGroupBox, QFormLayout, QMessageBox, QScrollArea
)
from PyQt6.QtCore import Qt
from PyQt6.QtGui import QPixmap
from PIL import Image
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
        self.image_url = data.get('imageUrl', '')
        self.image_path = data.get('imagePath', '')

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


class QuizEditorWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.questions = []
        self.current_question_index = 0
        self.image_cache = {}

        self.init_ui()
        self.load_csv()

    def init_ui(self):
        """UI初期化"""
        self.setWindowTitle('世界遺産検定4級 問題エディター')
        self.setGeometry(100, 100, 1400, 900)

        # メインウィジェット
        main_widget = QWidget()
        main_widget.setStyleSheet("""
            QWidget {
                background-color: white;
                color: black;
            }
            QListWidget {
                background-color: white;
                color: black;
                border: 1px solid #ccc;
            }
            QListWidget::item:selected {
                background-color: #0078d7;
                color: white;
            }
            QTextEdit, QLineEdit {
                background-color: white;
                color: black;
                border: 1px solid #ccc;
                padding: 5px;
            }
            QPushButton {
                background-color: #0078d7;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
            }
            QPushButton:hover {
                background-color: #005a9e;
            }
            QLabel {
                color: black;
            }
        """)
        self.setCentralWidget(main_widget)
        main_layout = QHBoxLayout(main_widget)

        # スプリッター
        splitter = QSplitter(Qt.Orientation.Horizontal)
        main_layout.addWidget(splitter)

        # 左パネル: 問題一覧
        left_widget = self.create_left_panel()
        splitter.addWidget(left_widget)

        # 右パネル: 問題詳細
        right_widget = self.create_right_panel()
        splitter.addWidget(right_widget)

        splitter.setStretchFactor(0, 1)
        splitter.setStretchFactor(1, 3)

    def create_left_panel(self):
        """左パネル作成"""
        widget = QWidget()
        layout = QVBoxLayout(widget)

        # タイトル
        title = QLabel('問題一覧')
        title.setStyleSheet('font-size: 16px; font-weight: bold;')
        layout.addWidget(title)

        # 問題リスト
        self.question_list = QListWidget()
        self.question_list.currentRowChanged.connect(self.on_question_select)
        layout.addWidget(self.question_list)

        return widget

    def create_right_panel(self):
        """右パネル作成"""
        widget = QWidget()
        layout = QVBoxLayout(widget)

        # スクロールエリア
        scroll = QScrollArea()
        scroll.setWidgetResizable(True)
        scroll_content = QWidget()
        scroll_layout = QVBoxLayout(scroll_content)

        # 問題詳細グループ
        detail_group = QGroupBox('問題詳細')
        detail_layout = QFormLayout()

        # ID
        self.id_label = QLabel()
        self.id_label.setStyleSheet('font-weight: bold;')
        detail_layout.addRow('ID:', self.id_label)

        # テーマ
        self.theme_label = QLabel()
        detail_layout.addRow('テーマ:', self.theme_label)

        # 問題文
        self.question_text = QTextEdit()
        self.question_text.setMaximumHeight(120)
        self.question_text.setStyleSheet('font-size: 14px; font-weight: bold;')
        detail_layout.addRow('問題文:', self.question_text)

        # 画像プレビュー（問題文の直後）
        self.image_label = QLabel('画像プレビュー')
        self.image_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        self.image_label.setMinimumHeight(250)
        self.image_label.setMaximumHeight(400)
        self.image_label.setStyleSheet('border: 2px solid #ccc; background: #f5f5f5; margin: 10px 0;')
        detail_layout.addRow('', self.image_label)

        # 選択肢（ボタン風に表示）
        choices_label = QLabel('回答候補:')
        choices_label.setStyleSheet('font-weight: bold; margin-top: 10px;')
        detail_layout.addRow(choices_label)

        self.choice1_edit = QLineEdit()
        self.choice1_edit.setStyleSheet('background-color: #e3f2fd; padding: 10px; font-size: 13px;')
        detail_layout.addRow('①', self.choice1_edit)

        self.choice2_edit = QLineEdit()
        self.choice2_edit.setStyleSheet('background-color: #e3f2fd; padding: 10px; font-size: 13px;')
        detail_layout.addRow('②', self.choice2_edit)

        self.choice3_edit = QLineEdit()
        self.choice3_edit.setStyleSheet('background-color: #e3f2fd; padding: 10px; font-size: 13px;')
        detail_layout.addRow('③', self.choice3_edit)

        self.correct_edit = QLineEdit()
        self.correct_edit.setStyleSheet('background-color: #c8e6c9; padding: 10px; font-size: 13px; font-weight: bold;')
        detail_layout.addRow('✓ 正解:', self.correct_edit)

        # 解説
        self.explanation_text = QTextEdit()
        self.explanation_text.setMaximumHeight(100)
        detail_layout.addRow('解説:', self.explanation_text)

        # 画像URL
        self.image_url_edit = QLineEdit()
        detail_layout.addRow('画像URL:', self.image_url_edit)

        # 画像操作ボタン
        btn_layout = QHBoxLayout()
        preview_btn = QPushButton('画像プレビュー')
        preview_btn.clicked.connect(self.preview_image)
        btn_layout.addWidget(preview_btn)

        download_btn = QPushButton('画像をダウンロード')
        download_btn.clicked.connect(self.download_image)
        btn_layout.addWidget(download_btn)

        btn_layout.addStretch()
        detail_layout.addRow('', btn_layout)

        # ローカル画像パス
        self.image_path_label = QLabel('未設定')
        self.image_path_label.setStyleSheet('color: gray;')
        detail_layout.addRow('ローカル画像:', self.image_path_label)

        detail_group.setLayout(detail_layout)
        scroll_layout.addWidget(detail_group)

        scroll.setWidget(scroll_content)
        layout.addWidget(scroll)

        # ボトムボタン
        bottom_layout = QHBoxLayout()
        bottom_layout.addStretch()

        reload_btn = QPushButton('CSVをリロード')
        reload_btn.clicked.connect(self.load_csv)
        bottom_layout.addWidget(reload_btn)

        export_btn = QPushButton('JSONにエクスポート')
        export_btn.clicked.connect(self.export_json)
        bottom_layout.addWidget(export_btn)

        layout.addLayout(bottom_layout)

        return widget

    def load_csv(self):
        """CSVファイルを読み込む"""
        try:
            if not CSV_PATH.exists():
                QMessageBox.critical(self, 'エラー', f'CSVファイルが見つかりません:\n{CSV_PATH}')
                return

            self.questions = []
            with open(CSV_PATH, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                for row in reader:
                    self.questions.append(QuizQuestion(row))

            self.update_question_list()
            QMessageBox.information(self, '成功', f'{len(self.questions)}問の問題を読み込みました')

        except Exception as e:
            import traceback
            error_detail = traceback.format_exc()
            QMessageBox.critical(self, 'エラー', f'CSVの読み込みに失敗しました:\n{e}\n\n{error_detail}')

    def update_question_list(self):
        """問題一覧を更新"""
        self.question_list.clear()
        for q in self.questions:
            display_text = f'{q.id}: {q.question[:40]}...'
            self.question_list.addItem(display_text)

        if self.questions:
            self.question_list.setCurrentRow(0)

    def on_question_select(self, index):
        """問題選択時のイベント"""
        if index < 0 or index >= len(self.questions):
            return

        self.current_question_index = index
        q = self.questions[index]

        self.id_label.setText(q.id)
        self.theme_label.setText(q.theme)
        self.question_text.setPlainText(q.question)
        self.choice1_edit.setText(q.choice1)
        self.choice2_edit.setText(q.choice2)
        self.choice3_edit.setText(q.choice3)
        self.correct_edit.setText(q.correct_answer)
        self.explanation_text.setPlainText(q.explanation)
        self.image_url_edit.setText(q.image_url)

        if q.image_path:
            self.image_path_label.setText(q.image_path)
            self.image_path_label.setStyleSheet('color: green;')
        else:
            self.image_path_label.setText('未設定')
            self.image_path_label.setStyleSheet('color: gray;')

        # 画像プレビューをクリア
        self.image_label.clear()
        self.image_label.setText('画像プレビュー')

    def preview_image(self):
        """Google Drive画像をプレビュー"""
        url = self.image_url_edit.text().strip()
        if not url:
            QMessageBox.warning(self, '警告', '画像URLを入力してください')
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

            # 一時ファイルに保存してQPixmapで読み込み
            temp_path = Path('/tmp/preview_image.jpg')
            image.save(temp_path, 'JPEG')

            pixmap = QPixmap(str(temp_path))
            self.image_label.setPixmap(pixmap)

            # キャッシュに保存
            self.image_cache[self.current_question_index] = image_data

        except Exception as e:
            QMessageBox.critical(self, 'エラー', f'画像の読み込みに失敗しました:\n{e}')

    def download_image(self):
        """画像をローカルに保存"""
        url = self.image_url_edit.text().strip()
        if not url:
            QMessageBox.warning(self, '警告', '画像URLを入力してください')
            return

        q = self.questions[self.current_question_index]

        try:
            # 画像データを取得
            if self.current_question_index in self.image_cache:
                image_data = self.image_cache[self.current_question_index]
            else:
                direct_url = self.convert_gdrive_url(url)
                with urllib.request.urlopen(direct_url) as response:
                    image_data = response.read()

            # 保存先ファイル名
            image_filename = f'{q.id}.jpg'
            image_path = IMAGE_DIR / image_filename

            # 画像を保存
            IMAGE_DIR.mkdir(parents=True, exist_ok=True)
            with open(image_path, 'wb') as f:
                f.write(image_data)

            # 問題データを更新
            q.image_path = f'assets/images/quiz/{image_filename}'
            self.image_path_label.setText(q.image_path)
            self.image_path_label.setStyleSheet('color: green;')

            QMessageBox.information(self, '成功', f'画像を保存しました:\n{image_path}')

        except Exception as e:
            QMessageBox.critical(self, 'エラー', f'画像の保存に失敗しました:\n{e}')

    def convert_gdrive_url(self, url):
        """Google DriveのURLをダイレクトダウンロードURLに変換"""
        if 'drive.google.com' in url:
            if '/file/d/' in url:
                file_id = url.split('/file/d/')[1].split('/')[0]
                return f'https://drive.google.com/uc?export=download&id={file_id}'
        return url

    def export_json(self):
        """JSONファイルにエクスポート"""
        try:
            # JSON形式に変換
            json_data = {
                'version': '1.0',
                'totalQuestions': len(self.questions),
                'questions': [q.to_dict() for q in self.questions]
            }

            # JSONファイルに保存
            JSON_OUTPUT_PATH.parent.mkdir(parents=True, exist_ok=True)
            with open(JSON_OUTPUT_PATH, 'w', encoding='utf-8') as f:
                json.dump(json_data, f, ensure_ascii=False, indent=2)

            QMessageBox.information(self, '成功', f'JSONファイルを保存しました:\n{JSON_OUTPUT_PATH}')

        except Exception as e:
            QMessageBox.critical(self, 'エラー', f'JSONの保存に失敗しました:\n{e}')


def main():
    app = QApplication(sys.argv)
    window = QuizEditorWindow()
    window.show()
    sys.exit(app.exec())


if __name__ == '__main__':
    main()
