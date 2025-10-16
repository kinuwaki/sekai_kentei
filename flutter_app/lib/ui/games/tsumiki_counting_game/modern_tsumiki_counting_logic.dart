import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/instant_feedback_service.dart';
import 'models/tsumiki_counting_models.dart';
import '../base/common_game_phase.dart';

class ModernTsumikiCountingLogic extends StateNotifier<TsumikiCountingState> {
  static const String _tag = 'TsumikiCountingLogic';

  ModernTsumikiCountingLogic() : super(const TsumikiCountingState());

  /// テスト環境かどうかを判定
  bool _isTestEnvironment() {
    try {
      return Zone.current[#flutter.test] != null ||
             (Platform.environment['FLUTTER_TEST'] == 'true');
    } catch (e) {
      return false; // エラーが発生した場合は通常環境とみなして音声を有効にする
    }
  }

  // BaseGameScreen互換プロパティ
  String? get questionText => state.questionText;
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  // ブロック数別の画像リスト
  static final Map<int, List<String>> _blockImageLists = {
    1: ['block1_000.jpg'],
    2: ['block2_000.jpg', 'block2_001.jpg', 'block2_002.jpg'],
    3: ['block3_000.jpg', 'block3_001.jpg', 'block3_002.jpg', 'block3_003.jpg',
        'block3_004.jpg', 'block3_005.jpg', 'block3_006.jpg', 'block3_007.jpg',
        'block3_008.jpg'],
    4: List.generate(26, (i) => 'block4_${i.toString().padLeft(3, '0')}.jpg'),
    5: List.generate(57, (i) => 'block5_${i.toString().padLeft(3, '0')}.jpg'),
    6: List.generate(97, (i) => 'block6_${i.toString().padLeft(3, '0')}.jpg'),
    7: List.generate(122, (i) => 'block7_${i.toString().padLeft(3, '0')}.jpg'),
    8: List.generate(126, (i) => 'block8_${i.toString().padLeft(3, '0')}.jpg'),
    9: List.generate(97, (i) => 'block9_${i.toString().padLeft(3, '0')}.jpg'),
  };

  void resetGame() {
    debugPrint('[$_tag] ゲームリセット (called from: ${StackTrace.current})');
    state = const TsumikiCountingState();
  }

  void startGame(TsumikiCountingSettings settings) {
    debugPrint('[$_tag] ゲーム開始: ${settings.displayName} (called from: ${StackTrace.current})');
    final firstProblem = _generateProblem(settings, 0);
    final session = TsumikiCountingSession(
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

    final currentEpoch = state.epoch;
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

    // フィードバック効果音（テスト環境では無効化）
    if (!_isTestEnvironment()) {
      try {
        final feedbackService = InstantFeedbackService();
        if (isCorrect) {
          await feedbackService.playCorrectAnswerFeedback();
        } else {
          await feedbackService.playWrongAnswerFeedback();
        }
      } catch (e) {
        debugPrint('[$_tag] フィードバック音声エラー: $e');
      }
    }

    if (isCorrect) {
      await _handleCorrectAnswer(result, currentEpoch);
    } else {
      await _handleWrongAnswer(result, currentEpoch);
    }
  }

  Future<void> _handleCorrectAnswer(AnswerResult result, int epoch) async {
    if (!mounted || state.epoch != epoch) return;

    state = state.copyWith(
      phase: CommonGamePhase.feedbackOk,
      lastResult: result,
    );

    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted || state.epoch != epoch) return;

    _proceedToNext(true);
  }

  Future<void> _handleWrongAnswer(AnswerResult result, int epoch) async {
    if (!mounted || state.epoch != epoch) return;

    state = state.copyWith(
      phase: CommonGamePhase.feedbackNg,
      lastResult: result,
      session: state.session?.copyWith(
        wrongAnswers: state.session!.wrongAnswers + 1,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted || state.epoch != epoch) return;

    // 間違えたら即座に次の問題へ
    _proceedToNext(false);
  }

  void _proceedToNext(bool isPerfect) {
    final session = state.session!;
    final newResults = List<bool?>.from(session.results);
    newResults[session.index] = isPerfect;

    if (session.index + 1 >= session.total) {
      // ゲーム完了
      state = state.copyWith(
        phase: CommonGamePhase.completed,
        session: session.copyWith(results: newResults),
      );
    } else {
      // 次の問題
      final nextProblem = _generateProblem(state.settings!, session.index + 1);
      state = state.copyWith(
        phase: CommonGamePhase.transitioning,
        lastResult: null, // 次の問題に進む時にクリア
        session: session.copyWith(
          index: session.index + 1,
          results: newResults,
          currentProblem: nextProblem,
        ),
      );
      _autoAdvance();
    }
  }

  Future<void> _autoAdvance() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    if (state.phase == CommonGamePhase.displaying ||
        state.phase == CommonGamePhase.transitioning) {
      state = state.copyWith(phase: CommonGamePhase.questioning);
    }
  }

  TsumikiCountingProblem _generateProblem(TsumikiCountingSettings settings, int index) {
    final random = Random(index * 1000 + settings.range.hashCode);
    final range = settings.range;

    // 正解のブロック数を範囲内からランダムに決定
    final correctBlockCount = range.minValue + random.nextInt(range.maxValue - range.minValue + 1);

    if (settings.mode == TsumikiCountingMode.imageToNumber) {
      return _generateImageToNumberProblem(correctBlockCount, random);
    } else {
      return _generateNumberToImageProblem(correctBlockCount, random);
    }
  }

  TsumikiCountingProblem _generateImageToNumberProblem(int correctBlockCount, Random random) {
    // 正解画像を選択
    final imageList = _blockImageLists[correctBlockCount];
    if (imageList == null || imageList.isEmpty) {
      throw Exception('No images available for block count: $correctBlockCount');
    }
    final imagePath = imageList[random.nextInt(imageList.length)];

    // ±1, ±2の間違い選択肢を生成
    final options = <int>{};
    options.add(correctBlockCount);

    // ±1の選択肢を追加
    if (correctBlockCount > 1) {
      options.add(correctBlockCount - 1);
    }
    if (correctBlockCount < 9) {
      options.add(correctBlockCount + 1);
    }

    // ±2の選択肢を追加（4つに満たない場合）
    if (options.length < 4 && correctBlockCount > 2) {
      options.add(correctBlockCount - 2);
    }
    if (options.length < 4 && correctBlockCount < 8) {
      options.add(correctBlockCount + 2);
    }

    // まだ4つに満たない場合は1-9の範囲で追加
    while (options.length < 4) {
      final option = random.nextInt(9) + 1;
      if (option != correctBlockCount) {
        options.add(option);
      }
    }

    final optionList = options.toList()..shuffle(random);
    final correctIndex = optionList.indexOf(correctBlockCount);

    return TsumikiCountingProblem(
      questionText: 'つみきはいくつありますか？',
      correctAnswerIndex: correctIndex,
      options: optionList.map((number) => number.toString()).toList(),
      mode: TsumikiCountingMode.imageToNumber,
      blockCount: correctBlockCount,
      imagePath: imagePath,
    );
  }

  TsumikiCountingProblem _generateNumberToImageProblem(
    int correctBlockCount,
    Random random
  ) {
    // 正解画像を選択
    final correctImageList = _blockImageLists[correctBlockCount];
    if (correctImageList == null || correctImageList.isEmpty) {
      throw Exception('No images available for block count: $correctBlockCount');
    }
    final correctImagePath = correctImageList[random.nextInt(correctImageList.length)];

    // ±1, ±2の間違い選択肢となるブロック数を生成
    final wrongBlockCounts = <int>{};

    // ±1の選択肢を追加
    if (correctBlockCount > 1 && _blockImageLists[correctBlockCount - 1]?.isNotEmpty == true) {
      wrongBlockCounts.add(correctBlockCount - 1);
    }
    if (correctBlockCount < 9 && _blockImageLists[correctBlockCount + 1]?.isNotEmpty == true) {
      wrongBlockCounts.add(correctBlockCount + 1);
    }

    // ±2の選択肢を追加（4つに満たない場合）
    if (wrongBlockCounts.length < 3 && correctBlockCount > 2 && _blockImageLists[correctBlockCount - 2]?.isNotEmpty == true) {
      wrongBlockCounts.add(correctBlockCount - 2);
    }
    if (wrongBlockCounts.length < 3 && correctBlockCount < 8 && _blockImageLists[correctBlockCount + 2]?.isNotEmpty == true) {
      wrongBlockCounts.add(correctBlockCount + 2);
    }

    // まだ3つに満たない場合は画像が存在する他の数字を追加
    final availableCounts = _blockImageLists.keys.where((count) =>
      count != correctBlockCount &&
      _blockImageLists[count]?.isNotEmpty == true
    ).toList();

    while (wrongBlockCounts.length < 3 && availableCounts.isNotEmpty) {
      final randomCount = availableCounts[random.nextInt(availableCounts.length)];
      wrongBlockCounts.add(randomCount);
      availableCounts.remove(randomCount);
    }

    // 間違いの画像を選択
    final wrongImagePaths = <String>[];
    for (final wrongCount in wrongBlockCounts) {
      final wrongImageList = _blockImageLists[wrongCount]!;
      final wrongImagePath = wrongImageList[random.nextInt(wrongImageList.length)];
      wrongImagePaths.add(wrongImagePath);
    }

    // 選択肢をシャッフル
    final options = [correctImagePath, ...wrongImagePaths];
    options.shuffle(random);
    final correctIndex = options.indexOf(correctImagePath);

    return TsumikiCountingProblem(
      questionText: 'すうじとおなじかずのつみきはどれですか？',
      correctAnswerIndex: correctIndex,
      options: options,
      mode: TsumikiCountingMode.numberToImage,
      blockCount: correctBlockCount,
    );
  }
}

final modernTsumikiCountingLogicProvider =
    StateNotifierProvider<ModernTsumikiCountingLogic, TsumikiCountingState>((ref) {
  return ModernTsumikiCountingLogic();
});