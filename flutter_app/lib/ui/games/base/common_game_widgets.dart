import 'package:flutter/material.dart';

class GameLoadingWidget extends StatelessWidget {
  final String message;
  final Color? backgroundColor;
  final Color? textColor;

  const GameLoadingWidget({
    super.key,
    this.message = 'せってい がめんを よみこみちゅう...',
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundColor != null
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.shade50,
                  Colors.purple.shade50,
                ],
              ),
        color: backgroundColor,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              message,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor ?? Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameResponsiveUtils {
  static double getFontSize(BuildContext context, {double ratio = 0.04}) {
    final size = MediaQuery.of(context).size;
    return size.width * ratio;
  }

  static double getButtonSize(BuildContext context, {double ratio = 0.08}) {
    final size = MediaQuery.of(context).size;
    return size.shortestSide * ratio;
  }

  static double getCellSize(BuildContext context, int columns, {double padding = 20.0}) {
    final size = MediaQuery.of(context).size;
    final availableWidth = size.width - (padding * 2);
    return availableWidth / columns;
  }

  static Size getGameAreaSize(BuildContext context, {double aspectRatio = 1.0}) {
    final size = MediaQuery.of(context).size;
    final maxWidth = size.width * 0.8;
    final maxHeight = size.height * 0.7;

    if (maxWidth / maxHeight > aspectRatio) {
      return Size(maxHeight * aspectRatio, maxHeight);
    } else {
      return Size(maxWidth, maxWidth / aspectRatio);
    }
  }

  static EdgeInsets getGamePadding(BuildContext context, {double ratio = 0.02}) {
    final size = MediaQuery.of(context).size;
    final padding = size.shortestSide * ratio;
    return EdgeInsets.all(padding);
  }

  static double getResponsiveValue(
    BuildContext context, {
    required double phone,
    required double tablet,
    double? desktop,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return phone;
    if (width < 1200) return tablet;
    return desktop ?? tablet;
  }
}

class TwoPanelGameLayout extends StatelessWidget {
  final Widget leftPanel;
  final Widget rightPanel;
  final double leftFlex;
  final double rightFlex;
  final double spacing;
  final Color? backgroundColor;

  const TwoPanelGameLayout({
    super.key,
    required this.leftPanel,
    required this.rightPanel,
    this.leftFlex = 1,
    this.rightFlex = 1,
    this.spacing = 20,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    if (!isLandscape) {
      return Container(
        color: backgroundColor,
        child: Column(
          children: [
            Expanded(
              flex: leftFlex.toInt(),
              child: Padding(
                padding: EdgeInsets.all(spacing / 2),
                child: leftPanel,
              ),
            ),
            Expanded(
              flex: rightFlex.toInt(),
              child: Padding(
                padding: EdgeInsets.all(spacing / 2),
                child: rightPanel,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      color: backgroundColor,
      child: Row(
        children: [
          Expanded(
            flex: leftFlex.toInt(),
            child: Padding(
              padding: EdgeInsets.all(spacing / 2),
              child: leftPanel,
            ),
          ),
          Expanded(
            flex: rightFlex.toInt(),
            child: Padding(
              padding: EdgeInsets.all(spacing / 2),
              child: rightPanel,
            ),
          ),
        ],
      ),
    );
  }
}

/// 共通のドット形状定義
enum CommonDotShape {
  circle,
  square,
  star,
}

/// ドットウィジェットビルダー - 各ゲームで共通使用
class DotWidgetBuilder {
  /// ドットウィジェットを構築
  static Widget buildDot({
    required Offset position,
    required CommonDotShape shape,
    required Color color,
    required double size,
  }) {
    Widget dotWidget;

    switch (shape) {
      case CommonDotShape.circle:
        dotWidget = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        );
        break;
      case CommonDotShape.square:
        dotWidget = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(size * 0.2),
          ),
        );
        break;
      case CommonDotShape.star:
        dotWidget = Icon(
          Icons.star,
          color: color,
          size: size,
        );
        break;
    }

    return Positioned(
      left: position.dx - size / 2,
      top: position.dy - size / 2,
      child: dotWidget,
    );
  }
}

class GameErrorWidget extends StatelessWidget {
  final String message;
  final String? details;
  final VoidCallback? onRetry;
  final IconData icon;

  const GameErrorWidget({
    super.key,
    this.message = 'エラーが発生しました',
    this.details,
    this.onRetry,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.red.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          if (details != null) ...[
            const SizedBox(height: 8),
            Text(
              details!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (onRetry != null) ...[
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('もういちど'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}