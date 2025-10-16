#!/usr/bin/env python3
"""
Tsumiki - 積み木レンダリングツール
OpenGLを使用して積み木を木目テクスチャ付きでレンダリングし、
トゥーンシェーディングと輪郭線付きでPNG出力します。
"""

import sys
import os
import numpy as np
from OpenGL.GL import *
from OpenGL.GLU import *
from OpenGL.GLUT import *
from PIL import Image
import math
import argparse


class TsumikiRenderer:
    def __init__(self, width=800, height=600):
        self.width = width
        self.height = height
        self.blocks = []
        self.wood_texture_id = None
        self.framebuffer = None
        self.color_texture = None
        self.depth_texture = None
        self.normal_texture = None
        
    def initialize(self):
        """OpenGL初期化"""
        glutInit(sys.argv)
        glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA | GLUT_DEPTH)
        glutInitWindowSize(self.width, self.height)
        glutCreateWindow(b"Tsumiki Renderer")
        
        glEnable(GL_DEPTH_TEST)
        glEnable(GL_LIGHTING)
        glEnable(GL_LIGHT0)
        glEnable(GL_NORMALIZE)
        glEnable(GL_TEXTURE_2D)
        
        # アルファブレンディング設定
        glEnable(GL_BLEND)
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
        
        # 背景を透明に
        glClearColor(0.0, 0.0, 0.0, 0.0)
        
        # フレームバッファの設定
        self.setup_framebuffer()
        
        # 木目テクスチャの生成
        self.generate_wood_texture()
        
        # ライティング設定
        self.setup_lighting()
        
    def setup_framebuffer(self):
        """オフスクリーンレンダリング用フレームバッファ設定"""
        # フレームバッファオブジェクト作成
        self.framebuffer = glGenFramebuffers(1)
        glBindFramebuffer(GL_FRAMEBUFFER, self.framebuffer)
        
        # カラーテクスチャ
        self.color_texture = glGenTextures(1)
        glBindTexture(GL_TEXTURE_2D, self.color_texture)
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, self.width, self.height, 
                     0, GL_RGBA, GL_UNSIGNED_BYTE, None)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
        glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, 
                               GL_TEXTURE_2D, self.color_texture, 0)
        
        # 深度テクスチャ
        self.depth_texture = glGenTextures(1)
        glBindTexture(GL_TEXTURE_2D, self.depth_texture)
        glTexImage2D(GL_TEXTURE_2D, 0, GL_DEPTH_COMPONENT24, self.width, self.height,
                     0, GL_DEPTH_COMPONENT, GL_FLOAT, None)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
        glFramebufferTexture2D(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT,
                               GL_TEXTURE_2D, self.depth_texture, 0)
        
        # 法線テクスチャ（エッジ検出用）
        self.normal_texture = glGenTextures(1)
        glBindTexture(GL_TEXTURE_2D, self.normal_texture)
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA32F, self.width, self.height,
                     0, GL_RGBA, GL_FLOAT, None)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
        glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT1,
                               GL_TEXTURE_2D, self.normal_texture, 0)
        
        glBindFramebuffer(GL_FRAMEBUFFER, 0)
        
    def generate_wood_texture(self):
        """木目テクスチャを生成"""
        width, height = 512, 512
        texture_data = np.zeros((height, width, 3), dtype=np.uint8)
        
        # 基本色
        base_color = np.array([139, 69, 19])  # 茶色
        light_color = np.array([205, 133, 63])  # 明るい茶色
        
        # 木目パターン生成
        for y in range(height):
            for x in range(width):
                # シンプルな木目パターン（サイン波を使用）
                pattern = math.sin(x * 0.05) * 0.5 + 0.5
                pattern += math.sin((x + y) * 0.02) * 0.3
                pattern = max(0, min(1, pattern))
                
                # ノイズを追加
                noise = np.random.random() * 0.1
                pattern = pattern * (1 - noise) + noise
                
                # 色を補間
                color = base_color * (1 - pattern) + light_color * pattern
                texture_data[y, x] = color.astype(np.uint8)
        
        # OpenGLテクスチャとして設定
        self.wood_texture_id = glGenTextures(1)
        glBindTexture(GL_TEXTURE_2D, self.wood_texture_id)
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, 
                     GL_RGB, GL_UNSIGNED_BYTE, texture_data)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT)
        
    def setup_lighting(self):
        """ライティング設定"""
        # ライト位置
        light_position = [5.0, 10.0, 5.0, 1.0]
        glLightfv(GL_LIGHT0, GL_POSITION, light_position)
        
        # ライト色
        ambient = [0.3, 0.3, 0.3, 1.0]
        diffuse = [0.8, 0.8, 0.8, 1.0]
        specular = [1.0, 1.0, 1.0, 1.0]
        
        glLightfv(GL_LIGHT0, GL_AMBIENT, ambient)
        glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuse)
        glLightfv(GL_LIGHT0, GL_SPECULAR, specular)
        
    def add_block(self, position, size=(1, 1, 1), rotation=(0, 0, 0)):
        """積み木ブロックを追加"""
        self.blocks.append({
            'position': position,
            'size': size,
            'rotation': rotation
        })
        
    def draw_block(self, block):
        """個別のブロックを描画"""
        glPushMatrix()
        
        # 位置と回転を適用
        glTranslatef(*block['position'])
        glRotatef(block['rotation'][0], 1, 0, 0)
        glRotatef(block['rotation'][1], 0, 1, 0)
        glRotatef(block['rotation'][2], 0, 0, 1)
        
        # スケール適用
        glScalef(*block['size'])
        
        # テクスチャバインド
        glBindTexture(GL_TEXTURE_2D, self.wood_texture_id)
        
        # キューブを描画（各面にテクスチャ座標を設定）
        self.draw_textured_cube()
        
        glPopMatrix()
        
    def draw_textured_cube(self):
        """テクスチャ付きキューブを描画"""
        vertices = [
            # 前面
            [[-0.5, -0.5, 0.5], [0.5, -0.5, 0.5], [0.5, 0.5, 0.5], [-0.5, 0.5, 0.5]],
            # 背面
            [[-0.5, -0.5, -0.5], [-0.5, 0.5, -0.5], [0.5, 0.5, -0.5], [0.5, -0.5, -0.5]],
            # 上面
            [[-0.5, 0.5, -0.5], [-0.5, 0.5, 0.5], [0.5, 0.5, 0.5], [0.5, 0.5, -0.5]],
            # 下面
            [[-0.5, -0.5, -0.5], [0.5, -0.5, -0.5], [0.5, -0.5, 0.5], [-0.5, -0.5, 0.5]],
            # 右面
            [[0.5, -0.5, -0.5], [0.5, 0.5, -0.5], [0.5, 0.5, 0.5], [0.5, -0.5, 0.5]],
            # 左面
            [[-0.5, -0.5, -0.5], [-0.5, -0.5, 0.5], [-0.5, 0.5, 0.5], [-0.5, 0.5, -0.5]]
        ]
        
        normals = [
            [0, 0, 1],   # 前
            [0, 0, -1],  # 後
            [0, 1, 0],   # 上
            [0, -1, 0],  # 下
            [1, 0, 0],   # 右
            [-1, 0, 0]   # 左
        ]
        
        tex_coords = [[0, 0], [1, 0], [1, 1], [0, 1]]
        
        for i, face in enumerate(vertices):
            glBegin(GL_QUADS)
            glNormal3fv(normals[i])
            for j, vertex in enumerate(face):
                glTexCoord2fv(tex_coords[j])
                glVertex3fv(vertex)
            glEnd()
            
    def apply_toon_shading(self, image):
        """トゥーンシェーディングを適用"""
        # PILイメージをnumpy配列に変換
        img_array = np.array(image)
        
        # 明度を計算
        gray = np.dot(img_array[..., :3], [0.2989, 0.5870, 0.1140])
        
        # 階調を減らす（セルシェーディング効果）
        levels = 4
        gray_quantized = np.floor(gray * levels) / levels
        
        # カラーに戻す
        for i in range(3):
            img_array[..., i] = (img_array[..., i] / 255.0 * gray_quantized * 255).astype(np.uint8)
            
        return Image.fromarray(img_array)
        
    def detect_edges(self, image):
        """エッジ検出と輪郭線の描画"""
        img_array = np.array(image)
        gray = np.dot(img_array[..., :3], [0.2989, 0.5870, 0.1140])
        
        # Sobelフィルタでエッジ検出
        sobel_x = np.array([[-1, 0, 1], [-2, 0, 2], [-1, 0, 1]])
        sobel_y = np.array([[-1, -2, -1], [0, 0, 0], [1, 2, 1]])
        
        # 簡易的なエッジ検出（実際はscipy.ndimageを使うべきだが、依存を減らすため簡易実装）
        edges = np.zeros_like(gray)
        for y in range(1, gray.shape[0] - 1):
            for x in range(1, gray.shape[1] - 1):
                gx = np.sum(sobel_x * gray[y-1:y+2, x-1:x+2])
                gy = np.sum(sobel_y * gray[y-1:y+2, x-1:x+2])
                edges[y, x] = np.sqrt(gx**2 + gy**2)
                
        # 閾値処理
        threshold = 50
        edges = (edges > threshold) * 255
        
        # エッジを黒い線として描画
        for y in range(img_array.shape[0]):
            for x in range(img_array.shape[1]):
                if edges[y, x] > 0:
                    img_array[y, x, :3] = [0, 0, 0]  # 黒
                    
        return Image.fromarray(img_array)
        
    def render_to_png(self, filename):
        """シーンをレンダリングしてPNGファイルに保存"""
        # フレームバッファにレンダリング
        glBindFramebuffer(GL_FRAMEBUFFER, self.framebuffer)
        glViewport(0, 0, self.width, self.height)
        
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
        
        # カメラ設定
        glMatrixMode(GL_PROJECTION)
        glLoadIdentity()
        gluPerspective(45.0, float(self.width) / float(self.height), 0.1, 100.0)
        
        glMatrixMode(GL_MODELVIEW)
        glLoadIdentity()
        gluLookAt(5, 5, 5,  # カメラ位置
                  0, 0, 0,  # 注視点
                  0, 1, 0)  # 上方向
        
        # ブロックを描画
        for block in self.blocks:
            self.draw_block(block)
            
        # ピクセルデータを読み取り
        glReadBuffer(GL_COLOR_ATTACHMENT0)
        pixels = glReadPixels(0, 0, self.width, self.height, GL_RGBA, GL_UNSIGNED_BYTE)
        
        # PILイメージに変換
        image = Image.frombytes("RGBA", (self.width, self.height), pixels)
        image = image.transpose(Image.FLIP_TOP_BOTTOM)
        
        # トゥーンシェーディング適用
        image = self.apply_toon_shading(image)
        
        # エッジ検出と輪郭線描画
        image = self.detect_edges(image)
        
        # PNG保存
        image.save(filename, "PNG")
        
        glBindFramebuffer(GL_FRAMEBUFFER, 0)
        
        return filename


