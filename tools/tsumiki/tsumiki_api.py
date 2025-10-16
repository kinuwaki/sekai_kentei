#!/usr/bin/env python3
"""
Tsumiki API - 積み木レンダリングツールのPython API
"""

from tsumiki_moderngl import TsumikiRenderer
import numpy as np


class Tsumiki:
    """積み木レンダリングAPI"""
    
    def __init__(self, width=800, height=600):
        """
        Args:
            width: 出力画像の幅
            height: 出力画像の高さ
        """
        self.renderer = TsumikiRenderer(width, height)
        self.renderer.initialize()
        
    def add_block(self, x=0, y=0, z=0, width=1, height=1, depth=1, 
                  rot_x=0, rot_y=0, rot_z=0):
        """
        積み木ブロックを追加
        
        Args:
            x, y, z: ブロックの位置
            width, height, depth: ブロックのサイズ
            rot_x, rot_y, rot_z: 各軸の回転角度（度）
        """
        self.renderer.add_block(
            position=[x, y, z],
            size=[width, height, depth],
            rotation=[rot_x, rot_y, rot_z]
        )
        return self
        
    def add_tower(self, x=0, z=0, blocks=3, base_size=1.5, shrink_factor=0.8):
        """
        積み木のタワーを追加
        
        Args:
            x, z: タワーの位置
            blocks: ブロック数
            base_size: 最下段のサイズ
            shrink_factor: 上段に行くごとのサイズ縮小率
        """
        y = 0
        size = base_size
        for i in range(blocks):
            height = 0.3 + i * 0.1
            self.add_block(x, y, z, size, height, size, rot_y=i*30)
            y += height
            size *= shrink_factor
        return self
        
    def add_bridge(self, start_x=-2, end_x=2, y=1, z=0):
        """
        橋のような構造を追加
        
        Args:
            start_x, end_x: 橋の開始と終了位置
            y: 高さ
            z: Z位置
        """
        # 支柱
        self.add_block(start_x, 0, z, 0.5, y+0.5, 0.5)
        self.add_block(end_x, 0, z, 0.5, y+0.5, 0.5)
        
        # 橋板
        bridge_width = abs(end_x - start_x)
        center_x = (start_x + end_x) / 2
        self.add_block(center_x, y, z, bridge_width, 0.3, 1)
        
        return self
        
    def add_stairs(self, x=0, z=0, steps=4, step_height=0.3, step_depth=0.5):
        """
        階段を追加
        
        Args:
            x, z: 階段の開始位置
            steps: 段数
            step_height: 各段の高さ
            step_depth: 各段の奥行き
        """
        for i in range(steps):
            y = i * step_height
            current_x = x + i * step_depth
            self.add_block(current_x, y, z, step_depth, step_height, 1)
        return self
        
    def add_arch(self, x=0, y=0, z=0, width=2, height=2):
        """
        アーチ構造を追加
        
        Args:
            x, y, z: アーチの中心位置
            width: アーチの幅
            height: アーチの高さ
        """
        # 左柱
        self.add_block(x - width/2, y, z, 0.4, height * 0.7, 0.5)
        # 右柱
        self.add_block(x + width/2, y, z, 0.4, height * 0.7, 0.5)
        # 上部
        self.add_block(x, y + height * 0.7, z, width + 0.4, height * 0.3, 0.5)
        # アーチ装飾
        self.add_block(x, y + height * 0.85, z, width * 0.7, height * 0.15, 0.5, rot_z=45)
        
        return self
        
    def add_pyramid(self, x=0, z=0, levels=4, base_size=2):
        """
        ピラミッド構造を追加
        
        Args:
            x, z: ピラミッドの中心位置
            levels: 段数
            base_size: 最下段のサイズ
        """
        y = 0
        for i in range(levels):
            size = base_size * (1 - i / levels)
            height = 0.3
            self.add_block(x, y, z, size, height, size)
            y += height
        return self
        
    def clear(self):
        """すべてのブロックをクリア"""
        self.renderer.blocks = []
        return self
        
    def render(self, filename="tsumiki.png"):
        """
        シーンをレンダリングしてPNGファイルに保存
        
        Args:
            filename: 出力ファイル名
            
        Returns:
            出力ファイルパス
        """
        return self.renderer.render_to_png(filename)
        
    def demo_scene(self):
        """デモシーンをセットアップ"""
        self.clear()
        
        # タワー
        self.add_tower(x=-2, z=0, blocks=4)
        
        # 橋
        self.add_bridge(start_x=-1, end_x=1, y=0.5, z=-1)
        
        # 階段
        self.add_stairs(x=1, z=1, steps=3)
        
        # アーチ
        self.add_arch(x=0, y=0, z=2, width=1.5, height=1.5)
        
        # 散らばったブロック
        self.add_block(2, 0, -1, 0.6, 0.4, 0.6, rot_y=30)
        self.add_block(-1.5, 0, 1.5, 0.5, 0.5, 0.5, rot_y=45)
        
        return self


# 簡単な使用例
if __name__ == "__main__":
    # 基本的な使用方法
    tsumiki = Tsumiki(width=1024, height=768)
    
    # デモシーンを作成
    tsumiki.demo_scene()
    
    # レンダリング
    output_file = tsumiki.render("demo_api.png")
    print(f"レンダリング完了: {output_file}")
    
    # カスタムシーン例
    tsumiki2 = Tsumiki()
    tsumiki2.clear()
    
    # ピラミッドとタワーの組み合わせ
    tsumiki2.add_pyramid(x=-1.5, z=0, levels=5, base_size=2)
    tsumiki2.add_tower(x=1.5, z=0, blocks=6, base_size=1, shrink_factor=0.9)
    
    # 周りに小さなブロック
    for i in range(5):
        angle = i * 72  # 5つを円状に配置
        x = np.cos(np.radians(angle)) * 3
        z = np.sin(np.radians(angle)) * 3
        tsumiki2.add_block(x, 0, z, 0.4, 0.3, 0.4, rot_y=angle)
    
    tsumiki2.render("custom_scene.png")
    print("カスタムシーンレンダリング完了: custom_scene.png")