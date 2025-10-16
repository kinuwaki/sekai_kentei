#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Lesson Editor
Modern PyQt6-based lesson configuration editor with dark theme,
drag-and-drop, search, and improved UX.
"""

import sys
import json
import yaml
from pathlib import Path
from typing import Dict, List, Any, Optional, Tuple
from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout, 
    QLabel, QSpinBox, QComboBox, QPushButton, QGroupBox, QSplitter, 
    QLineEdit, QMessageBox, QFileDialog, QTabWidget, QCheckBox, 
    QListWidget, QListWidgetItem, QScrollArea, QGridLayout, QSlider,
    QFormLayout, QToolBar, QStatusBar, QMenuBar, QMenu, QTextEdit,
    QDialog, QDialogButtonBox, QFrame, QSizePolicy, QSpacerItem
)
from PyQt6.QtCore import (
    Qt, QTimer, QSettings, pyqtSignal, QObject, QSize, QPropertyAnimation,
    QEasingCurve, QAbstractListModel, QModelIndex, QMimeData, QSignalBlocker
)
from PyQt6.QtGui import (
    QFont, QAction, QIcon, QPixmap, QPainter, QColor, QPalette,
    QKeySequence, QCursor, QStandardItemModel
)

# ===== テーマ管理 =====
class ThemeManager:
    """テーマ管理システム"""
    
    LIGHT_THEME = {
        "background": "#ffffff",
        "surface": "#f5f5f5", 
        "primary": "#2196f3",
        "secondary": "#03dac6",
        "text": "#212121",
        "text_secondary": "#757575",
        "border": "#e0e0e0",
        "success": "#4caf50",
        "warning": "#ff9800", 
        "error": "#f44336",
        "hover": "#e3f2fd"
    }
    
    DARK_THEME = {
        "background": "#121212",
        "surface": "#1e1e1e",
        "primary": "#bb86fc", 
        "secondary": "#03dac6",
        "text": "#ffffff",
        "text_secondary": "#b0b0b0",
        "border": "#333333",
        "success": "#4caf50",
        "warning": "#ff9800",
        "error": "#cf6679",
        "hover": "#2d2d30"
    }
    
    def __init__(self):
        self.current_theme = "dark"
        self.themes = {
            "dark": self.DARK_THEME
        }
        
    def get_color(self, key: str) -> str:
        return self.themes[self.current_theme].get(key, "#000000")
        
    def set_theme(self, theme_name: str):
        if theme_name in self.themes:
            self.current_theme = theme_name
            
    def get_stylesheet(self) -> str:
        """アプリケーション全体のスタイルシートを生成"""
        theme = self.themes[self.current_theme]
        
        return f"""
        QMainWindow {{
            background-color: {theme['background']};
            color: {theme['text']};
        }}
        
        QWidget {{
            background-color: {theme['background']};
            color: {theme['text']};
        }}
        
        QGroupBox {{
            font-weight: bold;
            border: 2px solid {theme['border']};
            border-radius: 8px;
            margin-top: 1ex;
            padding-top: 10px;
            background-color: {theme['surface']};
        }}
        
        QGroupBox::title {{
            subcontrol-origin: margin;
            left: 10px;
            padding: 0 5px 0 5px;
            color: {theme['primary']};
        }}
        
        QPushButton {{
            background-color: {theme['primary']};
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            font-weight: bold;
        }}
        
        QPushButton:hover {{
            background-color: {theme['secondary']};
        }}
        
        QPushButton:pressed {{
            background-color: {theme['border']};
        }}
        
        QListWidget {{
            background-color: {theme['surface']};
            border: 1px solid {theme['border']};
            border-radius: 4px;
            padding: 4px;
        }}
        
        QListWidget::item {{
            padding: 8px;
            border-bottom: 1px solid {theme['border']};
            border-radius: 4px;
            margin: 2px;
        }}
        
        QListWidget::item:selected {{
            background-color: {theme['primary']};
            color: white;
        }}
        
        QListWidget::item:hover {{
            background-color: {theme['hover']};
        }}
        
        QTabWidget::pane {{
            border: 1px solid {theme['border']};
            background-color: {theme['surface']};
        }}
        
        QTabBar::tab {{
            background-color: {theme['background']};
            color: {theme['text']};
            padding: 12px 20px;
            margin-right: 2px;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }}
        
        QTabBar::tab:selected {{
            background-color: {theme['primary']};
            color: white;
        }}
        
        QTabBar::tab:hover {{
            background-color: {theme['hover']};
        }}
        
        QLineEdit, QSpinBox, QComboBox {{
            background-color: {theme['surface']};
            border: 2px solid {theme['border']};
            border-radius: 4px;
            padding: 6px;
            color: {theme['text']};
        }}
        
        QLineEdit:focus, QSpinBox:focus, QComboBox:focus {{
            border-color: {theme['primary']};
        }}
        
        QScrollArea {{
            background-color: {theme['background']};
            border: none;
        }}
        
        QToolBar {{
            background-color: {theme['surface']};
            border-bottom: 1px solid {theme['border']};
            spacing: 4px;
            padding: 4px;
        }}
        
        QStatusBar {{
            background-color: {theme['surface']};
            border-top: 1px solid {theme['border']};
            color: {theme['text_secondary']};
        }}
        """

# ===== アイコン管理 =====
class IconManager:
    """アイコン管理システム"""
    
    def __init__(self):
        self.icons = {}
        self.create_text_icons()
        
    def create_text_icons(self):
        """テキストベースのアイコンを作成"""
        icons_map = {
            "new": "📄",
            "open": "📂", 
            "save": "💾",
            "undo": "↩️",
            "redo": "↪️",
            "search": "🔍",
            "dark_mode": "🌙",
            "light_mode": "☀️",
            "settings": "⚙️",
            "add": "➕",
            "remove": "🗑️",
            "copy": "📋",
            "duplicate": "📄",
            "help": "ℹ️",
            "preview": "👁️",
            "brain": "🧠",
            "numbers": "🔢", 
            "writing": "✍️",
            "game": "🎮",
            "warning": "⚠️",
            "success": "✅",
            "error": "❌"
        }
        
        for key, emoji in icons_map.items():
            self.icons[key] = self.create_emoji_icon(emoji)
            
    def create_emoji_icon(self, emoji: str, size: int = 16) -> QIcon:
        """絵文字からQIconを作成"""
        pixmap = QPixmap(size, size)
        pixmap.fill(Qt.GlobalColor.transparent)
        
        painter = QPainter(pixmap)
        font = QFont()
        font.setPointSize(size - 4)
        painter.setFont(font)
        painter.drawText(0, 0, size, size, Qt.AlignmentFlag.AlignCenter, emoji)
        painter.end()
        
        return QIcon(pixmap)
        
    def get_icon(self, name: str) -> QIcon:
        return self.icons.get(name, QIcon())

# ===== データモデル =====
class LessonModel(QObject):
    """レッスンデータ管理"""
    
    dataChanged = pyqtSignal()
    lessonAdded = pyqtSignal(int)
    lessonRemoved = pyqtSignal(int)
    lessonMoved = pyqtSignal(int, int)
    
    def __init__(self):
        super().__init__()
        self.catalog = {}
        self.course_data = {"lessons": []}
        self.current_file = None
        self._lessons = self.course_data.get("lessons", [])
        
    def load_catalog(self, catalog_path: Path) -> bool:
        """カタログファイルを読み込み"""
        try:
            if catalog_path.exists():
                with open(catalog_path, 'r', encoding='utf-8') as f:
                    self.catalog = json.load(f)
                return True
        except Exception as e:
            print(f"カタログ読み込みエラー: {e}")
        return False
        
    def load_course(self, file_path: str) -> bool:
        """コースファイルを読み込み"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                self.course_data = yaml.safe_load(f) or {"lessons": []}

            # 読み込み時に通し番号が不足していれば自動追加
            self._add_lesson_numbers()

            self.current_file = file_path
            self.dataChanged.emit()
            print(f"[LOAD] 完了: {file_path} ({len(self.get_lessons())}レッスン)")
            return True
        except Exception as e:
            print(f"コースファイル読み込みエラー: {e}")
        return False
        
    def save_course(self, file_path: str = None) -> bool:
        """コースファイルを保存"""
        save_path = file_path or self.current_file
        if not save_path:
            return False

        try:
            # 保存前に通し番号を自動追加
            self._add_lesson_numbers()

            print(f"[SAVE] 保存データ: {self.course_data}")

            with open(save_path, 'w', encoding='utf-8') as f:
                yaml.safe_dump(self.course_data, f, default_flow_style=False,
                              allow_unicode=True, sort_keys=False)
            self.current_file = save_path
            print(f"[SAVE] 完了: {save_path}")
            return True
        except Exception as e:
            print(f"コースファイル保存エラー: {e}")
        return False
        
    def get_lessons(self) -> List[Dict]:
        return self.course_data.get("lessons", [])
        
    def get_lesson(self, index: int) -> Dict:
        lessons = self.get_lessons()
        if 0 <= index < len(lessons):
            return lessons[index]
        return {}
        
    def add_lesson(self) -> int:
        lessons = self.get_lessons()
        new_lesson = {}
        lessons.append(new_lesson)
        self.lessonAdded.emit(len(lessons) - 1)
        self.dataChanged.emit()
        return len(lessons) - 1
        
    def remove_lesson(self, index: int) -> bool:
        lessons = self.get_lessons()
        if 0 <= index < len(lessons):
            lessons.pop(index)
            self.lessonRemoved.emit(index)
            self.dataChanged.emit()
            return True
        return False

    def move_lesson(self, from_index: int, to_index: int) -> bool:
        """レッスンの順序を変更"""
        lessons = self.get_lessons()
        if 0 <= from_index < len(lessons) and 0 <= to_index < len(lessons):
            lesson = lessons.pop(from_index)
            lessons.insert(to_index, lesson)
            self.lessonMoved.emit(from_index, to_index)
            self.dataChanged.emit()
            return True
        return False
        
    def duplicate_lesson(self, index: int) -> int:
        lessons = self.get_lessons()
        if 0 <= index < len(lessons):
            lesson_copy = lessons[index].copy()
            lessons.append(lesson_copy)
            new_index = len(lessons) - 1
            self.lessonAdded.emit(new_index)
            self.dataChanged.emit()
            return new_index
        return -1
        
    def update_lesson_game(self, lesson_index: int, game_key: str, config: Dict):
        """レッスンのゲーム設定を更新"""
        lessons = self.get_lessons()
        if 0 <= lesson_index < len(lessons):
            if config:
                lessons[lesson_index][game_key] = config
                print(f"[MODEL] レッスン{lesson_index+1}更新: {lessons[lesson_index]}")
            else:
                lessons[lesson_index].pop(game_key, None)
            self.dataChanged.emit()
        else:
            print(f"[ERROR] 無効なインデックス: {lesson_index} (最大: {len(lessons)-1})")

    def update_lesson_game_if_changed(self, row: int, category_key: str, config: Dict) -> bool:
        """差分がある時だけレッスンのゲーム設定を更新"""
        key = f"{category_key}_game"
        lessons = self.get_lessons()
        if 0 <= row < len(lessons):
            prev = lessons[row].get(key)
            if prev == config:
                return False
            lessons[row][key] = config
            self.dataChanged.emit()
            return True
        return False

    def _add_lesson_numbers(self):
        """レッスンに通し番号を自動追加"""
        lessons = self.get_lessons()
        for i, lesson in enumerate(lessons, 1):
            # indexを最初に配置するため、一旦既存のデータを保存
            old_data = dict(lesson)
            lesson.clear()
            lesson['index'] = i
            # 残りのデータを復元
            for key, value in old_data.items():
                if key != 'index':
                    lesson[key] = value
            print(f"[AUTO_NUMBER] レッスン{i}: index={i}")

