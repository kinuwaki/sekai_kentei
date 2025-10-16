import 'package:flutter/material.dart';
import 'drawing_models.dart';
import '../../../core/debug_logger.dart';

/// 共通の描画キャンバスウィジェット
class DrawingCanvas extends StatefulWidget {
  final DrawingData drawingData;
  final DrawingConfig config;
  final Function(DrawingPath) onPathAdded;
  final VoidCallback? onClear;
  final VoidCallback? onUndo;
  final bool enabled;

  const DrawingCanvas({
    super.key,
    required this.drawingData,
    required this.onPathAdded,
    this.config = const DrawingConfig(),
    this.onClear,
    this.onUndo,
    this.enabled = true,
  });

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  List<Offset> _currentPath = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.config.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 2),
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
        child: GestureDetector(
          onPanStart: widget.enabled ? _onPanStart : null,
          onPanUpdate: widget.enabled ? _onPanUpdate : null,
          onPanEnd: widget.enabled ? _onPanEnd : null,
          child: CustomPaint(
            painter: DrawingPainter(
              widget.drawingData,
              // IMPORTANT: List.from()でコピーを作成してCustomPainterに渡す
              // これにより、_currentPathの変更がCustomPainterに確実に反映される
              // 直接 _currentPath を渡すと、リアルタイム描画が動作しない場合がある
              currentPath: List.from(_currentPath),
              config: widget.config,
            ),
            size: Size.infinite,
            child: Container(),
          ),
        ),
      ),
    );
  }

  void _onPanStart(DragStartDetails details) {
    final renderBox = context.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(details.globalPosition);
    
    setState(() {
      _currentPath = [localPosition];
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final renderBox = context.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(details.globalPosition);
    
    setState(() {
      _currentPath.add(localPosition);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_currentPath.isNotEmpty) {
      final path = DrawingPath(
        points: List.from(_currentPath),
        color: widget.config.strokeColor,
        strokeWidth: widget.config.strokeWidth,
        timestamp: DateTime.now(),
      );
      
      widget.onPathAdded(path);
      
      setState(() {
        _currentPath.clear();
      });
    } else {
    }
  }
}

/// 描画用のカスタムペインター
class DrawingPainter extends CustomPainter {
  final DrawingData drawingData;
  final List<Offset> currentPath;
  final DrawingConfig config;

  DrawingPainter(
    this.drawingData, {
    this.currentPath = const [],
    this.config = const DrawingConfig(),
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 完成した描画パスを描画
    for (final path in drawingData.paths) {
      _drawPath(canvas, path);
    }
    
    // 現在描画中のパスを描画（リアルタイム）
    if (currentPath.isNotEmpty) {
      _drawCurrentPath(canvas, currentPath);
    }
  }

  void _drawPath(Canvas canvas, DrawingPath drawingPath) {
    if (drawingPath.points.isEmpty) return;

    final paint = Paint()
      ..color = drawingPath.color
      ..strokeWidth = drawingPath.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    if (drawingPath.points.length == 1) {
      // 単一点の場合は円を描画
      canvas.drawCircle(
        drawingPath.points.first,
        drawingPath.strokeWidth / 2,
        paint..style = PaintingStyle.fill,
      );
    } else {
      // 複数点の場合はパスを描画
      final path = Path();
      path.moveTo(drawingPath.points.first.dx, drawingPath.points.first.dy);

      for (int i = 1; i < drawingPath.points.length; i++) {
        path.lineTo(drawingPath.points[i].dx, drawingPath.points[i].dy);
      }

      canvas.drawPath(path, paint);
    }
  }

  /// 現在描画中のパスを描画（リアルタイム表示用）
  void _drawCurrentPath(Canvas canvas, List<Offset> points) {
    if (points.isEmpty) return;

    final paint = Paint()
      ..color = config.strokeColor
      ..strokeWidth = config.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    if (points.length == 1) {
      // 単一点の場合は円を描画
      canvas.drawCircle(
        points.first,
        config.strokeWidth / 2,
        paint..style = PaintingStyle.fill,
      );
    } else {
      // 複数点の場合はパスを描画
      final path = Path();
      path.moveTo(points.first.dx, points.first.dy);

      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) {
    // データ、描画中のパス、設定のいずれかが変更された場合に再描画
    final shouldRepaintResult = oldDelegate.drawingData != drawingData ||
           !_listEquals(oldDelegate.currentPath, currentPath) ||
           oldDelegate.config != config;
    
    
    return shouldRepaintResult;
  }
  
  /// リストの内容を比較（順序も含めて完全一致）
  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

/// 描画コントロールボタン付きウィジェット
class DrawingPad extends StatelessWidget {
  final DrawingData drawingData;
  final DrawingConfig config;
  final Function(DrawingPath) onPathAdded;
  final VoidCallback? onClear;
  final VoidCallback? onUndo;
  final VoidCallback? onRecognize;
  final bool isProcessing;
  final String clearButtonText;
  final String recognizeButtonText;

  const DrawingPad({
    super.key,
    required this.drawingData,
    required this.onPathAdded,
    this.config = const DrawingConfig(),
    this.onClear,
    this.onUndo,
    this.onRecognize,
    this.isProcessing = false,
    this.clearButtonText = 'けす',
    this.recognizeButtonText = 'にんしきする',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // 描画エリア
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DrawingCanvas(
                drawingData: drawingData,
                config: config,
                onPathAdded: onPathAdded,
                enabled: !isProcessing,
              ),
            ),
          ),

          // コントロールボタン
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            child: Row(
              children: [
                // クリアボタン
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: drawingData.isEmpty ? null : onClear,
                    icon: const Icon(Icons.clear, size: 32),
                    label: Text(
                      clearButtonText,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[100],
                      foregroundColor: Colors.red[800],
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // 認識ボタン（オプション）
                if (onRecognize != null)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: drawingData.isEmpty || isProcessing ? null : onRecognize,
                      icon: isProcessing
                          ? const SizedBox(
                              width: 32,
                              height: 32,
                              child: CircularProgressIndicator(strokeWidth: 3),
                            )
                          : const Icon(Icons.psychology, size: 32),
                      label: Text(
                        isProcessing ? 'にんしきちゅう...' : recognizeButtonText,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[100],
                        foregroundColor: Colors.blue[800],
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 描画キャンバスのみのウィジェット（ボタンなし）
class SimpleDrawingPad extends StatelessWidget {
  final DrawingData drawingData;
  final DrawingConfig config;
  final Function(DrawingPath) onPathAdded;
  final bool enabled;

  const SimpleDrawingPad({
    super.key,
    required this.drawingData,
    required this.onPathAdded,
    this.config = const DrawingConfig(),
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DrawingCanvas(
            drawingData: drawingData,
            config: config,
            onPathAdded: onPathAdded,
            enabled: enabled,
          ),
        ),
      ),
    );
  }
}