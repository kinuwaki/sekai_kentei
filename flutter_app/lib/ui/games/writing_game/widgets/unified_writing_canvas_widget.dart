import 'package:flutter/material.dart';
import '../writing_game_models.dart';
import '../../../components/drawing/drawing_models.dart';
import '../../../components/drawing/drawing_canvas.dart';
import 'writing_colors.dart';
import 'smooth_tracing_widget.dart';

/// 統合された書字練習キャンバスウィジェット
/// なぞり書き、なぞり書き２、自由がきの3つのモードを統一
enum WritingCanvasMode {
  tracing,     // なぞり書き: トレース線とシルエット表示
  tracingFree, // なぞり書き２: シルエットのみ表示
  freeWrite,   // 自由がき: 何も表示せず
}

/// キャンバスのカスタマイズ設定
class CanvasCustomization {
  final Color? backgroundColor;        // 背景色
  final bool showGradient;            // グラデーション背景を使用するか
  final bool showShadow;              // シャドウを表示するか
  final bool showExternalButtons;     // 外部ボタンを表示するか（falseなら統合ボタンのみ）
  final double? canvasWidth;          // キャンバス幅の固定値
  final double? canvasHeight;         // キャンバス高さの固定値
  final EdgeInsets? canvasMargin;     // キャンバスマージン
  final double? borderRadius;         // 角丸半径
  final double? strokeWidth;          // ペンの太さ
  final Color? strokeColor;           // ペンの色

  const CanvasCustomization({
    this.backgroundColor,
    this.showGradient = true,
    this.showShadow = true,
    this.showExternalButtons = true,
    this.canvasWidth,
    this.canvasHeight,
    this.canvasMargin,
    this.borderRadius,
    this.strokeWidth,
    this.strokeColor,
  });
}

class UnifiedWritingCanvasWidget extends StatefulWidget {
  final CharacterData? character; // 数字認識用にoptionalに変更
  final WritingCanvasMode mode;
  final DrawingData drawingData;
  final Function(DrawingPath)? onPathAdded;
  final Function(DrawingData)? onDrawingDataChanged;
  final VoidCallback? onClearDrawing;
  final VoidCallback? onRecognize;
  final VoidCallback? onComplete; // なぞり書き用（認識不要）
  final VoidCallback? onRetry;
  final bool isProcessing;
  final CanvasCustomization? customization; // カスタマイズ設定

  const UnifiedWritingCanvasWidget({
    super.key,
    this.character, // optionalに変更
    required this.mode,
    required this.drawingData,
    this.onPathAdded,
    this.onDrawingDataChanged,
    this.onClearDrawing,
    this.onRecognize,
    this.onComplete,
    this.onRetry,
    this.isProcessing = false,
    this.customization, // カスタマイズ設定
  });

  @override
  State<UnifiedWritingCanvasWidget> createState() => _UnifiedWritingCanvasWidgetState();
}

class _UnifiedWritingCanvasWidgetState extends State<UnifiedWritingCanvasWidget> {
  int _clearCounter = 0;

  void _clearDrawing() {
    setState(() {
      _clearCounter++;
    });
    widget.onClearDrawing?.call();
  }

  bool get _showTracing => widget.mode == WritingCanvasMode.tracing;
  bool get _showSilhouette => widget.mode != WritingCanvasMode.freeWrite;
  bool get _needsRecognition => widget.mode != WritingCanvasMode.tracing;

  void _handleEndDrawing(Size size) {
    if (_needsRecognition) {
      widget.onRecognize?.call();
    } else {
      widget.onComplete?.call();
    }
  }

  void _handleCompleteButton() {
    if (_needsRecognition) {
      widget.onRecognize?.call();
    } else {
      widget.onComplete?.call();
    }
  }