# ===== ゲーム設定ウィジェット基底クラス =====
class GameConfigWidget(QGroupBox):
    """ゲーム設定の基底クラス"""
    
    configChanged = pyqtSignal(dict)
    validationChanged = pyqtSignal(bool, str)
    
    def __init__(self, game_type: str, game_info: Dict, theme_manager: ThemeManager):
        super().__init__()
        self.game_type = game_type
        self.game_info = game_info
        self.theme_manager = theme_manager
        self.is_enabled = False
        
        self.setTitle(game_info.get('displayName', game_type))
        self.setCheckable(True)
        self.setChecked(False)
        
        self.init_ui()
        self.toggled.connect(self.on_enabled_changed)
        
    def init_ui(self):
        """UI初期化（サブクラスでオーバーライド）"""
        layout = QVBoxLayout(self)
        
        
        # 設定エリア
        self.config_area = QWidget()
        self.init_config_ui(self.config_area)
        layout.addWidget(self.config_area)
        
        # エラー表示
        self.error_label = QLabel()
        self.error_label.setStyleSheet("color: red; font-weight: bold;")
        self.error_label.hide()
        layout.addWidget(self.error_label)
        
        self.config_area.setEnabled(False)
        
    def init_config_ui(self, parent: QWidget):
        """設定UIの初期化（サブクラスで実装）"""
        layout = QVBoxLayout(parent)
        info_label = QLabel(f"{self.game_type} の設定はまだ実装されていません")
        info_label.setStyleSheet("color: #ff9800; font-style: italic;")
        layout.addWidget(info_label)
        
    def get_config(self) -> Dict:
        """現在の設定を取得（サブクラスで実装）"""
        if not self.is_enabled:
            return {}
        return {"type": self.game_type}
        
    def set_config(self, config: Dict):
        """設定をUIに反映（サブクラスで実装）"""
        pass
        
    def validate(self) -> Tuple[bool, str]:
        """設定を検証（サブクラスでオーバーライド可能）"""
        return True, ""
        
        
    def on_enabled_changed(self, enabled: bool):
        """有効/無効状態変更時"""
        self.is_enabled = enabled
        self.config_area.setEnabled(enabled)

        if enabled:
            config = self.get_config()
            print(f"[ENABLE] {self.__class__.__name__}: {config}")
            self.configChanged.emit(config)

            # 100ms後にも送信（確実性のため）
            QTimer.singleShot(100, lambda: self.configChanged.emit(self.get_config()) if self.is_enabled else None)
        else:
            self.configChanged.emit({})
            
        # バリデーション実行
        if enabled:
            is_valid, error_msg = self.validate()
            if not is_valid:
                self.error_label.setText(f"⚠️ {error_msg}")
                self.error_label.show()
            else:
                self.error_label.hide()
            self.validationChanged.emit(is_valid, error_msg)
        else:
            self.error_label.hide()
            self.validationChanged.emit(True, "")

