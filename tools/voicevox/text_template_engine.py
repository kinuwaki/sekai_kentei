#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
高機能テキストテンプレートエンジン
条件付きテキスト生成とパラメータ展開をサポート
"""

import re
import itertools
from typing import List, Dict, Any, Union, Tuple
import sys
import io

# Windows環境でのUTF-8出力設定
if sys.platform == 'win32':
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

class TextTemplateEngine:
    """テキストテンプレートエンジン"""
    
    def __init__(self):
        # 変数パターン: {変数名}
        self.var_pattern = re.compile(r'\{([^}]+)\}')
        # 条件パターン: [condition:text1|text2]
        self.condition_pattern = re.compile(r'\[([^:]+):([^|]+)\|([^]]+)\]')
    
    def expand_template(self, template: str, variables: Dict[str, List[str]], 
                       conditions: Dict[str, bool] = None) -> List[str]:
        """テンプレートを展開してすべての組み合わせを生成"""
        if conditions is None:
            conditions = {}
        
        # 1. 条件付きテキストを処理
        processed_template = self._process_conditions(template, conditions)
        
        # 2. 変数を抽出
        var_matches = self.var_pattern.findall(processed_template)
        
        if not var_matches:
            return [processed_template]
        
        # 3. 変数の全組み合わせを生成
        combinations = []
        var_values = []
        
        for var_name in var_matches:
            if var_name in variables:
                var_values.append(variables[var_name])
            else:
                raise ValueError(f"Variable '{var_name}' not found in variables")
        
        # 全組み合わせを計算
        for combination in itertools.product(*var_values):
            result_text = processed_template
            for var_name, value in zip(var_matches, combination):
                result_text = result_text.replace(f'{{{var_name}}}', value)
            combinations.append(result_text)
        
        return combinations
    
    def _process_conditions(self, template: str, conditions: Dict[str, bool]) -> str:
        """条件付きテキストを処理"""
        def replace_condition(match):
            condition_name = match.group(1).strip()
            text_true = match.group(2).strip()
            text_false = match.group(3).strip()
            
            if condition_name in conditions:
                return text_true if conditions[condition_name] else text_false
            else:
                # 条件が指定されていない場合は両方のパターンを生成
                # ここでは真の場合を返す（後で改良）
                return text_true
        
        return self.condition_pattern.sub(replace_condition, template)
    
    def expand_conditional_template(self, template: str, variables: Dict[str, List[str]],
                                  condition_combinations: List[Dict[str, bool]]) -> List[str]:
        """条件の全組み合わせでテンプレートを展開"""
        all_results = []
        
        for conditions in condition_combinations:
            results = self.expand_template(template, variables, conditions)
            all_results.extend(results)
        
        # 重複除去
        return list(set(all_results))

# 新しい高機能設定
ADVANCED_GAME_CONFIGS = {
    'comparison_advanced': {
        'templates': [
            # 基本比較テンプレート
            "{question_type}",
            # 条件付きテンプレート
            "[two_options:どちらが {comparison_type}？|{rank} {comparison_type}のは？]"
        ],
        'variables': {
            'comparison_type': ['おおい', 'すくない', 'おおきい', 'ちいさい'],
            'question_type': ['どちらが おおい？', 'どちらが おおきい？', 'どちらが すくない？', 'どちらが ちいさい？'],
            'rank': ['いちばん', 'にばんめに', 'さんばんめに']
        },
        'conditions': [
            {'two_options': True},
            {'two_options': False}
        ]
    },
    
    'writing_advanced': {
        'templates': [
            # ストローク完了メッセージ
            "{stroke_number}画目: {feedback}！",
            # 次のストロークガイダンス  
            "次は{next_stroke_number}画目です",
            # エラーメッセージ
            "{stroke_number}画目から{instruction}",
            # 認識結果
            "あなたがかいたのは「{character}」です"
        ],
        'variables': {
            'stroke_number': ['1', '2', '3', '4', '5'],
            'next_stroke_number': ['2', '3', '4', '5', '6'],
            'feedback': ['よくできました', 'すばらしい', 'がんばりました'],
            'instruction': ['始めてください', 'やってください'],
            'character': ['あ', 'か', 'さ', '1', '2', '3']
        }
    },

    'number_sequence': {
        'templates': [
            # 数字の組み合わせ
            "{number}は {question_type}",
            # カウンティング
            "{object}は {number}個あります"
        ],
        'variables': {
            'number': ['いち', 'に', 'さん', 'よん', 'ご'],
            'question_type': ['いくつですか？', 'いくつかな？'],
            'object': ['ドット', 'まる', 'しかく']
        }
    }
}

def generate_advanced_texts() -> List[Tuple[str, int]]:
    """高機能テンプレートエンジンを使用してテキスト生成"""
    try:
        engine = TextTemplateEngine()
        all_texts = []
        
        print("🚀 高機能テンプレートエンジンでテキスト生成中...")
        
        for game_name, config in ADVANCED_GAME_CONFIGS.items():
            print(f"  📝 {game_name} を処理中...")
            
            for template in config['templates']:
                try:
                    if 'conditions' in config:
                        # 条件付き展開
                        expanded = engine.expand_conditional_template(
                            template, 
                            config['variables'], 
                            config['conditions']
                        )
                    else:
                        # 通常展開
                        expanded = engine.expand_template(template, config['variables'])
                    
                    for text in expanded:
                        all_texts.append((text, 0))
                        
                except Exception as e:
                    print(f"    ⚠️ テンプレート '{template}' の処理でエラー: {e}")
        
        print(f"✅ テンプレートエンジンで {len(all_texts)} 個のテキストを生成")
        return all_texts
    except Exception as e:
        print(f"❌ テンプレートエンジン全体でエラー: {e}")
        return []

def test_template_engine():
    """テンプレートエンジンのテスト"""
    print("=" * 60)
    print("テンプレートエンジン テスト")
    print("=" * 60)
    
    engine = TextTemplateEngine()
    
    # テスト1: 基本的な変数展開
    print("\n🧪 テスト1: 基本的な変数展開")
    template = "{greeting} {name}さん"
    variables = {
        'greeting': ['こんにちは', 'おはよう'],
        'name': ['太郎', '花子']
    }
    results = engine.expand_template(template, variables)
    for result in results:
        print(f"  → {result}")
    
    # テスト2: 条件付きテキスト
    print("\n🧪 テスト2: 条件付きテキスト")
    template = "[morning:おはよう|こんにちは] {name}さん"
    variables = {'name': ['太郎']}
    conditions = [{'morning': True}, {'morning': False}]
    results = engine.expand_conditional_template(template, variables, conditions)
    for result in results:
        print(f"  → {result}")
    
    # テスト3: 実際のゲームテンプレート
    print("\n🧪 テスト3: 実際のゲームテンプレート")
    advanced_texts = generate_advanced_texts()
    print(f"\n生成されたテキスト例 (最初の10個):")
    for text, speaker in advanced_texts[:10]:
        print(f"  → '{text}' (speaker: {speaker})")

if __name__ == "__main__":
    test_template_engine()