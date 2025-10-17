import 'package:freezed_annotation/freezed_annotation.dart';

part 'sekai_kentei_models.freezed.dart';

/// ゲームの共通フェーズ
enum CommonGamePhase {
  ready,         // 準備中（設定画面）
  displaying,    // 問題表示中
  questioning,   // 回答受付中
  processing,    // 処理中
  feedbackOk,    // 正解フィードバック
  feedbackNg,    // 不正解フィードバック
  transitioning, // 次の問題へ遷移中
  completed,     // ゲーム完了
}

/// クイズのテーマ（カテゴリー）
enum QuizTheme {
  basic('世界遺産の基礎知識', 'きそちしき'),
  japan('日本の世界遺産', 'にほんのせかいいさん'),
  world('世界の世界遺産', 'せかいのせかいいさん');

  final String displayName;
  final String description;

  const QuizTheme(this.displayName, this.description);
}

/// ゲーム設定
@freezed
abstract class SekaiKenteiSettings with _$SekaiKenteiSettings {
  const factory SekaiKenteiSettings({
    @Default(QuizTheme.basic) QuizTheme theme,
    @Default(10) int questionCount,
  }) = _SekaiKenteiSettings;

  const SekaiKenteiSettings._();

  String get displayName => '${theme.displayName}（$questionCount問）';
}

/// 問題データ
@freezed
abstract class SekaiKenteiProblem with _$SekaiKenteiProblem {
  const factory SekaiKenteiProblem({
    required String id,  // 問題ID（CSV/JSONのid）
    required String question,  // 問題文
    required List<String> options,  // 選択肢（4つ）
    required int correctIndex,  // 正解のインデックス
    @Default('') String explanation,  // 解説
    String? imagePath,  // 画像パス（任意）
  }) = _SekaiKenteiProblem;

  const SekaiKenteiProblem._();
}

/// ゲームセッション（進行状況）
@freezed
abstract class SekaiKenteiSession with _$SekaiKenteiSession {
  const factory SekaiKenteiSession({
    required int index,  // 現在の問題番号
    required int total,  // 総問題数
    required List<bool?> results,  // 各問題の結果
    SekaiKenteiProblem? currentProblem,
    @Default([]) List<int> selectedIndices,  // 選択された選択肢
    @Default(0) int wrongAnswers,  // 間違えた回数
  }) = _SekaiKenteiSession;

  const SekaiKenteiSession._();

  bool get isCompleted => index >= total;
  int get correctCount => results.where((r) => r == true).length;
  int get incorrectCount => results.where((r) => r == false).length;
}

/// ゲーム状態
@freezed
abstract class SekaiKenteiState with _$SekaiKenteiState {
  const factory SekaiKenteiState({
    @Default(CommonGamePhase.ready) CommonGamePhase phase,
    SekaiKenteiSettings? settings,
    SekaiKenteiSession? session,
    AnswerResult? lastResult,
    @Default(0) int epoch,
  }) = _SekaiKenteiState;

  const SekaiKenteiState._();

  bool get canAnswer => phase == CommonGamePhase.questioning;
  bool get isProcessing => phase == CommonGamePhase.processing || phase == CommonGamePhase.transitioning;
  double get progress => session != null ? session!.index / session!.total : 0.0;
  String? get questionText => session?.currentProblem?.question;
}

/// 回答結果
@freezed
abstract class AnswerResult with _$AnswerResult {
  const factory AnswerResult({
    required int selectedIndex,
    required int correctIndex,
    required bool isCorrect,
    required bool isPerfect,
  }) = _AnswerResult;
}

/// テーマ名の定数
class QuizThemeNames {
  static const String basic = '世界遺産の基礎知識';
  static const String japan = '日本の世界遺産';
  static const String world = '世界の世界遺産';
}

/// 問題データベース（現在は使用しない - CSV読み込みに移行）
class QuizDatabase {
  /// 基礎知識の問題（サンプル - CSV読み込み失敗時のフォールバック用）
  static const List<Map<String, dynamic>> basicQuestions = [
    {
      'question': '日本で最初に登録された世界遺産は次のうちどれ？',
      'options': ['厳島神社', '知床', '白神山地', '富士山'],
      'correctIndex': 2,
    },
    {
      'question': '世界遺産条約が採択された年は？',
      'options': ['1962年', '1972年', '1982年', '1992年'],
      'correctIndex': 1,
    },
    {
      'question': '世界遺産は何種類に分類される？',
      'options': ['2種類', '3種類', '4種類', '5種類'],
      'correctIndex': 1,
    },
    {
      'question': 'ユネスコの本部がある都市は？',
      'options': ['ロンドン', 'ニューヨーク', 'パリ', 'ジュネーブ'],
      'correctIndex': 2,
    },
    {
      'question': '世界遺産の3つの種類に含まれないものは？',
      'options': ['文化遺産', '自然遺産', '複合遺産', '無形遺産'],
      'correctIndex': 3,
    },
    {
      'question': '危機遺産リストに登録される理由として正しいものは？',
      'options': ['観光客が多すぎる', '保存状態が良好', '遺産が危機にさらされている', '新しく発見された'],
      'correctIndex': 2,
    },
    {
      'question': '世界遺産の登録を審査する機関は？',
      'options': ['国際連合', 'ユネスコ', '国際司法裁判所', 'WHO'],
      'correctIndex': 1,
    },
    {
      'question': '日本の世界遺産の数は（2024年時点で）約何件？',
      'options': ['15件', '20件', '25件', '30件'],
      'correctIndex': 2,
    },
    {
      'question': '世界遺産に登録されるための基準は何個ある？',
      'options': ['5個', '10個', '15個', '20個'],
      'correctIndex': 1,
    },
    {
      'question': '世界遺産条約の正式名称に含まれるキーワードは？',
      'options': ['平和', '文化', '教育', '保護'],
      'correctIndex': 3,
    },
  ];

