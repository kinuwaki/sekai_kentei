import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../writing_game_models.dart';
import 'smooth_tracing_widget.dart';
import 'writing_colors.dart';
import '../../../../tts/tts_controller.dart';

class TracingCanvasWidget extends ConsumerStatefulWidget {
  final CharacterData character;
  final bool isAnimatingStrokes;
  final int currentStrokeIndex;
  final Function(double canvasSize) onEndDrawing;
  final Function() onClearDrawing;

  const TracingCanvasWidget({
    super.key,
    required this.character,
    required this.isAnimatingStrokes,
    required this.currentStrokeIndex,
    required this.onEndDrawing,
    required this.onClearDrawing,
  });

  @override
  ConsumerState<TracingCanvasWidget> createState() => _TracingCanvasWidgetState();
}

class _TracingCanvasWidgetState extends ConsumerState<TracingCanvasWidget> {
  bool _hasPlayedInstructions = false;

  @override
  void initState() {
    super.initState();
    // 初回表示時に音声指示を再生
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasPlayedInstructions) {
        _hasPlayedInstructions = true;
        final tts = ref.read(ttsControllerProvider.notifier);
        tts.speakWritingInstruction(widget.character.character);
      }
    });
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
        child: Align(
          alignment: Alignment.topCenter,
          child: LayoutBuilder(
            builder: (context, constraints) {
              // 利用可能な領域を計算
              final screenWidth = MediaQuery.of(context).size.width;
              final maxWidth = constraints.maxWidth;
              final maxHeight = constraints.maxHeight;
              
              // レスポンシブ計算（適切なサイズに調整）
              final margin = 10.0;
              final smallerDimension = maxWidth < maxHeight ? maxWidth : maxHeight;
              final canvasSize = (smallerDimension - margin * 2).clamp(300.0, 500.0);
              
              return Container(
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
                    character: widget.character,
                    onEndDrawing: (size) => widget.onEndDrawing(size.width),
                    onStrokeComplete: (strokeIndex) {
                      // ストローク完了時の処理は onEndDrawing で統一
                    },
                    onProgressChanged: (progress) {
                      // 進行度の変化は必要に応じて
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}