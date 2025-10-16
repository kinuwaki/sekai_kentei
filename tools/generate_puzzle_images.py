#!/usr/bin/env python3
"""
パズルゲーム用のサンプル画像を生成
縦長（1024x1536）の画像を作成
"""

from PIL import Image, ImageDraw, ImageFont
import os
import random

def generate_puzzle_image(index, output_dir):
    """パズル用画像を生成"""
    width = 1024
    height = 1536
    
    # カラフルな背景色のリスト
    backgrounds = [
        ((255, 182, 193), (255, 105, 180)),  # ピンク系グラデーション
        ((135, 206, 250), (70, 130, 180)),   # ブルー系グラデーション
        ((152, 251, 152), (34, 139, 34)),    # グリーン系グラデーション
        ((255, 255, 224), (255, 215, 0)),    # イエロー系グラデーション
        ((255, 218, 185), (255, 140, 0)),    # オレンジ系グラデーション
        ((221, 160, 221), (186, 85, 211)),   # パープル系グラデーション
    ]
    
    # 画像作成
    img = Image.new('RGB', (width, height))
    draw = ImageDraw.Draw(img)
    
    # グラデーション背景を描画
    color1, color2 = backgrounds[index % len(backgrounds)]
    for y in range(height):
        ratio = y / height
        r = int(color1[0] * (1 - ratio) + color2[0] * ratio)
        g = int(color1[1] * (1 - ratio) + color2[1] * ratio)
        b = int(color1[2] * (1 - ratio) + color2[2] * ratio)
        draw.rectangle([(0, y), (width, y+1)], fill=(r, g, b))
    
    # 動物や物のシンプルな絵を描く
    shapes = [
        draw_bear,
        draw_car,
        draw_house,
        draw_tree,
        draw_sun,
        draw_flower,
    ]
    
    shapes[index % len(shapes)](draw, width, height)
    
    # ファイル名を0000形式で保存
    filename = f"{index:04d}.jpg"
    filepath = os.path.join(output_dir, filename)
    img.save(filepath, 'JPEG', quality=90)
    print(f"Generated: {filepath}")

