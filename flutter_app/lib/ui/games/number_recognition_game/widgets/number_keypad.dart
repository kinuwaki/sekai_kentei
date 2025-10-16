import 'package:flutter/material.dart';
import '../../../../core/responsive_theme.dart';

/// 数字入力用のテンキーウィジェット
class NumberKeypad extends StatelessWidget {
  final Function(int) onNumberPressed;
  final bool enabled;

  const NumberKeypad({
    super.key,
    required this.onNumberPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // タイトル
          Text(
            'すうじをえらぶ',
            style: TextStyle(
              fontSize: context.fontSizes.gameTitle,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 16),
          
          // 数字ボタン（0-9）
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(10, (index) {
              return NumberButton(
                number: index,
                onPressed: enabled ? () => onNumberPressed(index) : null,
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// 個別の数字ボタン
class NumberButton extends StatelessWidget {
  final int number;
  final VoidCallback? onPressed;

  const NumberButton({
    super.key,
    required this.number,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    
    return SizedBox(
      width: 100,
      height: 100,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? Colors.blue[100] : Colors.grey[200],
          foregroundColor: isEnabled ? Colors.blue[800] : Colors.grey[500],
          elevation: isEnabled ? 2 : 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          '$number',
          style: TextStyle(
            fontSize: context.fontSizes.keypadNumber,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// コンパクトな横一列のテンキー
class CompactNumberKeypad extends StatelessWidget {
  final Function(int) onNumberPressed;
  final bool enabled;
  final List<int>? highlightNumbers; // 強調表示する数字

  const CompactNumberKeypad({
    super.key,
    required this.onNumberPressed,
    this.enabled = true,
    this.highlightNumbers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(10, (index) {
            final isHighlighted = highlightNumbers?.contains(index) ?? false;
            
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: SizedBox(
                width: 40,
                height: 40,
                child: ElevatedButton(
                  onPressed: enabled ? () => onNumberPressed(index) : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isHighlighted 
                        ? Colors.orange[200] 
                        : enabled 
                            ? Colors.blue[50] 
                            : Colors.grey[200],
                    foregroundColor: isHighlighted
                        ? Colors.orange[800]
                        : enabled 
                            ? Colors.blue[800] 
                            : Colors.grey[500],
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    '$index',
                    style: TextStyle(
                      fontSize: 14, // Half size of normal keypad
                      fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// カスタマイズ可能な数字ボタン
class CustomNumberButton extends StatelessWidget {
  final int number;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double size;
  final double fontSize;
  final bool isSelected;

  const CustomNumberButton({
    super.key,
    required this.number,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.size = 60,
    this.fontSize = 24,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    
    Color effectiveBackgroundColor;
    Color effectiveForegroundColor;
    
    if (!isEnabled) {
      effectiveBackgroundColor = Colors.grey[200]!;
      effectiveForegroundColor = Colors.grey[500]!;
    } else if (isSelected) {
      effectiveBackgroundColor = Colors.green[200]!;
      effectiveForegroundColor = Colors.green[800]!;
    } else {
      effectiveBackgroundColor = backgroundColor ?? Colors.blue[100]!;
      effectiveForegroundColor = foregroundColor ?? Colors.blue[800]!;
    }
    
    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveForegroundColor,
          elevation: isEnabled ? (isSelected ? 4 : 2) : 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size * 0.2),
          ),
        ),
        child: Text(
          '$number',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// 範囲指定可能な数字キーパッド
class RangeNumberKeypad extends StatelessWidget {
  final Function(int) onNumberPressed;
  final bool enabled;
  final int minNumber;
  final int maxNumber;
  final int? selectedNumber;

  const RangeNumberKeypad({
    super.key,
    required this.onNumberPressed,
    this.enabled = true,
    this.minNumber = 0,
    this.maxNumber = 9,
    this.selectedNumber,
  });

  @override
  Widget build(BuildContext context) {
    final numbers = List.generate(
      maxNumber - minNumber + 1, 
      (index) => minNumber + index,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: numbers.map((number) {
          return CustomNumberButton(
            number: number,
            onPressed: enabled ? () => onNumberPressed(number) : null,
            isSelected: selectedNumber == number,
            size: 50,
            fontSize: 20,
          );
        }).toList(),
      ),
    );
  }
}

/// 縦一列の数字キーパッド（0-9）
class VerticalNumberKeypad extends StatelessWidget {
  final Function(int) onNumberPressed;
  final bool enabled;
  final int? selectedNumber;

  const VerticalNumberKeypad({
    super.key,
    required this.onNumberPressed,
    this.enabled = true,
    this.selectedNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(10, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: CustomNumberButton(
              number: index,
              onPressed: enabled ? () => onNumberPressed(index) : null,
              isSelected: selectedNumber == index,
              size: 50,
              fontSize: 24,
            ),
          );
        }),
      ),
    );
  }
}