def main():
    parser = argparse.ArgumentParser(description='Tsumiki - 積み木レンダリングツール')
    parser.add_argument('-o', '--output', default='tsumiki_output.png',
                        help='出力ファイル名 (default: tsumiki_output.png)')
    parser.add_argument('-w', '--width', type=int, default=800,
                        help='画像幅 (default: 800)')
    parser.add_argument('-h', '--height', type=int, default=600,
                        help='画像高さ (default: 600)')
    parser.add_argument('--demo', action='store_true',
                        help='デモシーンをレンダリング')
    
    args = parser.parse_args()
    
    # レンダラー初期化
    renderer = TsumikiRenderer(args.width, args.height)
    renderer.initialize()
    
    if args.demo:
        # デモシーン：積み木をいくつか配置
        renderer.add_block(position=[0, 0, 0], size=[2, 0.5, 1])
        renderer.add_block(position=[0, 0.5, 0], size=[1.5, 0.5, 0.8], rotation=[0, 45, 0])
        renderer.add_block(position=[0, 1, 0], size=[1, 0.5, 0.6], rotation=[0, 90, 0])
        renderer.add_block(position=[1, 0, 0.5], size=[0.5, 1, 0.5])
        renderer.add_block(position=[-1, 0, -0.5], size=[0.5, 0.8, 0.5])
    
    # レンダリングとPNG出力
    output_file = renderer.render_to_png(args.output)
    print(f"レンダリング完了: {output_file}")
    

if __name__ == "__main__":
    main()