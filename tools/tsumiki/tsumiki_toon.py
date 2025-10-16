#!/usr/bin/env python3
"""
Tsumiki Toon Viewer - トゥーンシェーディング強化版
アニメ調の見た目を実現する積み木レンダリングビューア
"""

import pygame
from pygame.locals import *
from OpenGL.GL import *
from OpenGL.GLU import *
import numpy as np
import math
from PIL import Image
import datetime
import os
from typing import List, Tuple, Iterable, Set
import random
import json
from collections import deque
from itertools import combinations


# ===== プロシージュアル生成システム =====
PROC_GRID_SIZE = (3, 2, 3)  # (X, Y, Z) = (0..2, 0..1, 0..2) - 3x2x3
# 4つの角の起点パターン
PROC_ANCHOR_PATTERNS = [
    (0, 0, 0),  # 手前左下
    (2, 0, 0),  # 手前右下  
    (0, 0, 2),  # 奥左下
    (2, 0, 2)   # 奥右下
]
PROC_CURRENT_ANCHOR_INDEX = 0  # デフォルトは手前左下 (0,0,0)
PROC_MIN_BLOCKS = 2
PROC_MAX_BLOCKS = 8

Pos = Tuple[int, int, int]

def neighbors6(p: Pos) -> Iterable[Pos]:
    x, y, z = p
    for dx, dy, dz in [(1,0,0),(-1,0,0),(0,1,0),(0,-1,0),(0,0,1),(0,0,-1)]:
        yield (x+dx, y+dy, z+dz)

def in_bounds(p: Pos, size=PROC_GRID_SIZE) -> bool:
    x, y, z = p
    X, Y, Z = size
    return 0 <= x < X and 0 <= y < Y and 0 <= z < Z

def is_all_connected(blocks: Set[Pos]) -> bool:
    if not blocks: return True
    seen = set()
    stack = [next(iter(blocks))]
    while stack:
        q = stack.pop()
        if q in seen: continue
        seen.add(q)
        for nb in neighbors6(q):
            if nb in blocks and nb not in seen:
                stack.append(nb)
    return len(seen) == len(blocks)

def validate_pattern(blocks_list: List[Pos], size=PROC_GRID_SIZE) -> bool:
    blocks = set(blocks_list)
    # 3. 範囲 & 重複
    if len(blocks) != len(blocks_list): return False
    for p in blocks:
        if not in_bounds(p, size): return False
    # 1. 物理（支持）
    for x, y, z in blocks:
        if y > 0 and (x, y-1, z) not in blocks:
            return False
    # 2. 連結
    if not is_all_connected(blocks): return False
    return True

def strategy_score(p: Pos, blocks: Set[Pos], strategy: str, density: float) -> float:
    x, y, z = p
    X, Y, Z = PROC_GRID_SIZE

    # 密度：既存重心に近いほど密集（高スコア）
    if blocks:
        cx = sum(b[0] for b in blocks)/len(blocks)
        cy = sum(b[1] for b in blocks)/len(blocks)
        cz = sum(b[2] for b in blocks)/len(blocks)
        d = math.dist((x,y,z),(cx,cy,cz))
        dmax = math.sqrt((X-1)**2 + (Y-1)**2 + (Z-1)**2) or 1.0
        density_term = (1.0 - d/dmax)
        density_term = density_term if density >= 0.5 else (1.0 - density_term)
        density_weight = 0.6 * abs(density - 0.5) * 2.0
    else:
        density_term = 0.0; density_weight = 0.0

    up = y/(Y-1) if (Y-1) > 0 else 0.0
    flat = 1.0 - up
    tower = 0.0
    if blocks:
        same_column = any((bx==x and bz==z) for (bx,by,bz) in blocks)
        tower = 1.0 if same_column else 0.0

    bridge = 1.0 if (x in (0,X-1) or z in (0,Z-1)) else 0.0
    stairs = (x + z + y) / ((X-1)+(Z-1)+(Y-1) or 1)

    base = 0.0
    if strategy == 'up':         base = 0.8*up + 0.2*(1-flat)
    elif strategy == 'flat':     base = 0.8*flat + 0.2*(1-up)
    elif strategy == 'balanced': base = 0.5*up + 0.5*flat
    elif strategy == 'tower':    base = 0.6*tower + 0.3*up + 0.1*flat
    elif strategy == 'bridge':   base = 0.6*bridge + 0.3*flat + 0.1*up
    elif strategy == 'stairs':   base = 0.6*stairs + 0.3*up + 0.1*flat
    else:                        base = 0.5  # 'random'

    return base + density_weight * density_term

def enumerate_all_valid_patterns_recursive(
    num_blocks: int,
    size = PROC_GRID_SIZE,
    anchor: Pos = (0, 0, 0),
    max_distance: int = 3
) -> List[List[Pos]]:
    """起点から再帰的に成長させて全有効パターンを列挙"""
    X, Y, Z = size
    all_patterns = set()
    
    def manhattan_distance(p1: Pos, p2: Pos) -> int:
        return abs(p1[0] - p2[0]) + abs(p1[1] - p2[1]) + abs(p1[2] - p2[2])
    
    def get_valid_neighbors(blocks: Set[Pos]) -> List[Pos]:
        """現在のブロック群から追加可能な位置を取得"""
        candidates = set()
        for block in blocks:
            for neighbor in neighbors6(block):
                if neighbor not in blocks and in_bounds(neighbor, size):
                    # 距離制約チェック
                    if manhattan_distance(anchor, neighbor) <= max_distance:
                        # 物理制約チェック（下にサポートが必要）
                        nx, ny, nz = neighbor
                        if ny == 0 or (nx, ny-1, nz) in blocks:
                            candidates.add(neighbor)
        return sorted(list(candidates))
    
    def recursive_grow(blocks: Set[Pos], remaining: int):
        """再帰的にブロックを成長させる"""
        if remaining == 0:
            # 目標ブロック数に達したらパターンを記録
            pattern_tuple = tuple(sorted(blocks, key=lambda t: (t[1], t[2], t[0])))
            all_patterns.add(pattern_tuple)
            return
        
        # 次に追加可能な位置を取得
        neighbors = get_valid_neighbors(blocks)
        
        for next_pos in neighbors:
            # 新しいブロックを追加して再帰
            new_blocks = blocks.copy()
            new_blocks.add(next_pos)
            recursive_grow(new_blocks, remaining - 1)
    
    # 起点から開始
    recursive_grow({anchor}, num_blocks - 1)
    
    # 視認性の問題があるパターンをフィルタリング
    filtered_patterns = []
    for pattern_tuple in all_patterns:
        # (1,1,1)を含むパターンを除外
        if (1, 1, 1) in pattern_tuple:
            continue
        
        # (1,1,0)と(0,1,1)の両方を含むパターンを除外
        has_110 = (1, 1, 0) in pattern_tuple
        has_011 = (0, 1, 1) in pattern_tuple
        if has_110 and has_011:
            continue
        
        filtered_patterns.append(pattern_tuple)
    
    # タプルからリストに変換してソート
    valid_patterns = [list(pattern) for pattern in filtered_patterns]
    valid_patterns.sort(key=lambda p: tuple(p))
    
    return valid_patterns

