import 'package:freezed_annotation/freezed_annotation.dart';
import '../../base/common_game_phase.dart';

part 'word_fill_models.freezed.dart';

/// ゲーム設定
@freezed
abstract class WordFillSettings with _$WordFillSettings {
  const factory WordFillSettings({
    @Default(5) int questionCount,
  }) = _WordFillSettings;

  const WordFillSettings._();

  String get displayName => 'ことばあなうめ（$questionCount問）';
}

/// 問題
@freezed
abstract class WordFillProblem with _$WordFillProblem {
  const factory WordFillProblem({
    required String word,           // 正解の単語（例：てぶくろ）
    required int blankIndex,        // 空欄のインデックス（0-based）
    required String imagePath,      // 画像パス
  }) = _WordFillProblem;

  const WordFillProblem._();

  /// 空欄の文字
  String get blankChar => word[blankIndex];

  /// 表示用の単語（空欄を？で表示）
  List<String> get displayChars {
    return List.generate(word.length, (i) {
      if (i == blankIndex) return '？';
      return word[i];
    });
  }
}

/// セッション
@freezed
abstract class WordFillSession with _$WordFillSession {
  const factory WordFillSession({
    required int index,
    required int total,
    required List<bool?> results,
    WordFillProblem? currentProblem,
    @Default(0) int wrongAttempts,
    @Default('') String userInput,  // ユーザーの手書き入力
  }) = _WordFillSession;

  const WordFillSession._();

  bool get isCompleted => index >= total;
  bool get isLast => index + 1 >= total;
  int get correctCount => results.where((r) => r == true).length;
  int get incorrectCount => results.where((r) => r == false).length;
}

/// ゲーム状態
@freezed
abstract class WordFillState with _$WordFillState {
  const factory WordFillState({
    @Default(CommonGamePhase.ready) CommonGamePhase phase,
    WordFillSettings? settings,
    WordFillSession? session,
    @Default(0) int epoch,
  }) = _WordFillState;

  const WordFillState._();

  bool get canAnswer => phase == CommonGamePhase.questioning;
  bool get isProcessing =>
      phase == CommonGamePhase.processing ||
      phase == CommonGamePhase.transitioning;
  double get progress =>
      session != null ? session!.index / session!.total : 0.0;
}
