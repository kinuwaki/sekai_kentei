import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/instant_feedback_service.dart';
import '../base/common_game_phase.dart';
import 'models/shape_matching_models.dart';

// プロバイダー
final modernShapeMatchingLogicProvider = StateNotifierProvider.autoDispose<ModernShapeMatchingLogic, ShapeMatchingState>((ref) {
  return ModernShapeMatchingLogic();
});

// ロジッククラス
class ModernShapeMatchingLogic extends StateNotifier<ShapeMatchingState> {
  static const String _tag = 'ShapeMatchingLogic';
  math.Random _random = math.Random();

  ModernShapeMatchingLogic() : super(const ShapeMatchingState());

  // BaseGameScreen互換プロパティ
  String? get questionText => state.questionText;
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  // BaseGameScreen互換メソッド - リセット
  void resetGame() {
    // 状態を初期化（ゲームを再開始しない）
    debugPrint('[$_tag] ゲームリセット');
    state = const ShapeMatchingState();
  }

  // ゲーム開始
  void startGame(ShapeMatchingSettings settings) {
    debugPrint('[$_tag] ゲーム開始: ${settings.displayName}');
    
    // シード初期化
    if (settings.seed != 0) {
      _random = math.Random(settings.seed);
    } else {
      _random = math.Random(DateTime.now().millisecondsSinceEpoch);
    }

    final firstProblem = _generateProblem(settings, 0);
    final session = ShapeMatchingSession(
      index: 0,
      total: settings.questionCount,
      results: List.filled(settings.questionCount, null),
      currentProblem: firstProblem,
    );

    state = state.copyWith(
      phase: CommonGamePhase.displaying,
      settings: settings,
      session: session,
      epoch: state.epoch + 1,
    );

    _autoAdvance();
  }

  // タイル選択
  void toggleTile(int index) {
    if (!state.canSelectTiles || state.session == null) return;
    
    final session = state.session!;
    final selectedTiles = Set<int>.from(session.selectedTiles);
    
    if (selectedTiles.contains(index)) {
      selectedTiles.remove(index);
      debugPrint('[$_tag] タイル選択解除: $index');
    } else {
      selectedTiles.add(index);
      debugPrint('[$_tag] タイル選択: $index');
    }

    state = state.copyWith(
      session: session.copyWith(selectedTiles: selectedTiles),
    );
  }

  // 答え合わせ
  Future<void> checkAnswer() async {
    if (!state.canAnswer || state.session?.currentProblem == null) return;
    
    final currentEpoch = state.epoch;
    final session = state.session!;
    final problem = session.currentProblem!;
    
    debugPrint('[$_tag] 答え合わせ: 選択=${session.selectedTiles}, 正解=${problem.answerIndices} (epoch: $currentEpoch)');

    // 処理中状態に変更
    state = state.copyWith(
      phase: CommonGamePhase.processing,
      epoch: currentEpoch,
    );

    // 回答判定
    final isCorrect = problem.isCorrectAnswer(session.selectedTiles);
    final isPerfect = isCorrect && session.wrongAttempts == 0;
    
    final result = ShapeMatchingResult(
      selectedIndices: session.selectedTiles,
      correctIndices: problem.answerIndices,
      isCorrect: isCorrect,
      isPerfect: isPerfect,
      attemptCount: session.wrongAttempts + 1,
    );

    // フィードバック効果音
    if (isCorrect) {
      InstantFeedbackService().playCorrectAnswerFeedback();
    } else {
      InstantFeedbackService().playWrongAnswerFeedback();
    }

    if (isCorrect) {
      await _handleCorrectAnswer(result, currentEpoch);
    } else {
      await _handleWrongAnswer(result, currentEpoch);
    }
  }

  // 正解処理
  Future<void> _handleCorrectAnswer(ShapeMatchingResult result, int epoch) async {
    if (state.epoch != epoch) return;
    
    state = state.copyWith(
      phase: CommonGamePhase.feedbackOk,
      lastResult: result,
    );

    await Future.delayed(const Duration(milliseconds: 1500));
    if (state.epoch != epoch) return;

    _proceedToNext(result.isPerfect);
  }

  // 不正解処理
  Future<void> _handleWrongAnswer(ShapeMatchingResult result, int epoch) async {
    if (state.epoch != epoch) return;
    
    final session = state.session!;
    final problem = session.currentProblem!;
    final updatedWrongAttempts = session.wrongAttempts + 1;
    
    // 正解選択を計算（選択した中で正解のもの）
    final correctlySelectedTiles = session.selectedTiles.intersection(problem.answerIndices);
    
    state = state.copyWith(
      phase: CommonGamePhase.feedbackNg,
      lastResult: result,
      session: session.copyWith(
        wrongAttempts: updatedWrongAttempts,
        correctlySelectedTiles: correctlySelectedTiles,
      ),
    );

    // 2回間違えたら次の問題へ（この問題は不正解扱い）
    if (updatedWrongAttempts >= 2) {
      // 短い遅延後に次へ
      await Future.delayed(const Duration(milliseconds: 800));
      if (state.epoch != epoch) return;
      
      // 不正解として記録して次へ進む
      _proceedToNext(false);
    } else {
      // 1回目の間違いの場合は、少し待ってから再試行可能にする
      await Future.delayed(const Duration(milliseconds: 800));
      if (state.epoch != epoch) return;

      // 再試行可能状態に戻す（正解選択は保持、それ以外はクリア）
      state = state.copyWith(
        phase: CommonGamePhase.questioning,
        lastResult: null,
        session: state.session?.copyWith(
          selectedTiles: correctlySelectedTiles,
        ),
      );
    }
  }