# ===== 動的ゲーム設定ウィジェット =====
class DynamicGameConfigWidget(GameConfigWidget):
    """カタログから完全動的にUI構築する汎用ウィジェット"""

    def __init__(self, game_type: str, game_info: Dict, theme_manager: ThemeManager):
        # ↓ 先に用意しておく（ベース __init__ の init_ui から参照される）
        self.option_widgets = {}
        self._last_emitted = None

        super().__init__(game_type, game_info, theme_manager)

    def init_config_ui(self, parent: QWidget):
        """カタログ options から完全自動でUI構築"""
        options = self.game_info.get('options', {})

        # writing.v1 の特殊ケース: 複雑なレイアウト
        if self.game_type == "writing.v1":
            self.create_writing_ui(parent, options)
        else:
            # 通常ケース: FormLayout で自動構築
            self.create_standard_ui(parent, options)

    def create_standard_ui(self, parent: QWidget, options: Dict):
        """標準的なFormLayoutでUI構築"""
        layout = QFormLayout(parent)

        for option_key, option_data in options.items():
            if option_key == 'defaultConfig':
                continue  # defaultConfig はスキップ

            widget = self.create_widget_from_data(option_key, option_data)
            if widget:
                label = self.get_display_label(option_key)
                layout.addRow(label, widget)
                self.option_widgets[option_key] = widget
                self.connect_widget_signals(widget)

        # comparison.v1 の特殊処理: displayType変更時の連動更新
        if self.game_type == "comparison.v1" and 'displayType' in self.option_widgets:
            display_type_widget = self.option_widgets['displayType']
            display_type_widget.currentTextChanged.connect(self.update_comparison_options)

    def create_writing_ui(self, parent: QWidget, options: Dict):
        """writing.v1 専用の複雑なレイアウト"""
        layout = QVBoxLayout(parent)

        # 文字チェックボックス辞書を初期化
        self.char_checkboxes = {}

        # カテゴリー選択
        cat_layout = QFormLayout()
        self.category_combo = QComboBox()
        categories = options.get('categoryId', [])
        if isinstance(categories, list):
            for cat_id in categories:
                display_name = {'hiragana': 'ひらがな', 'katakana': 'カタカナ', 'kanji': '漢字'}.get(cat_id, cat_id)
                self.category_combo.addItem(display_name, cat_id)
        cat_layout.addRow("文字種類:", self.category_combo)
        layout.addLayout(cat_layout)

        # 文字選択エリア
        chars_group = QGroupBox("文字選択")
        chars_layout = QVBoxLayout(chars_group)

        self.chars_scroll = QScrollArea()
        self.chars_widget = QWidget()
        self.chars_grid = QGridLayout(self.chars_widget)
        self.chars_scroll.setWidget(self.chars_widget)
        self.chars_scroll.setMaximumHeight(200)
        self.chars_scroll.setWidgetResizable(True)

        chars_layout.addWidget(self.chars_scroll)
        layout.addWidget(chars_group)

        # シーケンス選択
        seq_layout = QFormLayout()
        self.sequence_combo = QComboBox()
        sequence_patterns = options.get('sequence', [])
        for i, pattern in enumerate(sequence_patterns):
            if isinstance(pattern, list):
                pattern_str = ', '.join(pattern)
                self.sequence_combo.addItem(f"パターン{i+1}: [{pattern_str}]", pattern)
        seq_layout.addRow("学習パターン:", self.sequence_combo)
        layout.addLayout(seq_layout)

        # ウィジェット辞書に登録
        self.option_widgets['categoryId'] = self.category_combo
        self.option_widgets['sequence'] = self.sequence_combo

        # 初期文字選択を設定
        self.update_character_options()

        # シグナル接続
        self.category_combo.currentTextChanged.connect(self.update_character_options)
        self.category_combo.currentTextChanged.connect(self.on_config_changed)
        self.sequence_combo.currentTextChanged.connect(self.on_config_changed)

    def create_widget_from_data(self, key: str, data):
        """データ型とキー名から適切なウィジェットを自動生成"""

        if isinstance(data, list) and len(data) > 0:
            # comparison.v1のdisplayTypeの特殊処理
            if key == 'displayType' and self.game_type == "comparison.v1":
                return self.create_display_type_widget(data)
            return self.create_list_widget(key, data)
        elif isinstance(data, dict):
            return self.create_dict_widget(key, data)
        elif isinstance(data, (int, float)):
            return self.create_number_widget(key, data)
        elif isinstance(data, str):
            return self.create_string_widget(key, data)

        return None

    def create_list_widget(self, key: str, data: list):
        """リストデータからコンボボックスを生成"""
        combo = QComboBox()

        for i, item in enumerate(data):
            if isinstance(item, str):
                combo.addItem(item, item)
            elif isinstance(item, (int, float)):
                combo.addItem(str(item), item)
            elif isinstance(item, list):
                display = self.format_list_display(key, item, i)
                combo.addItem(display, item)

        return combo

    def create_dict_widget(self, key: str, data: dict):
        """辞書データからコンボボックスを生成（comparison.v1のdisplayType用）"""
        combo = QComboBox()

        for dt_key, dt_info in data.items():
            if isinstance(dt_info, dict):
                display_name = dt_info.get('displayName', dt_key)
                combo.addItem(display_name, dt_key)
            else:
                combo.addItem(str(dt_key), dt_key)

        return combo

    def create_number_widget(self, key: str, data):
        """数値データからスピンボックスを生成"""
        spin = QSpinBox()
        spin.setValue(data)
        return spin

    def create_string_widget(self, key: str, data: str):
        """文字列データからラインエディットを生成"""
        line_edit = QLineEdit()
        line_edit.setText(data)
        return line_edit

    def create_display_type_widget(self, data: list):
        """comparison.v1のdisplayType専用ウィジェット（リスト→正規化辞書）"""
        combo = QComboBox()

        # リストを辞書に正規化
        for item in data:
            if isinstance(item, str):
                # 文字列だけならキー=表示名
                combo.addItem(item, item)
            elif isinstance(item, dict):
                # 辞書の場合はdisplayNameを使用
                key = item.get('key', item.get('name', 'unknown'))
                display_name = item.get('displayName', key)
                combo.addItem(display_name, key)

        return combo

    def format_list_display(self, key: str, item: list, index: int) -> str:
        """リスト項目の表示フォーマット"""
        if key == 'sequence':
            pattern_str = ', '.join(item)
            return f"パターン{index+1}: [{pattern_str}]"
        elif key == 'targetNumbers':
            if len(item) == 1:
                return f"数字: {item[0]}"
            else:
                range_str = '-'.join(map(str, item))
                return f"数字セット{index+1}: {range_str}"
        elif key == 'figures':
            return f"図形セット{index+1} ({len(item)}種類)"
        elif key == 'shapes':
            return f"形セット{index+1} ({len(item)}種類)"
        elif key == 'objects':
            return f"オブジェクトセット{index+1} ({len(item)}種類)"
        else:
            return f"選択肢{index+1}: {item}"

    def get_display_label(self, option_key: str) -> str:
        """現在のUIと同じラベルを使用"""
        labels = {
            'range': '範囲',
            'displayType': '表示タイプ',
            'categoryId': '文字種類',
            'characterId': '文字選択',
            'sequence': '学習パターン',
            'mode': 'モード',
            'targetNumbers': '対象数字',
            'repetitions': '繰り返し',
            'difficulty': '難易度',
            'figures': '図形',
            'shapes': '形',
            'objects': 'オブジェクト',
            'category': 'カテゴリ',
            'targetType': '対象タイプ',
            'comparisonChoice': '比較選択',
            'optionCount': '選択肢数',
            'questionType': '問題タイプ'
        }
        return labels.get(option_key, option_key)

    def connect_widget_signals(self, widget):
        """ウィジェットのシグナルを接続"""
        if isinstance(widget, QComboBox):
            widget.currentTextChanged.connect(self.on_config_changed)
        elif isinstance(widget, QSpinBox):
            widget.valueChanged.connect(self.on_config_changed)
        elif isinstance(widget, QLineEdit):
            widget.textChanged.connect(self.on_config_changed)

    def on_config_changed(self, *args):
        """各入力の変更時に呼ばれる共通ハンドラ"""
        # バリデーションとエラーメッセージ
        is_valid, error_msg = self.validate()
        if not is_valid:
            self.error_label.setText(f"⚠️ {error_msg}")
            self.error_label.show()
        else:
            self.error_label.hide()

        # 前回と差分があるときだけ configChanged を飛ばす
        self.emit_if_changed()

    def update_character_options(self):
        """writing.v1 専用: カテゴリーに応じて文字選択を更新"""
        if self.game_type != "writing.v1":
            return

        # 既存のチェックボックスをクリア
        for cb in getattr(self, 'char_checkboxes', {}).values():
            cb.setParent(None)
        self.char_checkboxes = {}

        category_key = self.category_combo.currentData()
        if not category_key:
            return

        options = self.game_info.get('options', {})
        # カタログからすべての文字を取得（ひらがなのみ実装）
        if category_key == 'hiragana':
            characters = options.get('characterId', [])
        else:
            characters = []  # カタカナ・漢字は未実装

        default_chars = options.get('defaultConfig', {}).get('characterId', [])
        if isinstance(default_chars, str):
            default_chars = [default_chars]

        row, col = 0, 0
        for char in characters:
            cb = QCheckBox(char)
            if char in default_chars:
                cb.setChecked(True)
            cb.toggled.connect(self.on_config_changed)
            self.char_checkboxes[char] = cb
            self.chars_grid.addWidget(cb, row, col)
            col += 1
            if col >= 8:
                col = 0
                row += 1

    def update_comparison_options(self):
        """comparison.v1 専用: displayType変更時の連動更新"""
        if self.game_type != "comparison.v1":
            return

        # displayTypeがlistの場合の正規化処理は既に create_dict_widget で処理済み
        # 実際のカタログではdisplayTypeはlistなので、特別な連動処理は不要
        pass

    def current_config(self) -> Dict:
        """現在の設定を取得"""
        config = {"type": self.game_type}

        # writing.v1 の特殊処理
        if self.game_type == "writing.v1":
            selected_chars = [char for char, cb in getattr(self, 'char_checkboxes', {}).items() if cb.isChecked()]
            config['categoryId'] = self.category_combo.currentData()
            config['characterId'] = selected_chars[0] if selected_chars else None
            config['sequence'] = self.sequence_combo.currentData()
            return config

        # 通常のオプション収集
        for option_key, widget in self.option_widgets.items():
            if isinstance(widget, QComboBox):
                config[option_key] = widget.currentData() or widget.currentText()
            elif isinstance(widget, QSpinBox):
                config[option_key] = widget.value()
            elif isinstance(widget, QLineEdit):
                config[option_key] = widget.text()

        return config

    def get_config(self) -> Dict:
        if not self.is_enabled:
            return {}
        return self.current_config()

    def set_config(self, config: Dict):
        """設定をUIに反映（汎用版）"""
        if not config:
            return

        print(f"[DYNAMIC_SET_CONFIG] {self.game_type}: {config}")

        # writing.v1 の特殊処理
        if self.game_type == "writing.v1":
            # カテゴリ設定
            category = config.get('categoryId', 'hiragana')
            if hasattr(self, 'category_combo'):
                for i in range(self.category_combo.count()):
                    if self.category_combo.itemData(i) == category:
                        self.category_combo.setCurrentIndex(i)
                        break

                # 文字選択UIを更新
                self.update_character_options()

                # 文字設定（1文字のみ）
                char_id = config.get('characterId')
                if char_id and hasattr(self, 'char_checkboxes') and char_id in self.char_checkboxes:
                    # 全てのチェックを外してから、指定文字のみチェック
                    for cb in self.char_checkboxes.values():
                        cb.setChecked(False)
                    self.char_checkboxes[char_id].setChecked(True)

                # シーケンス設定
                sequence = config.get('sequence', ['tracing'])
                if hasattr(self, 'sequence_combo'):
                    for i in range(self.sequence_combo.count()):
                        if self.sequence_combo.itemData(i) == sequence:
                            self.sequence_combo.setCurrentIndex(i)
                            break
            return

        # 通常のオプション設定
        for option_key, value in config.items():
            if option_key == 'type':  # type は除外
                continue

            if option_key in self.option_widgets:
                widget = self.option_widgets[option_key]
                print(f"[DYNAMIC_SET_CONFIG] 設定中: {option_key} = {value}")

                if isinstance(widget, QComboBox):
                    # データ値で検索してみる
                    found = False
                    for i in range(widget.count()):
                        if widget.itemData(i) == value:
                            widget.setCurrentIndex(i)
                            found = True
                            break
                    # データ値で見つからない場合はテキストで検索
                    if not found:
                        for i in range(widget.count()):
                            if widget.itemText(i) == str(value):
                                widget.setCurrentIndex(i)
                                break
                elif isinstance(widget, QSpinBox):
                    widget.setValue(int(value) if isinstance(value, (int, str)) else value)
                elif isinstance(widget, QLineEdit):
                    widget.setText(str(value))
            else:
                print(f"[DYNAMIC_SET_CONFIG] 不明なオプション: {option_key} = {value}")

    def emit_if_changed(self):
        cfg = self.current_config()
        if cfg != self._last_emitted:
            self._last_emitted = dict(cfg)
            self.configChanged.emit(cfg)

    def set_defaults_and_emit_once(self):
        """デフォルト値を設定して一度だけ送信"""
        self.apply_defaults()
        self.emit_if_changed()

    def apply_defaults(self):
        """デフォルト値をUIに適用"""
        default_config = self.game_info.get('options', {}).get('defaultConfig', {})

        for option_key, default_value in default_config.items():
            if option_key in self.option_widgets:
                widget = self.option_widgets[option_key]

                if isinstance(widget, QComboBox):
                    # データまたはテキストで検索
                    idx = widget.findData(default_value)
                    if idx < 0:
                        idx = widget.findText(str(default_value))
                    if idx >= 0:
                        widget.setCurrentIndex(idx)
                elif isinstance(widget, QSpinBox):
                    widget.setValue(default_value)
                elif isinstance(widget, QLineEdit):
                    widget.setText(str(default_value))

    def set_config(self, config: Dict):
        """設定をUIに反映"""
        if not config:
            return

        # writing.v1 の特殊処理
        if self.game_type == "writing.v1":
            # カテゴリ設定
            category = config.get('categoryId', 'hiragana')
            for i in range(self.category_combo.count()):
                if self.category_combo.itemData(i) == category:
                    self.category_combo.setCurrentIndex(i)
                    break

            self.update_character_options()

            # 文字設定（1文字のみ）
            char_id = config.get('characterId')
            if char_id and char_id in getattr(self, 'char_checkboxes', {}):
                self.char_checkboxes[char_id].setChecked(True)

            # シーケンス設定
            sequence = config.get('sequence', ['tracing'])
            for i in range(self.sequence_combo.count()):
                if self.sequence_combo.itemData(i) == sequence:
                    self.sequence_combo.setCurrentIndex(i)
                    break
            return

        # 通常のオプション設定
        for option_key, value in config.items():
            if option_key == 'type':
                continue

            if option_key in self.option_widgets:
                widget = self.option_widgets[option_key]

                if isinstance(widget, QComboBox):
                    idx = widget.findData(value)
                    if idx < 0:
                        idx = widget.findText(str(value))
                    if idx >= 0:
                        widget.setCurrentIndex(idx)
                elif isinstance(widget, QSpinBox):
                    widget.setValue(value)
                elif isinstance(widget, QLineEdit):
                    widget.setText(str(value))

    def validate(self) -> Tuple[bool, str]:
        """設定を検証"""
        if self.game_type == "writing.v1":
            selected_chars = [char for char, cb in getattr(self, 'char_checkboxes', {}).items() if cb.isChecked()]
            if not selected_chars:
                return False, "最低1つの文字を選択してください"
        return True, ""

