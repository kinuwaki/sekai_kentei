import 'package:flutter/material.dart';
import 'common_action_buttons.dart';

/// 全ゲーム共通の結果画面レイアウト
/// 
/// 上部のコンテンツはカスタマイズ可能
/// 下部の「もういちど」「もどる」ボタンは統一レイアウト
class CommonGameResult extends StatelessWidget {
  /// 結果コンテンツ（アイコン、メッセージ、スコアなど）
  final Widget content;
  
  /// もういちどボタンが押された時のコールバック
  final VoidCallback onRetry;
  
  /// もどるボタンが押された時のコールバック（nullの場合はデフォルト）
  final VoidCallback? onBack;
  
  /// もういちどボタンのテキスト
  final String retryText;
  
  /// もどるボタンのテキスト
  final String backText;

  const CommonGameResult({
    super.key,
    required this.content,
    required this.onRetry,
    this.onBack,
    this.retryText = ActionButtonTexts.retry,
    this.backText = ActionButtonTexts.back,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // ヘッダー高さを計算（SafeAreaとヘッダー本体）
    final safePadding = MediaQuery.of(context).padding;
    final headerHeight = safePadding.top + (screenHeight * 0.07);
    final remainingHeight = screenHeight - headerHeight;
    
    return Column(
      children: [
        SizedBox(height: remainingHeight * 0.05),
        // 結果カード - 統一されたレイアウト
        Container(
          width: screenWidth * 0.65,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // カスタマイズ可能なコンテンツ部分
              content,
              const SizedBox(height: 15),
              // 統一されたアクションボタン
              CommonActionButtons(
                onRetry: onRetry,
                onBack: onBack,
                retryText: retryText,
                backText: backText,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 標準的な成功結果
  factory CommonGameResult.success({
    required String title,
    required String subtitle,
    String? detail,
    required VoidCallback onRetry,
    VoidCallback? onBack,
    String retryText = ActionButtonTexts.retry,
    String backText = ActionButtonTexts.back,
  }) {
    return CommonGameResult(
      content: _StandardResultContent(
        icon: Icons.celebration,
        iconColor: const Color(0xFF4A90E2),
        title: title,
        subtitle: subtitle,
        detail: detail,
      ),
      onRetry: onRetry,
      onBack: onBack,
      retryText: retryText,
      backText: backText,
    );
  }

  /// スコア付き結果
  factory CommonGameResult.withScore({
    required int score,
    required int totalQuestions,
    required VoidCallback onRetry,
    VoidCallback? onBack,
    String retryText = ActionButtonTexts.retry,
    String backText = ActionButtonTexts.back,
  }) {
    final scorePercentage = (score / totalQuestions * 100).round();
    
    return CommonGameResult(
      content: _StandardResultContent(
        icon: Icons.celebration,
        iconColor: const Color(0xFF4A90E2),
        title: 'ゲームクリア！',
        subtitle: 'スコア: $score / $totalQuestions',
        detail: '正解率: $scorePercentage%',
      ),
      onRetry: onRetry,
      onBack: onBack,
      retryText: retryText,
      backText: backText,
    );
  }

  /// カスタムアイコンと結果
  factory CommonGameResult.custom({
    required IconData icon,
    Color? iconColor,
    required String title,
    String? subtitle,
    String? detail,
    required VoidCallback onRetry,
    VoidCallback? onBack,
    String retryText = ActionButtonTexts.retry,
    String backText = ActionButtonTexts.back,
  }) {
    return CommonGameResult(
      content: _StandardResultContent(
        icon: icon,
        iconColor: iconColor ?? const Color(0xFF4A90E2),
        title: title,
        subtitle: subtitle,
        detail: detail,
      ),
      onRetry: onRetry,
      onBack: onBack,
      retryText: retryText,
      backText: backText,
    );
  }
}

/// 標準的な結果コンテンツウィジェット
class _StandardResultContent extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final String? detail;

  const _StandardResultContent({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 50,
          color: iconColor,
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E3A59),
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          Text(
            subtitle!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A90E2),
            ),
          ),
        ],
        if (detail != null) ...[
          const SizedBox(height: 5),
          Text(
            detail!,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ],
    );
  }
}