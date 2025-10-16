import 'package:flutter/material.dart';

/// ホーム画面のモードカード
/// 正方形のカードで子どもでも押しやすい大きさ
/// 全要素固定サイズで描画を共通化
class ModeCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double? progress;  // 0.0 ~ 1.0 の進捗（nullで非表示）
  final IconData icon;
  final Color accent;
  final String? badgeText;  // NEW や +5 などのバッジ
  final VoidCallback? onTap;
  final bool isDisabled;  // カードを無効化するかどうか

  const ModeCard({
    super.key,
    required this.title,
    this.subtitle,
    this.progress,
    required this.icon,
    required this.accent,
    this.badgeText,
    required this.onTap,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // カード本体
        Material(
          borderRadius: BorderRadius.circular(24),
          elevation: isDisabled ? 2 : 4,
          shadowColor: Colors.black.withOpacity(0.2),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: isDisabled ? null : onTap,
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: isDisabled
                    ? Colors.grey.withOpacity(0.4)
                    : accent.withOpacity(0.6), // アルファ薄く調整
                border: Border.all(
                  color: isDisabled
                      ? Colors.grey.withOpacity(0.3)
                      : Colors.white.withOpacity(0.4),
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // アイコン（上部中央、固定サイズで統一）
                    Container(
                      width: 44, // さらに縮小
                      height: 44, // さらに縮小
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        icon,
                        size: 28,
                        color: isDisabled ? Colors.grey : accent,
                      ),
                    ),
                    // テキストコンテンツ（下部中央）
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // タイトル（固定サイズで共通化）
                        SizedBox(
                          height: 36, // 高さ拡大
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isDisabled ? Colors.grey[300] : Colors.white,
                                  fontSize: 21, // 文字サイズ30%拡大
                                  height: 1.0, // 行間調整
                                ),
                              ),
                            ),
                          ),
                        ),
                        // 進捗表示（固定サイズで共通化）
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 32, // 高さ縮小
                          child: progress != null
                              ? Column(
                                  children: [
                                    // 円形プログレス
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        value: progress,
                                        backgroundColor: Colors.white.withOpacity(0.3),
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    // パーセント表示
                                    Text(
                                      '${(progress! * 100).toStringAsFixed(1)}%',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // バッジ（NEW, +5 など）
        if (badgeText != null)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: _getBadgeColor(badgeText!),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Text(
                badgeText!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }
  
  /// バッジの色を決定
  Color _getBadgeColor(String text) {
    if (text.toUpperCase() == 'NEW') {
      return Colors.red;
    } else if (text.startsWith('+')) {
      return Colors.blue;
    } else {
      return Colors.orange;
    }
  }
}