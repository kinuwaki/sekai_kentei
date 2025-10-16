import 'package:freezed_annotation/freezed_annotation.dart';
import '../../base/common_game_phase.dart';

part 'shiritori_maze_models.freezed.dart';

/// しりとりルートデータ
@freezed
abstract class ShiritoriRoute with _$ShiritoriRoute {
  const factory ShiritoriRoute({
    required List<String> correctPath,  // しりとりの正解ルート（例: ['けむし', 'しか', 'かめ', ...]）
    required List<String> decoyWords,   // 関係ないひらがな（例: ['うま', 'ぞう', ...]）
  }) = _ShiritoriRoute;

  const ShiritoriRoute._();

  /// すべての単語を取得
  List<String> get allWords => [...correctPath, ...decoyWords];
}

/// ゲーム設定
@freezed
abstract class ShiritoriMazeSettings with _$ShiritoriMazeSettings {
  const factory ShiritoriMazeSettings({
    @Default(3) int questionCount,  // 問題数
    @Default(3) int rows,           // グリッドの行数（4x3固定）
    @Default(4) int cols,           // グリッドの列数
  }) = _ShiritoriMazeSettings;

  const ShiritoriMazeSettings._();

  String get displayName => 'しりとりめいろ（$questionCount問）';
  int get gridSize => rows * cols;
}

/// 問題
@freezed
abstract class ShiritoriMazeProblem with _$ShiritoriMazeProblem {
  const factory ShiritoriMazeProblem({
    required ShiritoriRoute route,        // しりとりルート
    required Map<int, String> gridMap,    // グリッド位置→単語のマッピング
    required List<int> correctPath,       // 正解の経路（グリッドインデックス）
  }) = _ShiritoriMazeProblem;

  const ShiritoriMazeProblem._();

  String get questionText => 'しりとりをしながら\nあかからあおにむかいましょう';
  String get startWord => route.correctPath.first;
  String get goalWord => route.correctPath.last;
}

/// セッション
@freezed
abstract class ShiritoriMazeSession with _$ShiritoriMazeSession {
  const factory ShiritoriMazeSession({
    required int index,                   // 現在の問題番号
    required int total,                   // 総問題数
    required List<bool?> results,         // 結果配列
    ShiritoriMazeProblem? currentProblem,
    @Default([]) List<int> selectedPath,  // 選択した経路
    @Default(0) int wrongAttempts,        // 間違い回数
  }) = _ShiritoriMazeSession;

  const ShiritoriMazeSession._();

  bool get isCompleted => index >= total;
  bool get isLast => index + 1 >= total;
  int get correctCount => results.where((r) => r == true).length;
}

/// ゲーム状態
@freezed
abstract class ShiritoriMazeState with _$ShiritoriMazeState {
  const factory ShiritoriMazeState({
    @Default(CommonGamePhase.ready) CommonGamePhase phase,
    ShiritoriMazeSettings? settings,
    ShiritoriMazeSession? session,
    @Default(0) int epoch,
  }) = _ShiritoriMazeState;

  const ShiritoriMazeState._();

  bool get canAnswer => phase == CommonGamePhase.questioning;
  bool get isProcessing =>
      phase == CommonGamePhase.processing ||
      phase == CommonGamePhase.transitioning;
  double get progress =>
      session != null ? session!.index / session!.total : 0.0;
  String? get questionText => session?.currentProblem?.questionText;
}

