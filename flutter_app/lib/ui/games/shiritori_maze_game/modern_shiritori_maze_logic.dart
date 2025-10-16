import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/debug_logger.dart';
import 'models/shiritori_maze_models.dart';
import '../base/common_game_phase.dart';
import '../base/answer_handler_mixin.dart';

/// しりとり迷路ゲームロジック
class ModernShiritoriMazeLogic extends StateNotifier<ShiritoriMazeState>
    with AnswerHandlerMixin {
  static const String _tag = 'ShiritoriMazeGame';
  final math.Random _random = math.Random();

  ModernShiritoriMazeLogic()
      : super(const ShiritoriMazeState(phase: CommonGamePhase.ready)) {
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
    if (state.session == null || state.session!.currentProblem == null) return;

    // 最初のセルだけ残す
    final initialPath = [state.session!.currentProblem!.correctPath.first];

    state = state.copyWith(
      phase: CommonGamePhase.questioning,
      session: state.session!.copyWith(selectedPath: initialPath),
    );
  }

  // ---- BaseGameScreen互換プロパティ ----
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  // ---- ゲーム制御 ----

  /// ゲーム開始
  void startGame(ShiritoriMazeSettings settings) {
    Log.d('Starting game: ${settings.displayName}', tag: _tag);

    final initialResults = List<bool?>.filled(settings.questionCount, null);

    // 先に設定をstateに保存してから問題生成
    state = ShiritoriMazeState(
      phase: CommonGamePhase.questioning,
      settings: settings,
      epoch: state.epoch + 1,
    );

    final firstProblem = _generateProblem();

    // 最初のセルを自動的に選択
    final initialPath = [firstProblem.correctPath.first];

    state = state.copyWith(
      session: ShiritoriMazeSession(
        index: 0,
        total: settings.questionCount,
        results: initialResults,
        currentProblem: firstProblem,
        selectedPath: initialPath,
      ),
    );
  }

  /// セルをタップ
  void onCellTapped(int gridIndex) {
    if (!state.canAnswer || state.session?.currentProblem == null) return;

    final session = state.session!;
    final problem = session.currentProblem!;
    final selectedPath = List<int>.from(session.selectedPath);

    // 既に選択済みのセルはスキップ
    if (selectedPath.contains(gridIndex)) {
      return;
    }

    final lastCell = selectedPath.last;

    // しりとりルールチェックのみ
    final lastWord = problem.gridMap[lastCell]!;
    final nextWord = problem.gridMap[gridIndex];

    if (nextWord == null) return;

    if (!_isValidShiritori(lastWord, nextWord)) {
      Log.d('Invalid shiritori: $lastWord -> $nextWord', tag: _tag);
      return;
    }

    // パスに追加
    selectedPath.add(gridIndex);
    Log.d('Path updated: $selectedPath', tag: _tag);

    state = state.copyWith(
      session: session.copyWith(selectedPath: selectedPath),
    );

    // ゴール到達チェック
    if (gridIndex == problem.correctPath.last) {
      _submitAnswer();
    }
  }

  /// しりとりルールチェック
  bool _isValidShiritori(String from, String to) {
    if (from.isEmpty || to.isEmpty) return false;
    final lastChar = from[from.length - 1];
    final firstChar = to[0];
    return lastChar == firstChar;
  }

  /// やりなおし
  void resetPath() {
    if (state.session == null || state.session!.currentProblem == null) return;

    // 最初のセルだけ残す
    final initialPath = [state.session!.currentProblem!.correctPath.first];

    state = state.copyWith(
      session: state.session!.copyWith(selectedPath: initialPath),
    );
  }

  /// 回答確定
  Future<void> _submitAnswer() async {
    if (!state.canAnswer || state.session?.currentProblem == null) {
      return;
    }

    final currentEpoch = state.epoch;
    final session = state.session!;
    final problem = session.currentProblem!;
    final selectedPath = session.selectedPath;

    Log.d('Submit answer: $selectedPath (epoch: $currentEpoch)', tag: _tag);

    // 処理中状態に変更
    state = state.copyWith(
      phase: CommonGamePhase.processing,
      epoch: currentEpoch,
    );

    await Future.delayed(const Duration(milliseconds: 300));

    if (!mounted || state.epoch != currentEpoch) return;

    // 正解判定：選択したパスが正解パスと一致するか
    final isCorrect = _checkPath(problem.correctPath, selectedPath);

    Log.d('Answer is ${isCorrect ? "correct" : "wrong"}', tag: _tag);

    if (isCorrect) {
      await _handleCorrectAnswer(currentEpoch);
    } else {
      await _handleWrongAnswer(currentEpoch);
    }
  }

  /// パスチェック
  bool _checkPath(List<int> correctPath, List<int> userPath) {
    if (userPath.length != correctPath.length) return false;

    for (int i = 0; i < correctPath.length; i++) {
      if (correctPath[i] != userPath[i]) {
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

    // 再挑戦可能
    final allowRetry = true;

    // 最初のセルだけ残す
    final initialPath = [session.currentProblem!.correctPath.first];

    await handleWrongAnswer(
      epoch: epoch,
      allowRetry: allowRetry,
      updateState: () {
        state = state.copyWith(
          phase: CommonGamePhase.feedbackNg,
          session: session.copyWith(
            wrongAttempts: session.wrongAttempts + 1,
            selectedPath: initialPath, // 最初のセルだけ残す
          ),
        );
      },
    );
  }

  /// 次の問題または完了
  Future<void> _autoAdvance() async {
    state = state.copyWith(phase: CommonGamePhase.transitioning);

    await Future.delayed(const Duration(milliseconds: 350));

    if (!mounted) return;

    final session = state.session!;
    if (session.isLast) {
      // ゲーム完了
      state = state.copyWith(phase: CommonGamePhase.completed);
      Log.d('Game completed - score: ${session.correctCount}/${session.total}',
          tag: _tag);
    } else {
      // 次の問題
      final nextProblem = _generateProblem();

      // 最初のセルを自動的に選択
      final initialPath = [nextProblem.correctPath.first];

      final nextSession = ShiritoriMazeSession(
        index: session.index + 1,
        total: session.total,
        results: session.results,
        currentProblem: nextProblem,
        selectedPath: initialPath,
      );

      Log.d('Advancing to question ${nextSession.index + 1}', tag: _tag);

      state = state.copyWith(
        phase: CommonGamePhase.questioning,
        session: nextSession,
      );
    }
  }

  /// 問題生成
  ShiritoriMazeProblem _generateProblem() {
    final settings = state.settings!;
    final rows = settings.rows;
    final cols = settings.cols;
    final gridSize = settings.gridSize;

    // ランダムにルートを選択
    final route = ShiritoriRouteDatabase.routes[_random.nextInt(ShiritoriRouteDatabase.routes.length)];

    final gridMap = <int, String>{};
    final correctPath = <int>[];

    // 先にパスを埋める（スタート0からゴール11まで隣接する経路）
    final startIndex = 0; // 左上
    final goalIndex = gridSize - 1; // 右下

    // 経路を作成（上下左右のみで隣接）
    final pathIndices = _generatePath(startIndex, goalIndex, rows, cols, route.correctPath.length);

    // 経路に単語を配置
    for (int i = 0; i < route.correctPath.length; i++) {
      gridMap[pathIndices[i]] = route.correctPath[i];
      correctPath.add(pathIndices[i]);
    }

    // 残りのマスにおとりの単語を配置
    final usedIndices = Set<int>.from(pathIndices);
    final availableIndices = List.generate(gridSize, (i) => i)
      ..removeWhere((i) => usedIndices.contains(i))
      ..shuffle(_random);

    final decoyWords = List<String>.from(route.decoyWords)..shuffle(_random);

    for (int i = 0; i < decoyWords.length && i < availableIndices.length; i++) {
      gridMap[availableIndices[i]] = decoyWords[i];
    }

    Log.d('Generated problem: route=${route.correctPath}, path=$pathIndices', tag: _tag);

    return ShiritoriMazeProblem(
      route: route,
      gridMap: gridMap,
      correctPath: correctPath,
    );
  }

  /// スタートからゴールまでの経路を生成（上下左右のみ）
  List<int> _generatePath(int start, int goal, int rows, int cols, int pathLength) {
    final path = <int>[start];
    int current = start;

    while (path.length < pathLength) {
      final neighbors = _getNeighbors(current, rows, cols);

      // まだ訪れていない隣接セルのうち、ゴールに近づく方向を優先
      neighbors.removeWhere((n) => path.contains(n));

      if (neighbors.isEmpty) {
        // 行き詰まったらやり直し
        return _generatePath(start, goal, rows, cols, pathLength);
      }

      // 最後のステップならゴールを選択
      if (path.length == pathLength - 1) {
        if (neighbors.contains(goal)) {
          path.add(goal);
          break;
        } else {
          // ゴールに到達できない経路なのでやり直し
          return _generatePath(start, goal, rows, cols, pathLength);
        }
      }

      // ゴールに向かう方向を選択（ランダム性を持たせる）
      neighbors.shuffle(_random);
      current = neighbors.first;
      path.add(current);
    }

    return path;
  }

  /// 上下左右の隣接セルを取得
  List<int> _getNeighbors(int index, int rows, int cols) {
    final x = index % cols;
    final y = index ~/ cols;
    final neighbors = <int>[];

    // 上
    if (y > 0) neighbors.add((y - 1) * cols + x);
    // 下
    if (y < rows - 1) neighbors.add((y + 1) * cols + x);
    // 左
    if (x > 0) neighbors.add(y * cols + (x - 1));
    // 右
    if (x < cols - 1) neighbors.add(y * cols + (x + 1));

    return neighbors;
  }

  /// ゲームリセット
  void resetGame() {
    Log.d('Resetting game', tag: _tag);
    state = const ShiritoriMazeState(phase: CommonGamePhase.ready);
  }
}

/// プロバイダー
final modernShiritoriMazeLogicProvider =
    StateNotifierProvider.autoDispose<ModernShiritoriMazeLogic, ShiritoriMazeState>((ref) {
  return ModernShiritoriMazeLogic();
});