# ===== レガシーWidgetクラス削除完了 =====
# 以下の635行のレガシーコードをDynamicGameConfigWidgetに統合済み:
# - CountingConfigWidget (61行)
# - ComparisonConfigWidget (130行)
# - WritingConfigWidget (138行)
# - OddEvenConfigWidget (67行)
# - TsumikiCountingConfigWidget (65行)
# - SimpleGameConfigWidget (174行)
#
# 新システムでは1つのDynamicGameConfigWidgetが全ゲームに対応

# ===== メインウィンドウ =====
class MainWindow(QMainWindow):
    """メインウィンドウクラス"""
    
    def __init__(self):
        super().__init__()
        
        # 初期化
        self.settings = QSettings("MonakaLessons", "LessonEditor")
        self.theme_manager = ThemeManager()
        self.icon_manager = IconManager()
        self.model = LessonModel()

        # 再入防止フラグ
        self._in_on_lesson_selected = False
        self._suppress_list_refresh = False
        self._last_selected_row = -1
        self._cfg_widget_cache = {}  # {(category_key, game_type): widget}

        # イベントストーム遮断用タイマー
        self._refresh_timer = QTimer(self)
        self._refresh_timer.setSingleShot(True)
        self._refresh_timer.timeout.connect(self._do_coalesced_refresh)
        
        # データ読み込み
        catalog_path = Path(__file__).parent / "game_settings_catalog.json"
        self.model.load_catalog(catalog_path)
        
        # UI初期化
        self.init_ui()
        self.apply_theme()
        self.restore_settings()
        
        # シグナル接続
        self.model.dataChanged.connect(self.request_refresh)

        # デフォルトでレッスン1を作成
        if len(self.model.get_lessons()) == 0:
            self.model.add_lesson()
            self.populate_lesson_list()
            self.lesson_list.setCurrentRow(0)
        
    def init_ui(self):
        """UI初期化"""
        self.setWindowTitle("レッスンエディタ v2.0")
        self.setGeometry(100, 100, 1600, 1000)
        
        # メニューバー作成
        self.create_menus()
        
        # ツールバー作成
        self.create_toolbar()
        
        # メインエリア作成
        self.create_main_area()
        
        # ステータスバー
        self.statusBar().showMessage("準備完了")
        
    def create_menus(self):
        """メニューバー作成"""
        menubar = self.menuBar()
        
        # ファイルメニュー
        file_menu = menubar.addMenu('ファイル')
        
        new_action = QAction(self.icon_manager.get_icon('new'), '新規作成', self)
        new_action.setShortcut(QKeySequence.StandardKey.New)
        new_action.triggered.connect(self.new_file)
        file_menu.addAction(new_action)
        
        open_action = QAction(self.icon_manager.get_icon('open'), '開く', self)
        open_action.setShortcut(QKeySequence.StandardKey.Open)
        open_action.triggered.connect(self.open_file)
        file_menu.addAction(open_action)
        
        save_action = QAction(self.icon_manager.get_icon('save'), '保存', self)
        save_action.setShortcut(QKeySequence.StandardKey.Save)
        save_action.triggered.connect(self.save_file)
        file_menu.addAction(save_action)
        
        save_as_action = QAction('名前を付けて保存', self)
        save_as_action.setShortcut(QKeySequence.StandardKey.SaveAs)
        save_as_action.triggered.connect(self.save_file_as)
        file_menu.addAction(save_as_action)
        
        # 表示メニュー
        view_menu = menubar.addMenu('表示')
        
        
    def create_toolbar(self):
        """ツールバー作成"""
        toolbar = self.addToolBar('メインツールバー')
        toolbar.setToolButtonStyle(Qt.ToolButtonStyle.ToolButtonTextUnderIcon)
        
        # ファイル操作
        toolbar.addAction(self.icon_manager.get_icon('new'), '新規', self.new_file)
        toolbar.addAction(self.icon_manager.get_icon('open'), '開く', self.open_file)
        toolbar.addAction(self.icon_manager.get_icon('save'), '保存', self.save_file)
        toolbar.addSeparator()
        toolbar.addAction(self.icon_manager.get_icon('numbers'), '自動番号', self.auto_number_lessons)
        
        
    def create_main_area(self):
        """メインエリア作成"""
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # 水平分割
        splitter = QSplitter(Qt.Orientation.Horizontal)
        
        # 左パネル: レッスンリスト
        self.create_lesson_panel(splitter)
        
        # 右パネル: ゲーム設定
        self.create_game_panel(splitter)
        
        splitter.setSizes([300, 1300])
        
        layout = QVBoxLayout(central_widget)
        layout.addWidget(splitter)
        
    def create_lesson_panel(self, parent):
        """レッスンパネル作成"""
        panel = QWidget()
        layout = QVBoxLayout(panel)
        
        # 検索ボックス
        self.search_box = QLineEdit()
        self.search_box.setPlaceholderText("レッスンを検索...")
        layout.addWidget(self.search_box)
        
        # レッスンリスト（ドラッグ&ドロップ有効）
        self.lesson_list = QListWidget()
        self.lesson_list.setDragDropMode(QListWidget.DragDropMode.InternalMove)
        self.lesson_list.currentRowChanged.connect(self.on_lesson_selected)
        self.lesson_list.model().rowsMoved.connect(self.on_lesson_moved)
        layout.addWidget(self.lesson_list)
        
        # 操作ボタン
        btn_layout = QHBoxLayout()

        add_btn = QPushButton(self.icon_manager.get_icon('add'), "追加")
        add_btn.clicked.connect(self.add_lesson)
        btn_layout.addWidget(add_btn)

        copy_btn = QPushButton(self.icon_manager.get_icon('copy'), "複製")
        copy_btn.clicked.connect(self.duplicate_lesson)
        btn_layout.addWidget(copy_btn)

        del_btn = QPushButton(self.icon_manager.get_icon('remove'), "削除")
        del_btn.clicked.connect(self.delete_lesson)
        btn_layout.addWidget(del_btn)

        layout.addLayout(btn_layout)

        # ドラッグ&ドロップの説明
        drag_info = QLabel("🔄 ドラッグ&ドロップで順序変更可能")
        drag_info.setStyleSheet("font-size: 10px; color: #b0b0b0; margin: 5px;")
        layout.addWidget(drag_info)
        
        parent.addWidget(panel)
        
    def create_game_panel(self, parent):
        """ゲーム設定パネル作成"""
        panel = QWidget()
        layout = QVBoxLayout(panel)
        
        # レッスン情報ヘッダー（シンプル化）
        info_layout = QHBoxLayout()
        self.lesson_info_label = QLabel("レッスンを選択してください")
        self.lesson_info_label.setStyleSheet("font-size: 14px; font-weight: bold; color: #bb86fc;")
        info_layout.addWidget(self.lesson_info_label)
        info_layout.addStretch()
        layout.addLayout(info_layout)
        
        # タブウィジェット
        self.tabs = QTabWidget()
        
        # 各カテゴリタブを作成
        self.category_tabs = {}
        categories = {
            'chie': ('🧠 ちえ', 'wisdom'),
            'kazu': ('🔢 かず', 'numbers'), 
            'moji': ('✍️ もじ', 'writing')
        }
        
        for category_key, (tab_name, description) in categories.items():
            tab_widget = self.create_category_tab(category_key)
            self.tabs.addTab(tab_widget, tab_name)
            self.category_tabs[category_key] = tab_widget
            
        layout.addWidget(self.tabs)
        
        parent.addWidget(panel)
        
    def create_category_tab(self, category_key: str) -> QWidget:
        """カテゴリタブ作成（ドロップダウン選択式）"""
        tab_widget = QWidget()
        layout = QVBoxLayout(tab_widget)
        
        # ゲーム選択エリア
        selection_group = QGroupBox("ゲーム選択")
        selection_layout = QVBoxLayout(selection_group)
        
        # ゲーム選択ドロップダウン
        game_select_layout = QHBoxLayout()
        game_select_layout.addWidget(QLabel("ゲーム:"))
        
        game_combo = QComboBox()
        game_combo.addItem("-- ゲームを選択 --", "")
        
        # 利用可能なゲームを追加
        if self.model.catalog and 'games' in self.model.catalog:
            for game_type, game_info in self.model.catalog['games'].items():
                display_name = game_info.get('displayName', game_type)
                game_combo.addItem(display_name, game_type)
        
        game_select_layout.addWidget(game_combo)
        game_select_layout.addStretch()
        selection_layout.addLayout(game_select_layout)
        
        layout.addWidget(selection_group)
        
        # 設定エリア（初期は非表示）
        config_area = QWidget()
        config_layout = QVBoxLayout(config_area)
        config_area.hide()
        layout.addWidget(config_area)
        
        layout.addStretch()
        
        # 現在の設定ウィジェット
        current_config_widget = None
        
        def on_game_selection_changed():
            nonlocal current_config_widget

            selected_game_type = game_combo.currentData()
            print(f"[DEBUG] ゲーム選択変更: {game_combo.currentText()} -> {selected_game_type}")

            # 既存のウィジェットを削除
            if current_config_widget:
                current_config_widget.setParent(None)
                current_config_widget = None
            
            if selected_game_type and selected_game_type in self.model.catalog['games']:
                game_info = self.model.catalog['games'][selected_game_type]
                
                # 動的ウィジェットシステムを使用
                current_config_widget = DynamicGameConfigWidget(selected_game_type, game_info, self.theme_manager)

                # 自動的に有効化
                current_config_widget.setChecked(True)
                # 確実に有効化されるように明示的に呼び出し
                current_config_widget.on_enabled_changed(True)
                print(f"[INIT] {selected_game_type} ウィジェット有効化")

                # シグナル接続（クロージャの問題を修正）
                # 参照を安全にキャプチャ
                captured_category_key = category_key
                captured_game_type = selected_game_type

                def _shrink(cfg: dict) -> str:
                    # でかい配列は長さだけ
                    view = {}
                    for k, v in cfg.items():
                        if isinstance(v, list) and len(v) > 10:
                            view[k] = f"<list len={len(v)}>"
                        else:
                            view[k] = v
                    return str(view)

                # 重複送信防止用
                last_emitted_config = [None]  # リスト内包でクロージャの参照問題を回避

                def config_callback(config):
                    # 前回と同一内容なら無視
                    if config == last_emitted_config[0]:
                        return
                    last_emitted_config[0] = config.copy() if config else None
                    print(f"[CONFIG] {captured_game_type}: {_shrink(config)}")
                    self.on_category_game_config_changed(captured_category_key, captured_game_type, config)

                current_config_widget.configChanged.connect(config_callback)

                # デフォルト設定を1回だけ送信（設定復元中でない場合のみ）
                def send_default_config():
                    # 現在のタブを特定（クロージャでキャプチャされた captured_category_key を使用）
                    current_tab = self.category_tabs.get(captured_category_key) if hasattr(self, 'category_tabs') else None

                    # 設定復元中はデフォルト送信をスキップ
                    if current_tab and getattr(current_tab, '_restoring_config', False):
                        print(f"[SKIP] 設定復元中のためデフォルト送信をスキップ")
                        return

                    if current_config_widget and hasattr(current_config_widget, 'get_config'):
                        default_config = current_config_widget.get_config()
                        if default_config:
                            print(f"[FORCE] デフォルト設定送信: {default_config}")
                            config_callback(default_config)

                # 100ms後に1回だけ実行（確実性のため）
                QTimer.singleShot(100, send_default_config)
                
                config_layout.addWidget(current_config_widget)
                config_area.show()
            else:
                # 何も選ばれていないときはUIだけ隠す。モデルはクリアしない。
                config_area.hide()
        
        # シグナル接続
        game_combo.currentIndexChanged.connect(lambda _i: on_game_selection_changed())

        # 初期選択時もコールバックを呼ぶ
        if game_combo.count() > 0:
            game_combo.setCurrentIndex(0)
            print(f"[DEBUG] 初期ゲーム選択: {game_combo.currentText()}")
            on_game_selection_changed()
        
        # タブの状態を保存
        setattr(tab_widget, 'game_combo', game_combo)
        setattr(tab_widget, 'config_area', config_area)
        setattr(tab_widget, 'config_layout', config_layout)
        setattr(tab_widget, 'get_current_widget', lambda: current_config_widget)
        setattr(tab_widget, 'on_selection_changed', on_game_selection_changed)

        return tab_widget
        
    def _create_config_widget(self, game_type: str):
        """ゲームタイプに応じた設定ウィジェットを作成（動的システム使用）"""
        if game_type not in self.model.catalog.get('games', {}):
            return None

        game_info = self.model.catalog['games'][game_type]

        # 全ゲームでDynamicGameConfigWidgetを使用
        return DynamicGameConfigWidget(game_type, game_info, self.theme_manager)

    def _get_or_create_config_widget(self, category_key: str, game_type: str):
        """設定ウィジェットをキャッシュから取得または新規作成"""
        key = (category_key, game_type)
        if key in self._cfg_widget_cache:
            return self._cfg_widget_cache[key], False

        widget = self._create_config_widget(game_type)
        if not widget:
            return None, False

        widget.game_type = game_type
        widget.configChanged.connect(lambda cfg, k=category_key: self.on_config_changed(k, cfg))
        self._cfg_widget_cache[key] = widget
        return widget, True

    def _apply_game_selection(self, category_key: str, game_type: str, user_trigger: bool):
        """ゲーム選択を適用（キャッシュ使用）"""
        tab = self.category_tabs[category_key]

        if not game_type:
            tab.config_area.hide()
            return

        widget, is_new = self._get_or_create_config_widget(category_key, game_type)
        if not widget:
            return

        # スタックウィジェットに切り替え（新規のみ addWidget）
        if not hasattr(tab, 'config_stack') or tab.config_stack is None:
            from PyQt6.QtWidgets import QStackedWidget
            tab.config_stack = QStackedWidget()
            tab.config_layout.addWidget(tab.config_stack)

        if widget.parent() is None:
            tab.config_stack.addWidget(widget)
        tab.config_stack.setCurrentWidget(widget)
        tab.config_area.show()

        # 初回のみデフォルト送信
        if is_new and hasattr(widget, 'set_defaults_and_emit_once'):
            widget.set_defaults_and_emit_once()

    def on_config_changed(self, category_key: str, config: Dict):
        """設定変更コールバック（キャッシュ版）"""
        game_type = config.get('type', '') if config else ''
        self.on_category_game_config_changed(category_key, game_type, config)

    def on_category_game_config_changed(self, category_key: str, game_type: str, config: Dict):
        """カテゴリタブのゲーム設定変更時"""
        current_lesson_index = self.lesson_list.currentRow()
        # フェイルセーフ：一時的に未選択なら 0 番レッスンを採用（存在すれば）
        if current_lesson_index < 0 and len(self.model.get_lessons()) > 0:
            current_lesson_index = 0

        if current_lesson_index < 0:
            print("[WARN] レッスンが選択されていません")
            return

        lesson = self.model.get_lesson(current_lesson_index)

        # このカテゴリの既存設定をクリア
        category_game_key = f"{category_key}_game"

        if config and game_type:
            # 新しい設定を保存
            print(f"[SAVE] {category_game_key} = {config}")
            self.model.update_lesson_game(current_lesson_index, category_game_key, config)
        else:
            # 設定を削除
            if category_game_key in lesson:
                print(f"[DELETE] {category_game_key}")
                lesson.pop(category_game_key)
                self.model.dataChanged.emit()

        self.update_lesson_list_display()
        
    def on_game_config_changed(self, game_type: str, config: Dict):
        """ゲーム設定変更時（旧バージョン互換用）"""
        # 新システムでは使用しない
        pass
        
    def populate_lesson_list(self, *, keep_selection=True):
        """レッスンリストを更新"""
        cur = self.lesson_list.currentRow()
        with QSignalBlocker(self.lesson_list):
            self.lesson_list.clear()
            lessons = self.model.get_lessons()

            for i, lesson in enumerate(lessons):
                # カテゴリ別ゲーム数をカウント
                category_games = []
                for key in lesson.keys():
                    if key.endswith('_game'):
                        category_key = key.replace('_game', '')
                        if category_key in ['chie', 'kazu', 'moji']:
                            category_name = {'chie': 'ちえ', 'kazu': 'かず', 'moji': 'もじ'}[category_key]
                            category_games.append(category_name)

                item_text = f"📚 レッスン {i + 1}"
                if category_games:
                    item_text += f" - 🎮 {', '.join(category_games)}"

                item = QListWidgetItem(item_text)
                self.lesson_list.addItem(item)

            if keep_selection and 0 <= cur < self.lesson_list.count():
                self.lesson_list.setCurrentRow(cur)

    def update_lesson_list_display(self):
        """レッスンリスト表示を更新（選択状態を保持）"""
        current_row = self.lesson_list.currentRow()
        self.populate_lesson_list()
        if 0 <= current_row < self.lesson_list.count():
            self.lesson_list.setCurrentRow(current_row)
            
    def on_lesson_selected(self, index: int):
        """レッスン選択時"""
        # 再入防止
        if self._in_on_lesson_selected:
            return
        # 同じ行の再選択防止
        if index == self._last_selected_row or index < 0:
            return
        self._last_selected_row = index
        self._in_on_lesson_selected = True
        try:
            print(f"[SELECT] レッスン選択: {index}")

            # 負値は無視（描画中の一瞬の -1 を拾わない）
            if index < 0:
                return

            # 選択変更の再発火を抑止
            was_blocked = self.lesson_list.blockSignals(True)

            # 設定パネルを有効化
            for category_key, category_tab in self.category_tabs.items():
                category_tab.setEnabled(True)

            # 設定パネルを有効化
            for category_key, category_tab in self.category_tabs.items():
                category_tab.setEnabled(True)

            lesson = self.model.get_lesson(index)
            print(f"[SELECT] レッスン{index + 1} データ: {lesson}")

            # レッスン情報を表示
            self.lesson_info_label.setText(f"レッスン {index + 1} を編集中")

            # 全カテゴリタブのUIを初期表示に戻すが、モデルを変えないようにsignalをブロック
            for category_key, category_tab in self.category_tabs.items():
                game_combo = category_tab.game_combo
                gb = game_combo.blockSignals(True)
                game_combo.setCurrentIndex(0)  # "-- ゲームを選択 --" に見た目だけ戻す
                if not gb:
                    game_combo.blockSignals(False)
                category_tab.config_area.hide()

            # レッスンのカテゴリ別ゲーム設定を反映
            for key, config in lesson.items():
                if key.endswith('_game') and isinstance(config, dict):
                    category_key = key.replace('_game', '')
                    game_type = config.get('type', '')
                    print(f"[CONFIG_RESTORE] 設定復元中: {category_key}, game_type={game_type}, config={config}")

                    if category_key in self.category_tabs and game_type:
                        category_tab = self.category_tabs[category_key]
                        game_combo = category_tab.game_combo

                        # 対応するゲームタイプを選択
                        for i in range(game_combo.count()):
                            if game_combo.itemData(i) == game_type:
                                print(f"[CONFIG_RESTORE] ゲームタイプ選択: {game_type} (index={i})")
                                # 設定復元フラグを設定（デフォルト送信を抑制）
                                category_tab._restoring_config = True
                                # シグナルをブロックせずに選択してウィジェットを作成
                                game_combo.setCurrentIndex(i)
                                # 選択変更によってウィジェットが作成される
                                # 設定を適用するための関数を作成
                                def apply_config_with_closure(tab=category_tab, cfg=config.copy()):
                                    self.apply_config_delayed(tab, cfg)
                                    # 設定適用後にフラグをクリア
                                    tab._restoring_config = False
                                QTimer.singleShot(200, apply_config_with_closure)
                                break

        finally:
            if not was_blocked:
                self.lesson_list.blockSignals(False)
            self._in_on_lesson_selected = False

    def apply_config_delayed(self, category_tab, config, retry_count=0):
        """設定を遅延適用（リトライ機能付き）"""
        current_widget = category_tab.get_current_widget()
        if current_widget and hasattr(current_widget, 'set_config'):
            print(f"[CONFIG_APPLY] 設定を適用中: {config}")
            current_widget.set_config(config)
        else:
            if retry_count < 3:  # 最大3回リトライ
                print(f"[CONFIG_APPLY] ウィジェット未作成、リトライ中... ({retry_count + 1}/3)")
                QTimer.singleShot(100, lambda: self.apply_config_delayed(category_tab, config, retry_count + 1))
            else:
                print(f"[CONFIG_APPLY] 設定適用失敗: widget={current_widget}, config={config}")

    def auto_number_lessons(self):
        """レッスンに自動で連番を割り振る（後工程用）"""
        lessons = self.model.get_lessons()
        for i, lesson in enumerate(lessons, 1):
            lesson['lesson'] = i
            lesson['day'] = f'Day {i}'
        self.model.dataChanged.emit()
                        
            
    def request_refresh(self):
        """リフレッシュ要求（イベント合流）"""
        self._refresh_timer.start(30)  # 30ms 窓で合流

    def _do_coalesced_refresh(self):
        """合流されたリフレッシュ実行"""
        self.update_lesson_item_text(self.lesson_list.currentRow())

    def update_lesson_item_text(self, row: int):
        """指定行のテキストのみ更新"""
        if 0 <= row < self.lesson_list.count():
            lessons = self.model.get_lessons()
            if row < len(lessons):
                lesson = lessons[row]
                category_games = []
                for key in lesson.keys():
                    if key.endswith('_game'):
                        category_key = key.replace('_game', '')
                        if category_key in ['chie', 'kazu', 'moji']:
                            category_name = {'chie': 'ちえ', 'kazu': 'かず', 'moji': 'もじ'}[category_key]
                            category_games.append(category_name)

                item_text = f"📚 レッスン {row + 1}"
                if category_games:
                    item_text += f" - 🎮 {', '.join(category_games)}"

                item = self.lesson_list.item(row)
                if item:
                    item.setText(item_text)

    def on_data_changed(self):
        """データ変更時（選択を保持して再描画）"""
        self.update_lesson_list_display()
        
    # ===== ファイル操作 =====
    def new_file(self):
        """新規作成"""
        self.model.course_data = {"lessons": []}
        self.model.current_file = None
        self.populate_lesson_list()
        self.setWindowTitle("レッスンエディタ v2.0 - 新規ファイル")
        
    def open_file(self):
        """ファイルを開く"""
        # スクリプトと同じディレクトリをデフォルトに設定
        script_dir = str(Path(__file__).parent)
        filename, _ = QFileDialog.getOpenFileName(
            self, "YAMLファイルを開く",
            script_dir,
            "YAML Files (*.yml *.yaml)")
            
        if filename:
            if self.model.load_course(filename):
                self.populate_lesson_list()
                self.setWindowTitle(f"レッスンエディタ v2.0 - {Path(filename).name}")
                self.statusBar().showMessage(f"読み込み完了: {Path(filename).name}")

                # レッスンがある場合は最初のレッスンを自動選択
                if self.lesson_list.count() > 0:
                    # 再入防止フラグをリセット
                    self._last_selected_row = -1
                    self.lesson_list.setCurrentRow(0)
                    # 選択イベントを強制発火
                    self.on_lesson_selected(0)
            else:
                QMessageBox.critical(self, "エラー", "ファイルの読み込みに失敗しました。")
                
    def save_file(self):
        """保存"""
        if self.model.current_file:
            if self.model.save_course():
                self.statusBar().showMessage(f"保存完了: {Path(self.model.current_file).name}")
            else:
                QMessageBox.critical(self, "エラー", "ファイルの保存に失敗しました。")
        else:
            self.save_file_as()
            
    def save_file_as(self):
        """名前を付けて保存"""
        # スクリプトと同じディレクトリをデフォルトに設定
        script_dir = str(Path(__file__).parent)
        default_filename = str(Path(script_dir) / "new_course.yml")
        filename, _ = QFileDialog.getSaveFileName(
            self, "YAMLファイルを保存",
            default_filename,
            "YAML Files (*.yml *.yaml)")
            
        if filename:
            if self.model.save_course(filename):
                self.setWindowTitle(f"レッスンエディタ v2.0 - {Path(filename).name}")
                self.statusBar().showMessage(f"保存完了: {Path(filename).name}")
            else:
                QMessageBox.critical(self, "エラー", "ファイルの保存に失敗しました。")
                
    # ===== レッスン操作 =====
    def add_lesson(self):
        """レッスン追加"""
        new_index = self.model.add_lesson()
        self.populate_lesson_list()
        self.lesson_list.setCurrentRow(new_index)
        # 新しいレッスンを選択して設定パネルを有効化
        self.on_lesson_selected(new_index)
        
    def duplicate_lesson(self):
        """レッスン複製"""
        current_index = self.lesson_list.currentRow()
        if current_index >= 0:
            new_index = self.model.duplicate_lesson(current_index)
            if new_index >= 0:
                self.populate_lesson_list()
                self.lesson_list.setCurrentRow(new_index)
                
    def delete_lesson(self):
        """レッスン削除"""
        current_index = self.lesson_list.currentRow()
        if current_index >= 0:
            # 最後の1つは削除できない
            if self.lesson_list.count() <= 1:
                QMessageBox.warning(self, "警告", "最後のレッスンは削除できません")
                return

            reply = QMessageBox.question(self, "確認", "選択したレッスンを削除しますか？")
            if reply == QMessageBox.StandardButton.Yes:
                self.model.remove_lesson(current_index)
                self.populate_lesson_list()
                # 削除後に適切なレッスンを選択
                if self.lesson_list.count() > 0:
                    new_index = min(current_index, self.lesson_list.count() - 1)
                    self.lesson_list.setCurrentRow(new_index)

    def on_lesson_moved(self, parent, start, end, destination, row):
        """レッスンがドラッグ&ドロップで移動された時"""
        # 移動先のインデックスを調整
        to_index = row if row < start else row - 1

        # モデル側でもデータを移動
        self.model.move_lesson(start, to_index)

        # 表示を更新（選択状態を保持）
        current_row = self.lesson_list.currentRow()
        self.populate_lesson_list()
        self.lesson_list.setCurrentRow(to_index)
                
        
    def apply_theme(self):
        """テーマ適用"""
        self.setStyleSheet(self.theme_manager.get_stylesheet())
        
    # ===== 設定管理 =====
    def restore_settings(self):
        """設定復元"""
        geometry = self.settings.value("geometry")
        if geometry:
            self.restoreGeometry(geometry)
            
        # ダークテーマ固定
        self.theme_manager.set_theme("dark")
        
    def save_settings(self):
        """設定保存"""
        self.settings.setValue("geometry", self.saveGeometry())
        # ダークテーマ固定のため保存不要
        
    def closeEvent(self, event):
        """終了時"""
        self.save_settings()
        event.accept()

# ===== メイン関数 =====
def main():
    app = QApplication(sys.argv)
    app.setStyle('Fusion')

    # 日本語フォント設定
    font = QFont()
    font.setFamily("Yu Gothic UI")
    font.setPointSize(9)
    app.setFont(font)

    # メインウィンドウ表示
    window = MainWindow()
    window.show()

    sys.exit(app.exec())

if __name__ == "__main__":
    main()