  @override
  Widget build(BuildContext context) {

    // カスタマイズ設定を取得（デフォルト値を使用）
    final customization = widget.customization ?? const CanvasCustomization();

    return Container(
      decoration: customization.showGradient
          ? const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: WritingColors.screenGradient,
              ),
            )
          : BoxDecoration(
              color: customization.backgroundColor ?? Colors.white,
            ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            // ボタンエリアサイズの計算（外部ボタンを表示しない場合は0）
            final buttonWidth = (widget.mode == WritingCanvasMode.tracing || !customization.showExternalButtons)
                ? 0.0 : screenWidth * 0.25;
            final margin = customization.canvasMargin?.horizontal ?? 10.0;

            // キャンバスサイズの計算（カスタム指定があればそれを使用）
            final double canvasWidth;
            final double canvasHeight;
            if (customization.canvasWidth != null && customization.canvasHeight != null) {
              canvasWidth = customization.canvasWidth!;
              canvasHeight = customization.canvasHeight!;
            } else {
              final availableWidth = screenWidth - buttonWidth;
              final smallerDimension = availableWidth < screenHeight ? availableWidth : screenHeight;
              final size = (smallerDimension - margin * 2).clamp(300.0, 500.0);
              canvasWidth = size;
              canvasHeight = size;
            }

            return Stack(
              children: [
                // キャンバス
                Center(
                  child: Container(
                    width: canvasWidth,
                    height: canvasHeight,
                    margin: customization.canvasMargin ?? EdgeInsets.all(margin),
                    decoration: BoxDecoration(
                      color: customization.backgroundColor ?? WritingColors.canvasBackground,
                      borderRadius: BorderRadius.circular(customization.borderRadius ?? 16),
                      boxShadow: customization.showShadow
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(customization.borderRadius ?? 16),
                      child: widget.character != null
                        ? SmoothTracingWidget(
                            key: ValueKey('unified_tracing_$_clearCounter'),
                            character: widget.character!,
                            showTracing: _showTracing,
                            showSilhouette: _showSilhouette,
                            strokeWidth: customization.strokeWidth ?? 12.0,
                            onEndDrawing: _handleEndDrawing,
                            onDrawingDataChanged: (drawingData) {
                              widget.onDrawingDataChanged?.call(drawingData);
                              // 既存のパス追加ロジックも維持
                              if (widget.onPathAdded != null) {
                                for (final path in drawingData.paths) {
                                  if (!widget.drawingData.paths.contains(path)) {
                                    widget.onPathAdded!(path);
                                  }
                                }
                              }
                            },
                          )
                        : SimpleDrawingPad(
                            drawingData: widget.drawingData,
                            onPathAdded: (path) {
                              widget.onPathAdded?.call(path);
                              // 数字認識ゲームでは描画中の自動判定を削除
                            },
                            config: DrawingConfig(
                              strokeWidth: customization.strokeWidth ?? 12.0,
                              strokeColor: customization.strokeColor ?? Colors.black,
                            ),
                          ),
                    ),
                  ),
                ),

                // ボタンエリア（なぞり書き以外のモード かつ 外部ボタン表示設定の場合のみ表示）
                if (widget.mode != WritingCanvasMode.tracing && customization.showExternalButtons) ...[
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    width: buttonWidth,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // できたボタン
                          SizedBox(
                            width: buttonWidth * 0.85,
                            height: screenHeight * 0.12,
                            child: ElevatedButton(
                              onPressed: widget.isProcessing ? null : _handleCompleteButton,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: WritingColors.completeButton,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 4,
                              ),
                              child: Text(
                                'できた',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.08),  // ボタン間の間隔を調整

                          // やりなおしボタン
                          SizedBox(
                            width: buttonWidth * 0.85,
                            height: screenHeight * 0.12,
                            child: ElevatedButton(
                              onPressed: () {
                                _clearDrawing();
                                widget.onRetry?.call();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: WritingColors.retryButton,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 4,
                              ),
                              child: Text(
                                'やりなおし',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.03,
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
              ],
            );
          },
        ),
      ),
    );
  }
}