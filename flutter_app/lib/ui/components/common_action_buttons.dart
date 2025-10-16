import 'package:flutter/material.dart';
import '../games/base/navigation_utils.dart';

/// 共通のテキスト定数
class ActionButtonTexts {
  static const String retry = 'もういちど';
  static const String back = 'おわる';
}

/// 全ゲーム共通のアクションボタン（もういちど・もどる）
class CommonActionButtons extends StatelessWidget {
  /// もういちどボタンが押された時のコールバック
  final VoidCallback onRetry;
  
  /// もどるボタンが押された時のコールバック（nullの場合はデフォルトのナビゲーション処理）
  final VoidCallback? onBack;
  
  /// もういちどボタンのテキスト（カスタマイズ用）
  final String retryText;
  
  /// もどるボタンのテキスト（カスタマイズ用）
  final String backText;
  
  /// ボタンのレイアウト方向
  final Axis direction;
  
  /// ボタン間のスペース
  final double spacing;
  
  /// もういちどボタンのアイコン（オプション）
  final IconData? retryIcon;
  
  /// もどるボタンのアイコン（オプション）
  final IconData? backIcon;
  
  /// もういちどボタンの色（nullの場合はデフォルト青）
  final Color? retryColor;
  
  /// もどるボタンの色（nullの場合はデフォルトグレー）
  final Color? backColor;

  const CommonActionButtons({
    super.key,
    required this.onRetry,
    this.onBack,
    this.retryText = ActionButtonTexts.retry,
    this.backText = ActionButtonTexts.back,
    this.direction = Axis.horizontal,
    this.spacing = 16,
    this.retryIcon,
    this.backIcon,
    this.retryColor,
    this.backColor,
  });

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton(
            context: context,
            onPressed: onRetry,
            text: retryText,
            icon: retryIcon,
            color: retryColor ?? const Color(0xFF4A90E2),
          ),
          _buildButton(
            context: context,
            onPressed: onBack ?? () => GameNavigationUtils.handleBackPress(context),
            text: backText,
            icon: backIcon,
            color: backColor ?? Colors.grey.shade600,
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildButton(
            context: context,
            onPressed: onRetry,
            text: retryText,
            icon: retryIcon,
            color: retryColor ?? const Color(0xFF4A90E2),
          ),
          SizedBox(height: spacing),
          _buildButton(
            context: context,
            onPressed: onBack ?? () => GameNavigationUtils.handleBackPress(context),
            text: backText,
            icon: backIcon,
            color: backColor ?? Colors.grey.shade600,
          ),
        ],
      );
    }
  }

  Widget _buildButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required String text,
    IconData? icon,
    required Color color,
  }) {
    final child = icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 8),
              Text(
                text,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          )
        : Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          );

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: child,
    );
  }
}

/// より簡単に使えるファクトリコンストラクタ
extension CommonActionButtonsShortcuts on CommonActionButtons {
  /// 標準的な横並びボタン
  static Widget standard({
    required VoidCallback onRetry,
    VoidCallback? onBack,
    String retryText = ActionButtonTexts.retry,
    String backText = ActionButtonTexts.back,
  }) {
    return CommonActionButtons(
      onRetry: onRetry,
      onBack: onBack,
      retryText: retryText,
      backText: backText,
    );
  }
  
  /// 縦並びボタン（スペースが狭い場合）
  static Widget vertical({
    required VoidCallback onRetry,
    VoidCallback? onBack,
    String retryText = ActionButtonTexts.retry,
    String backText = ActionButtonTexts.back,
  }) {
    return CommonActionButtons(
      onRetry: onRetry,
      onBack: onBack,
      retryText: retryText,
      backText: backText,
      direction: Axis.vertical,
    );
  }
  
  /// アイコン付きボタン
  static Widget withIcons({
    required VoidCallback onRetry,
    VoidCallback? onBack,
    String retryText = ActionButtonTexts.retry,
    String backText = ActionButtonTexts.back,
    IconData? retryIcon = Icons.refresh,
    IconData? backIcon = Icons.arrow_back,
  }) {
    return CommonActionButtons(
      onRetry: onRetry,
      onBack: onBack,
      retryText: retryText,
      backText: backText,
      retryIcon: retryIcon,
      backIcon: backIcon,
    );
  }
}