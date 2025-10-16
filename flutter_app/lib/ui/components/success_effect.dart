import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../core/debug_logger.dart';
import 'dart:math' as math;

class SuccessEffect extends StatefulWidget {
  final VoidCallback? onComplete;
  final Duration duration;
  final bool hadWrongAnswer;  // スコア計算用（この問題で間違えたか）

  const SuccessEffect({
    super.key,
    this.onComplete,
    this.duration = const Duration(milliseconds: 1200),
    this.hadWrongAnswer = false,  // スコア表示用のみ、音声には影響しない
  });

  @override
  State<SuccessEffect> createState() => _SuccessEffectState();
}

class _SuccessEffectState extends State<SuccessEffect>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _controller.forward();

    // 正解時の音声再生（SuccessEffectは正解時のみ表示される）
    _playPinponSound();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            // 背景テクスチャのみ表示
            _buildBackgroundTexture(),
          ],
        );
      },
    );
  }


  Widget _buildBackgroundTexture() {
    final opacity = 0.8; // 固定で表示（フェードなし）
    // 正解時のエフェクトなので、その問題で間違えたかどうかで画像を分ける
    // hadWrongAnswer = true: その問題で一度間違えた後に正解した
    // hadWrongAnswer = false: 一発正解した
    final textureImage = widget.hadWrongAnswer 
        ? 'assets/images/buttons/grade5_ganbarimasyou.png'  // 間違えた後の正解
        : 'assets/images/buttons/grade1_taihenyoku.png';   // 一発正解
    
    return Center(
      child: SizedBox(
        width: 400,
        height: 400,
        child: Opacity(
          opacity: opacity,
          child: Image.asset(
            textureImage,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              // テクスチャファイルが見つからない場合のフォールバック
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.yellow.withOpacity(0.3),
                      Colors.orange.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }


  Future<void> _playPinponSound() async {
    try {
      await _audioPlayer.play(AssetSource('audio/pinpon.mp3'));
      Log.d('Playing pinpon sound', tag: 'SuccessEffect');
    } catch (e) {
      Log.e('Failed to play pinpon sound: $e', tag: 'SuccessEffect');
      // 音声ファイルが見つからない場合はサイレントに続行
    }
  }
}

class HanamaruPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;

    // 外側の円（赤）
    final outerPaint = Paint()
      ..color = Colors.red.shade600
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    canvas.drawCircle(center, radius, outerPaint);

    // 内側の円（ピンク）
    final innerPaint = Paint()
      ..color = Colors.pink.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawCircle(center, radius - 15, innerPaint);

    // 花の装飾を描画
    _drawFlowerDecorations(canvas, center, radius);

    // 中央の「〇」文字
    final textPainter = TextPainter(
      text: TextSpan(
        text: '〇',
        style: TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.bold,
          color: Colors.red.shade700,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  void _drawFlowerDecorations(Canvas canvas, Offset center, double radius) {
    final petalPaint = Paint()
      ..color = Colors.pink.shade200
      ..style = PaintingStyle.fill;

    // 花びらを8個配置
    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi * 2) / 8;
      final petalCenter = Offset(
        center.dx + math.cos(angle) * (radius + 10),
        center.dy + math.sin(angle) * (radius + 10),
      );

      // 小さな花びら
      canvas.drawCircle(petalCenter, 8, petalPaint);
    }

    // 葉っぱの装飾
    final leafPaint = Paint()
      ..color = Colors.green.shade400
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 4; i++) {
      final angle = (i * math.pi * 2) / 4 + math.pi / 4;
      final leafCenter = Offset(
        center.dx + math.cos(angle) * (radius + 25),
        center.dy + math.sin(angle) * (radius + 25),
      );

      // 小さな葉っぱ
      final leafPath = Path();
      leafPath.addOval(Rect.fromCenter(
        center: leafCenter,
        width: 12,
        height: 6,
      ));
      
      canvas.save();
      canvas.translate(leafCenter.dx, leafCenter.dy);
      canvas.rotate(angle);
      canvas.translate(-leafCenter.dx, -leafCenter.dy);
      canvas.drawPath(leafPath, leafPaint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class StarBurstPainter extends CustomPainter {
  final double progress;
  final List<StarParticle> stars = [];

  StarBurstPainter({required this.progress}) {
    _initializeStars();
  }

  void _initializeStars() {
    final random = math.Random();
    
    for (int i = 0; i < 15; i++) {
      final angle = (i * math.pi * 2) / 15;
      stars.add(StarParticle(
        angle: angle,
        distance: random.nextDouble() * 300 + 100,
        size: random.nextDouble() * 20 + 15,
        color: _getRandomStarColor(),
        rotationSpeed: (random.nextDouble() - 0.5) * 4,
      ));
    }
  }

  Color _getRandomStarColor() {
    final colors = [
      Colors.yellow.shade400,
      Colors.orange.shade400,
      Colors.pink.shade300,
      Colors.purple.shade300,
      Colors.blue.shade300,
    ];
    return colors[math.Random().nextInt(colors.length)];
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    for (final star in stars) {
      final currentDistance = star.distance * progress;
      final x = center.dx + math.cos(star.angle) * currentDistance;
      final y = center.dy + math.sin(star.angle) * currentDistance;

      final opacity = math.max(0.0, 1.0 - progress);
      final paint = Paint()
        ..color = star.color.withOpacity(opacity)
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(star.rotationSpeed * progress * 10);
      
      _drawStar(canvas, paint, star.size * (1.0 + progress * 0.5));
      
      canvas.restore();
    }
  }

  void _drawStar(Canvas canvas, Paint paint, double size) {
    final path = Path();
    const numPoints = 5;
    final outerRadius = size;
    final innerRadius = size * 0.4;

    for (int i = 0; i < numPoints * 2; i++) {
      final angle = (i * math.pi) / numPoints - math.pi / 2;
      final radius = i.isEven ? outerRadius : innerRadius;
      final x = radius * math.cos(angle);
      final y = radius * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class StarParticle {
  final double angle;
  final double distance;
  final double size;
  final Color color;
  final double rotationSpeed;

  StarParticle({
    required this.angle,
    required this.distance,
    required this.size,
    required this.color,
    required this.rotationSpeed,
  });
}