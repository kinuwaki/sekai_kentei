#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
音声システムチェック用スクリプト
生成される音声データの詳細な検証を行う
"""

import sys
import io
from pathlib import Path

# Windows環境でのUTF-8出力設定
if sys.platform == 'win32':
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

sys.path.append(str(Path(__file__).parent))

from game_text_configs import extract_game_texts_dynamic

def check_voice_texts():
    """音声テキストの詳細チェック"""
    print("=== 音声システム詳細チェック ===")
    
    texts = extract_game_texts_dynamic()
    
    # カテゴリ別に分類
    categories = {
        'カウンティング': [],
        '比較ゲーム': [],
        '書字練習': [],
        '数字認識': [],
        '算数ゲーム': [],
        '視覚認識': [],
        'その他': []
    }
    
    for text, speaker in texts:
        if text == "ドットは いくつかな？":
            categories['カウンティング'].append(text)
        elif any(keyword in text for keyword in ['どちら', 'いちばん', 'にばんめ', 'さんばんめ']):
            categories['比較ゲーム'].append(text)
        elif 'をかいてみよう' in text:
            categories['書字練習'].append(text)
        elif text in ["いち", "に", "さん", "よん", "ご", "ろく", "なな", "はち", "きゅう", "じゅう"]:
            categories['数字認識'].append(text)
        elif any(keyword in text for keyword in ['きすう', 'ぐうすう', 'より', 'たし', 'ひき', 'なんばん']):
            categories['算数ゲーム'].append(text)
        elif any(keyword in text for keyword in ['むき', 'まちがい', 'おてほん', 'ただしい', 'えらんで', 'さがし']):
            categories['視覚認識'].append(text)
        else:
            categories['その他'].append(text)
    
    total = 0
    for category, items in categories.items():
        if items:
            print(f"\n📂 {category} ({len(items)}個):")
            if category == '書字練習':
                # 書字練習は最初の5個と最後の5個を表示
                if len(items) <= 10:
                    for item in items:
                        print(f"  - '{item}'")
                else:
                    for item in items[:3]:
                        print(f"  - '{item}'")
                    print(f"  ... (省略 {len(items)-6}個) ...")
                    for item in items[-3:]:
                        print(f"  - '{item}'")
            else:
                # その他は全て表示
                for item in items:
                    print(f"  - '{item}'")
            total += len(items)
    
    print(f"\n📊 合計: {total}個の音声テキスト")
    
    return categories

def check_specific_texts():
    """特定テキストの存在チェック"""
    print("\n=== 特定テキスト存在チェック ===")
    
    texts = extract_game_texts_dynamic()
    all_texts = [text for text, speaker in texts]
    
    # チェック対象のテキスト
    check_targets = [
        "きすうをぜんぶさがそう",
        "ぐうすうをぜんぶさがそう", 
        "４より３つちいさいかずをかきましょう",
        "おてほんとおなじものをぜんぶえらんでね",
        "ただしいくみあわせをえらんでね",
        "ただしいじゅんばんにならべてね"
    ]
    
    for target in check_targets:
        if target in all_texts:
            print(f"✅ '{target}' - 存在")
        else:
            print(f"❌ '{target}' - 不足")
    
    # 不要なテキストのチェック
    unwanted = [
        "おなじかたちをえらんでね",
        "おなじいろをえらんでね"
    ]
    
    print("\n不要テキストチェック:")
    for unwanted_text in unwanted:
        if unwanted_text in all_texts:
            print(f"❌ '{unwanted_text}' - 削除必要")
        else:
            print(f"✅ '{unwanted_text}' - 削除済み")

if __name__ == "__main__":
    check_voice_texts()
    check_specific_texts()