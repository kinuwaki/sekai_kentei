import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/debug_logger.dart';
import 'models/instant_memory_models.dart';
import '../base/common_game_phase.dart';
import '../base/answer_handler_mixin.dart';

/// 瞬間記憶ゲームロジック
class ModernInstantMemoryLogic extends StateNotifier<InstantMemoryState>
    with AnswerHandlerMixin {
  static const String _tag = 'InstantMemoryGame';
  final math.Random _random = math.Random();

  // 使用可能な単語リスト（単語ゲームと同じ）
  static const List<String> _availableWords = [
    'あいす', 'あさがお', 'あり', 'うきわ', 'うさぎ', 'うでどけい', 'うま', 'えび',
    'えんぴつ', 'おたま', 'おにぎり', 'かたつむり', 'きうい', 'きゃべつ', 'きりん', 'くるま',
    'こっぷ', 'さいころ', 'じてんしゃ', 'しんかんせん', 'すずめ', 'すにーかー', 'すぷーん', 'ぞう',
    'らけっと', 'たんぽぽ', 'ちゅーりっぷ', 'ちりとり', 'とまと', 'とらくたー', 'にんじん', 'はさみ',
    'ばす', 'ばなな', 'ひこうき', 'ふうせん', 'ふぉーく', 'ぶどう', 'ふね', 'ふらいぱん',
    'ほうき', 'ほうちょう', 'ぼーる', 'ほっちきす', 'みかん', 'めがね', 'めろん', 'もみじ',
    'やかん', 'らいおん', 'りんご', 'れもん', 'れんこん',
  ];

  ModernInstantMemoryLogic()
      : super(const InstantMemoryState(phase: CommonGamePhase.ready)) {
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
  String? get questionText => state.questionText;
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  // ---- ゲーム制御 ----

  /// ゲーム開始
  void startGame(InstantMemorySettings settings) {
    Log.d('Starting game: ${settings.displayName}', tag: _tag);

    final initialResults = List<bool?>.filled(settings.questionCount, null);
    final firstProblem = _generateProblem(settings);

    state = InstantMemoryState(
      phase: CommonGamePhase.displaying,
      settings: settings,
      session: InstantMemorySession(
        index: 0,
        total: settings.questionCount,
        results: initialResults,
        currentProblem: firstProblem,
      ),
      epoch: state.epoch + 1,
    );

    // 記憶時間後に問題表示フェーズへ
    _scheduleQuestioningPhase(settings.memorySeconds);
  }

  /// 記憶時間後に質問フェーズへ移行
  Future<void> _scheduleQuestioningPhase(int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
    if (!mounted) return;

    state = state.copyWith(
      phase: CommonGamePhase.questioning,
      session: state.session?.copyWith(showingAnswer: true),
      epoch: state.epoch + 1,
    );
  }

  /// 回答処理
  Future<void> answerQuestion(int selectedIndex) async {
    if (!state.canAnswer || state.session?.currentProblem == null) {
      return;
    }

    final currentEpoch = state.epoch;
    final session = state.session!;
    final problem = session.currentProblem!;

    Log.d('Answer: $selectedIndex (correct: ${problem.changedIndex}, epoch: $currentEpoch)', tag: _tag);

    // 処理中状態に変更
    state = state.copyWith(
      phase: CommonGamePhase.processing,
      epoch: currentEpoch,
    );

    // 正解判定
    final isCorrect = selectedIndex == problem.changedIndex;

    Log.d('Answer is ${isCorrect ? "correct" : "wrong"}', tag: _tag);

    if (isCorrect) {
      await _handleCorrectAnswer(currentEpoch);
    } else {
      await _handleWrongAnswer(currentEpoch);
    }
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
      Log.d('Game completed - score: ${session.score}/${session.total}',
          tag: _tag);
    } else {
      // 次の問題
      final nextProblem = _generateProblem(state.settings!);
      final nextSession = InstantMemorySession(
        index: session.index + 1,
        total: session.total,
        results: session.results,
        currentProblem: nextProblem,
      );

      Log.d('Advancing to question ${nextSession.index + 1}', tag: _tag);

      state = state.copyWith(
        phase: CommonGamePhase.displaying,
        session: nextSession,
      );

      _scheduleQuestioningPhase(state.settings!.memorySeconds);
    }
  }

  /// ランダム座標生成（0.0〜1.0の範囲）
  /// 単純に乱数生成のみ（UI側で矩形の重なり判定と再配置を行う）
  List<Map<String, double>> _generateRandomPositions(int count) {
    final positions = <Map<String, double>>[];

    for (int i = 0; i < count; i++) {
      final x = _random.nextDouble();
      final y = _random.nextDouble();
      positions.add({'x': x, 'y': y});
      Log.d('Position $i: u=$x, v=$y (normalized 0..1)', tag: _tag);
    }

    return positions;
  }

  /// 問題生成
  InstantMemoryProblem _generateProblem(InstantMemorySettings settings) {
    final difficulty = settings.difficulty;

    // アイテム数をランダムに決定
    final itemCount = difficulty.minItems +
        _random.nextInt(difficulty.maxItems - difficulty.minItems + 1);

    // ランダムな単語を選択（重複なし）
    final selectedWords = List<String>.from(_availableWords)..shuffle(_random);

    // ランダム座標生成
    final positions = _generateRandomPositions(itemCount);
    final initialItems = <MemoryItem>[];

    for (int i = 0; i < itemCount; i++) {
      initialItems.add(MemoryItem(
        word: selectedWords[i],
        id: i,
        x: positions[i]['x']!,
        y: positions[i]['y']!,
      ));
    }

    // 追加か置き換えをランダムに決定
    final changeType = ChangeType.values[_random.nextInt(ChangeType.values.length)];
    List<MemoryItem> changedItems;
    int changedIndex;
    String displayWord;

    if (changeType == ChangeType.added) {
      // 追加：新しいアイテムを含めて全座標を再生成
      final newWord = selectedWords[itemCount];
      final newPositions = _generateRandomPositions(itemCount + 1);
      changedItems = <MemoryItem>[];

      for (int i = 0; i < itemCount; i++) {
        changedItems.add(MemoryItem(
          word: selectedWords[i],
          id: i,
          x: newPositions[i]['x']!,
          y: newPositions[i]['y']!,
        ));
      }

      // 新しいアイテムを追加
      changedItems.add(MemoryItem(
        word: newWord,
        id: itemCount,
        x: newPositions[itemCount]['x']!,
        y: newPositions[itemCount]['y']!,
      ));

      changedIndex = itemCount;
      displayWord = newWord;
      Log.d('Problem: added $newWord at index $changedIndex', tag: _tag);
    } else {
      // 置き換え：1個を別の図形に変更
      changedIndex = _random.nextInt(initialItems.length);
      final newWord = selectedWords[itemCount];
      displayWord = newWord;

      changedItems = <MemoryItem>[];
      for (int i = 0; i < itemCount; i++) {
        if (i == changedIndex) {
          changedItems.add(MemoryItem(
            word: newWord,
            id: itemCount,
            x: positions[i]['x']!,
            y: positions[i]['y']!,
          ));
        } else {
          // 変更されていないアイテムはそのまま使用（epochでシードが変わるのでUI層で配置は変わる）
          changedItems.add(initialItems[i]);
        }
      }
      Log.d('Problem: replaced ${initialItems[changedIndex].word} with $newWord at index $changedIndex', tag: _tag);
    }
    Log.d('Generated problem: type=$changeType, itemCount=$itemCount, changedIndex=$changedIndex', tag: _tag);

    return InstantMemoryProblem(
      initialItems: initialItems,
      changedItems: changedItems,
      changeType: changeType,
      changedIndex: changedIndex,
      displayWord: displayWord,
    );
  }

  /// ゲームリセット
  void resetGame() {
    Log.d('Resetting game', tag: _tag);
    state = const InstantMemoryState(phase: CommonGamePhase.ready);
  }
}

/// プロバイダー
final modernInstantMemoryLogicProvider =
    StateNotifierProvider.autoDispose<ModernInstantMemoryLogic, InstantMemoryState>((ref) {
  return ModernInstantMemoryLogic();
});
