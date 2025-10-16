import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/figure_orientation_models.dart';
import '../base/common_game_phase.dart';
import '../base/answer_handler_mixin.dart';

class ModernFigureOrientationLogic extends StateNotifier<FigureOrientationState>
    with AnswerHandlerMixin {
  static const String _tag = 'FigureOrientationLogic';

  ModernFigureOrientationLogic() : super(const FigureOrientationState());

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

  // BaseGameScreen互換プロパティ
  String? get questionText => state.questionText;
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  // 利用可能な図形画像のパス
  static const List<String> _availableImages = [
    '000', '001', '002', '003', '004', '005', '006', '007',
    '008', '009', '010', '011', '012',
    '100', '101', '102', '103', '104'
  ];
  
  // ミラー反転のみ使用する画像
  static const List<String> _mirrorOnlyImages = ['100', '101', '102', '103', '104'];

  void startGame(FigureOrientationSettings settings) {
    debugPrint('[$_tag] ゲーム開始: ${settings.displayName}');
    final firstProblem = _generateProblem(settings, 0);
    final session = FigureOrientationSession(
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

  Future<void> answerQuestion(int selectedIndex) async {
    if (!state.canAnswer || state.session?.currentProblem == null) return;

    final currentEpoch = state.epoch + 1;
    debugPrint('[$_tag] 回答: $selectedIndex (epoch: $currentEpoch)');

    // 処理中状態に変更
    state = state.copyWith(
      phase: CommonGamePhase.processing,
      epoch: currentEpoch,
    );

    // 回答判定
    final problem = state.session!.currentProblem!;
    final isCorrect = selectedIndex == problem.correctAnswerIndex;
    final result = AnswerResult(
      selectedIndex: selectedIndex,
      correctIndex: problem.correctAnswerIndex,
      isCorrect: isCorrect,
      isPerfect: isCorrect,
    );

    if (isCorrect) {
      await _handleCorrectAnswer(result, currentEpoch);
    } else {
      await _handleWrongAnswer(result, currentEpoch);
    }
  }

  Future<void> _handleCorrectAnswer(AnswerResult result, int epoch) async {
    final session = state.session!;
    final updatedResults = List<bool?>.from(session.results);
    updatedResults[session.index] = true; // 完全正解

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

  Future<void> _handleWrongAnswer(AnswerResult result, int epoch) async {
    final session = state.session!;
    final updatedResults = List<bool?>.from(session.results);
    updatedResults[session.index] = false; // 不正解

    await handleWrongAnswer(
      epoch: epoch,
      allowRetry: false, // 再挑戦なし、次の問題へ
      feedbackDuration: const Duration(milliseconds: 500),
      updateState: () {
        state = state.copyWith(
          phase: CommonGamePhase.feedbackNg,
          lastResult: result,
          session: session.copyWith(
            wrongAnswers: session.wrongAnswers + 1,
            results: updatedResults,
          ),
        );
      },
    );
  }

  Future<void> _autoAdvance() async {
    state = state.copyWith(phase: CommonGamePhase.transitioning);

    await Future.delayed(const Duration(milliseconds: 350));

    final session = state.session!;
    if (session.index + 1 >= session.total) {
      // ゲーム完了
      state = state.copyWith(phase: CommonGamePhase.completed);
      debugPrint('[$_tag] ゲーム完了 - スコア: ${session.correctCount}/${session.total}');
    } else {
      // 次の問題
      final nextProblem = _generateProblem(state.settings!, session.index + 1);
      state = state.copyWith(
        phase: CommonGamePhase.displaying,
        session: session.copyWith(
          index: session.index + 1,
          currentProblem: nextProblem,
          wrongAnswers: 0,
        ),
        lastResult: null,
      );

      // 表示フェーズ後、自動的に質問フェーズへ
      await Future.delayed(const Duration(milliseconds: 500));
      if (state.phase == CommonGamePhase.displaying) {
        state = state.copyWith(phase: CommonGamePhase.questioning);
      }
    }
  }

  FigureOrientationProblem _generateProblem(FigureOrientationSettings settings, int index) {
    final random = Random(DateTime.now().millisecondsSinceEpoch + index);
    
    // 設定に応じた範囲から画像を選択
    final rangeStart = settings.range.minIndex;
    final rangeEnd = settings.range.maxIndex;
    final availableInRange = _availableImages.sublist(rangeStart, rangeEnd + 1);
    final imageIndex = random.nextInt(availableInRange.length);
    final imageName = availableInRange[imageIndex];
    final imagePath = 'assets/images/figures/geometry/$imageName.jpg';
    
    // 正解位置をランダムに決定（0-3）
    final correctPosition = random.nextInt(4);
    
    // 変換方法を決定
    FigureTransform oddTransform;
    if (_mirrorOnlyImages.contains(imageName)) {
      // 100-104はミラー反転のみ
      oddTransform = FigureTransform.flipHorizontal;
    } else {
      // その他は回転または反転
      final useRotation = random.nextBool();
      if (useRotation) {
        // 90, 180, 270度の回転から選択
        final rotations = [
          FigureTransform.rotate90,
          FigureTransform.rotate180,
          FigureTransform.rotate270,
        ];
        oddTransform = rotations[random.nextInt(3)];
      } else {
        oddTransform = FigureTransform.flipHorizontal;
      }
    }
    
    // 4つのオプションを生成
    final options = List.generate(4, (i) {
      final isCorrect = i == correctPosition;
      return FigureOrientationOption(
        imagePath: imagePath,
        transform: isCorrect ? oddTransform : FigureTransform.normal,
        isCorrect: isCorrect,
      );
    });
    
    return FigureOrientationProblem(
      questionText: 'ちがうむきのものを\nえらんでね',
      correctAnswerIndex: correctPosition,
      options: options,
      imagePath: imagePath,
    );
  }

  void resetGame() {
    state = const FigureOrientationState();
  }
}

final modernFigureOrientationLogicProvider = 
    StateNotifierProvider<ModernFigureOrientationLogic, FigureOrientationState>(
  (ref) => ModernFigureOrientationLogic(),
);