  // 次の問題へ
  void _proceedToNext(bool isPerfect) {
    final session = state.session!;
    final newResults = List<bool?>.from(session.results);
    newResults[session.index] = isPerfect;

    if (session.index + 1 >= session.total) {
      // ゲーム完了
      state = state.copyWith(
        phase: CommonGamePhase.completed,
        session: session.copyWith(
          results: newResults,
          selectedTiles: {},
          correctlySelectedTiles: {},
        ),
      );
    } else {
      // 次の問題
      final nextProblem = _generateProblem(state.settings!, session.index + 1);
      state = state.copyWith(
        phase: CommonGamePhase.transitioning,
        session: session.copyWith(
          index: session.index + 1,
          results: newResults,
          currentProblem: nextProblem,
          wrongAttempts: 0,
          selectedTiles: {},
          correctlySelectedTiles: {},
        ),
      );
      _autoAdvance();
    }
  }

  // 自動進行
  Future<void> _autoAdvance() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (state.phase == CommonGamePhase.displaying || state.phase == CommonGamePhase.transitioning) {
      state = state.copyWith(phase: CommonGamePhase.questioning);
    }
  }

  // 問題生成
  ShapeMatchingProblem _generateProblem(ShapeMatchingSettings settings, int index) {
    debugPrint('[$_tag] 問題生成: index=$index');
    
    // ターゲットをランダム生成
    final target = _generateRandomTileSpec();
    
    // 正解の数を決定
    final targetCount = settings.targetCountMin + 
        _random.nextInt(settings.targetCountMax - settings.targetCountMin + 1);
    
    // グリッド生成
    final totalCells = settings.totalCells;
    final grid = List<TileSpec>.filled(totalCells, target);
    final answerIndices = <int>{};
    
    // 正解位置をランダムに配置
    while (answerIndices.length < targetCount) {
      final index = _random.nextInt(totalCells);
      answerIndices.add(index);
    }
    
    // 残りのマスをダミーで埋める
    for (int i = 0; i < totalCells; i++) {
      if (!answerIndices.contains(i)) {
        grid[i] = _generateDifferentTileSpec(target);
      }
    }
    
    // 問題文生成
    final questionText = '${target.ttsText}を つけましょう';
    
    return ShapeMatchingProblem(
      target: target,
      grid: grid,
      answerIndices: answerIndices,
      questionText: questionText,
    );
  }

  // ランダムなタイル仕様生成
  TileSpec _generateRandomTileSpec() {
    final shape = GeoShape.values[_random.nextInt(GeoShape.values.length)];
    final variant = GeoVariant.values[_random.nextInt(GeoVariant.values.length)];
    final color = GeoColor.values[_random.nextInt(GeoColor.values.length)];
    
    return TileSpec(shape: shape, variant: variant, color: color);
  }

  // ターゲットと異なるタイル仕様生成
  TileSpec _generateDifferentTileSpec(TileSpec target) {
    TileSpec result;
    int attempts = 0;
    
    do {
      // どれか1つまたは2つを変える
      final changeWhat = _random.nextInt(7); // 0-6で7パターン
      
      GeoShape shape = target.shape;
      GeoVariant variant = target.variant;
      GeoColor color = target.color;
      
      switch (changeWhat) {
        case 0: // 形だけ変更
          shape = _randomDifferent(GeoShape.values, target.shape);
          break;
        case 1: // 色だけ変更
          color = _randomDifferent(GeoColor.values, target.color);
          break;
        case 2: // バリアントだけ変更
          variant = _randomDifferent(GeoVariant.values, target.variant);
          break;
        case 3: // 形と色を変更
          shape = _randomDifferent(GeoShape.values, target.shape);
          color = _randomDifferent(GeoColor.values, target.color);
          break;
        case 4: // 形とバリアントを変更
          shape = _randomDifferent(GeoShape.values, target.shape);
          variant = _randomDifferent(GeoVariant.values, target.variant);
          break;
        case 5: // 色とバリアントを変更
          color = _randomDifferent(GeoColor.values, target.color);
          variant = _randomDifferent(GeoVariant.values, target.variant);
          break;
        case 6: // 全部変更
          shape = _randomDifferent(GeoShape.values, target.shape);
          color = _randomDifferent(GeoColor.values, target.color);
          variant = _randomDifferent(GeoVariant.values, target.variant);
          break;
      }
      
      result = TileSpec(shape: shape, variant: variant, color: color);
      attempts++;
    } while (result.matches(target) && attempts < 10);
    
    return result;
  }

  // 異なる値をランダムに選択
  T _randomDifferent<T>(List<T> values, T current) {
    if (values.length <= 1) return current;
    
    T result;
    do {
      result = values[_random.nextInt(values.length)];
    } while (result == current);
    
    return result;
  }
}