#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
音声分離機能のテストスクリプト
「う」+「をかいてみよう」のように文字と指示を分離して組み合わせる機能をテスト
"""

import sys
import io
from pathlib import Path

# Windows環境でのUTF-8出力設定
if sys.platform == 'win32':
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

# プロジェクト内のモジュールをインポート
sys.path.append(str(Path(__file__).parent))

from game_text_configs import (
    generate_combined_instruction, 
    get_separated_audio_files,
    GAME_TEXT_CONFIGS
)

def test_audio_separation():
    """音声分離機能のテスト"""
    print("=== 音声分離機能テスト ===")
    
    config = GAME_TEXT_CONFIGS['writing']
    
    # テスト用の文字とテンプレート
    test_chars = ['あ', 'う', 'か', 'を']
    test_templates = config['instruction_templates']
    
    print(f"\n📝 利用可能なテンプレート:")
    for template in test_templates:
        print(f"  - '{template}'")
    
    print(f"\n🧪 分離音声テスト例:")
    
    for char in test_chars:
        for template in test_templates:
            # 組み合わせ指示文生成
            combined = generate_combined_instruction(char, template)
            
            # 分離音声ファイル名取得
            char_file, template_file = get_separated_audio_files(char, template)
            
            print(f"\n  組み合わせ: '{combined}'")
            print(f"    文字音声: {char_file}")
            print(f"    テンプレート音声: {template_file}")
    
    print(f"\n✅ テスト完了")

def show_current_audio_files():
    """現在生成される音声ファイル一覧を表示"""
    from game_text_configs import extract_game_texts_dynamic
    
    print("\n=== 現在の音声ファイル構成 ===")
    
    texts = extract_game_texts_dynamic()
    config = GAME_TEXT_CONFIGS['writing']
    
    # カテゴリ別に分類表示
    categories = {
        'カウンティング': [],
        '比較ゲーム': [],
        '文字（分離音声1）': [],
        'テンプレート（分離音声2）': [],
        '数字認識': []
    }
    
    for text, speaker in texts:
        if text == "ドットは いくつかな？":
            categories['カウンティング'].append(text)
        elif any(keyword in text for keyword in ['どちら', 'いちばん', 'にばんめ', 'さんばんめ']):
            categories['比較ゲーム'].append(text)
        elif text in config['hiragana_chars']:
            categories['文字（分離音声1）'].append(text)
        elif text in config['instruction_templates']:
            categories['テンプレート（分離音声2）'].append(text)
        elif text in ["いち", "に", "さん", "よん", "ご", "ろく", "なな", "はち", "きゅう", "じゅう"]:
            categories['数字認識'].append(text)
    
    total = 0
    for category, items in categories.items():
        if items:
            print(f"\n📂 {category} ({len(items)}個):")
            if category in ['文字（分離音声1）', 'テンプレート（分離音声2）']:
                # 文字とテンプレートは簡潔に表示
                if len(items) <= 10:
                    print(f"  {', '.join(items)}")
                else:
                    print(f"  {', '.join(items[:5])} ... (他{len(items)-5}個)")
            else:
                for item in items[:3]:  # 最初の3個のみ表示
                    print(f"  - '{item}'")
                if len(items) > 3:
                    print(f"  ... (他{len(items)-3}個)")
            total += len(items)
    
    print(f"\n📊 合計: {total}個の音声ファイル")

if __name__ == "__main__":
    test_audio_separation()
    show_current_audio_files()