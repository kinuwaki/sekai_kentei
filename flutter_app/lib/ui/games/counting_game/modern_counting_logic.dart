import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/dot_layout_service.dart';
import 'models/counting_models.dart';
import '../base/common_game_phase.dart';
import '../base/common_game_widgets.dart';
import '../base/dot_display_helper.dart';
import '../base/answer_handler_mixin.dart';

/// 新しい状態マシンベースの数かぞえゲームロジック
class ModernCountingLogic extends StateNotifier<CountingState> with AnswerHandlerMixin {
  ModernCountingLogic()
      : super(const CountingState(
          phase: CommonGamePhase.ready,
        ));

  // ---- BaseGameScreen用の互換インターフェース ----
  String? get questionText => state.questionText;
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  // ---- 互換アダプタ用のパブリック状態アクセス ----
  CountingState get currentState => state;

  // ---- AnswerHandlerMixin実装 ----
  @override
  String get gameTitle => 'CountingGame';

  @override
  bool checkEpoch(int epoch) => state.epoch == epoch;

  @override
  Future<void> proceedToNext() => _autoAdvance();

  @override
  void returnToQuestioning() => _enterQuestioning();
  
  // ---- ゲーム制御 ----
  
  void startGame(CountingGameSettings settings) {
    
    // 問題数分のnull（未回答）で初期化
    final initialResults = List<bool?>.filled(settings.questionCount, null);
    
    // 最初の問題を生成
    final firstProblem = _generateProblem(settings, 0);
    
    state = CountingState(
      phase: CommonGamePhase.displaying,
      settings: settings,
      session: CountingSession(
        index: 0,
        total: settings.questionCount,
        current: firstProblem,
        results: initialResults,
      ),
    );
    
    // 表示フェーズ後、自動的に質問フェーズへ
    _enterQuestioning();
  }

  void _enterQuestioning() {
    state = state.copyWith(phase: CommonGamePhase.questioning);
  }

  // ---- 回答処理 ----
  
  Future<void> answerQuestion(int selectedIndex) async {
    if (!state.canAnswer) return;
    
    final session = state.session!;
    final question = session.current;
    final isCorrect = selectedIndex == question.correctAnswerIndex;
    final epoch = state.epoch + 1;
    
    
    // フェーズ遷移：処理中
    state = state.copyWith(
      phase: CommonGamePhase.processing,
      epoch: epoch,
    );
    
    final result = CountingAnswerResult(
      selectedIndex: selectedIndex,
      isCorrect: isCorrect,
      correctIndex: question.correctAnswerIndex,
    );
    
    if (isCorrect) {
      await _handleCorrectAnswer(result, epoch);
    } else {
      await _handleWrongAnswer(result, epoch);
    }
  }
  
  Future<void> _handleCorrectAnswer(CountingAnswerResult result, int epoch) async {
    final session = state.session!;

    // この問題で間違えていなければ完全正解（true）、間違えていれば不完全正解（false）
    final updatedResults = List<bool?>.from(session.results);
    final finalResult = !session.currentWrong;
    updatedResults[session.index] = finalResult;

    // AnswerHandlerMixinの共通処理を使用
    await handleCorrectAnswer(
      epoch: epoch,
      updateState: () {
        state = state.copyWith(
          phase: CommonGamePhase.feedbackOk,
          lastResult: result,
          session: session.copyWith(results: updatedResults),
        );
      },
    );
  }
  
  Future<void> _handleWrongAnswer(CountingAnswerResult result, int epoch) async {
    final session = state.session!;

    // 間違えフラグを立てる
    final updatedSession = session.copyWith(currentWrong: true);

    // AnswerHandlerMixinの共通処理を使用（再挑戦あり: allowRetry=true）
    await handleWrongAnswer(
      epoch: epoch,
      allowRetry: true,
      updateState: () {
        state = state.copyWith(
          phase: CommonGamePhase.feedbackNg,
          lastResult: result,
          session: updatedSession,
        );
      },
    );
  }
  
