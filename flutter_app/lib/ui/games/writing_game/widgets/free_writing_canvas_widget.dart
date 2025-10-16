import 'package:flutter/material.dart';
import '../writing_game_models.dart';
import '../../../components/drawing/drawing_models.dart';
import '../../../../core/debug_logger.dart';
import 'writing_colors.dart';
import 'smooth_tracing_widget.dart';

class FreeWritingCanvasWidget extends StatefulWidget {
  final CharacterData character;
  final DrawingData drawingData;
  final Function(DrawingPath) onPathAdded;
  final Function(DrawingData)? onDrawingDataChanged;
  final Function() onClearDrawing;
  final Function() onRecognize;
  final Function() onRetry;
  final bool isProcessing;

  const FreeWritingCanvasWidget({
    super.key,
    required this.character,
    required this.drawingData,
    required this.onPathAdded,
    this.onDrawingDataChanged,
    required this.onClearDrawing,
    required this.onRecognize,
    required this.onRetry,
    this.isProcessing = false,
  });

  @override
  State<FreeWritingCanvasWidget> createState() => _FreeWritingCanvasWidgetState();
}

class _FreeWritingCanvasWidgetState extends State<FreeWritingCanvasWidget> {
  int _clearCounter = 0; // クリア用のカウンター

  void _clearDrawing() {
    setState(() {
      _clearCounter++; // カウンターを増やしてキーを変更
    });
    widget.onClearDrawing();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: WritingColors.screenGradient,
        ),
      ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;
            
            // レスポンシブ計算
            final buttonWidth = screenWidth * 0.25; // 画面幅の25%をボタンエリアに
            final margin = 10.0;
            final smallerDimension = (screenWidth - buttonWidth) < screenHeight 
                ? (screenWidth - buttonWidth) 
                : screenHeight;
            final canvasSize = (smallerDimension - margin * 2).clamp(300.0, 500.0);
            
            return Stack(
              children: [
                // キャンバスを画面全体の中央に配置
                Center(
                  child: Container(
                    width: canvasSize,
                    height: canvasSize,
                    margin: EdgeInsets.all(margin),
                    decoration: BoxDecoration(
                      color: WritingColors.canvasBackground,
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
                      child: SmoothTracingWidget(
                        key: ValueKey('smooth_tracing_$_clearCounter'), // キーを追加して強制再作成
                        character: widget.character,
                        showTracing: false, // トレース線を非表示
                        showSilhouette: false, // シルエットも非表示
                        onEndDrawing: (size) {
                          print('FreeWritingCanvasWidget: onEndDrawing called');
                          widget.onRecognize();
                        },
                        onDrawingDataChanged: (drawingData) {
                          // 描画データを親に通知
                          widget.onDrawingDataChanged?.call(drawingData);
                          // 既存のパス追加ロジックも維持
                          for (final path in drawingData.paths) {
                            if (!widget.drawingData.paths.contains(path)) {
                              widget.onPathAdded(path);
                            }
                          }
                        },
                        onStrokeComplete: (strokeIndex) {
                          // ストローク完了時の処理は onEndDrawing で統一
                        },
                        onProgressChanged: (progress) {
                          // 進行度の変化は必要に応じて
                        },
                      ),
                    ),
                  ),
                ),
                
                // ボタンエリアを右側に配置
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  width: buttonWidth,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // できたボタン
                        SizedBox(
                          width: buttonWidth * 0.8,
                          height: screenHeight * 0.1,
                          child: ElevatedButton(
                            onPressed: widget.isProcessing
                                ? null : () {
                                    Log.d('🔥 FreeWritingCanvasWidget: できたボタン pressed - calling onRecognize');
                                    widget.onRecognize();
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: WritingColors.completeButton,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: widget.isProcessing
                                ? SizedBox(
                                    width: screenWidth * 0.04,
                                    height: screenWidth * 0.04,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'できた',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        
                        SizedBox(height: screenHeight * 0.025),
                        
                        // やりなおしボタン
                        SizedBox(
                          width: buttonWidth * 0.8,
                          height: screenHeight * 0.1,
                          child: ElevatedButton(
                            onPressed: () {
                              _clearDrawing();
                              widget.onRetry();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: WritingColors.retryButton,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              'やりなおし',
                              style: TextStyle(
                                fontSize: screenWidth * 0.025,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}