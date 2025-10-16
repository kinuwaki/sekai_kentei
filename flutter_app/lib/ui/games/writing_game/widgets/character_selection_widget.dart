import 'package:flutter/material.dart';
import '../writing_game_models.dart';
import '../character_data.dart';

class CharacterSelectionWidget extends StatelessWidget {
  final CharacterCategory category;
  final Function(CharacterData) onCharacterSelected;

  const CharacterSelectionWidget({
    super.key,
    required this.category,
    required this.onCharacterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final characters = CharacterDatabase.getCharactersForCategory(category);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // タイトル
          Text(
            '${category.displayName}から えらぼう',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 15),
          
          // 文字グリッド - コンパクトに配置
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 900, // 横幅を制限
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10, // 10列配置
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.1, // やや縦長
                  ),
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    return _buildCharacterCard(context, characters[index]);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterCard(BuildContext context, CharacterData character) {
    return GestureDetector(
      onTap: () => onCharacterSelected(character),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            character.character,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: category.color,
            ),
          ),
        ),
      ),
    );
  }
}