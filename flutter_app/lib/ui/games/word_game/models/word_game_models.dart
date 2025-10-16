import 'package:freezed_annotation/freezed_annotation.dart';
import '../../base/common_game_phase.dart';
import '../../../../services/vocabulary_image_service.dart';

part 'word_game_models.freezed.dart';

enum WordGameMode {
  hiraganaMode('ひらがなモード', 'ひらがなでまなぶ', 'hiragana'),
  katakanaMode('カタカナモード', 'カタカナでまなぶ', 'katakana');

  final String displayName;
  final String description;
  final String scriptType;

  const WordGameMode(this.displayName, this.description, this.scriptType);
}

enum QuestionType {
  pictureToText('えをみてもじをえらぶ'),
  textToPicture('もじをみてえをえらぶ');

  final String description;

  const QuestionType(this.description);
}

@freezed
abstract class WordGameSettings with _$WordGameSettings {
  const factory WordGameSettings({
    @Default(WordGameMode.hiraganaMode) WordGameMode mode,
    @Default(QuestionType.pictureToText) QuestionType questionType,
    @Default(5) int questionCount,
    @Default(4) int optionCount, // 選択肢の数（4つ固定）
  }) = _WordGameSettings;

  const WordGameSettings._();

  String get displayName => '${mode.description}（$questionCount問）';
}

@freezed
abstract class WordGameProblem with _$WordGameProblem {
  const factory WordGameProblem({
    required String word,  // 単語（例：くるま）
    required String imagePath,  // 画像パス
    required List<String> options,  // 選択肢
    required int correctIndex,  // 正解のインデックス
    required QuestionType questionType,  // 問題タイプ
    required String scriptType,  // 文字種別（hiragana/katakana）
  }) = _WordGameProblem;

  const WordGameProblem._();

  String get questionText {
    switch (questionType) {
      case QuestionType.pictureToText:
        return 'これはなに？';
      case QuestionType.textToPicture:
        return 'これはどれ？';
    }
  }
}

@freezed
abstract class WordGameSession with _$WordGameSession {
  const factory WordGameSession({
    required int index,
    required int total,
    required List<bool?> results,
    WordGameProblem? currentProblem,
    @Default([]) List<int> selectedIndices,  // 選択された選択肢
    @Default(0) int wrongAnswers,
  }) = _WordGameSession;

  const WordGameSession._();

  bool get isCompleted => index >= total;
  int get correctCount => results.where((r) => r == true).length;
  int get incorrectCount => results.where((r) => r == false).length;
}

@freezed
abstract class WordGameState with _$WordGameState {
  const factory WordGameState({
    @Default(CommonGamePhase.ready) CommonGamePhase phase,
    WordGameSettings? settings,
    WordGameSession? session,
    AnswerResult? lastResult,
    @Default(0) int epoch,
  }) = _WordGameState;

  const WordGameState._();

  bool get canAnswer => phase == CommonGamePhase.questioning;
  bool get isProcessing => phase == CommonGamePhase.processing || phase == CommonGamePhase.transitioning;
  double get progress => session != null ? session!.index / session!.total : 0.0;
  String? get questionText => session?.currentProblem?.questionText;
}

@freezed
abstract class AnswerResult with _$AnswerResult {
  const factory AnswerResult({
    required int selectedIndex,
    required int correctIndex,
    required bool isCorrect,
    required bool isPerfect,
  }) = _AnswerResult;
}

// 共通の画像リスト
class VocabularyImages {
  static const List<String> hiraganaItems = [
    'あいす',
    'あさがお',
    'あり',
    'うきわ',
    'うさぎ',
    'うちわ',
    'うでどけい',
    'うま',
    'えび',
    'えんぴつ',
    'おたま',
    'おにぎり',
    'かきごおり',
    'かたつむり',
    'きうい',
    'きゃべつ',
    'きゅうり',
    'きりん',
    'くつ',
    'くつした',
    'くま',
    'くるま',
    'こっぷ',
    'さいころ',
    'じてんしゃ',
    'じゃがいも',
    'しんかんせん',
    'すいか',
    'すずめ',
    'すにーかー',
    'すぷーん',
    'ぞう',
    'たまねぎ',
    'たんぽぽ',
    'ちゅーりっぷ',
    'ちりとり',
    'とうもろこし',
    'とまと',
    'とらくたー',
    'にんじん',
    'はさみ',
    'ばす',
    'ばなな',
    'ひこうき',
    'ふうせん',
    'ふぉーく',
    'ぶた',
    'ぶどう',
    'ふね',
    'ふらいぱん',
    'ぶろっこりー',
    'ほうき',
    'ほうちょう',
    'ぼーる',
    'ほっちきす',
    'みかん',
    'むぎわらぼうし',
    'めがね',
    'めろん',
    'もみじ',
    'やかん',
    'らいおん',
    'らけっと',
    'りんご',
    'れもん',
    'れんこん',
  ];

  static const List<String> katakanaItems = [
    'アイス',
    'キウイ',
    'キャベツ',
    'キュウリ',
    'キリン',
    'コップ',
    'サイコロ',
    'ジャガイモ',
    'スイカ',
    'ゾウ',
    'チューリップ',
    'トウモロコシ',
    'トラクター',
    'ハサミ',
    'バス',
    'バナナ',
    'フォーク',
    'ブドウ',
    'フライパン',
    'ブロッコリー',
    'ボール',
    'ホッチキス',
    'ミカン',
    'メガネ',
    'メロン',
    'ライオン',
    'ラケット',
    'リンゴ',
    'レモン',
  ];

  static List<String> getItems(String scriptType) {
    return scriptType == 'katakana' ? katakanaItems : hiraganaItems;
  }

  static String getImagePath(String word, String scriptType) {
    return VocabularyImageService.getImagePath(word, scriptType: scriptType);
  }
}