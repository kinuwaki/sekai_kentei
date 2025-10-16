import 'writing_game_models.dart';

class CharacterDatabase {
  // ひらがなのデータ（50音順）
  static const List<CharacterData> hiraganaCharacters = [
    // あ行
    CharacterData(
      character: 'あ',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3'],
      pronunciation: 'あ',
    ),
    CharacterData(
      character: 'い',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'い',
    ),
    CharacterData(
      character: 'う',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'う',
    ),
    CharacterData(
      character: 'え',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3'],
      pronunciation: 'え',
    ),
    CharacterData(
      character: 'お',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3'],
      pronunciation: 'お',
    ),
    // か行
    CharacterData(
      character: 'か',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3'],
      pronunciation: 'か',
    ),
    CharacterData(
      character: 'き',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3', 'stroke4'],
      pronunciation: 'き',
    ),
    CharacterData(
      character: 'く',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1'],
      pronunciation: 'く',
    ),
    CharacterData(
      character: 'け',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3'],
      pronunciation: 'け',
    ),
    CharacterData(
      character: 'こ',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'こ',
    ),
    // さ行
    CharacterData(
      character: 'さ',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3'],
      pronunciation: 'さ',
    ),
    CharacterData(
      character: 'し',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1'],
      pronunciation: 'し',
    ),
    CharacterData(
      character: 'す',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'す',
    ),
    CharacterData(
      character: 'せ',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3'],
      pronunciation: 'せ',
    ),
    CharacterData(
      character: 'そ',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1'],
      pronunciation: 'そ',
    ),
    // た行
    CharacterData(
      character: 'た',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3', 'stroke4'],
      pronunciation: 'た',
    ),
    CharacterData(
      character: 'ち',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'ち',
    ),
    CharacterData(
      character: 'つ',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1'],
      pronunciation: 'つ',
    ),
    CharacterData(
      character: 'て',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3'],
      pronunciation: 'て',
    ),
    CharacterData(
      character: 'と',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'と',
    ),
    // な行
    CharacterData(
      character: 'な',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3', 'stroke4'],
      pronunciation: 'な',
    ),
    CharacterData(
      character: 'に',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3'],
      pronunciation: 'に',
    ),
    CharacterData(
      character: 'ぬ',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'ぬ',
    ),
    CharacterData(
      character: 'ね',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'ね',
    ),
    CharacterData(
      character: 'の',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1'],
      pronunciation: 'の',
    ),
    // は行
    CharacterData(
      character: 'は',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3'],
      pronunciation: 'は',
    ),
    CharacterData(
      character: 'ひ',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1'],
      pronunciation: 'ひ',
    ),
    CharacterData(
      character: 'ふ',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3', 'stroke4'],
      pronunciation: 'ふ',
    ),
    CharacterData(
      character: 'へ',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1'],
      pronunciation: 'へ',
    ),
    CharacterData(
      character: 'ほ',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3', 'stroke4'],
      pronunciation: 'ほ',
    ),
    // ま行
    CharacterData(
      character: 'ま',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3'],
      pronunciation: 'ま',
    ),
    CharacterData(
      character: 'み',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'み',
    ),
    CharacterData(
      character: 'む',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3'],
      pronunciation: 'む',
    ),
    CharacterData(
      character: 'め',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'め',
    ),
    CharacterData(
      character: 'も',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3'],
      pronunciation: 'も',
    ),
    // や行
    CharacterData(
      character: 'や',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3'],
      pronunciation: 'や',
    ),
    CharacterData(
      character: 'ゆ',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'ゆ',
    ),
    CharacterData(
      character: 'よ',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'よ',
    ),
    // ら行（5列目に配置）
    CharacterData(
      character: 'ら',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'ら',
    ),
    CharacterData(
      character: 'り',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'り',
    ),
    CharacterData(
      character: 'る',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1'],
      pronunciation: 'る',
    ),
    CharacterData(
      character: 'れ',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'れ',
    ),
    CharacterData(
      character: 'ろ',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1'],
      pronunciation: 'ろ',
    ),
    // わ行
    CharacterData(
      character: 'わ',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'わ',
    ),
    CharacterData(
      character: 'を',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1', 'stroke2', 'stroke3'],
      pronunciation: 'を',
    ),
    CharacterData(
      character: 'ん',
      category: CharacterCategory.hiragana,
      strokeOrder: ['stroke1'],
      pronunciation: 'ん',
    ),
    // 追加のひらがなはここに
  ];

  // 数字のデータ（SVGなし版）
  static const List<CharacterData> numberCharacters = [
    CharacterData(
      character: '0',
      category: CharacterCategory.numbers,
      pronunciation: 'ぜろ',
    ),
    CharacterData(
      character: '1',
      category: CharacterCategory.numbers,
      strokeOrder: ['stroke1', 'stroke2'],
      pronunciation: 'いち',
    ),
    CharacterData(
      character: '2',
      category: CharacterCategory.numbers,
      pronunciation: 'に',
    ),
    CharacterData(
      character: '3',
      category: CharacterCategory.numbers,
      pronunciation: 'さん',
    ),
    CharacterData(
      character: '4',
      category: CharacterCategory.numbers,
      pronunciation: 'よん',
    ),
    CharacterData(
      character: '5',
      category: CharacterCategory.numbers,
      pronunciation: 'ご',
    ),
    CharacterData(
      character: '6',
      category: CharacterCategory.numbers,
      pronunciation: 'ろく',
    ),
    CharacterData(
      character: '7',
      category: CharacterCategory.numbers,
      pronunciation: 'なな',
    ),
    CharacterData(
      character: '8',
      category: CharacterCategory.numbers,
      pronunciation: 'はち',
    ),
    CharacterData(
      character: '9',
      category: CharacterCategory.numbers,
      pronunciation: 'きゅう',
    ),
  ];

  // アルファベットのデータ（SVGなし版）
  static const List<CharacterData> alphabetCharacters = [
    CharacterData(
      character: 'A',
      category: CharacterCategory.alphabet,
      pronunciation: 'エー',
    ),
    CharacterData(
      character: 'B',
      category: CharacterCategory.alphabet,
      pronunciation: 'ビー',
    ),
    CharacterData(
      character: 'C',
      category: CharacterCategory.alphabet,
      pronunciation: 'シー',
    ),
    // 追加のアルファベットはここに
  ];

  // カテゴリ別に文字を取得
  static List<CharacterData> getCharactersForCategory(CharacterCategory category) {
    switch (category) {
      case CharacterCategory.hiragana:
        return hiraganaCharacters;
      case CharacterCategory.numbers:
        return numberCharacters;
      case CharacterCategory.alphabet:
        return alphabetCharacters;
    }
  }

  // 全文字を取得
  static List<CharacterData> getAllCharacters() {
    return [
      ...hiraganaCharacters,
      ...numberCharacters,
      ...alphabetCharacters,
    ];
  }

  // 文字で検索
  static CharacterData? findCharacter(String character) {
    try {
      return getAllCharacters().firstWhere((c) => c.character == character);
    } catch (e) {
      return null;
    }
  }
}