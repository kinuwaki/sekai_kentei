import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/dot_layout_service.dart';
import 'models/comparison_models.dart';
import '../base/common_game_phase.dart';
import '../base/common_game_widgets.dart';
import '../base/dot_display_helper.dart';
import '../base/answer_handler_mixin.dart';

/// 新しい状態マシンベースの比較ゲームロジック
class ModernComparisonLogic extends StateNotifier<ComparisonState> with AnswerHandlerMixin {
  ModernComparisonLogic()
      : super(const ComparisonState(
          phase: CommonGamePhase.ready,
        ));

  // ---- BaseGameScreen用の互換インターフェース ----
  String? get questionText => state.questionText;
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  // ---- 互換アダプタ用のパブリック状態アクセス ----
  ComparisonState get currentState => state;

  // ---- AnswerHandlerMixin実装 ----
  @override
  String get gameTitle => 'ComparisonGame';

  @override
  bool checkEpoch(int epoch) => state.epoch == epoch;

  @override
  Future<void> proceedToNext() => _autoAdvance();

  @override
  void returnToQuestioning() => _enterQuestioning();
  
  // ---- ゲーム制御 ----
  
  void startGame(ComparisonGameSettings settings) {
    // 問題数分のnull（未回答）で初期化
    final initialResults = List<bool?>.filled(settings.questionCount, null);
    
    // 最初の問題を生成
    final firstProblem = _generateProblem(settings, 0);
    
    state = ComparisonState(
      phase: CommonGamePhase.displaying,
      settings: settings,
      session: ComparisonSession(
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
    
    final result = ComparisonAnswerResult(
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
  
  Future<void> _handleCorrectAnswer(ComparisonAnswerResult result, int epoch) async {
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
  
  Future<void> _handleWrongAnswer(ComparisonAnswerResult result, int epoch) async {
    final session = state.session!;

    // 間違いを結果に記録（false = 不正解）
    final updatedResults = List<bool?>.from(session.results);
    updatedResults[session.index] = false;

    final updatedSession = session.copyWith(
      currentWrong: true,
      results: updatedResults,
    );

    // AnswerHandlerMixinの共通処理を使用（再挑戦なし: allowRetry=false）
    await handleWrongAnswer(
      epoch: epoch,
      allowRetry: false,
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
  
  ComparisonProblem _generateProblem(ComparisonGameSettings settings, int index) {
    final random = math.Random();
    
    // 指定された択数分の数値を生成（10%以上の差をつける）
    final numbers = _generateNumbersWithMinimumDifference(
      settings.range.minValue,
      settings.range.maxValue,
      settings.optionCount,
      random,
    );
    
    final sortedNumbers = numbers.toList()..sort();
    final options = numbers.toList()..shuffle();
    
    // 正解インデックスを決定
    int correctAnswerIndex = 0;
    String questionText = '';
    
    // 問題タイプに応じた正解判定とテキスト設定
    final actualQuestionType = _determineActualQuestionType(settings.questionType, settings.optionCount, random);
    
    switch (actualQuestionType) {
      case ComparisonQuestionType.largest:
        correctAnswerIndex = options.indexOf(sortedNumbers.last);
        if (settings.displayType == ComparisonDisplayType.dots) {
          questionText = settings.optionCount == 2 ? 'どちらが おおい？' : 'いちばん おおいのは？';
        } else {
          questionText = settings.optionCount == 2 ? 'どちらが おおきい？' : 'いちばん おおきいのは？';
        }
        break;
      case ComparisonQuestionType.smallest:
        correctAnswerIndex = options.indexOf(sortedNumbers.first);
        if (settings.displayType == ComparisonDisplayType.dots) {
          questionText = settings.optionCount == 2 ? 'どちらが すくない？' : 'いちばん すくないのは？';
        } else {
          questionText = settings.optionCount == 2 ? 'どちらが ちいさい？' : 'いちばん ちいさいのは？';
        }
        break;
      case ComparisonQuestionType.secondLargest:
        correctAnswerIndex = options.indexOf(sortedNumbers[sortedNumbers.length - 2]);
        if (settings.displayType == ComparisonDisplayType.dots) {
          questionText = 'にばんめに おおいのは？';
        } else {
          questionText = 'にばんめに おおきいのは？';
        }
        break;
      case ComparisonQuestionType.secondSmallest:
        correctAnswerIndex = options.indexOf(sortedNumbers[1]);
        if (settings.displayType == ComparisonDisplayType.dots) {
          questionText = 'にばんめに すくないのは？';
        } else {
          questionText = 'にばんめに ちいさいのは？';
        }
        break;
      case ComparisonQuestionType.thirdLargest:
        correctAnswerIndex = options.indexOf(sortedNumbers[sortedNumbers.length - 3]);
        if (settings.displayType == ComparisonDisplayType.dots) {
          questionText = 'さんばんめに おおいのは？';
        } else {
          questionText = 'さんばんめに おおきいのは？';
        }
        break;
      case ComparisonQuestionType.thirdSmallest:
        correctAnswerIndex = options.indexOf(sortedNumbers[2]);
        if (settings.displayType == ComparisonDisplayType.dots) {
          questionText = 'さんばんめに すくないのは？';
        } else {
          questionText = 'さんばんめに ちいさいのは？';
        }
        break;
      default:
        // フォールバック
        correctAnswerIndex = options.indexOf(sortedNumbers.last);
        if (settings.displayType == ComparisonDisplayType.dots) {
          questionText = 'どちらが おおい？';
        } else {
          questionText = 'どちらが おおきい？';
        }
    }
    
    // ドットの外観をランダム化
    final dotShape = DotShape.values[random.nextInt(DotShape.values.length)];
    final dotColor = [
      Colors.red, Colors.blue, Colors.green, Colors.orange, 
      Colors.purple, Colors.teal, Colors.amber
    ][random.nextInt(7)];
    
    // ドット位置とサイズを事前生成（ドット表示タイプの場合のみ）
    final dotPositions = <int, List<Offset>>{};
    final dotSizes = <int, double>{};
    
    if (settings.displayType == ComparisonDisplayType.dots) {
      final dotLayoutService = DotLayoutService();
      const containerWidth = 200.0;  // Comparison gameのコンテナサイズ
      const containerHeight = 150.0;
      
      // 全選択肢の中で最も小さいドットサイズ（ドット数が最多のもの）を計算
      double uniformDotSize = double.infinity;
      for (final number in options) {
        final dotSize = dotLayoutService.calculateDotSize(
          containerWidth, containerHeight, number
        );
        if (dotSize < uniformDotSize) {
          uniformDotSize = dotSize;
        }
      }

      // 統一されたドットサイズを使用してポジションとサイズを設定
      for (final number in options) {
        dotPositions[number] = dotLayoutService.generateDotPositions(
          count: number,
          containerWidth: containerWidth,
          containerHeight: containerHeight,
          seed: number * 1000 + index,
          customDotRadius: uniformDotSize,
        );
        dotSizes[number] = uniformDotSize;
      }
    }

    return ComparisonProblem(
      options: options,
      correctAnswerIndex: correctAnswerIndex,
      questionText: questionText,
      dotShape: dotShape,
      dotColor: dotColor,
      dotPositions: dotPositions,
      dotSizes: dotSizes,
    );
  }
  
  /// 10%以上の差をつけて数値を生成
  List<int> _generateNumbersWithMinimumDifference(
    int minValue,
    int maxValue,
    int count,
    math.Random random,
  ) {
    final numbers = <int>[];
    final rangeSize = maxValue - minValue + 1;
    
    // 最小差を計算（10%または最低1）
    int calculateMinDifference(int baseNumber) {
      final tenPercent = (baseNumber * 0.1).ceil();
      return tenPercent < 1 ? 1 : tenPercent;
    }
    
    // 最初の数値をランダムに選択
    numbers.add(minValue + random.nextInt(rangeSize));
    
    // 残りの数値を10%以上の差をつけて生成
    for (int i = 1; i < count; i++) {
      int attempts = 0;
      bool placed = false;
      
      while (attempts < 100 && !placed) {
        final candidate = minValue + random.nextInt(rangeSize);
        bool validCandidate = true;
        
        // 既存の数値との差をチェック
        for (final existingNumber in numbers) {
          final minDiff = calculateMinDifference(existingNumber.abs());
          if ((candidate - existingNumber).abs() < minDiff) {
            validCandidate = false;
            break;
          }
        }
        
        if (validCandidate) {
          numbers.add(candidate);
          placed = true;
        }
        attempts++;
      }
      
      // 配置に失敗した場合は、等間隔で配置
      if (!placed) {
        final interval = rangeSize ~/ count;
        final fallbackNumber = minValue + (i * interval);
        if (fallbackNumber <= maxValue) {
          numbers.add(fallbackNumber);
        } else {
          // 範囲内に収まらない場合は最大値を使用
          numbers.add(maxValue - i);
        }
      }
    }
    
    return numbers;
  }

  /// 実際の問題タイプを決定する（上級モードの場合はランダム選択）
  ComparisonQuestionType _determineActualQuestionType(
    ComparisonQuestionType? baseType,
    int optionCount,
    math.Random random,
  ) {
    if (baseType == ComparisonQuestionType.advanced) {
      // 上級モードの場合、択数に応じてランダム選択
      switch (optionCount) {
        case 2:
          // 2択：50%ずつで一番大きい/一番小さい
          return random.nextBool() 
            ? ComparisonQuestionType.largest 
            : ComparisonQuestionType.smallest;
        case 3:
          // 3択：1番大きい、2番目に大きい、1番小さい、2番目に小さい
          final types = [
            ComparisonQuestionType.largest,
            ComparisonQuestionType.secondLargest,
            ComparisonQuestionType.smallest,
            ComparisonQuestionType.secondSmallest,
          ];
          return types[random.nextInt(types.length)];
        case 4:
          // 4択：1〜3番目に大きい、1〜3番目に小さい
          final types = [
            ComparisonQuestionType.largest,
            ComparisonQuestionType.secondLargest,
            ComparisonQuestionType.thirdLargest,
            ComparisonQuestionType.smallest,
            ComparisonQuestionType.secondSmallest,
            ComparisonQuestionType.thirdSmallest,
          ];
          return types[random.nextInt(types.length)];
        default:
          return ComparisonQuestionType.largest;
      }
    } else if (baseType == ComparisonQuestionType.fixedLargest) {
      return ComparisonQuestionType.largest;
    } else if (baseType == ComparisonQuestionType.fixedSmallest) {
      return ComparisonQuestionType.smallest;
    }
    
    // デフォルト
    return ComparisonQuestionType.largest;
  }
  
  // ---- BaseGameScreen互換メソッド（段階的移行用）----

  void resetGame() {
    // 状態を初期化（ゲームを再開始しない）
    state = const ComparisonState(phase: CommonGamePhase.ready);
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
final modernComparisonLogicProvider = StateNotifierProvider.autoDispose<ModernComparisonLogic, ComparisonState>((ref) {
  return ModernComparisonLogic();
});