/// しりとりルートデータベース
///
/// データセット追加方法：
/// routesリストに新しいShiritoriRouteを追加してください。
///
/// 例：
/// ShiritoriRoute(
///   correctPath: ['いぬ', 'ぬま', 'まど', 'どあ'],
///   decoyWords: ['ねこ', 'とり', 'ひと', 'かさ'],
/// ),
class ShiritoriRouteDatabase {
  static const List<ShiritoriRoute> routes = [
    // ルート1: けむし → にわとり
    ShiritoriRoute(
      correctPath: ['けむし', 'しか', 'かめ', 'めだか', 'かに', 'にわとり'],
      decoyWords: ['うま', 'ぞう', 'ねこ', 'さる', 'いぬ', 'たぬき'],
    ),

    // ルート2: どうぶつしりとり - ねこ → かに
    ShiritoriRoute(
      correctPath: ['ねこ', 'こいぬ', 'ぬま', 'まめ', 'めだか', 'かに'],
      decoyWords: ['うま', 'さる', 'くま', 'とり', 'うさぎ', 'ぞう'],
    ),

    // ルート3: たべものしりとり - りんご → おにぎり
    ShiritoriRoute(
      correctPath: ['りんご', 'ごま', 'まめ', 'めし', 'しお', 'おにぎり'],
      decoyWords: ['ぱん', 'ばなな', 'みかん', 'けーき', 'すいか', 'やさい'],
    ),

    // ルート4: しぜんしりとり - そら → つき
    ShiritoriRoute(
      correctPath: ['そら', 'らっこ', 'こめ', 'めだま', 'まつ', 'つき'],
      decoyWords: ['かわ', 'やま', 'はな', 'もり', 'たいよう', 'くも'],
    ),

    // ルート5: のりものしりとり - くるま → めだか
    ShiritoriRoute(
      correctPath: ['くるま', 'まり', 'りす', 'すいか', 'かめ', 'めだか'],
      decoyWords: ['でんしゃ', 'ばす', 'ふね', 'じてんしゃ', 'とらっく', 'ひこうき'],
    ),

    // ルート6: おもちゃしりとり - まり → にんぎょう
    ShiritoriRoute(
      correctPath: ['まり', 'りす', 'すな', 'なわ', 'わに', 'にんぎょう'],
      decoyWords: ['ぼーる', 'けんだま', 'ぱずる', 'ぶろっく', 'ふうせん', 'くるま'],
    ),

    // ルート7: いきものしりとり - かめ → すずめ
    ShiritoriRoute(
      correctPath: ['かめ', 'めだか', 'かに', 'にわとり', 'りす', 'すずめ'],
      decoyWords: ['ねこ', 'うま', 'さる', 'ぞう', 'くま', 'うさぎ'],
    ),

    // ルート8: くだものしりとり - もも → もも（ループ）
    ShiritoriRoute(
      correctPath: ['もも', 'もやし', 'しお', 'おちゃ', 'やきいも', 'もも'],
      decoyWords: ['りんご', 'ばなな', 'すいか', 'みかん', 'ぶどう', 'さくらんぼ'],
    ),

    // ルート9: せいかつしりとり - くつ → きんぎょ
    ShiritoriRoute(
      correctPath: ['くつ', 'つくえ', 'えんぴつ', 'つみき', 'き', 'きんぎょ'],
      decoyWords: ['ほん', 'いす', 'かさ', 'はさみ', 'かばん', 'せっけん'],
    ),

    // ルート10: いろしりとり - あか → じかん
    ShiritoriRoute(
      correctPath: ['あか', 'かめ', 'めだか', 'かに', 'にじ', 'じかん'],
      decoyWords: ['みどり', 'あお', 'きいろ', 'しろ', 'くろ', 'ちゃいろ'],
    ),

    // ルート11: まぜまぜ（どうぶつ＋たべものミックス）- ねこ → ねずみ
    ShiritoriRoute(
      correctPath: ['ねこ', 'こめ', 'めだか', 'かき', 'きつね', 'ねずみ'],
      decoyWords: ['ばなな', 'いぬ', 'すいか', 'りす', 'くま', 'ぱん'],
    ),

    // ここに新しいルートを追加してください
    // ShiritoriRoute(
    //   correctPath: ['単語1', '単語2', '単語3', ...],
    //   decoyWords: ['おとり1', 'おとり2', ...],
    // ),
  ];
}
