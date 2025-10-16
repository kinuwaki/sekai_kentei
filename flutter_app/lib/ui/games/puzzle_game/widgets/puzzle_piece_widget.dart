import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../models/puzzle_game_models.dart';

/// パズルピース描画ウィジェット
class PuzzlePieceWidget extends StatelessWidget {
  final PuzzlePiece piece;
  final ui.Image? image;
  final VoidCallback? onTap;
  final bool showFeedback;
  final bool isCorrect;

  const PuzzlePieceWidget({
    Key? key,
    required this.piece,
    required this.image,
    this.onTap,
    this.showFeedback = false,
    this.isCorrect = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _getBorderColor(),
            width: piece.isSelected ? 12.0 : 1.0,
          ),
          boxShadow: [
            if (piece.isSelected)
              BoxShadow(
                color: _getBorderColor().withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 2,
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: image != null
              ? CustomPaint(
                  painter: PuzzlePiecePainter(
                    image: image!,
                    uvRect: piece.uvRect,
                  ),
                  size: Size.infinite,
                )
              : Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
      ),
    );
  }

  Color _getBorderColor() {
    if (showFeedback) {
      return isCorrect ? Colors.green : Colors.red;
    } else if (piece.isSelected) {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }
}

/// パズルピース描画Painter（UV座標対応）
class PuzzlePiecePainter extends CustomPainter {
  final ui.Image image;
  final Rect uvRect;

  PuzzlePiecePainter({
    required this.image,
    required this.uvRect,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // UV座標を画像のピクセル座標に変換
    final srcRect = Rect.fromLTWH(
      uvRect.left * image.width,
      uvRect.top * image.height,
      uvRect.width * image.width,
      uvRect.height * image.height,
    );

    // 描画先の矩形（ウィジェット全体）
    final dstRect = Rect.fromLTWH(0, 0, size.width, size.height);

    // drawImageRectで部分描画
    canvas.drawImageRect(
      image,
      srcRect,
      dstRect,
      Paint()..filterQuality = FilterQuality.high,
    );
  }

  @override
  bool shouldRepaint(PuzzlePiecePainter oldDelegate) {
    return oldDelegate.image != image || oldDelegate.uvRect != uvRect;
  }
}

/// フル画像表示ウィジェット（お手本用）
class PuzzleReferenceWidget extends StatelessWidget {
  final ui.Image? image;

  const PuzzleReferenceWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade400,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: image != null
            ? CustomPaint(
                painter: FullImagePainter(image: image!),
                size: Size.infinite,
              )
            : Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Text(
                    'おてほん',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

/// フル画像描画Painter
class FullImagePainter extends CustomPainter {
  final ui.Image image;

  FullImagePainter({required this.image});

  @override
  void paint(Canvas canvas, Size size) {
    final srcRect = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final dstRect = Rect.fromLTWH(0, 0, size.width, size.height);
    
    canvas.drawImageRect(
      image,
      srcRect,
      dstRect,
      Paint()..filterQuality = FilterQuality.high,
    );
  }

  @override
  bool shouldRepaint(FullImagePainter oldDelegate) {
    return oldDelegate.image != image;
  }
}

/// パズルピースグリッドウィジェット
class PuzzlePieceGrid extends StatelessWidget {
  final List<PuzzlePiece> pieces;
  final ui.Image? image;
  final Function(int) onPieceTap;
  final bool showFeedback;
  final List<int> correctIndices;

  const PuzzlePieceGrid({
    Key? key,
    required this.pieces,
    required this.image,
    required this.onPieceTap,
    this.showFeedback = false,
    this.correctIndices = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 2x2グリッドを作成
    final gridItems = List<Widget?>.filled(4, null);
    
    // ピースを配置
    for (final piece in pieces) {
      final pieceIndex = pieces.indexOf(piece);
      gridItems[piece.gridPosition] = PuzzlePieceWidget(
        piece: piece,
        image: image,
        onTap: () => onPieceTap(pieceIndex),
        showFeedback: showFeedback,
        isCorrect: correctIndices.contains(pieceIndex),
      );
    }

    // nullの位置には空のコンテナを配置
    for (int i = 0; i < gridItems.length; i++) {
      gridItems[i] ??= Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
            width: 1.0,
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 2.0 / 3.0, // 2:3の正確なアスペクト比
      children: gridItems.cast<Widget>(),
    );
  }
}