def draw_bear(draw, width, height):
    """クマの絵を描く"""
    # 体
    draw.ellipse([width//2-200, height//2, width//2+200, height//2+400], 
                 fill=(139, 69, 19), outline=(101, 67, 33), width=5)
    
    # 頭
    draw.ellipse([width//2-150, height//2-200, width//2+150, height//2+100], 
                 fill=(160, 82, 45), outline=(101, 67, 33), width=5)
    
    # 耳
    draw.ellipse([width//2-150, height//2-180, width//2-50, height//2-80], 
                 fill=(160, 82, 45), outline=(101, 67, 33), width=3)
    draw.ellipse([width//2+50, height//2-180, width//2+150, height//2-80], 
                 fill=(160, 82, 45), outline=(101, 67, 33), width=3)
    
    # 目
    draw.ellipse([width//2-60, height//2-80, width//2-20, height//2-40], 
                 fill=(0, 0, 0))
    draw.ellipse([width//2+20, height//2-80, width//2+60, height//2-40], 
                 fill=(0, 0, 0))
    
    # 鼻
    draw.ellipse([width//2-20, height//2-20, width//2+20, height//2+20], 
                 fill=(0, 0, 0))

def draw_car(draw, width, height):
    """車の絵を描く"""
    # 車体
    draw.rectangle([width//2-250, height//2-50, width//2+250, height//2+150], 
                   fill=(255, 0, 0), outline=(139, 0, 0), width=5)
    
    # 窓
    draw.rectangle([width//2-200, height//2-100, width//2+50, height//2-50], 
                   fill=(135, 206, 250), outline=(0, 0, 139), width=3)
    
    # タイヤ
    draw.ellipse([width//2-200, height//2+100, width//2-100, height//2+200], 
                 fill=(0, 0, 0))
    draw.ellipse([width//2+100, height//2+100, width//2+200, height//2+200], 
                 fill=(0, 0, 0))

def draw_house(draw, width, height):
    """家の絵を描く"""
    # 壁
    draw.rectangle([width//2-200, height//2, width//2+200, height//2+300], 
                   fill=(255, 228, 196), outline=(139, 69, 19), width=5)
    
    # 屋根
    draw.polygon([(width//2-250, height//2), (width//2, height//2-200), 
                  (width//2+250, height//2)], 
                 fill=(178, 34, 34), outline=(139, 0, 0), width=5)
    
    # ドア
    draw.rectangle([width//2-50, height//2+150, width//2+50, height//2+300], 
                   fill=(139, 69, 19), outline=(101, 67, 33), width=3)
    
    # 窓
    draw.rectangle([width//2-150, height//2+50, width//2-80, height//2+120], 
                   fill=(135, 206, 250), outline=(0, 0, 139), width=3)
    draw.rectangle([width//2+80, height//2+50, width//2+150, height//2+120], 
                   fill=(135, 206, 250), outline=(0, 0, 139), width=3)

def draw_tree(draw, width, height):
    """木の絵を描く"""
    # 幹
    draw.rectangle([width//2-50, height//2+100, width//2+50, height//2+400], 
                   fill=(139, 69, 19), outline=(101, 67, 33), width=3)
    
    # 葉っぱ（3段）
    draw.ellipse([width//2-200, height//2-200, width//2+200, height//2+200], 
                 fill=(34, 139, 34), outline=(0, 100, 0), width=5)
    
def draw_sun(draw, width, height):
    """太陽の絵を描く"""
    # 太陽本体
    draw.ellipse([width//2-150, height//2-150, width//2+150, height//2+150], 
                 fill=(255, 215, 0), outline=(255, 140, 0), width=5)
    
    # 光線
    for angle in range(0, 360, 30):
        import math
        rad = math.radians(angle)
        x1 = width//2 + 180 * math.cos(rad)
        y1 = height//2 + 180 * math.sin(rad)
        x2 = width//2 + 250 * math.cos(rad)
        y2 = height//2 + 250 * math.sin(rad)
        draw.line([(x1, y1), (x2, y2)], fill=(255, 215, 0), width=10)
    
    # 顔
    draw.ellipse([width//2-40, height//2-60, width//2-10, height//2-30], 
                 fill=(0, 0, 0))
    draw.ellipse([width//2+10, height//2-60, width//2+40, height//2-30], 
                 fill=(0, 0, 0))
    draw.arc([width//2-60, height//2-20, width//2+60, height//2+60], 
             start=0, end=180, fill=(0, 0, 0), width=5)

def draw_flower(draw, width, height):
    """花の絵を描く"""
    # 茎
    draw.rectangle([width//2-10, height//2+100, width//2+10, height//2+400], 
                   fill=(34, 139, 34))
    
    # 花びら
    petals = [
        (width//2, height//2-100),
        (width//2+100, height//2-50),
        (width//2+100, height//2+50),
        (width//2, height//2+100),
        (width//2-100, height//2+50),
        (width//2-100, height//2-50),
    ]
    
    for px, py in petals:
        draw.ellipse([px-40, py-40, px+40, py+40], 
                     fill=(255, 182, 193), outline=(255, 105, 180), width=3)
    
    # 中心
    draw.ellipse([width//2-50, height//2-50, width//2+50, height//2+50], 
                 fill=(255, 215, 0), outline=(255, 140, 0), width=3)

def main():
    output_dir = "flutter_app/assets/images/figures/puzzle"
    
    # ディレクトリが存在しない場合は作成
    os.makedirs(output_dir, exist_ok=True)
    
    # 4枚の画像を生成
    for i in range(4):
        generate_puzzle_image(i, output_dir)
    
    print(f"\n✅ {4}枚の画像を生成しました: {output_dir}")

if __name__ == "__main__":
    main()