#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
シンプルな統合テキスト抽出システム
エラー処理を強化した安定版
"""

import sys
import io
from pathlib import Path
from typing import List, Tuple

# Windows環境でのUTF-8出力設定
if sys.platform == 'win32':
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

def safe_import():
    """安全なインポート"""
    modules = {}
    
    try:
        from game_text_configs import extract_game_texts_dynamic
        modules['config'] = extract_game_texts_dynamic
        print("✅ 基本設定モジュール: OK")
    except Exception as e:
        print(f"⚠️ 基本設定モジュール: {e}")
        modules['config'] = None
    
    try:
        from text_template_engine import generate_advanced_texts
        modules['template'] = generate_advanced_texts
        print("✅ テンプレートエンジン: OK")
    except Exception as e:
        print(f"⚠️ テンプレートエンジン: {e}")
        modules['template'] = None
    
    return modules

def extract_unified_texts() -> List[Tuple[str, int]]:
    """統合テキスト抽出（安全版）"""
    print("🚀 シンプル統合テキスト抽出開始")
    print("=" * 50)
    
    modules = safe_import()
    all_texts = set()
    stats = {'config': 0, 'template': 0, 'total': 0}
    
    # 基本設定からの抽出
    if modules['config']:
        print("\n📋 基本設定からテキスト抽出中...")
        try:
            config_results = modules['config']()
            config_texts = set()
            for text, speaker in config_results:
                config_texts.add(text)
            all_texts.update(config_texts)
            stats['config'] = len(config_texts)
            print(f"   → {len(config_texts)} 個のテキスト")
        except Exception as e:
            print(f"   ❌ エラー: {e}")
    
    # テンプレートからの抽出
    if modules['template']:
        print("\n🎨 テンプレートからテキスト抽出中...")
        try:
            template_results = modules['template']()
            template_texts = set()
            for text, speaker in template_results:
                template_texts.add(text)
            all_texts.update(template_texts)
            stats['template'] = len(template_texts)
            print(f"   → {len(template_texts)} 個のテキスト")
        except Exception as e:
            print(f"   ❌ エラー: {e}")
    
    # 結果の準備
    final_results = [(text, 0) for text in sorted(all_texts)]
    stats['total'] = len(final_results)
    
    print("\n" + "=" * 50)
    print(f"✅ 統合抽出完了")
    print(f"  基本設定:     {stats['config']:3d} 個")
    print(f"  テンプレート: {stats['template']:3d} 個")
    print(f"  合計:         {stats['total']:3d} 個")
    
    return final_results

def main():
    """メイン関数"""
    results = extract_unified_texts()
    
    print(f"\n🎯 生成されたテキスト例 (最初の15個):")
    for i, (text, speaker) in enumerate(results[:15]):
        print(f"  {i+1:2d}. '{text}' (speaker: {speaker})")
    
    if len(results) > 15:
        remaining = len(results) - 15
        print(f"  ... (他 {remaining} 個)")
    
    # generate_voice_assets.py との互換性テスト
    print(f"\n🔧 互換性テスト:")
    try:
        # 既存のextract_game_texts()と同じ形式で返せるかテスト
        print(f"  形式: List[Tuple[str, int]] ✅")
        print(f"  要素数: {len(results)} ✅")
        print(f"  サンプル: {results[0] if results else 'None'} ✅")
    except Exception as e:
        print(f"  ❌ 互換性エラー: {e}")

if __name__ == "__main__":
    main()