def enumerate_all_valid_patterns(
    num_blocks: int,
    size = PROC_GRID_SIZE,
    anchor: Pos = (0, 0, 0)
) -> List[List[Pos]]:
    """全有効パターンを列挙（再帰版を使用）"""
    return enumerate_all_valid_patterns_recursive(num_blocks, size, anchor, max_distance=3)

# ===== パターン分解・合成分析システム =====

def normalize_pattern(pts: List[Pos]) -> List[Pos]:
    """パターンを正規化（最小座標を原点に移動）"""
    if not pts:
        return []
    minx = min(x for x, y, z in pts)
    miny = min(y for x, y, z in pts)
    minz = min(z for x, y, z in pts)
    return sorted((x-minx, y-miny, z-minz) for x, y, z in pts)

def canon_hash(pts: List[Pos]) -> tuple:
    """平行移動を吸収した正規形のタプル"""
    return tuple(normalize_pattern(pts))

def is_connected_set(pts_set: Set[Pos]) -> bool:
    """点集合が連結かチェック（6近傍）"""
    if not pts_set:
        return False
    start = next(iter(pts_set))
    q = deque([start])
    seen = {start}
    
    while q:
        x, y, z = q.popleft()
        for dx, dy, dz in [(1,0,0),(-1,0,0),(0,1,0),(0,-1,0),(0,0,1),(0,0,-1)]:
            nb = (x+dx, y+dy, z+dz)
            if nb in pts_set and nb not in seen:
                seen.add(nb)
                q.append(nb)
    
    return len(seen) == len(pts_set)

def supports_ok(pts_set: Set[Pos]) -> bool:
    """物理的サポートチェック（y>0は下にブロックが必要）"""
    for x, y, z in pts_set:
        if y > 0 and (x, y-1, z) not in pts_set:
            return False
    return True

def is_valid_partial_pattern(pts: List[Pos]) -> bool:
    """部分パターンが独立して有効か（連結＋サポート）"""
    s = set(pts)
    return is_connected_set(s) and supports_ok(s)

def get_connected_pairs(pts: List[Pos]) -> List[List[Pos]]:
    """5点から連結な2点部分集合を列挙"""
    result = []
    for i in range(len(pts)):
        for j in range(i+1, len(pts)):
            p1, p2 = pts[i], pts[j]
            x1, y1, z1 = p1
            x2, y2, z2 = p2
            # マンハッタン距離1なら隣接
            if abs(x1-x2) + abs(y1-y2) + abs(z1-z2) == 1:
                result.append([p1, p2])
    return result

def can_decompose_pattern_iv(pattern5: List[Pos], canon2: set, canon3: set):
    """Independent-Valid分解: 2側・3側それぞれ独立して有効"""
    decompositions = []
    
    for sub2 in get_connected_pairs(pattern5):
        rem3 = [p for p in pattern5 if p not in sub2]
        
        # 正規化して既知パターンと照合
        h2 = canon_hash(sub2)
        h3 = canon_hash(rem3)
        
        if h2 in canon2 and h3 in canon3:
            # それぞれが独立して有効か確認
            if is_valid_partial_pattern(sub2) and is_valid_partial_pattern(rem3):
                decompositions.append((sub2, rem3))
    
    return decompositions

def can_decompose_pattern_cv(pattern5: List[Pos], canon2: set, canon3: set):
    """Context-Valid分解: 連結性のみチェック（サポートは合体後でOK）"""
    decompositions = []
    
    for sub2 in get_connected_pairs(pattern5):
        rem3 = [p for p in pattern5 if p not in sub2]
        
        # 正規化して既知パターンと照合
        h2 = canon_hash(sub2)
        h3 = canon_hash(rem3)
        
        if h2 in canon2 and h3 in canon3:
            # 連結性のみチェック
            if is_connected_set(set(sub2)) and is_connected_set(set(rem3)):
                decompositions.append((sub2, rem3))
    
    return decompositions

def analyze_composition(block5_patterns: List[List[Pos]], 
                        block2_patterns: List[List[Pos]], 
                        block3_patterns: List[List[Pos]]) -> dict:
    """5ブロックパターンの分解可能性を分析"""
    # 2,3ブロックパターンを正規化してセット化
    canon2 = {canon_hash(p) for p in block2_patterns}
    canon3 = {canon_hash(p) for p in block3_patterns}
    
    # パターンインデックス逆引き辞書
    p2_lookup = {}
    for i, p in enumerate(block2_patterns):
        h = canon_hash(p)
        if h not in p2_lookup:
            p2_lookup[h] = []
        p2_lookup[h].append(i)
    
    p3_lookup = {}
    for i, p in enumerate(block3_patterns):
        h = canon_hash(p)
        if h not in p3_lookup:
            p3_lookup[h] = []
        p3_lookup[h].append(i)
    
    results = {}
    
    for i, p5 in enumerate(block5_patterns):
        iv_decomps = []
        cv_decomps = []
        
        # IV分解を試す
        for sub2, rem3 in can_decompose_pattern_iv(p5, canon2, canon3):
            h2 = canon_hash(sub2)
            h3 = canon_hash(rem3)
            
            for j2 in p2_lookup.get(h2, []):
                for j3 in p3_lookup.get(h3, []):
                    iv_decomps.append({
                        'p2_idx': j2,
                        'p3_idx': j3,
                        'p2': sub2,
                        'p3': rem3
                    })
        
        # CV分解を試す
        for sub2, rem3 in can_decompose_pattern_cv(p5, canon2, canon3):
            h2 = canon_hash(sub2)
            h3 = canon_hash(rem3)
            
            for j2 in p2_lookup.get(h2, []):
                for j3 in p3_lookup.get(h3, []):
                    cv_decomps.append({
                        'p2_idx': j2,
                        'p3_idx': j3,
                        'p2': sub2,
                        'p3': rem3
                    })
        
        results[i] = {
            'pattern': p5,
            'IV': iv_decomps,
            'CV': cv_decomps
        }
    
    return results

