import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/responsive_theme.dart';
import '../../tts/tts_controller.dart';

/// システムヘッダー - ゲーム中のようにテキストと音声再生機能を持つ共通ヘッダー
class SystemHeader extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onBack;
  final String? messageText;
  final String? progressText;

  const SystemHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onBack,
    this.messageText,
    this.progressText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.responsive;
    final size = MediaQuery.sizeOf(context);
    final ttsState = ref.watch(ttsControllerProvider);
    final tts = ref.read(ttsControllerProvider.notifier);
    final headerHeight = theme.spacing.headerHeight;
    final padH = size.width * 0.02;
    final iconSize = headerHeight * 0.85;

    final headerFonts = theme.calculateHeaderFontSizes(headerHeight);
    final messagePadding = EdgeInsets.symmetric(
      horizontal: theme.spacing.elementSpacing * 0.3,
      vertical: theme.spacing.elementSpacing * 0.08
    );

    return SafeArea(
      child: Container(
        height: headerHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.purple.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: padH),
        child: Stack(
          children: [
            // 左ガード（30%）: 戻る + タイトル（左詰め）
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: size.width * 0.30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (onBack != null) ...[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: SizedBox(
                          width: iconSize,
                          height: iconSize,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: onBack,
                            icon: Icon(
                              Icons.arrow_back,
                              size: iconSize * 0.95,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.01),
                    ],
                    // タイトルを白い枠で囲む
                    Flexible(
                      child: IntrinsicWidth(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.02,
                            vertical: size.height * 0.005,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: headerFonts.title,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 右ガード（5%）: 進捗のみ（右詰め）
            if (progressText != null)
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: size.width * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          progressText!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 1.0,
                            fontSize: headerFonts.progress,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // 中央（制約付き65%）: メッセージ + スピーカー
            if (messageText != null)
              Positioned(
                left: size.width * 0.25,
                right: size.width * 0.07,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // メッセージテキスト
                    Flexible(
                      child: Container(
                        padding: messagePadding,
                        child: _buildMessageText(messageText!, headerFonts.question),
                      ),
                    ),

                    // スピーカーボタン
                    SizedBox(width: theme.spacing.elementSpacing * 0.4),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: theme.spacing.elementSpacing * 0.3,
                        vertical: theme.spacing.elementSpacing * 0.08,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.orangeAccent,
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        onTap: () => tts.speak(messageText!),
                        borderRadius: BorderRadius.circular(12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              ttsState.isSpeaking ? Icons.volume_up : Icons.volume_up_outlined,
                              size: headerFonts.question * 1.0,
                              color: Colors.white,
                            ),
                            SizedBox(width: theme.spacing.smallSpacing * 0.7),
                            Text(
                              'よみあげ',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 1.2,
                                fontSize: headerFonts.speakerButton,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageText(String text, double fontSize) {
    final isLongText = text.length >= 20;
    final adjustedFontSize = isLongText ? fontSize * 0.85 : fontSize;
    final maxLines = isLongText ? 2 : 1;

    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: isLongText ? 0.8 : 1.0,
        fontSize: adjustedFontSize,
        height: isLongText ? 1.1 : 1.0,
      ),
    );
  }
}