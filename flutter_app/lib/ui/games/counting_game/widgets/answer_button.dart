import 'package:flutter/material.dart';

/// 数字選択用の橙色ボタン
class AnswerButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool hadWrongAnswer;
  final double size;
  final double fontSizeRatio;
  
  const AnswerButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.hadWrongAnswer,
    required this.size,
    this.fontSizeRatio = 0.48,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: hadWrongAnswer
              ? [Colors.red.shade400, Colors.red.shade600]
              : [Colors.orange.shade400, Colors.orange.shade600],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: size * fontSizeRatio,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}