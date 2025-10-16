#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
事前音声生成スクリプト
ゲームで使用されるすべてのテキストの音声ファイルを事前生成し、
flutter_app/assets/voice/ に保存してpubspec.yamlに追加する
"""

import os
import sys
import hashlib
import re
import requests
import yaml
from pathlib import Path
import json
import argparse
from game_text_configs import extract_game_texts_dynamic

# Windows環境でのUTF-8出力設定
if sys.platform == 'win32':
    import io
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

# プロジェクトのルートディレクトリを基準にパスを設定
PROJECT_ROOT = Path(__file__).parent.parent.parent  # tools/voicevox -> tools -> project root
FLUTTER_APP_DIR = PROJECT_ROOT / "flutter_app"
ASSETS_DIR = FLUTTER_APP_DIR / "assets" / "voice"
PUBSPEC_PATH = FLUTTER_APP_DIR / "pubspec.yaml"

# 設定
VOICEVOX_URL = "http://127.0.0.1:50021"  # VOICEVOX公式APIのポート

def generate_filename(text, speaker=0):
    """ファイル名生成（Dartのロジックと同じ）"""
    # ファイル名に使えない文字を置換
    safe_text = re.sub(r'[\\/:*?"<>|]', '_', text)
    safe_text = re.sub(r'\s+', '_', safe_text)
    safe_text = safe_text.replace('？', '_').replace('！', '_')
    
    # テキストとspeakerIDを組み合わせてハッシュ生成
    hash_input = f'{text}-speaker{speaker}'
    hash_value = hashlib.md5(hash_input.encode()).hexdigest()[:6]
    
    # 最大長を制限
    truncated_text = safe_text[:30] if len(safe_text) > 30 else safe_text
    
    return f"{truncated_text}_{hash_value}.mp3"

def generate_audio(text, speaker=0, overwrite=False):
    """音声ファイル生成"""
    filename = generate_filename(text, speaker)
    filepath = ASSETS_DIR / filename
    
    # 既存ファイルチェック
    if filepath.exists() and not overwrite:
        print(f"⏭️  スキップ (既存): '{text}' -> {filename}")
        return filename
    
    print(f"🎤 生成中: '{text}' (speaker: {speaker})")
    
    try:
        # Step 1: 音声合成用のクエリを作成
        query_response = requests.post(
            f"{VOICEVOX_URL}/audio_query",
            params={'text': text, 'speaker': speaker},
            timeout=30
        )

        if query_response.status_code != 200:
            print(f"❌ クエリ作成エラー (HTTP {query_response.status_code}): {text}")
            return None

        # Step 2: 音声合成を実行
        synthesis_response = requests.post(
            f"{VOICEVOX_URL}/synthesis",
            params={'speaker': speaker},
            json=query_response.json(),
            timeout=30
        )

        if synthesis_response.status_code == 200:
            # 音声ファイル保存
            with open(filepath, 'wb') as f:
                f.write(synthesis_response.content)

            print(f"✅ 保存完了: {filename}")
            return filename
        else:
            print(f"❌ 音声合成エラー (HTTP {synthesis_response.status_code}): {text}")
            return None

    except Exception as e:
        print(f"❌ 生成失敗: {text} - {e}")
        return None

def get_japanese_number(number):
    """数字を日本語読みに変換"""
    numbers_jp = {
        1: 'いち', 2: 'に', 3: 'さん', 4: 'よん', 5: 'ご',
        6: 'ろく', 7: 'なな', 8: 'はち', 9: 'きゅう', 10: 'じゅう',
        11: 'じゅういち', 12: 'じゅうに', 13: 'じゅうさん', 14: 'じゅうよん', 15: 'じゅうご',
        16: 'じゅうろく', 17: 'じゅうなな', 18: 'じゅうはち', 19: 'じゅうきゅう', 20: 'にじゅう',
        30: 'さんじゅう', 40: 'よんじゅう', 50: 'ごじゅう', 60: 'ろくじゅう', 
        70: 'ななじゅう', 80: 'はちじゅう', 90: 'きゅうじゅう', 100: 'ひゃく'
    }
    
    if number in numbers_jp:
        return numbers_jp[number]
    elif 20 < number < 100:
        # 21-99の複合数字を処理
        tens = (number // 10) * 10
        ones = number % 10
        return numbers_jp[tens] + numbers_jp[ones]
    else:
        return str(number)

def extract_game_texts():
    """ゲーム内のすべてのテキストを抽出（動的生成システム）"""
    return extract_game_texts_dynamic()

def update_pubspec_yaml():
    """pubspec.yamlにアセットを追加"""
    print("\n📝 pubspec.yamlを更新中...")
    
    try:
        with open(PUBSPEC_PATH, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # assetsセクションを探す
        if 'assets:' in content:
            # 既存のassetsセクションに追加
            lines = content.split('\n')
            assets_start = -1
            
            for i, line in enumerate(lines):
                if line.strip().startswith('assets:'):
                    assets_start = i
                    break
            
            if assets_start != -1:
                # assets/voice/ ディレクトリを追加
                voice_entry = "    - assets/voice/"
                
                # 既に存在しないか確認
                if voice_entry.strip() not in content:
                    # assetsセクションの最後に追加
                    insert_pos = assets_start + 1
                    while insert_pos < len(lines) and (lines[insert_pos].startswith('    ') or lines[insert_pos].strip() == ''):
                        insert_pos += 1
                    
                    lines.insert(insert_pos, voice_entry)
                    
                    # ファイルに書き戻し
                    with open(PUBSPEC_PATH, 'w', encoding='utf-8') as f:
                        f.write('\n'.join(lines))
                    
                    print("✅ pubspec.yaml更新完了")
                else:
                    print("✅ pubspec.yamlは既に設定済み")
        else:
            print("❌ assetsセクションが見つかりません")
            
    except Exception as e:
        print(f"❌ pubspec.yaml更新エラー: {e}")

def check_existing_files():
    """既存ファイルのチェック"""
    if not ASSETS_DIR.exists():
        return []
    
    existing_files = list(ASSETS_DIR.glob("*.mp3"))
    return [f.name for f in existing_files]

def list_missing_files():
    """不足ファイルのリスト表示"""
    texts = extract_game_texts()
    existing = check_existing_files()
    missing = []
    
    for text, speaker in texts:
        filename = generate_filename(text, speaker)
        if filename not in existing:
            missing.append((text, speaker, filename))
    
    if missing:
        print("\n📋 不足している音声ファイル:")
        print("=" * 50)
        for text, speaker, filename in missing:
            print(f"  テキスト: '{text}'")
            print(f"  話者ID: {speaker}")
            print(f"  ファイル名: {filename}")
            print("-" * 30)
        print(f"\n合計: {len(missing)} ファイル")
    else:
        print("\n✅ すべての音声ファイルが存在します！")
    
    return missing

def main():
    parser = argparse.ArgumentParser(description='VOICEVOXで音声アセットを生成')
    parser.add_argument('--list', action='store_true', help='不足ファイルのリスト表示')
    parser.add_argument('--overwrite', action='store_true', default=True, help='既存ファイルを上書き（デフォルト: True）')
    parser.add_argument('--text', type=str, help='特定のテキストのみ生成')
    parser.add_argument('--speaker', type=int, default=0, help='話者ID (デフォルト: 0)')
    parser.add_argument('--json', action='store_true', help='不足ファイルをJSON形式で出力')
    
    args = parser.parse_args()
    
    print("=" * 50)
    print("音声アセット事前生成スクリプト")
    print("=" * 50)
    print(f"📁 プロジェクトルート: {PROJECT_ROOT}")
    print(f"📁 音声保存先: {ASSETS_DIR}")
    
    # ディレクトリ作成
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    
    # リスト表示モード
    if args.list:
        list_missing_files()
        return
    
    # JSON出力モード
    if args.json:
        missing = list_missing_files()
        json_data = [{"text": text, "speaker": speaker, "filename": filename} 
                     for text, speaker, filename in missing]
        print("\n📄 JSON形式:")
        print(json.dumps(json_data, ensure_ascii=False, indent=2))
        return
    
    # サーバー確認
    try:
        response = requests.get(f"{VOICEVOX_URL}/version", timeout=3)
        if response.status_code == 200:
            print("✅ VOICEVOX接続確認")
        else:
            print("❌ VOICEVOXが応答しません")
            sys.exit(1)
    except:
        print("❌ VOICEVOXが起動していません")
        print(f"VOICEVOXアプリケーションを起動してから再実行してください")
        sys.exit(1)
    
    # 特定テキストモード
    if args.text:
        filename = generate_audio(args.text, args.speaker, overwrite=args.overwrite)
        if filename:
            print(f"\n✅ 生成完了: {filename}")
        return
    
    # 全テキスト生成
    texts = extract_game_texts()
    print(f"\n🎯 生成対象: {len(texts)}個のテキスト")
    
    if not args.overwrite:
        existing = check_existing_files()
        print(f"📂 既存ファイル: {len(existing)}個")
    
    # 音声生成
    generated_files = []
    success_count = 0
    skip_count = 0
    
    for text, speaker in texts:
        filename = generate_audio(text, speaker, overwrite=args.overwrite)
        if filename:
            generated_files.append(filename)
            if ASSETS_DIR / filename in [ASSETS_DIR / f for f in check_existing_files()]:
                skip_count += 1
            else:
                success_count += 1
    
    print(f"\n📊 生成結果:")
    print(f"  ✅ 新規生成: {success_count}ファイル")
    if not args.overwrite:
        print(f"  ⏭️  スキップ: {skip_count}ファイル")
    print(f"  📁 合計: {len(generated_files)}ファイル")
    
    # pubspec.yaml更新
    if generated_files:
        update_pubspec_yaml()
        
        print(f"\n✅ 完了！")
        print(f"保存先: {ASSETS_DIR}")
        print(f"\n次は以下のコマンドを実行してください:")
        print(f"  cd {FLUTTER_APP_DIR}")
        print(f"  flutter pub get")
        print(f"  flutter build web")
    else:
        print("\n❌ 音声ファイルが生成されませんでした")

if __name__ == "__main__":
    main()