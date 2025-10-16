#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Dartコード解析モジュール
ゲームロジックファイルから音声テキストを自動抽出
"""

import os
import re
import ast
from pathlib import Path
from typing import List, Dict, Set, Tuple
import sys
import io

# Windows環境でのUTF-8出力設定
if sys.platform == 'win32':
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

class DartCodeAnalyzer:
    """Dartコード解析クラス"""
    
    def __init__(self, project_root: Path):
        self.project_root = project_root
        self.flutter_lib_path = project_root / "flutter_app" / "lib"
        
        # 日本語テキストパターン
        self.japanese_patterns = [
            # シングルクォート内の日本語
            r"'([^']*[あ-んア-ンー一-龯0-9？！。、][^']*)'",
            # ダブルクォート内の日本語  
            r'"([^"]*[あ-んア-ンー一-龯0-9？！。、][^"]*)"',
            # 複数行文字列
            r'"""([^"]*[あ-んア-ンー一-龯0-9？！。、][^"]*)"""',
            r"'''([^']*[あ-んア-ンー一-龯0-9？！。、][^']*)'''"
        ]
        
        # 特定の音声関連メソッドパターン
        self.voice_method_patterns = [
            r'speak\s*\(\s*["\']([^"\']+)["\']',
            r'playTTS\s*\([^,]*,\s*["\']([^"\']+)["\']',
            r'speakNumber\s*\(',
            r'speakComparison\s*\([^,]*,\s*["\']([^"\']+)["\']',
            r'speakSequence\s*\(\s*\[([^\]]+)\]',
            r'questionText\s*[=:>]\s*["\']([^"\']+)["\']'
        ]
        
        # 除外するファイルパターン
        self.exclude_patterns = [
            r'.*\.g\.dart$',      # 生成されたファイル
            r'.*\.freezed\.dart$', # Freezedファイル
            r'.*/test/.*',        # テストファイル
            r'.*/generated/.*',   # 生成されたファイル
        ]
    
    def find_dart_files(self) -> List[Path]:
        """Dartファイルを再帰的に検索"""
        dart_files = []
        
        if not self.flutter_lib_path.exists():
            print(f"❌ Flutter lib path not found: {self.flutter_lib_path}")
            return dart_files
        
        for dart_file in self.flutter_lib_path.rglob("*.dart"):
            # 除外パターンをチェック
            exclude = False
            for pattern in self.exclude_patterns:
                if re.match(pattern, str(dart_file)):
                    exclude = True
                    break
            
            if not exclude:
                dart_files.append(dart_file)
        
        return dart_files
    
    def extract_japanese_texts(self, file_path: Path) -> Set[str]:
        """ファイルから日本語テキストを抽出"""
        texts = set()
        
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # 全パターンで検索
            for pattern in self.japanese_patterns:
                matches = re.findall(pattern, content, re.MULTILINE | re.DOTALL)
                for match in matches:
                    # クリーンアップ
                    cleaned_text = self._clean_text(match)
                    if cleaned_text and self._is_valid_voice_text(cleaned_text):
                        texts.add(cleaned_text)
                        
            # 音声関連メソッド専用検索
            for pattern in self.voice_method_patterns:
                matches = re.findall(pattern, content)
                for match in matches:
                    if isinstance(match, tuple):
                        match = match[0] if match[0] else (match[1] if len(match) > 1 else '')
                    cleaned_text = self._clean_text(match)
                    if cleaned_text and self._is_valid_voice_text(cleaned_text):
                        texts.add(cleaned_text)
                        
        except Exception as e:
            print(f"⚠️ ファイル読み取りエラー {file_path}: {e}")
            
        return texts
    
    def _clean_text(self, text: str) -> str:
        """テキストをクリーンアップ"""
        if not text:
            return ""
            
        # 前後の空白を除去
        text = text.strip()
        
        # 制御文字を除去
        text = re.sub(r'[\n\r\t]', ' ', text)
        
        # 連続する空白を単一の空白に
        text = re.sub(r'\s+', ' ', text)
        
        # エスケープシーケンスを処理
        text = text.replace('\\n', ' ').replace('\\t', ' ').replace('\\r', '')
        text = text.replace("\\'", "'").replace('\\"', '"')
        
        return text.strip()
    
    def _is_valid_voice_text(self, text: str) -> bool:
        """音声として有効なテキストかどうかを判定"""
        if not text or len(text.strip()) == 0:
            return False
            
        # 最小・最大長チェック
        if len(text) < 1 or len(text) > 100:
            return False
            
        # 日本語が含まれているかチェック
        if not re.search(r'[あ-んア-ンー一-龯]', text):
            return False
            
        # 除外パターン
        exclude_patterns = [
            r'^[a-zA-Z_][a-zA-Z0-9_]*$',  # 変数名
            r'^\$[a-zA-Z_][a-zA-Z0-9_]*', # 変数参照
            r'^import\s+',                # import文
            r'^class\s+',                 # クラス宣言
            r'^void\s+',                  # メソッド宣言
            r'^\w+\(',                    # メソッド呼び出し
            r'//.*$',                     # コメント
        ]
        
        for pattern in exclude_patterns:
            if re.match(pattern, text):
                return False
                
        return True
    
    def extract_from_specific_patterns(self, file_path: Path) -> Dict[str, Set[str]]:
        """特定のパターンからテキストを抽出（詳細分析用）"""
        results = {
            'question_texts': set(),
            'feedback_texts': set(),
            'ui_texts': set(),
            'number_texts': set()
        }
        
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # questionText関連
            question_patterns = [
                r'questionText\s*[=:>]\s*["\']([^"\']+)["\']',
                r'get\s+questionText\s*=>\s*["\']([^"\']+)["\']',
                r'問題文.*?["\']([^"\']+)["\']'
            ]
            
            for pattern in question_patterns:
                matches = re.findall(pattern, content)
                for match in matches:
                    cleaned = self._clean_text(match)
                    if cleaned and self._is_valid_voice_text(cleaned):
                        results['question_texts'].add(cleaned)
            
            # フィードバック関連
            feedback_patterns = [
                r'よくできました[^"\']*',
                r'がんばりました[^"\']*',
                r'すばらしい[^"\']*',
                r'正解[^"\']*'
            ]
            
            for pattern in feedback_patterns:
                matches = re.findall(pattern, content)
                for match in matches:
                    cleaned = self._clean_text(match)
                    if cleaned and self._is_valid_voice_text(cleaned):
                        results['feedback_texts'].add(cleaned)
                        
        except Exception as e:
            print(f"⚠️ パターン解析エラー {file_path}: {e}")
            
        return results
    
    def analyze_all_files(self) -> Dict[str, any]:
        """全ファイルを解析してテキストを抽出"""
        print("🔍 Dartファイル解析を開始...")
        
        dart_files = self.find_dart_files()
        print(f"📂 解析対象ファイル: {len(dart_files)} 個")
        
        all_texts = set()
        file_results = {}
        category_results = {
            'question_texts': set(),
            'feedback_texts': set(), 
            'ui_texts': set(),
            'number_texts': set()
        }
        
        for file_path in dart_files:
            print(f"  📝 {file_path.relative_to(self.project_root)}")
            
            # 基本テキスト抽出
            texts = self.extract_japanese_texts(file_path)
            all_texts.update(texts)
            
            # カテゴリ別抽出
            categorized = self.extract_from_specific_patterns(file_path)
            for category, category_texts in categorized.items():
                category_results[category].update(category_texts)
            
            if texts:
                file_results[str(file_path)] = list(texts)
                print(f"    → {len(texts)} 個のテキストを発見")
        
        print(f"✅ 解析完了: 合計 {len(all_texts)} 個のユニークなテキスト")
        
        return {
            'all_texts': all_texts,
            'file_results': file_results,
            'categories': category_results,
            'total_files': len(dart_files),
            'files_with_texts': len(file_results)
        }

def test_dart_analyzer():
    """Dartコード解析のテスト"""
    print("=" * 60)
    print("Dartコード解析 テスト")
    print("=" * 60)
    
    # プロジェクトルートを設定
    project_root = Path(__file__).parent.parent.parent  # tools/voicevox -> tools -> project_root
    
    analyzer = DartCodeAnalyzer(project_root)
    results = analyzer.analyze_all_files()
    
    print(f"\n📊 解析結果:")
    print(f"  解析ファイル数: {results['total_files']}")
    print(f"  テキスト発見ファイル数: {results['files_with_texts']}")
    print(f"  総テキスト数: {len(results['all_texts'])}")
    
    print(f"\n📝 カテゴリ別結果:")
    for category, texts in results['categories'].items():
        print(f"  {category}: {len(texts)} 個")
    
    print(f"\n🎯 発見されたテキスト例 (最初の15個):")
    for i, text in enumerate(sorted(results['all_texts'])[:15]):
        print(f"  {i+1:2d}. '{text}'")
    
    if len(results['all_texts']) > 15:
        print(f"  ... (他 {len(results['all_texts']) - 15} 個)")

if __name__ == "__main__":
    test_dart_analyzer()