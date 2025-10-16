import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/debug_logger.dart';
import 'models/placement_memory_models.dart';
import '../base/common_game_phase.dart';
import '../base/answer_handler_mixin.dart';

/// 配置記憶ゲームロジック
class ModernPlacementMemoryLogic extends StateNotifier<PlacementMemoryState>
    with AnswerHandlerMixin {
  static const String _tag = 'PlacementMemoryGame';
  final math.Random _random = math.Random();

  // 使用可能な単語リスト（瞬間記憶ゲームと同じ）
  static const List<String> _availableWords = [
    'あいす', 'あさがお', 'あり', 'うきわ', 'うさぎ', 'うでどけい', 'うま', 'えび',
    'えんぴつ', 'おたま', 'おにぎり', 'かたつむり', 'きうい', 'きゃべつ', 'きりん', 'くるま',
    'こっぷ', 'さいころ', 'じてんしゃ', 'しんかんせん', 'すずめ', 'すにーかー', 'すぷーん', 'ぞう',
    'らけっと', 'たんぽぽ', 'ちゅーりっぷ', 'ちりとり', 'とまと', 'とらくたー', 'にんじん', 'はさみ',
    'ばす', 'ばなな', 'ひこうき', 'ふうせん', 'ふぉーく', 'ぶどう', 'ふね', 'ふらいぱん',
    'ほうき', 'ほうちょう', 'ぼーる', 'ほっちきす', 'みかん', 'めがね', 'めろん', 'もみじ',
    'やかん', 'らいおん', 'りんご', 'れもん', 'れんこん',
  ];

  ModernPlacementMemoryLogic()
      : super(const PlacementMemoryState(phase: CommonGamePhase.ready)) {
    Log.d('Created new instance', tag: _tag);
  }

  // ---- AnswerHandlerMixin実装 ----
  @override
  String get gameTitle => _tag;

  @override
  bool checkEpoch(int epoch) => state.epoch == epoch;

  @override
  Future<void> proceedToNext() => _autoAdvance();

  @override
  void returnToQuestioning() {
    state = state.copyWith(phase: CommonGamePhase.questioning);
  }

  // ---- BaseGameScreen互換プロパティ ----
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  // ---- ゲーム制御 ----

  /// ゲーム開始
  void startGame(PlacementMemorySettings settings) {
    Log.d('Starting game: ${settings.displayName}', tag: _tag);

    final initialResults = List<bool?>.filled(settings.questionCount, null);

    // 先に設定をstateに保存してから問題生成
    state = PlacementMemoryState(
      phase: CommonGamePhase.displaying,
      settings: settings,
      epoch: state.epoch + 1,
    );

    final firstProblem = _generateProblem();

    state = state.copyWith(
      session: PlacementMemorySession(
        index: 0,
        total: settings.questionCount,
        results: initialResults,
        currentProblem: firstProblem,
      ),
    );

    // 8秒後に回答フェーズへ
    _scheduleQuestioningPhase();
  }

  /// 8秒後に質問フェーズへ移行
  Future<void> _scheduleQuestioningPhase() async {
    await Future.delayed(const Duration(seconds: 8));
    if (!mounted) return;

    state = state.copyWith(
      phase: CommonGamePhase.questioning,
      showingAnswer: true,
      epoch: state.epoch + 1,
    );
  }

  /// ユーザーの配置を更新
  void updateUserPlacement(List<GridItem> placement) {
    final session = state.session;
    if (session == null) return;

    state = state.copyWith(
      session: session.copyWith(userPlacement: placement),
    );
  }

  /// やりなおし
  void resetPlacement() {
    final session = state.session;
    if (session == null) return;

    state = state.copyWith(
      session: session.copyWith(userPlacement: []),
    );
  }

  /// できた（回答確定）
  Future<void> submitAnswer() async {
    if (!state.canAnswer || state.session?.currentProblem == null) {
      return;
    }

    final currentEpoch = state.epoch;
    final session = state.session!;
    final problem = session.currentProblem!;
    final userPlacement = session.userPlacement;
    final itemCount = state.settings!.actualItemCount;

    // 必要なアイテム数がすべて配置されているか確認
    if (userPlacement.length != itemCount) {
      Log.d('Not all items placed: ${userPlacement.length}/$itemCount', tag: _tag);
      return;
    }

    Log.d('Submit answer: ${userPlacement.length} items placed (epoch: $currentEpoch)', tag: _tag);

    // 処理中状態に変更
    state = state.copyWith(
      phase: CommonGamePhase.processing,
      epoch: currentEpoch,
    );

    // 正解判定：すべてのアイテムが正しい位置にあるか
    final isCorrect = _checkPlacement(problem.items, userPlacement);

    Log.d('Answer is ${isCorrect ? "correct" : "wrong"}', tag: _tag);

    if (isCorrect) {
      await _handleCorrectAnswer(currentEpoch);
    } else {
      await _handleWrongAnswer(currentEpoch);
    }
  }

  /// 配置が正しいかチェック
  bool _checkPlacement(List<GridItem> correct, List<GridItem> userPlaced) {
    if (userPlaced.length != correct.length) return false;

    // すべてのアイテムが正しい位置にあるか
    for (final correctItem in correct) {
      final userItem = userPlaced.firstWhere(
        (item) => item.word == correctItem.word,
        orElse: () => const GridItem(word: '', gridIndex: -1),
      );
      if (userItem.gridIndex != correctItem.gridIndex) {
        return false;
      }
    }
    return true;
  }

  /// 正解処理
  Future<void> _handleCorrectAnswer(int epoch) async {
    final session = state.session!;

    // この問題で間違えていなければ完全正解
    final updatedResults = List<bool?>.from(session.results);
    final isPerfect = session.wrongAttempts == 0;
    updatedResults[session.index] = isPerfect;

    Log.d('Correct answer for question ${session.index + 1}: wrongAttempts=${session.wrongAttempts}, perfect=$isPerfect',
        tag: _tag);

    await handleCorrectAnswer(
      epoch: epoch,
      updateState: () {
        state = state.copyWith(
          phase: CommonGamePhase.feedbackOk,
          session: session.copyWith(results: updatedResults),
        );
      },
    );
  }

  /// 不正解処理
  Future<void> _handleWrongAnswer(int epoch) async {
    final session = state.session!;

    Log.d('Wrong answer for question ${session.index + 1}, attempts: ${session.wrongAttempts + 1}', tag: _tag);

    // 1回失敗したら次の問題へ
    final allowRetry = false; // 再挑戦不可

    await handleWrongAnswer(
      epoch: epoch,
      allowRetry: allowRetry,
      updateState: () {
        state = state.copyWith(
          phase: CommonGamePhase.feedbackNg,
          session: session.copyWith(
            wrongAttempts: session.wrongAttempts + 1,
          ),
        );
      },
    );
  }

  /// 次の問題または完了
  Future<void> _autoAdvance() async {
    state = state.copyWith(phase: CommonGamePhase.transitioning);

    await Future.delayed(const Duration(milliseconds: 350));

    final session = state.session!;
    if (session.isLast) {
      // ゲーム完了
      state = state.copyWith(phase: CommonGamePhase.completed);
      Log.d('Game completed - score: ${session.correctCount}/${session.total}',
          tag: _tag);
    } else {
      // 次の問題
      final nextProblem = _generateProblem();
      final nextSession = PlacementMemorySession(
        index: session.index + 1,
        total: session.total,
        results: session.results,
        currentProblem: nextProblem,
      );

      Log.d('Advancing to question ${nextSession.index + 1}', tag: _tag);

      state = state.copyWith(
        phase: CommonGamePhase.displaying,
        session: nextSession,
        showingAnswer: false,
      );

      _scheduleQuestioningPhase();
    }
  }

  /// 問題生成（グリッドサイズに応じた単語をランダム配置）
  PlacementMemoryProblem _generateProblem() {
    final settings = state.settings!;
    final gridSize = settings.gridSize;
    final itemCount = settings.actualItemCount;

    // ランダムな単語を選択（重複なし）
    final selectedWords = List<String>.from(_availableWords)..shuffle(_random);
    final words = selectedWords.take(itemCount).toList();

    // 0からgridSize-1のインデックスをシャッフルしてランダムな位置に配置
    final gridIndices = List.generate(gridSize, (i) => i)..shuffle(_random);

    final items = <GridItem>[];
    for (int i = 0; i < itemCount; i++) {
      items.add(GridItem(
        word: words[i],
        gridIndex: gridIndices[i],
      ));
    }

    Log.d('Generated problem (${settings.rows}x${settings.cols}, $itemCount items): ${items.map((e) => '${e.word}@${e.gridIndex}').join(', ')}', tag: _tag);

    return PlacementMemoryProblem(items: items);
  }

  /// ゲームリセット
  void resetGame() {
    Log.d('Resetting game', tag: _tag);
    state = const PlacementMemoryState(phase: CommonGamePhase.ready);
  }
}

/// プロバイダー
final modernPlacementMemoryLogicProvider =
    StateNotifierProvider.autoDispose<ModernPlacementMemoryLogic, PlacementMemoryState>((ref) {
  return ModernPlacementMemoryLogic();
});