def generate_anchor_based_pattern(
    seed: int = None,
    min_blocks: int = PROC_MIN_BLOCKS,
    max_blocks: int = PROC_MAX_BLOCKS,
    strategy: str = "balanced",
    density: float = 0.6,
    size = PROC_GRID_SIZE,
    anchor: Pos = None,
    attempts: int = 200
) -> List[Pos]:
    rng = random.Random(seed)
    X, Y, Z = size

    assert in_bounds(anchor, size), "ANCHOR_POS out of bounds"
    
    # 起点から始める（必ず含まれる固定ブロック）
    blocks: Set[Pos] = {anchor}
    target = rng.randint(min_blocks, max_blocks)
    
    # 起点ベースの成長方向を定義（起点から前方・上方・左方に成長）
    def get_anchor_growth_candidates() -> List[Pos]:
        """起点から成長可能な候補位置を取得"""
        candidates = set()
        
        for block in blocks:
            x, y, z = block
            
            # 起点(0,0,0)からの成長方向を優先
            growth_dirs = []
            
            # 奥方向（Z軸プラス方向）- 最優先
            if z < Z-1:
                growth_dirs.append((x, y, z+1))
            
            # 上方向
            if y < Y-1:
                growth_dirs.append((x, y+1, z))
                
            # 右方向（X軸プラス方向）
            if x < X-1:
                growth_dirs.append((x+1, y, z))
                
            # 前方（Z軸マイナス方向）- 低優先度
            if z > 0:
                growth_dirs.append((x, y, z-1))
                
            # 左方向（X軸マイナス方向）- 最低優先度
            if x > 0:
                growth_dirs.append((x-1, y, z))
                
            for pos in growth_dirs:
                if pos not in blocks and in_bounds(pos, size):
                    # 物理的サポートチェック
                    px, py, pz = pos
                    if py == 0 or (px, py-1, pz) in blocks:
                        candidates.add(pos)
        
        return list(candidates)
    
    stuck = 0
    while len(blocks) < target and stuck < attempts:
        candidates = get_anchor_growth_candidates()
        
        if not candidates:
            stuck += 1
            # 地面レベルで隣接する位置を探す
            ground_candidates = []
            for x in range(X):
                for z in range(Z):
                    pos = (x, 0, z)
                    if pos not in blocks:
                        # 既存ブロックに隣接しているかチェック
                        for nb in neighbors6(pos):
                            if nb in blocks:
                                ground_candidates.append(pos)
                                break
            
            if not ground_candidates:
                break
            choice = rng.choice(ground_candidates)
        else:
            # 起点からの距離と方向を考慮したスコアリング
            scored_candidates = []
            for pos in candidates:
                px, py, pz = pos
                ax, ay, az = anchor
                
                # 起点からの距離（近い方が高スコア）
                distance = abs(px - ax) + abs(py - ay) + abs(pz - az)
                distance_score = 1.0 / (1.0 + distance * 0.5)
                
                # 方向ボーナス（起点(0,0,0)から奥・上・右方向を優遇）
                direction_bonus = 1.0
                if pz > az:  # 奥方向（Z軸プラス）
                    direction_bonus += 0.8
                if py > ay:  # 上方向
                    direction_bonus += 0.6
                if px > ax:  # 右方向（X軸プラス）
                    direction_bonus += 0.4
                
                total_score = distance_score * direction_bonus
                scored_candidates.append((pos, total_score))
            
            # スコアに基づく重み付き選択
            weights = [score for _, score in scored_candidates]
            total_weight = sum(weights)
            r = rng.random() * total_weight
            
            acc = 0.0
            choice = scored_candidates[0][0]
            for pos, weight in scored_candidates:
                acc += weight
                if r <= acc:
                    choice = pos
                    break

        blocks.add(choice)
        stuck = 0  # 成功したらリセット

    pattern = sorted(blocks, key=lambda t: (t[1], t[2], t[0]))
    print(f"起点ベース生成: anchor={anchor}, {len(pattern)}ブロック")
    return pattern


