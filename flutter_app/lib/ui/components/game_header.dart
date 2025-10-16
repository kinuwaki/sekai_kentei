import 'package:flutter/material.dart';
import '../../core/responsive_theme.dart';

class GameHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBack;
  final String? questionText;
  final VoidCallback? onSpeakerPressed;
  final bool isSpeaking;
  final String? progressText; // "1/5" のような進捗表示

  const GameHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onBack,
    this.questionText,
    this.onSpeakerPressed,
    this.isSpeaking = false,
    this.progressText,
  });

  // 質問テキストの表示を制御するヘルパーメソッド
  Widget _buildQuestionText(String text, double fontSize) {
    // 改行文字があるか、長いテキスト（12文字以上）の場合は2行表示
    final hasLineBreak = text.contains('\n');
    final isLongText = text.length >= 12;
    final shouldUseMultipleLines = hasLineBreak || isLongText;
    final adjustedFontSize = shouldUseMultipleLines ? fontSize * 0.8 : fontSize;
    final maxLines = shouldUseMultipleLines ? 2 : 1;

    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: shouldUseMultipleLines ? 0.8 : 1.0,
        fontSize: adjustedFontSize,
        height: shouldUseMultipleLines ? 1.3 : 1.0, // 行間を広げる
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.responsive;
    final size = MediaQuery.sizeOf(context);
    final headerHeight = theme.spacing.headerHeight;
    final padH = size.width * 0.02;
    final iconSize = headerHeight * 0.85; // アイコンサイズを少し調整
    
    // 共通フォントサイズ計算を使用
    final headerFonts = theme.calculateHeaderFontSizes(headerHeight);
    final questionPadding = EdgeInsets.symmetric(
      horizontal: theme.spacing.elementSpacing * 0.3, 
      vertical: theme.spacing.elementSpacing * 0.08
    );
    // 問題文用のデコレーション（枠なし）
    const questionDecoration = BoxDecoration(); // 枠を削除
    
    
    return SafeArea(
      child: Container(
        height: headerHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.blue.shade700],
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
                    // タイトルを白い枠で囲む（文字幅に合わせる）
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
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: size.width * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // 進捗表示（一番右側・必須）
                    Flexible(
                      child: Text(
                        progressText ?? '0/0', // 進捗がない場合はダミー表示
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

            // 中央（制約付き65%）: 質問 + スピーカー（左右のパディングを考慮）
            if (questionText != null) 
              Positioned(
                left: size.width * 0.25, // 左側30% - さらに左に寄せる（0.28→0.25）
                right: size.width * 0.07, // 右側5% + 少しマージン  
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      // 質問テキスト
                      Flexible(
                        child: Container(
                          padding: questionPadding,
                          decoration: questionDecoration,
                          child: _buildQuestionText(questionText!, headerFonts.question),
                        ),
                      ),

                      // スピーカーボタン（大きく）
                      if (onSpeakerPressed != null) ...[
                        SizedBox(width: theme.spacing.elementSpacing * 0.4),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: theme.spacing.elementSpacing * 0.3, // 0.4 → 0.3 に縮小
                            vertical: theme.spacing.elementSpacing * 0.08, // 0.1 → 0.08 に縮小
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(12), // 角を丸く
                            border: Border.all(
                              color: Colors.orangeAccent,
                              width: 2,
                            ),
                          ),
                          child: InkWell(
                            onTap: onSpeakerPressed,
                            borderRadius: BorderRadius.circular(12),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isSpeaking ? Icons.volume_up : Icons.volume_up_outlined,
                                  size: headerFonts.question * 1.0, // アイコンサイズを質問テキストに合わせる
                                  color: Colors.white,
                                ),
                                SizedBox(width: theme.spacing.smallSpacing * 0.7),
                                Text(
                                  'よみあげ',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700, // 太字に
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
                    ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}