  /// 日本の世界遺産の問題
  static const List<Map<String, dynamic>> japanQuestions = [
    {
      'question': '日本で最初に登録された世界遺産は次のうちどれ？',
      'options': ['厳島神社', '知床', '白神山地', '富士山'],
      'correctIndex': 2,
    },
    {
      'question': '富士山が世界遺産に登録されたのは何年？',
      'options': ['2003年', '2008年', '2013年', '2018年'],
      'correctIndex': 2,
    },
    {
      'question': '原爆ドームはどの県にある？',
      'options': ['長崎県', '広島県', '沖縄県', '鹿児島県'],
      'correctIndex': 1,
    },
    {
      'question': '屋久島の世界遺産登録理由は主に何？',
      'options': ['文化的価値', '自然的価値', '歴史的価値', '芸術的価値'],
      'correctIndex': 1,
    },
    {
      'question': '法隆寺がある都道府県は？',
      'options': ['京都府', '奈良県', '大阪府', '兵庫県'],
      'correctIndex': 1,
    },
    {
      'question': '石見銀山はどの県にある？',
      'options': ['島根県', '鳥取県', '岡山県', '広島県'],
      'correctIndex': 0,
    },
    {
      'question': '小笠原諸島が世界遺産に登録された主な理由は？',
      'options': ['歴史的建造物', '固有種の生態系', '美しい景観', '文化的伝統'],
      'correctIndex': 1,
    },
    {
      'question': '日光の社寺がある都道府県は？',
      'options': ['群馬県', '栃木県', '茨城県', '埼玉県'],
      'correctIndex': 1,
    },
    {
      'question': '姫路城の別名は？',
      'options': ['黒鷺城', '白鷺城', '金鯱城', '銀鯱城'],
      'correctIndex': 1,
    },
    {
      'question': '沖ノ島と関連遺産群の正式名称に含まれる言葉は？',
      'options': ['海の道', '神宿る島', '祈りの島', '聖なる島'],
      'correctIndex': 1,
    },
  ];

  /// 世界の世界遺産の問題
  static const List<Map<String, dynamic>> worldQuestions = [
    {
      'question': 'エジプトのピラミッドがある場所は？',
      'options': ['カイロ', 'ギザ', 'ルクソール', 'アスワン'],
      'correctIndex': 1,
    },
    {
      'question': 'タージ・マハルはどの国にある？',
      'options': ['パキスタン', 'バングラデシュ', 'インド', 'ネパール'],
      'correctIndex': 2,
    },
    {
      'question': '万里の長城はどの国の世界遺産？',
      'options': ['日本', '韓国', '中国', 'モンゴル'],
      'correctIndex': 2,
    },
    {
      'question': 'マチュピチュがある国は？',
      'options': ['ブラジル', 'アルゼンチン', 'チリ', 'ペルー'],
      'correctIndex': 3,
    },
    {
      'question': 'アンコール・ワットはどの国にある？',
      'options': ['タイ', 'ベトナム', 'カンボジア', 'ミャンマー'],
      'correctIndex': 2,
    },
    {
      'question': '自由の女神像がある都市は？',
      'options': ['ロサンゼルス', 'ニューヨーク', 'シカゴ', 'ボストン'],
      'correctIndex': 1,
    },
    {
      'question': 'サグラダ・ファミリアがある都市は？',
      'options': ['マドリード', 'バルセロナ', 'バレンシア', 'セビリア'],
      'correctIndex': 1,
    },
    {
      'question': 'グランドキャニオンはどの国にある？',
      'options': ['カナダ', 'メキシコ', 'アメリカ', 'ブラジル'],
      'correctIndex': 2,
    },
    {
      'question': 'ヴェルサイユ宮殿はどの国にある？',
      'options': ['イギリス', 'ドイツ', 'イタリア', 'フランス'],
      'correctIndex': 3,
    },
    {
      'question': 'ストーンヘンジはどの国にある？',
      'options': ['アイルランド', 'スコットランド', 'イングランド', 'ウェールズ'],
      'correctIndex': 2,
    },
  ];

  /// テーマに応じた問題を取得
  static List<Map<String, dynamic>> getQuestions(QuizTheme theme) {
    switch (theme) {
      case QuizTheme.basic:
        return basicQuestions;
      case QuizTheme.japan:
        return japanQuestions;
      case QuizTheme.world:
        return worldQuestions;
    }
  }
}
