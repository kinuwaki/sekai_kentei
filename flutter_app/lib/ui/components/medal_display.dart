import 'package:flutter/material.dart';
import '../../core/progress/game_progress_provider.dart';

/// メダル表示ウィジェット
class MedalDisplay extends StatelessWidget {
  final MedalLevel medalLevel;
  final double size;

  const MedalDisplay({
    super.key,
    required this.medalLevel,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: ClipRect(
        child: Stack(
          children: [
            // メダル画像全体を読み込み
            Image.asset(
              'assets/images/buttons/medal.png',
              width: size * 3, // 3つのメダルが横に並んでいるため
              height: size,
              fit: BoxFit.cover,
            ),
            // 適切な部分だけを表示するためのマスク
            Positioned(
              left: _getOffsetForMedal(medalLevel, size),
              child: Container(
                width: size,
                height: size,
                child: Image.asset(
                  'assets/images/buttons/medal.png',
                  width: size * 3,
                  height: size,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// メダルレベルに応じたオフセットを計算
  double _getOffsetForMedal(MedalLevel level, double medalSize) {
    switch (level) {
      case MedalLevel.gold:
        return 0.0; // 左側（金メダル）
      case MedalLevel.silver:
        return -medalSize; // 真ん中（銀メダル）
      case MedalLevel.bronze:
        return -medalSize * 2; // 右側（銅メダル）
    }
  }
}

/// より正確なスプライト切り出しを行うメダル表示
class PreciseMedalDisplay extends StatelessWidget {
  final MedalLevel medalLevel;
  final double size;

  const PreciseMedalDisplay({
    super.key,
    required this.medalLevel,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    // メダル画像全体の幅（3つ分）
    final double totalWidth = size * 3;

    return SizedBox(
      width: size,
      height: size,
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.topLeft,
          maxWidth: totalWidth,
          child: Transform.translate(
            offset: Offset(_getOffsetForMedal(medalLevel), 0),
            child: Image.asset(
              'assets/images/buttons/medal.png',
              width: totalWidth,
              height: size,
              fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.high,
              isAntiAlias: true,
            ),
          ),
        ),
      ),
    );
  }

  /// メダルレベルに応じたオフセットを計算
  /// 画像配置: [金メダル|銀メダル|銅メダル]
  double _getOffsetForMedal(MedalLevel level) {
    switch (level) {
      case MedalLevel.gold:
        return 0.0; // 左1/3（U: 0.0～0.333）
      case MedalLevel.silver:
        return -size; // 中央1/3（U: 0.333～0.667）
      case MedalLevel.bronze:
        return -size * 2; // 右1/3（U: 0.667～1.0）
    }
  }
}