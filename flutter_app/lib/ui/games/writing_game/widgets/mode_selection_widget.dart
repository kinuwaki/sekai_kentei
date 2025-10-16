import 'package:flutter/material.dart';
import '../../../../core/responsive_theme.dart';
import '../writing_game_models.dart';

class ModeSelectionWidget extends StatelessWidget {
  final CharacterCategory category;  // 文字ではなくカテゴリを受け取る
  final Function(PracticeCombination) onCombinationSelected;

  const ModeSelectionWidget({
    super.key,
    required this.category,
    required this.onCombinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
          // タイトルと説明を1行に統合
          Text(
            'どのようにれんしゅうしますか？',
            style: TextStyle(
              fontSize: context.fontSizes.gameTitle,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'なぞりがき - なぞりがき２ - じゆうがき',
            style: TextStyle(
              fontSize: context.fontSizes.gameContent * 0.8,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 20),
          
          // プリセット組み合わせ - Wrapを使って配置
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: PracticeCombination.presets.map((combination) {
              return _buildCombinationCard(context, combination);
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildCombinationCard(BuildContext context, PracticeCombination combination) {
    return GestureDetector(
      onTap: () => onCombinationSelected(combination),
      child: Container(
        width: 65,  // おおきいちいさいと同じサイズ
        height: 65, // おおきいちいさいと同じサイズ
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            combination.displayName,
            style: TextStyle(
              fontSize: 14, // 固定サイズ
              fontWeight: FontWeight.bold,
              color: category.color,
            ),
          ),
        ),
      ),
    );
  }
}