class TsumikiToonViewer:
    def __init__(self, width=768, height=768):
        self.width = width
        self.height = height
        self.blocks = []
        
        # カメラ設定
        self.camera_distance = 6  # もう少し寄せる
        self.camera_rot_x = 30
        self.camera_rot_y = 45
        self.camera_target = [0, 0, 0]
        
        # マウス状態
        self.mouse_pressed = False
        self.middle_mouse_pressed = False  # 中ボタン（ホイールクリック）
        self.last_mouse_pos = None
        
        # トゥーンシェーディング設定
        self.cel_levels = 4  # セルシェーディングのレベル数（標準）
        self.outline_width = 6.0  # アウトラインの太さ（さらに太く）
        
        # テクスチャ
        self.wood_texture = None
        self.use_texture = True  # テクスチャ使用フラグ
        
        # グリッドシステム
        self.grid = {}  # (x, y, z) -> block_data の辞書
        
        
        # オートスクリーンショットモード
        self.auto_screenshot_mode = False
        self.screenshot_timer = 0
        self.screenshot_interval = 3.0  # 秒
        self.current_block_count = 2  # 開始ブロック数
        self.max_block_count = 8  # 最大ブロック数
        self.current_variation_index = 0
        self.variations_per_block_count = 5  # 各ブロック数あたりのバリエーション数
        self.screenshot_count = 0
        self.strategies = ["up", "flat", "balanced", "tower", "bridge", "stairs", "random"]
        
        # カメラ座標保存（シンプル版）
        self.saved_camera = None
        self.camera_save_file = os.path.join(os.path.dirname(__file__), "saved_camera.json")
        self.load_saved_camera()
        
        # 起点切り替え
        self.current_anchor_index = PROC_CURRENT_ANCHOR_INDEX
        
        # パターンキャッシュと管理
        self.pattern_cache = {}  # {(num_blocks, anchor): [patterns]}
        self.pattern_indices = {}  # {num_blocks: current_index}
        
        # 分解分析結果
        self.composition_analysis = None
        
    def init_pygame(self):
        """Pygame と OpenGL の初期化"""
        pygame.init()
        pygame.display.set_mode((self.width, self.height), DOUBLEBUF | OPENGL)
        pygame.display.set_caption("Tsumiki Toon Viewer - トゥーンシェーディング版")
        
        # OpenGL設定
        glEnable(GL_DEPTH_TEST)
        glEnable(GL_LIGHTING)
        glEnable(GL_LIGHT0)
        glEnable(GL_LIGHT1)  # 補助ライト有効化
        glEnable(GL_COLOR_MATERIAL)
        glColorMaterial(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE)
        
        # カリング有効化（アウトライン描画用）
        glEnable(GL_CULL_FACE)
        
        # テクスチャ有効化
        glEnable(GL_TEXTURE_2D)
        
        # アンチエイリアシング（線のみ）
        glEnable(GL_LINE_SMOOTH)
        glHint(GL_LINE_SMOOTH_HINT, GL_NICEST)
        
        # ブレンディング（線のAAのみ）
        glEnable(GL_BLEND)
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
        
        # 背景色（パステルピンク）
        glClearColor(1.0, 0.95, 0.95, 1.0)
        
        # ライト設定（トゥーン用）
        self.setup_toon_lighting()
        
        # 木目テクスチャ読み込み
        self.load_wood_texture()
        
        # 投影設定
        self.setup_projection()
        
    def setup_projection(self):
        """投影行列の設定"""
        glMatrixMode(GL_PROJECTION)
        glLoadIdentity()
        gluPerspective(45, self.width / self.height, 0.1, 100.0)
        glMatrixMode(GL_MODELVIEW)
        
    def setup_toon_lighting(self):
        """トゥーンシェーディング用のライティング設定"""
        # メインライト（右側から）
        glLightfv(GL_LIGHT0, GL_POSITION, [5, 10, 5, 1])
        glLightfv(GL_LIGHT0, GL_AMBIENT, [0.3, 0.3, 0.3, 1])  # アンビエント光を少し強化
        glLightfv(GL_LIGHT0, GL_DIFFUSE, [1.0, 1.0, 1.0, 1])
        glLightfv(GL_LIGHT0, GL_SPECULAR, [0, 0, 0, 1])  # スペキュラーなし
        
        # 左側の補助ライト（LIGHT1）を追加
        glEnable(GL_LIGHT1)
        glLightfv(GL_LIGHT1, GL_POSITION, [-5, 8, 5, 1])  # 左側から
        glLightfv(GL_LIGHT1, GL_AMBIENT, [0.1, 0.1, 0.1, 1])
        glLightfv(GL_LIGHT1, GL_DIFFUSE, [0.6, 0.6, 0.6, 1])  # メインより弱め
        glLightfv(GL_LIGHT1, GL_SPECULAR, [0, 0, 0, 1])
        
        # マテリアル設定
        glMaterialfv(GL_FRONT, GL_SPECULAR, [0, 0, 0, 1])
        glMaterialf(GL_FRONT, GL_SHININESS, 0)
        
    def load_wood_texture(self):
        """wood.jpgを読み込んでテクスチャとして使用"""
        try:
            # wood.jpgを読み込み
            texture_path = os.path.join(os.path.dirname(__file__), 'wood.jpg')
            if not os.path.exists(texture_path):
                print(f"テクスチャファイルが見つかりません: {texture_path}")
                return
                
            image = Image.open(texture_path).convert('RGB')
            # OpenGLは左下原点なので画像を上下反転
            image = image.transpose(Image.FLIP_TOP_BOTTOM)
            
            width, height = image.size
            texture_data = np.array(image)
            
            # テクスチャをOpenGLに登録
            self.wood_texture = glGenTextures(1)
            glBindTexture(GL_TEXTURE_2D, self.wood_texture)
            
            # テクスチャパラメータ設定
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR)
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT)
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT)
            
            # テクスチャデータをアップロード
            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, texture_data)
            glGenerateMipmap(GL_TEXTURE_2D)
            
            glBindTexture(GL_TEXTURE_2D, 0)
            print(f"木目テクスチャを読み込みました: {width}x{height}")
            
        except Exception as e:
            print(f"テクスチャ読み込みエラー: {e}")
            self.wood_texture = None
        
    def quantize_color(self, color, levels=4):
        """色を段階的に量子化（トゥーン効果）"""
        r, g, b, a = color
        factor = 1.0 / levels
        r = math.floor(r * levels) * factor
        g = math.floor(g * levels) * factor
        b = math.floor(b * levels) * factor
        return [r, g, b, a]
        
    def draw_block_outline(self, position, size, color):
        """ブロックのアウトラインを描画"""
        x, y, z = position
        w, h, d = size
        
        # アウトライン用の設定
        glDisable(GL_LIGHTING)
        glEnable(GL_BLEND)  # エッジラインのみブレンディング有効
        glLineWidth(self.outline_width)
        glColor4f(0.4, 0.25, 0.1, 0.8)  # 茶色っぽい線
        
        # 頂点をちょうどエッジに合わせる
        expansion = 0.001
        
        # エッジを描画
        glBegin(GL_LINES)
        
        # 前面の四角
        vertices_front = [
            (x - w/2 - expansion, y - h/2 - expansion, z + d/2 + expansion),
            (x + w/2 + expansion, y - h/2 - expansion, z + d/2 + expansion),
            (x + w/2 + expansion, y + h/2 + expansion, z + d/2 + expansion),
            (x - w/2 - expansion, y + h/2 + expansion, z + d/2 + expansion)
        ]
        
        # 背面の四角
        vertices_back = [
            (x - w/2 - expansion, y - h/2 - expansion, z - d/2 - expansion),
            (x + w/2 + expansion, y - h/2 - expansion, z - d/2 - expansion),
            (x + w/2 + expansion, y + h/2 + expansion, z - d/2 - expansion),
            (x - w/2 - expansion, y + h/2 + expansion, z - d/2 - expansion)
        ]
        
        # 前面のエッジ
        for i in range(4):
            glVertex3fv(vertices_front[i])
            glVertex3fv(vertices_front[(i + 1) % 4])
            
        # 背面のエッジ
        for i in range(4):
            glVertex3fv(vertices_back[i])
            glVertex3fv(vertices_back[(i + 1) % 4])
            
        # 接続エッジ
        for i in range(4):
            glVertex3fv(vertices_front[i])
            glVertex3fv(vertices_back[i])
            
        glEnd()
        
        glEnable(GL_LIGHTING)
        glLineWidth(1.0)
        glDisable(GL_BLEND)  # エッジライン描画後はブレンディング無効に戻す
        
    def draw_block_toon(self, position, size, color):
        """トゥーンシェーディングでブロックを描画"""
        x, y, z = position
        w, h, d = size
        
        # ポリゴン描画時はブレンディング無効（隙間防止）
        glDisable(GL_BLEND)
        
        # テクスチャを使用する場合はバインド
        if self.use_texture and self.wood_texture:
            glBindTexture(GL_TEXTURE_2D, self.wood_texture)
            glEnable(GL_TEXTURE_2D)
            # テクスチャと色を合成
            glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE)
        
        # 色を量子化
        toon_color = self.quantize_color(color, self.cel_levels)
        
        # 通常の面を描画
        glColor4fv(toon_color)
        
        # 各面を描画
        glBegin(GL_QUADS)
        
        # UV座標を4分割（十字の黒線を避ける）
        # 左上 (0, 0.51) - (0.49, 1.0)
        uv_tl = [(0, 0.51), (0.49, 0.51), (0.49, 1.0), (0, 1.0)]
        # 右上 (0.51, 0.51) - (1.0, 1.0)
        uv_tr = [(0.51, 0.51), (1.0, 0.51), (1.0, 1.0), (0.51, 1.0)]
        # 左下 (0, 0) - (0.49, 0.49)
        uv_bl = [(0, 0), (0.49, 0), (0.49, 0.49), (0, 0.49)]
        # 右下 (0.51, 0) - (1.0, 0.49)
        uv_br = [(0.51, 0), (1.0, 0), (1.0, 0.49), (0.51, 0.49)]
        
        # 前面（左上）
        glNormal3f(0, 0, 1)
        glTexCoord2fv(uv_tl[0]); glVertex3f(x - w/2, y - h/2, z + d/2)
        glTexCoord2fv(uv_tl[1]); glVertex3f(x + w/2, y - h/2, z + d/2)
        glTexCoord2fv(uv_tl[2]); glVertex3f(x + w/2, y + h/2, z + d/2)
        glTexCoord2fv(uv_tl[3]); glVertex3f(x - w/2, y + h/2, z + d/2)
        
        # 背面（右上）
        glNormal3f(0, 0, -1)
        glTexCoord2fv(uv_tr[0]); glVertex3f(x - w/2, y - h/2, z - d/2)
        glTexCoord2fv(uv_tr[3]); glVertex3f(x - w/2, y + h/2, z - d/2)
        glTexCoord2fv(uv_tr[2]); glVertex3f(x + w/2, y + h/2, z - d/2)
        glTexCoord2fv(uv_tr[1]); glVertex3f(x + w/2, y - h/2, z - d/2)
        
        # 上面（左下）
        glNormal3f(0, 1, 0)
        glTexCoord2fv(uv_bl[0]); glVertex3f(x - w/2, y + h/2, z - d/2)
        glTexCoord2fv(uv_bl[3]); glVertex3f(x - w/2, y + h/2, z + d/2)
        glTexCoord2fv(uv_bl[2]); glVertex3f(x + w/2, y + h/2, z + d/2)
        glTexCoord2fv(uv_bl[1]); glVertex3f(x + w/2, y + h/2, z - d/2)
        
        # 下面（右下）
        glNormal3f(0, -1, 0)
        glTexCoord2fv(uv_br[0]); glVertex3f(x - w/2, y - h/2, z - d/2)
        glTexCoord2fv(uv_br[1]); glVertex3f(x + w/2, y - h/2, z - d/2)
        glTexCoord2fv(uv_br[2]); glVertex3f(x + w/2, y - h/2, z + d/2)
        glTexCoord2fv(uv_br[3]); glVertex3f(x - w/2, y - h/2, z + d/2)
        
        # 右面（左上の回転）
        glNormal3f(1, 0, 0)
        glTexCoord2fv(uv_tl[0]); glVertex3f(x + w/2, y - h/2, z - d/2)
        glTexCoord2fv(uv_tl[3]); glVertex3f(x + w/2, y + h/2, z - d/2)
        glTexCoord2fv(uv_tl[2]); glVertex3f(x + w/2, y + h/2, z + d/2)
        glTexCoord2fv(uv_tl[1]); glVertex3f(x + w/2, y - h/2, z + d/2)
        
        # 左面（右上の回転）
        glNormal3f(-1, 0, 0)
        glTexCoord2fv(uv_tr[0]); glVertex3f(x - w/2, y - h/2, z - d/2)
        glTexCoord2fv(uv_tr[1]); glVertex3f(x - w/2, y - h/2, z + d/2)
        glTexCoord2fv(uv_tr[2]); glVertex3f(x - w/2, y + h/2, z + d/2)
        glTexCoord2fv(uv_tr[3]); glVertex3f(x - w/2, y + h/2, z - d/2)
        
        glEnd()
        
        # テクスチャを無効化
        if self.use_texture:
            glDisable(GL_TEXTURE_2D)
        
        # アウトラインを描画
        self.draw_block_outline(position, size, color)
        
    def add_block(self, position, size=(1, 1, 1), color=(0.8, 0.6, 0.4, 1)):
        """ブロックを追加"""
        self.blocks.append({
            'position': position,
            'size': size,
            'color': color
        })
        
    def set_block(self, x, y, z, color=(0.98, 0.94, 0.88, 1)):
        """整数グリッド座標にブロックを配置"""
        x, y, z = int(x), int(y), int(z)
        self.grid[(x, y, z)] = {
            'position': [x, y, z],
            'size': [1.0, 1.0, 1.0],
            'color': color
        }
        
    def remove_block(self, x, y, z):
        """整数グリッド座標のブロックを削除"""
        x, y, z = int(x), int(y), int(z)
        if (x, y, z) in self.grid:
            del self.grid[(x, y, z)]
            
    def get_block(self, x, y, z):
        """整数グリッド座標のブロックを取得"""
        x, y, z = int(x), int(y), int(z)
        return self.grid.get((x, y, z))
        
    def clear_grid(self):
        """グリッドをクリア"""
        self.grid.clear()
        
    def grid_to_blocks(self):
        """グリッドデータをblocks配列に変換"""
        self.blocks.clear()
        for block_data in self.grid.values():
            self.blocks.append(block_data)
        
    def setup_camera(self):
        """カメラの設定"""
        glLoadIdentity()
        
        # カメラ位置を計算
        camera_x = self.camera_distance * math.sin(math.radians(self.camera_rot_y)) * math.cos(math.radians(self.camera_rot_x))
        camera_y = self.camera_distance * math.sin(math.radians(self.camera_rot_x))
        camera_z = self.camera_distance * math.cos(math.radians(self.camera_rot_y)) * math.cos(math.radians(self.camera_rot_x))
        
        gluLookAt(
            camera_x + self.camera_target[0], camera_y + self.camera_target[1], camera_z + self.camera_target[2],
            self.camera_target[0], self.camera_target[1], self.camera_target[2],
            0, 1, 0
        )
        
    def draw_ground(self):
        """地面を描画（シンプルな平面）"""
        glDisable(GL_LIGHTING)
        
        # シンプルな白っぽい地面
        glColor4f(0.95, 0.95, 0.95, 1.0)
        glBegin(GL_QUADS)
        glVertex3f(-10, -0.01, -10)
        glVertex3f(10, -0.01, -10)
        glVertex3f(10, -0.01, 10)
        glVertex3f(-10, -0.01, 10)
        glEnd()
        
        glEnable(GL_LIGHTING)
        
    def render(self):
        """シーンをレンダリング"""
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
        
        self.setup_camera()
        self.draw_ground()
        
        # ブロックを描画
        for block in self.blocks:
            self.draw_block_toon(
                block['position'],
                block['size'],
                block['color']
            )
            
        pygame.display.flip()
        
    def handle_mouse(self, event):
        """マウスイベントの処理 (Mayaライク)"""
        if event.type == MOUSEBUTTONDOWN:
            print(f"🖱️ マウスボタン押下: {event.button}")  # デバッグ用
            if event.button == 1:  # 左クリック - 回転
                self.mouse_pressed = True
                self.last_mouse_pos = pygame.mouse.get_pos()
            elif event.button == 2:  # 中ボタン（ホイールクリック） - パン
                self.middle_mouse_pressed = True
                self.last_mouse_pos = pygame.mouse.get_pos()
                print("🖱️ 中ボタン押下 - パンモード開始")
            elif event.button == 3:  # 右クリック（もしかして中ボタン？）
                self.middle_mouse_pressed = True
                self.last_mouse_pos = pygame.mouse.get_pos()
                print("🖱️ 右クリック（パンモード） - パンモード開始")
            elif event.button == 4:  # ホイールアップ - ズームイン
                self.camera_distance = max(1, self.camera_distance - 0.5)
            elif event.button == 5:  # ホイールダウン - ズームアウト
                self.camera_distance = min(30, self.camera_distance + 0.5)
                
        elif event.type == MOUSEBUTTONUP:
            if event.button == 1:
                self.mouse_pressed = False
            elif event.button == 2 or event.button == 3:  # 中ボタンまたは右クリック
                self.middle_mouse_pressed = False
                print(f"🖱️ ボタン{event.button}離す - パンモード終了")
                
        elif event.type == MOUSEMOTION:
            if self.last_mouse_pos:
                pos = pygame.mouse.get_pos()
                dx = pos[0] - self.last_mouse_pos[0]
                dy = pos[1] - self.last_mouse_pos[1]
                
                if self.mouse_pressed:  # 左ドラッグ - カメラ回転
                    self.camera_rot_y += dx * 0.5
                    self.camera_rot_x = max(-89, min(89, self.camera_rot_x - dy * 0.5))
                    
                elif self.middle_mouse_pressed:  # 中ドラッグ - パン
                    # シンプルなパン移動（画面に対して水平・垂直）
                    pan_speed = 0.02
                    
                    # カメラの右方向ベクトル（水平面）
                    right_x = math.cos(math.radians(self.camera_rot_y + 90))
                    right_z = math.sin(math.radians(self.camera_rot_y + 90))
                    
                    # パン移動（シンプル版）
                    self.camera_target[0] += dx * right_x * pan_speed
                    self.camera_target[1] += dy * pan_speed  # Y軸は単純に上下
                    self.camera_target[2] += dx * right_z * pan_speed
                    
                    print(f"パン移動: target=({self.camera_target[0]:.2f}, {self.camera_target[1]:.2f}, {self.camera_target[2]:.2f})")
                
                self.last_mouse_pos = pos
                
    def save_screenshot(self):
        """スクリーンショットを保存"""
        timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
        filename = f"tsumiki_toon_{timestamp}.png"
        self.save_screenshot_with_filename(filename)
        
    def save_screenshot_with_filename(self, filename):
        """指定されたファイル名でスクリーンショットを保存"""
        # OpenGLのピクセルデータを取得
        pixels = glReadPixels(0, 0, self.width, self.height, GL_RGB, GL_UNSIGNED_BYTE)
        
        # PILイメージに変換
        image = Image.frombytes('RGB', (self.width, self.height), pixels)
        image = image.transpose(Image.FLIP_TOP_BOTTOM)
        
        # 保存
        image.save(filename)
        print(f"スクリーンショットを保存しました: {filename}")
    
    def save_all_patterns_for_block_count(self, num_blocks: int):
        """指定ブロック数の全パターンを連番で保存"""
        anchor = self.get_current_anchor()
        cache_key = (num_blocks, anchor)
        
        # キャッシュになければ全パターンを列挙
        if cache_key not in self.pattern_cache:
            print(f"🔄 {num_blocks}ブロックの全パターンを列挙中...")
            patterns = enumerate_all_valid_patterns(num_blocks, PROC_GRID_SIZE, anchor)
            self.pattern_cache[cache_key] = patterns
            print(f"✅ {len(patterns)}個の有効パターンを発見")
        
        patterns = self.pattern_cache[cache_key]
        if not patterns:
            print(f"⚠️ {num_blocks}ブロックの有効パターンがありません")
            return
        
        print(f"\n📸 {num_blocks}ブロックの全{len(patterns)}パターンを保存開始...")
        
        # 各パターンを描画して保存
        colors = [
            (0.98, 0.94, 0.88, 1),  # クリーム色
            (0.9, 0.8, 0.8, 1),     # 薄いピンク
            (0.8, 0.9, 0.8, 1),     # 薄い緑
            (0.8, 0.8, 0.9, 1),     # 薄い青
        ]
        
        for i, pattern in enumerate(patterns):
            # パターンごとに異なる色を使用
            color = colors[i % len(colors)]
            
            # パターンを適用（色付き）
            self.clear_grid()
            for x, y, z in pattern:
                self.set_block(x, y, z, color)
            self.grid_to_blocks()
            
            # レンダリング
            self.render()
            
            # バッファを確実にフラッシュ
            glFinish()
            pygame.display.flip()
            
            # ファイル名を生成（3桁ゼロパディング）
            filename = f"block{num_blocks}_{i:03d}.jpg"
            
            # スクリーンショット保存
            pixels = glReadPixels(0, 0, self.width, self.height, GL_RGB, GL_UNSIGNED_BYTE)
            image = Image.frombytes('RGB', (self.width, self.height), pixels)
            image = image.transpose(Image.FLIP_TOP_BOTTOM)
            
            # JPEGで保存（品質95）
            image.save(filename, 'JPEG', quality=95)
            
            print(f"  [{i+1:3d}/{len(patterns):3d}] {filename} - パターン: {pattern}")
        
        print(f"✅ 全{len(patterns)}パターンの保存が完了しました！")
        
        # 保存後はインデックスを0にリセット（次回は最初から）
        self.pattern_indices[num_blocks] = 0
        
            
    def is_connected(self, x, y, z):
        """指定位置が既存のブロックと隣接しているかチェック"""
        if not self.grid:  # 最初のブロックは常にOK
            return True
            
        neighbors = [
            (x+1, y, z), (x-1, y, z),
            (x, y+1, z), (x, y-1, z),
            (x, y, z+1), (x, y, z-1)
        ]
        
        for nx, ny, nz in neighbors:
            if (nx, ny, nz) in self.grid:
                return True
        return False
        
    def get_possible_positions(self):
        """配置可能な位置のリストを取得"""
        if not self.grid:
            return [(0, 0, 0)]  # 最初のブロック
            
        possible = set()
        for (x, y, z) in self.grid.keys():
            # 隣接する6方向の位置をチェック
            neighbors = [
                (x+1, y, z), (x-1, y, z),
                (x, y+1, z), (x, y-1, z),
                (x, y, z+1), (x, y, z-1)
            ]
            for nx, ny, nz in neighbors:
                if (nx, ny, nz) not in self.grid:  # 空の位置
                    # 物理的に不安定でないかチェック（下にサポートがあるか）
                    if ny == 0 or (nx, ny-1, nz) in self.grid:
                        possible.add((nx, ny, nz))
                        
        return list(possible)
        
        
        
            
            
    def start_auto_screenshot_mode(self):
        """オートスクリーンショットモードを開始"""
        self.auto_screenshot_mode = True
        self.screenshot_timer = 0
        self.current_block_count = 2
        self.current_variation_index = 0
        self.screenshot_count = 0
        total_patterns = (self.max_block_count - self.current_block_count + 1) * self.variations_per_block_count
        print("オートスクリーンショットモード開始")
        print(f"ブロック数 {self.current_block_count}-{self.max_block_count}、各{self.variations_per_block_count}バリエーション")
        print(f"全 {total_patterns} パターンを生成予定")
        
    def stop_auto_screenshot_mode(self):
        """オートスクリーンショットモードを停止"""
        self.auto_screenshot_mode = False
        print(f"オートスクリーンショットモード停止 - 合計 {self.screenshot_count} 枚撮影")
        
    def next_auto_screenshot(self):
        """次のオートスクリーンショットを実行"""
        if self.current_block_count > self.max_block_count:
            self.stop_auto_screenshot_mode()
            return
            
        # ランダムにストラテジーと密度を選択
        strategy = random.choice(self.strategies)
        density = random.uniform(0.3, 0.9)
        
        # パターン生成
        if self.generate_fixed_block_pattern(self.current_block_count, strategy, density):
            # スクリーンショット撮影
            timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
            filename = f"auto_{self.screenshot_count:03d}_{self.current_block_count}blocks_v{self.current_variation_index+1}_{timestamp}.png"
            self.save_screenshot_with_filename(filename)
            self.screenshot_count += 1
        
        # 次のバリエーションへ
        self.current_variation_index += 1
        if self.current_variation_index >= self.variations_per_block_count:
            self.current_variation_index = 0
            self.current_block_count += 1
            if self.current_block_count <= self.max_block_count:
                print(f"ブロック数 {self.current_block_count} に移行")
        
        
    def reset_view(self):
        """ビューをリセット"""
        self.camera_distance = 6
        self.camera_rot_x = 30
        self.camera_rot_y = 45
        self.camera_target = [0, 0, 0]
        
    def save_camera_position(self):
        """現在のカメラ位置を保存"""
        self.saved_camera = {
            'distance': self.camera_distance,
            'rot_x': self.camera_rot_x,
            'rot_y': self.camera_rot_y,
            'target': self.camera_target.copy()
        }
        try:
            with open(self.camera_save_file, 'w', encoding='utf-8') as f:
                json.dump(self.saved_camera, f, indent=2, ensure_ascii=False)
            print(f"📸 カメラ位置を保存しました！ (距離={self.camera_distance:.1f}, 回転=({self.camera_rot_x:.1f}°, {self.camera_rot_y:.1f}°))")
        except Exception as e:
            print(f"カメラ保存エラー: {e}")
            
    def load_camera_position(self):
        """保存されたカメラ位置をロード"""
        if self.saved_camera:
            self.camera_distance = self.saved_camera['distance']
            self.camera_rot_x = self.saved_camera['rot_x']
            self.camera_rot_y = self.saved_camera['rot_y']
            self.camera_target = self.saved_camera['target'].copy()
            print(f"📷 カメラ位置をロードしました！")
        else:
            print("💾 保存されたカメラ位置がありません")
            
    def load_saved_camera(self):
        """起動時にカメラ位置を読み込み"""
        try:
            if os.path.exists(self.camera_save_file):
                with open(self.camera_save_file, 'r', encoding='utf-8') as f:
                    self.saved_camera = json.load(f)
                # 読み込んだカメラ位置を実際に適用
                self.camera_distance = self.saved_camera['distance']
                self.camera_rot_x = self.saved_camera['rot_x']
                self.camera_rot_y = self.saved_camera['rot_y']
                self.camera_target = self.saved_camera['target'].copy()
                print(f"💾 前回のカメラ位置を読み込みました (距離={self.camera_distance:.1f}, 回転=({self.camera_rot_x:.1f}°, {self.camera_rot_y:.1f}°))")
            else:
                print("📁 保存されたカメラ位置がありません")
        except Exception as e:
            print(f"カメラ読み込みエラー: {e}")
            self.saved_camera = None
            
        
    def get_current_anchor(self):
        """現在の起点座標を取得"""
        return PROC_ANCHOR_PATTERNS[self.current_anchor_index]
    
    def analyze_block5_composition(self):
        """5ブロックパターンの分解可能性を分析"""
        print("\n🔧 5ブロックパターンの分解分析を開始...")
        
        anchor = self.get_current_anchor()
        
        # 2,3,5ブロックパターンを取得
        patterns2 = self.get_or_generate_patterns(2, anchor)
        patterns3 = self.get_or_generate_patterns(3, anchor)
        patterns5 = self.get_or_generate_patterns(5, anchor)
        
        if not patterns2 or not patterns3 or not patterns5:
            print("⚠️ パターンを取得できませんでした")
            return
        
        # 分析実行
        self.composition_analysis = analyze_composition(patterns5, patterns2, patterns3)
        
        # 統計表示
        total_iv = sum(len(data['IV']) > 0 for data in self.composition_analysis.values())
        total_cv = sum(len(data['CV']) > 0 for data in self.composition_analysis.values())
        
        print(f"\n📋 分析結果:")
        print(f"  2ブロックパターン: {len(patterns2)}個")
        print(f"  3ブロックパターン: {len(patterns3)}個")
        print(f"  5ブロックパターン: {len(patterns5)}個")
        print(f"\n  IV分解可能: {total_iv}/{len(patterns5)} ({100*total_iv/len(patterns5):.1f}%)")
        print(f"  CV分解可能: {total_cv}/{len(patterns5)} ({100*total_cv/len(patterns5):.1f}%)")
        print(f"\n✅ 分析完了！Dキーで詳細をダンプできます")
    
    def get_or_generate_patterns(self, num_blocks: int, anchor: Pos) -> List[List[Pos]]:
        """キャッシュからパターンを取得または生成"""
        cache_key = (num_blocks, anchor)
        if cache_key not in self.pattern_cache:
            patterns = enumerate_all_valid_patterns(num_blocks, PROC_GRID_SIZE, anchor)
            self.pattern_cache[cache_key] = patterns
        return self.pattern_cache[cache_key]
    
    def dump_composition_for_blocks(self, target_blocks: int):
        """指定ブロック数の分解分析をダンプ"""
        anchor = self.get_current_anchor()
        
        # 各ブロック数ごとの分解パターン定義
        decomp_patterns = {
            3: [(1,2)],           # 3 = 1+2
            4: [(1,3), (2,2)],    # 4 = 1+3, 2+2
            5: [(1,4), (2,3)],    # 5 = 1+4, 2+3
            6: [(1,5), (2,4), (3,3)],  # 6 = 1+5, 2+4, 3+3
            7: [(1,6), (2,5), (3,4)],  # 7 = 1+6, 2+5, 3+4
            8: [(1,7), (2,6), (3,5), (4,4)],  # 8 = 1+7, 2+6, 3+5, 4+4
            9: [(1,8), (2,7), (3,6), (4,5)]   # 9 = 1+8, 2+7, 3+6, 4+5
        }
        
        if target_blocks not in decomp_patterns:
            print(f"⚠️ {target_blocks}ブロックの分解分析はサポートされていません")
            return
        
        print(f"\n🔧 {target_blocks}ブロックの分解分析を実行中...")
        self.dump_decomposition_simple(target_blocks, decomp_patterns[target_blocks], anchor)
        print(f"✅ {target_blocks}ブロックの分析完了！")
    
    def dump_decomposition_simple(self, target_blocks: int, decomp_pairs: List[tuple], anchor: Pos):
        """指定ブロック数の分解をシンプルフォーマットで出力"""
        
        filename = f"block{target_blocks}_decomp.txt"
        all_decomp_lines = []
        
        for n1, n2 in decomp_pairs:
            # パターンを取得
            patterns_target = self.get_or_generate_patterns(target_blocks, anchor)
            patterns_n1 = self.get_or_generate_patterns(n1, anchor)
            patterns_n2 = self.get_or_generate_patterns(n2, anchor)
            
            if not patterns_target or not patterns_n1 or not patterns_n2:
                print(f"⚠️ {target_blocks}ブロック ({n1}+{n2}) のパターン取得失敗")
                continue
            
            # 分析実行
            analysis = self.analyze_decomposition_simple(patterns_target, patterns_n1, patterns_n2, n1, n2)
            
            # IV分解を収集
            for i, decomps in analysis['IV'].items():
                for d in decomps:
                    all_decomp_lines.append(f"block{target_blocks}_{i:03d}, block{n1}_{d[0]:03d}, block{n2}_{d[1]:03d}")
        
        # ファイルに出力
        with open(filename, 'w', encoding='utf-8') as f:
            f.write(f"{len(all_decomp_lines)}\n")
            for line in all_decomp_lines:
                f.write(line + "\n")
        
        print(f"  {filename}: {len(all_decomp_lines)}個のIV分解")
    
    def analyze_decomposition_simple(self, patterns_target, patterns_n1, patterns_n2, n1, n2):
        """シンプルな分解分析（n1+n2への分解）"""
        # 正規化セットを作成
        canon_n1 = {canon_hash(p) for p in patterns_n1}
        canon_n2 = {canon_hash(p) for p in patterns_n2}
        
        # インデックス逆引き
        lookup_n1 = {}
        for i, p in enumerate(patterns_n1):
            h = canon_hash(p)
            if h not in lookup_n1:
                lookup_n1[h] = []
            lookup_n1[h].append(i)
        
        lookup_n2 = {}
        for i, p in enumerate(patterns_n2):
            h = canon_hash(p)
            if h not in lookup_n2:
                lookup_n2[h] = []
            lookup_n2[h].append(i)
        
        result = {'IV': {}, 'CV': {}}
        
        for i, pattern in enumerate(patterns_target):
            iv_decomps = []
            
            # 全部分集合を試す
            for subset_n1 in combinations(pattern, n1):
                subset_n2 = [p for p in pattern if p not in subset_n1]
                
                # サイズチェック
                if len(subset_n2) != n2:
                    continue
                
                # 正規化ハッシュ
                h1 = canon_hash(list(subset_n1))
                h2 = canon_hash(subset_n2)
                
                # パターンマッチ
                if h1 in canon_n1 and h2 in canon_n2:
                    # IVチェック（連結＋サポート）
                    if (is_connected_set(set(subset_n1)) and is_connected_set(set(subset_n2)) and
                        supports_ok(set(subset_n1)) and supports_ok(set(subset_n2))):
                        
                        # インデックスを取得
                        for idx1 in lookup_n1.get(h1, []):
                            for idx2 in lookup_n2.get(h2, []):
                                iv_decomps.append((idx1, idx2))
            
            if iv_decomps:
                result['IV'][i] = iv_decomps
        
        return result
    
    def get_next_pattern_sequential(self, num_blocks: int):
        """指定ブロック数の次のパターンを順番に取得"""
        anchor = self.get_current_anchor()
        cache_key = (num_blocks, anchor)
        
        # キャッシュになければ全パターンを列挙
        if cache_key not in self.pattern_cache:
            print(f"🔄 {num_blocks}ブロックの全パターンを列挙中...")
            patterns = enumerate_all_valid_patterns(num_blocks, PROC_GRID_SIZE, anchor)
            self.pattern_cache[cache_key] = patterns
            print(f"✅ {len(patterns)}個の有効パターンを発見")
            
            # インデックスを初期化
            if num_blocks not in self.pattern_indices:
                self.pattern_indices[num_blocks] = 0
        
        patterns = self.pattern_cache[cache_key]
        if not patterns:
            print(f"⚠️ {num_blocks}ブロックの有効パターンがありません")
            return None
        
        # 現在のインデックスを取得
        if num_blocks not in self.pattern_indices:
            self.pattern_indices[num_blocks] = 0
        
        current_index = self.pattern_indices[num_blocks]
        pattern = patterns[current_index]
        
        # インデックスを進める（ループ）
        self.pattern_indices[num_blocks] = (current_index + 1) % len(patterns)
        
        print(f"🎲 パターン {current_index + 1}/{len(patterns)} (ブロック数: {num_blocks})")
        return pattern
    
    def apply_pattern(self, pattern: List[Pos]):
        """パターンをグリッドに適用"""
        if pattern is None:
            return False
            
        self.clear_grid()
        cream_color = (0.98, 0.94, 0.88, 1)
        
        for x, y, z in pattern:
            self.set_block(x, y, z, cream_color)
        
        self.grid_to_blocks()
        print(f"DEBUG: パターン適用後のグリッド = {list(self.grid.keys())}, ブロック数 = {len(self.blocks)}")
        return True
        
    def run(self):
        """メインループ"""
        self.init_pygame()
        
        clock = pygame.time.Clock()
        running = True
        
        print("\n=== Tsumiki Toon Viewer ===")
        print("操作方法 (Mayaライク):")
        print("  左ドラッグ: カメラ回転")
        print("  中ドラッグ: パン（視点移動）")
        print("  マウスホイール: ズーム")
        print("  S: スクリーンショット保存")
        print("  R: ビューリセット")
        print("  1-9: 指定ブロック数で順番に全パターン表示")
        print("  Shift+1-9: 指定ブロック数の全パターンを連番保存")
        print("  Alt+3-9: 指定ブロック数の分解パターンをダンプ")
        print("  D: 5ブロックパターンの分析表示")
        print("  O: オートスクリーンショットモード開始/停止")
        print("  T: テクスチャON/OFF切り替え")
        print("  C: カメラ位置保存")
        print("  V: カメラ位置ロード")
        print("  Q: 終了")
        print("=" * 30)
        
        # 初期起点を表示
        anchor_names = ["手前左下", "手前右下", "奥左下", "奥右下"]
        current_anchor = self.get_current_anchor()
        print(f"🎯 現在の起点: {anchor_names[self.current_anchor_index]} {current_anchor}")
        
        while running:
            for event in pygame.event.get():
                if event.type == QUIT:
                    running = False
                elif event.type == KEYDOWN:
                    if event.key == K_q or event.key == K_ESCAPE:
                        running = False
                    elif event.key == K_s:
                        self.save_screenshot()
                    elif event.key == K_r:
                        self.reset_view()
                    elif event.key == K_o:
                        if self.auto_screenshot_mode:
                            self.stop_auto_screenshot_mode()
                        else:
                            self.start_auto_screenshot_mode()
                    elif event.key == K_t:
                        self.use_texture = not self.use_texture
                        print(f"テクスチャ: {'ON' if self.use_texture else 'OFF'}")
                    elif event.key == K_c:
                        self.save_camera_position()  # Cキー = 保存
                    elif event.key == K_v:
                        self.load_camera_position()  # Vキー = ロード（復元）
                    elif event.key == K_d:
                        # Alt+3-9 で各ブロックの分解分析をダンプ
                        mods = pygame.key.get_mods()
                        if mods & KMOD_ALT:
                            # Altキーが押されている場合はスキップ
                            pass
                        elif mods & KMOD_SHIFT:
                            # Shift+D = 5ブロックのみダンプ（互換性のため）
                            self.dump_composition_for_blocks(5)
                        else:
                            self.analyze_block5_composition()  # D = 5ブロック分析
                    elif event.key >= K_1 and event.key <= K_9:
                        block_count = event.key - K_0
                        mods = pygame.key.get_mods()
                        
                        if mods & KMOD_ALT:
                            # Alt+3-9: 分解分析をダンプ
                            if block_count >= 3:
                                self.dump_composition_for_blocks(block_count)
                            else:
                                print(f"⚠️ {block_count}ブロックは分解分析対象外です")
                        elif mods & KMOD_SHIFT:
                            # Shift+1-9: 全パターン保存
                            self.save_all_patterns_for_block_count(block_count)
                        else:
                            # 1-9: パターン表示
                            pattern = self.get_next_pattern_sequential(block_count)
                            self.apply_pattern(pattern)
                else:
                    self.handle_mouse(event)
            
            # オートスクリーンショットのタイマー処理
            dt = clock.get_time() / 1000.0  # デルタタイム（秒）
            if self.auto_screenshot_mode:
                self.screenshot_timer += dt
                if self.screenshot_timer >= self.screenshot_interval:
                    self.next_auto_screenshot()
                    self.screenshot_timer = 0
                    
            self.render()
            clock.tick(60)
            
        pygame.quit()


if __name__ == "__main__":
    viewer = TsumikiToonViewer()
    viewer.run()