  Future<void> _autoAdvance() async {
    state = state.copyWith(phase: CommonGamePhase.transitioning);
    
    await Future.delayed(const Duration(milliseconds: 350));
    
    final session = state.session!;
    if (session.isLast) {
      // ゲーム完了
      state = state.copyWith(phase: CommonGamePhase.completed);
    } else {
      // 次の問題へ
      final nextProblem = _generateProblem(state.settings!, session.index + 1);
      final nextSession = session.next(nextProblem);
      
      
      state = state.copyWith(
        phase: CommonGamePhase.displaying,
        session: nextSession,
        lastResult: null,
      );
      
      // 自動的に質問フェーズへ
      _enterQuestioning();
    }
  }
  
  // ---- 問題生成 ----
  
  CountingProblem _generateProblem(CountingGameSettings settings, int index) {
    final random = math.Random();
    
    // ランダムな目標数値を生成
    final targetNumber = settings.range.minValue + 
        random.nextInt(settings.range.maxValue - settings.range.minValue + 1);
    
    // 選択肢を生成（3択固定）
    final options = <int>{targetNumber};
    while (options.length < 3) {
      final wrongAnswer = settings.range.minValue + 
          random.nextInt(settings.range.maxValue - settings.range.minValue + 1);
      options.add(wrongAnswer);
    }
    
    final optionsList = options.toList()..shuffle();
    final correctIndex = optionsList.indexOf(targetNumber);
    
    // ドットの外観をランダム化
    final dotShape = DotShape.values[random.nextInt(DotShape.values.length)];
    final dotColor = [
      Colors.red, Colors.blue, Colors.green, Colors.orange, 
      Colors.purple, Colors.teal, Colors.amber
    ][random.nextInt(7)];
    
    // ドット位置とサイズを事前生成
    final dotLayoutService = DotLayoutService();
    const containerWidth = 540.0;
    const containerHeight = 540.0;
    
    final dotPositions = <int, List<Offset>>{};
    final dotSizes = <int, double>{};
    
    for (final number in {targetNumber, ...optionsList}) {
      dotPositions[number] = dotLayoutService.generateDotPositions(
        count: number,
        containerWidth: containerWidth,
        containerHeight: containerHeight,
        seed: number * 1000 + index,
      );
      dotSizes[number] = dotLayoutService.calculateDotSize(
        containerWidth, containerHeight, number
      );
    }
    
    
    return CountingProblem(
      targetNumber: targetNumber,
      options: optionsList,
      correctAnswerIndex: correctIndex,
      dotShape: dotShape,
      dotColor: dotColor,
      dotPositions: dotPositions,
      dotSizes: dotSizes,
    );
  }
  
  // ---- BaseGameScreen互換メソッド（段階的移行用）----

  void resetGame() {
    // 状態を初期化（ゲームを再開始しない）
    state = const CountingState(phase: CommonGamePhase.ready);
  }
  
  void hideSuccessEffect() {
    // 新しい状態マシンでは不要（フェーズ遷移で自動管理）
    // ただし、旧UIとの互換性のため空実装を提供
  }
  
  void displayQuestion() {
    // 互換性のため（実際には自動遷移）
    if (state.phase == CommonGamePhase.displaying) {
      _enterQuestioning();
    }
  }

  // ドット描画用ヘルパーメソッド（旧コードとの互換性のため）
  List<Widget> buildDotsFromPositions(List<Offset> positions, DotShape shape, Color color, double size) {
    final commonShape = DotDisplayHelper.convertDotShape(shape);
    return DotDisplayHelper.buildDotsFromPositions(
      positions: positions,
      shape: commonShape,
      color: color,
      size: size,
    );
  }
}

/// 新しいロジック用のプロバイダー
final modernCountingLogicProvider = StateNotifierProvider.autoDispose<ModernCountingLogic, CountingState>((ref) {
  return ModernCountingLogic();
});