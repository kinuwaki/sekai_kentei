#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
ゲーム別テキスト設定
既存のハードコードされたテキストを構造化して管理
"""

# 基本的な問題文・UI要素
COMMON_TEXTS = {
    'ui_elements': [
        "やり直し",
        "ヒント", 
        "にんしき",
        "もういちど",
        "べつのもじ",
        "べつのモード",
    ],
    'feedback': [
        "よくできました",
        "よくできました正解",
        "なぞってみよう",
    ]
}

# ゲーム別設定
GAME_TEXT_CONFIGS = {
    'counting': {
        'static_texts': [
            "ドットは いくつかな？",
        ],
        'number_range': {
            'start': 1,
            'end': 100,
            'format': 'japanese'  # いち、に、さん...
        }
    },
    
    'comparison': {
        'templates': {
            # 2択の場合
            'two_options': [
                "どちらが おおい？",
                "どちらが すくない？", 
                "どちらが おおきい？",
                "どちらが ちいさい？"
            ],
            # 3択以上の場合  
            'multiple_first': [
                "いちばん おおいのは？",
                "いちばん すくないのは？",
                "いちばん おおきいのは？", 
                "いちばん ちいさいのは？"
            ],
            # 順位指定
            'ranked': [
                "にばんめに おおいのは？",
                "にばんめに すくないのは？",
                "にばんめに おおきいのは？",
                "にばんめに ちいさいのは？",
                "さんばんめに おおいのは？",
                "さんばんめに すくないのは？",
                "さんばんめに おおきいのは？",
                "さんばんめに ちいさいのは？"
            ]
        }
    },
    
    'writing': {
        'writing_instructions': [
            "あをかいてみよう", "いをかいてみよう", "うをかいてみよう", "えをかいてみよう", "おをかいてみよう",
            "かをかいてみよう", "きをかいてみよう", "くをかいてみよう", "けをかいてみよう", "こをかいてみよう", 
            "さをかいてみよう", "しをかいてみよう", "すをかいてみよう", "せをかいてみよう", "そをかいてみよう",
            "たをかいてみよう", "ちをかいてみよう", "つをかいてみよう", "てをかいてみよう", "とをかいてみよう",
            "なをかいてみよう", "にをかいてみよう", "ぬをかいてみよう", "ねをかいてみよう", "のをかいてみよう",
            "はをかいてみよう", "ひをかいてみよう", "ふをかいてみよう", "へをかいてみよう", "ほをかいてみよう",
            "まをかいてみよう", "みをかいてみよう", "むをかいてみよう", "めをかいてみよう", "もをかいてみよう", 
            "やをかいてみよう", "ゆをかいてみよう", "よをかいてみよう",
            "らをかいてみよう", "りをかいてみよう", "るをかいてみよう", "れをかいてみよう", "ろをかいてみよう",
            "わをかいてみよう", "ををかいてみよう", "んをかいてみよう"
        ]
    },
    
    'puzzle_games': {
        'jigsaw_puzzle': [
            "ばらばらパズル",
            "ピースをはめよう",
            "かんせい",
            "あとすこし"
        ],
        'shape_finding': [
            "かたちさがし",
            "おなじかたちは？",
            "まる",
            "さんかく",
            "しかく",
            "ほし"
        ],
        'dot_copy': [
            "ずけいもしゃ",
            "おてほんとおなじずをかきましょう",
            "やりなおし",
            "もどす",
            "できた"
        ]
    },
    
    'math_games': {
        'addition_subtraction': [
            "たしひきさゆう",
            "たしざん",
            "ひきざん",
            "こたえは？",
            "せいかい"
        ],
        'odd_even': [
            "きすうをぜんぶさがそう",
            "ぐうすうをぜんぶさがそう"
        ],
        'ordinal_numbers': [
            "なんばんめ",
            "いちばんめ",
            "にばんめ", 
            "さんばんめ",
            "よんばんめ",
            "ごばんめ"
        ],
        'number_recognition': [
            "４より３つちいさいかずをかきましょう",
            "７より２つちいさいかずをかきましょう",
            "５より１つおおきいかずをかきましょう"
        ]
    },
    
    'visual_games': {
        'shape_direction': [
            "ちがうむきのものをえらんでね",
            "おなじむきのものをえらんでね",
            "むきをかえてみよう"
        ],
        'spot_difference': [
            "まちがいをさがしてね",
            "ちがうところをさがしてね",
            "みつけられるかな？"
        ],
        'pattern_matching': [
            "おてほんとおなじものをぜんぶえらんでね",
            "ただしいくみあわせをえらんでね",
            "ただしいじゅんばんにならべてね"
        ]
    }
}

def get_japanese_number(number):
    """数字を日本語読みに変換（既存ロジックと同じ）"""
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

def generate_number_texts():
    """数字テキストを動的生成"""
    texts = []
    config = GAME_TEXT_CONFIGS['counting']['number_range']
    
    # 基本数字 1-20
    for i in range(1, 21):
        text = get_japanese_number(i)
        texts.append((text, 0))
    
    # 10の倍数 30-100
    for i in range(30, 101, 10):
        text = get_japanese_number(i)
        texts.append((text, 0))
    
    return texts

def generate_comparison_texts():
    """比較ゲームのテキストを動的生成"""
    texts = []
    config = GAME_TEXT_CONFIGS['comparison']['templates']
    
    for category in ['two_options', 'multiple_first', 'ranked']:
        for text in config[category]:
            texts.append((text, 0))
    
    return texts

def generate_writing_texts():
    """書字ゲームのテキストを動的生成"""
    texts = []
    config = GAME_TEXT_CONFIGS['writing']
    
    # カテゴリ名
    for text in config['categories']:
        texts.append((text, 0))
    
    # モード説明
    for text in config['mode_descriptions']:
        texts.append((text, 0))
        
    # ひらがな文字
    for text in config['hiragana_chars']:
        texts.append((text, 0))
    
    
    return texts

def generate_puzzle_game_texts():
    """パズルゲームのテキストを生成"""
    texts = []
    config = GAME_TEXT_CONFIGS['puzzle_games']
    
    for game_type in config.values():
        for text in game_type:
            texts.append((text, 0))
    
    return texts

def generate_math_game_texts():
    """算数ゲームのテキストを生成"""
    texts = []
    config = GAME_TEXT_CONFIGS['math_games']
    
    for game_type in config.values():
        for text in game_type:
            texts.append((text, 0))
    
    return texts

def generate_visual_game_texts():
    """視覚認識ゲームのテキストを生成"""
    texts = []
    config = GAME_TEXT_CONFIGS['visual_games']
    
    for game_type in config.values():
        for text in game_type:
            texts.append((text, 0))
    
    return texts

def generate_common_texts():
    """共通テキストを生成"""
    texts = []
    
    for category in COMMON_TEXTS:
        for text in COMMON_TEXTS[category]:
            texts.append((text, 0))
    
    return texts

def extract_game_texts_dynamic():
    """Flutterゲームコードから動的にTTSテキストを抽出

    各ゲームのヘッダに表示される問題文（questionText）のみを抽出。
    ボタンやUI要素のテキストは含まない。
    """
    print("🚀 ゲーム問題文の抽出を開始...")

    try:
        # 各ゲームの問題文（ヘッダに表示され、読み上げボタンが付くもののみ）
        essential_texts = [
            # 1. counting_game (かずかぞえ)
            ("ドットは いくつかな？", 0),

            # 2. comparison_game (おおきい・ちいさい)
            ("どちらが おおい？", 0),
            ("どちらが すくない？", 0),
            ("どちらが おおきい？", 0),
            ("どちらが ちいさい？", 0),
            ("いちばん おおいのは？", 0),
            ("いちばん すくないのは？", 0),
            ("いちばん おおきいのは？", 0),
            ("いちばん ちいさいのは？", 0),
            ("にばんめに おおいのは？", 0),
            ("にばんめに すくないのは？", 0),
            ("にばんめに おおきいのは？", 0),
            ("にばんめに ちいさいのは？", 0),
            ("さんばんめに おおいのは？", 0),
            ("さんばんめに すくないのは？", 0),
            ("さんばんめに おおきいのは？", 0),
            ("さんばんめに ちいさいのは？", 0),

            # 3. size_comparison_game (サイズ比較・位置)
            # サイズ比較モード
            ("いちばん\nおおきいのは？", 0),
            ("いちばん\nちいさいのは？", 0),
            ("2ばんめに\nおおきいのは？", 0),
            ("2ばんめに\nちいさいのは？", 0),
            ("3ばんめに\nおおきいのは？", 0),
            ("3ばんめに\nちいさいのは？", 0),
            # 位置モード
            ("ひだりから\n1ばんめは？", 0),
            ("ひだりから\n2ばんめは？", 0),
            ("ひだりから\n3ばんめは？", 0),
            ("ひだりから\n4ばんめは？", 0),
            ("ひだりから\n5ばんめは？", 0),
            ("みぎから\n1ばんめは？", 0),
            ("みぎから\n2ばんめは？", 0),
            ("みぎから\n3ばんめは？", 0),
            ("みぎから\n4ばんめは？", 0),
            ("みぎから\n5ばんめは？", 0),

            # 4. number_recognition_game (すうじをかこう)
            # 動的生成パターン: "4より3つちいさいかずをかきましょう"
            # 実際に表示される形式
            ("4より3つ\nちいさいかずをかきましょう", 0),
            ("5より2つ\nちいさいかずをかきましょう", 0),
            ("6より3つ\nちいさいかずをかきましょう", 0),
            ("7より3つ\nちいさいかずをかきましょう", 0),
            ("8より3つ\nちいさいかずをかきましょう", 0),
            ("9より3つ\nちいさいかずをかきましょう", 0),
            ("10より3つ\nちいさいかずをかきましょう", 0),

            # 5. odd_even_game (きすう・ぐうすう)
            ("きすうをぜんぶさがそう", 0),
            ("ぐうすうをぜんぶさがそう", 0),

            # 6. figure_orientation_game (ずけいむきまちがい)
            ("ちがうむきのものを\nえらんでね", 0),

            # 7. tsumiki_counting_game (つみきかぞえ)
            ("つみきはいくつありますか？", 0),
            ("すうじとおなじかずのつみきはどれですか？", 0),

            # 8. dot_copy_game (ずけいもしゃ)
            ("おてほんとおなじずをかきましょう", 0),

            # 9. shape_matching_game (かたちさがし)
            # 動的生成パターン: "{shape.ttsText}を つけましょう"
            # 実際の形状名は shapes.dart で定義されている
            ("まるを つけましょう", 0),
            ("さんかくを つけましょう", 0),
            ("しかくを つけましょう", 0),
            ("ほしを つけましょう", 0),
            ("はーとを つけましょう", 0),

            # 10. puzzle_game (ばらばらパズル)
            ("ただしいくみあわせを\nえらんでください", 0),

            # 11. writing_game (かきれんしゅう)
            # 問題文なし（文字のみ表示）

            # 12. word_game (ことばゲーム)
            ("これはなに？", 0),  # pictureToText mode
            ("これはどれ？", 0),  # textToPicture mode

            # 13. janken_game (じゃんけん)
            ("じゃんけんをして\nみほんにかってね", 0),
            ("じゃんけんをして\nみほんにまけてね", 0),

            # 14. word_trace_game (もじめぐり)
            ("ことばをみつけてね", 0),
            # 各単語の問題文
            ("「あさごはんをたべる」\nをなぞろう", 0),
            ("「みずをのむ」\nをなぞろう", 0),
            ("「てをあらう」\nをなぞろう", 0),
            ("「そらをみあげる」\nをなぞろう", 0),
            ("「はをみがく」\nをなぞろう", 0),
            ("「くつをはく」\nをなぞろう", 0),
            ("「ともだちとあそぶ」\nをなぞろう", 0),
            ("「ほんをよむ」\nをなぞろう", 0),
            ("「いぬがはしる」\nをなぞろう", 0),
            ("「ねこがないてる」\nをなぞろう", 0),
            ("「おにぎりをたべる」\nをなぞろう", 0),
            ("「あめがふる」\nをなぞろう", 0),
            ("「ゆきがつもる」\nをなぞろう", 0),
            ("「かぜがふく」\nをなぞろう", 0),
            ("「つきがでている」\nをなぞろう", 0),
            ("「ほしがひかる」\nをなぞろう", 0),
            ("「えをかく」\nをなぞろう", 0),
            ("「うたをうたう」\nをなぞろう", 0),
            ("「おどりをする」\nをなぞろう", 0),
            ("「でんしゃにのる」\nをなぞろう", 0),
            ("「くるまがはしる」\nをなぞろう", 0),
            ("「かわであそぶ」\nをなぞろう", 0),
            ("「うみでおよぐ」\nをなぞろう", 0),
            ("「やまにのぼる」\nをなぞろう", 0),
            ("「もりをあるく」\nをなぞろう", 0),
            ("「たまごをやく」\nをなぞろう", 0),
            ("「りんごをたべる」\nをなぞろう", 0),
            ("「すいかをわる」\nをなぞろう", 0),
            ("「おちゃをのむ」\nをなぞろう", 0),
            ("「あいさつをする」\nをなぞろう", 0),

            # 15. shiritori_maze_game (しりとりめいろ)
            ("しりとりをしながら\nあかからあおにむかいましょう", 0),

            # 16. word_fill_game (ことばあなうめ)
            ("はてなのなかにはいる\nことばはなにかな", 0),

            # 17. instant_memory_game (しゅんかんきおく)
            ("どのえがあるか\n８びょうでおぼえてね", 0),
            ("どのえがふえたかな", 0),
            ("どのえがおきかわったかな", 0),

            # 18. pattern_matching_game (きそくせい)
            ("はてなには\nなにがはいるかな", 0),

            # 19. placement_memory_game (はいちきおく)
            ("８びょうで\nえのばしょをおぼえてください", 0),
            ("さっきおぼえたばしょに\nえをもどしてください", 0),
        ]

        print(f"✅ {len(essential_texts)} 個の問題文テキストを生成")
        return essential_texts

    except Exception as e:
        print(f"❌ 動的抽出エラー: {e}")
        # フォールバック: 最小限のテキスト
        return [
            ("ドットは いくつかな？", 0),
            ("どちらが おおい？", 0),
        ]

def generate_combined_instruction(character, template):
    """文字と指示テンプレートを組み合わせた指示文を生成
    
    Args:
        character (str): 文字（例: 'う'）
        template (str): テンプレート（例: 'をかいてみよう'）
    
    Returns:
        str: 組み合わせた指示文（例: 'うをかいてみよう'）
    """
    return f"{character}{template}"

def get_separated_audio_files(character, template):
    """分離音声ファイル名を取得
    
    Args:
        character (str): 文字
        template (str): テンプレート
    
    Returns:
        tuple: (文字音声ファイル名, テンプレート音声ファイル名)
    """
    from generate_voice_assets import generate_filename
    
    char_filename = generate_filename(character, 0)
    template_filename = generate_filename(template, 0)
    
    return (char_filename, template_filename)

if __name__ == "__main__":
    import sys
    import io
    
    # Windows環境でのUTF-8出力設定
    if sys.platform == 'win32':
        sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
        sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')
    
    # テスト実行
    texts = extract_game_texts_dynamic()
    print(f"Generated {len(texts)} texts:")
    for text, speaker in texts[:10]:  # 最初の10個を表示
        print(f"  '{text}' (speaker: {speaker})")
    print("...")
    
    # 統計情報
    print(f"\n=== 統計情報 ===")
    print(f"総テキスト数: {len(texts)}")
    
    # 重複チェック
    unique_texts = set(t[0] for t in texts)
    if len(unique_texts) != len(texts):
        print(f"⚠️  重複テキストあり: {len(texts) - len(unique_texts)}個")
    else:
        print("✅ 重複なし")