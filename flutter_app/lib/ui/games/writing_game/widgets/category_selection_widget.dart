import 'package:flutter/material.dart';
import '../../../../core/responsive_theme.dart';
import '../writing_game_models.dart';

class CategorySelectionWidget extends StatelessWidget {
  final Function(CharacterCategory) onCategorySelected;

  const CategorySelectionWidget({
    super.key,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(context.spacing.cardSpacing),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
            'どのもじをれんしゅうしますか？',
            style: TextStyle(
              fontSize: context.fontSizes.gameTitle,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          
          SizedBox(height: context.spacing.elementSpacing * 2),
          
          // カテゴリカード（横並び）
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: CharacterCategory.values.map((category) => 
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.spacing.smallSpacing),
                  child: _buildCategoryCard(context, category),
                ),
              ),
            ).toList(),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, CharacterCategory category) {
    return Container(
      margin: EdgeInsets.only(bottom: context.spacing.cardSpacing),
      child: GestureDetector(
        onTap: () => onCategorySelected(category),
        child: Container(
          height: context.constraints.cardMinHeight,
          padding: context.spacing.cardPadding,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // アイコン
              Icon(
                category.icon,
                size: context.iconSizes.gameIcon,
                color: category.color,
              ),
              
              SizedBox(height: context.spacing.smallSpacing),
              
              // テキスト
              Text(
                category.displayName,
                style: TextStyle(
                  fontSize: context.fontSizes.gameContent,
                  fontWeight: FontWeight.bold,
                  color: category.color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getCategoryDescription(CharacterCategory category) {
    switch (category) {
      case CharacterCategory.hiragana:
        return 'あ、か、さ...';
      case CharacterCategory.numbers:
        return '0、1、2、3...';
      case CharacterCategory.alphabet:
        return 'A、B、C...';
    }
  }
}