/// 単語画像のパス管理サービス
///
/// 単語ゲーム、瞬間記憶ゲーム、配置記憶ゲームで使用する
/// vocabulary画像のパスを一元管理する
class VocabularyImageService {
  static const String _basePath = 'assets/images/figures/vocabulary';

  /// 単語から画像パスを取得
  ///
  /// [word] 単語（例：'くるま', 'りんご', 'リンゴ'）
  /// [scriptType] 文字種別（'hiragana' または 'katakana'）。nullの場合はひらがなを使用
  /// 返値: 画像パス（例：'assets/images/figures/vocabulary/hiragana/くるま.png'）
  static String getImagePath(String word, {String? scriptType}) {
    final type = scriptType ?? 'hiragana';
    return '$_basePath/$type/$word.png';
  }
}
