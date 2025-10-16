import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/size_comparison_models.dart';
import '../base/common_game_phase.dart';
import '../base/answer_handler_mixin.dart';

class ModernSizeComparisonLogic extends StateNotifier<SizeComparisonState>
    with AnswerHandlerMixin {
  static const String _tag = 'SizeComparisonLogic';
  final Random _random = Random();

  // ---- AnswerHandlerMixin実装 ----
  @override
  String get gameTitle => _tag;

  @override
  bool checkEpoch(int epoch) => state.epoch == epoch;

  @override
  Future<void> proceedToNext() => _proceedToNext(false);

  @override
  void returnToQuestioning() {
    state = state.copyWith(phase: CommonGamePhase.questioning);
  }

  // 利用可能なアイコンのリスト（vocabularyフォルダの実際のPNGファイル）
  static const List<String> _availableIcons = [
    'あいす', 'あかいくるま', 'あさがお', 'あり', 'うきわ', 'うさぎ', 'うでどけい', 'うま',
    'えび', 'えんぴつ', 'おたま', 'おにぎり', 'かたつむり', 'きうい', 'きゃべつ', 'きりん',
    'こっぷ', 'さいころ', 'しんかんせん', 'すずめ', 'すにーかー', 'すぷーん', 'ぞう', 'たっきゅうらけっと',
    'たんぽぽ', 'ちゅーりっぷ', 'ちりとり', 'とまと', 'にんじん', 'はさみ', 'ばす', 'ばなな',
    'ひこうき', 'ふうせん', 'ふぉーく', 'ぶどう', 'ふらいぱん', 'ほうき', 'ほうちょう', 'ぼーる',
    'ほっちきす', 'みかん', 'めがね', 'めろん', 'もみじ', 'やかん', 'らいおん', 'りんご',
    'れもん', 'れんこん'
  ];

  ModernSizeComparisonLogic() : super(const SizeComparisonState());

  // BaseGameScreen互換プロパティ
  String? get questionText => state.questionText;
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  void startGame(SizeComparisonSettings settings) {
    debugPrint('[$_tag] ゲーム開始: ${settings.displayName}');

    final firstProblem = _generateProblem(settings, 0);
    final session = SizeComparisonSession(
      index: 0,
      total: settings.questionCount,
      results: List.filled(settings.questionCount, null),
      currentProblem: firstProblem,
      startedAt: DateTime.now(),
    );

    state = state.copyWith(
      phase: CommonGamePhase.displaying,
      settings: settings,
      session: session,
      epoch: state.epoch + 1,
    );

    _enterQuestioning();
  }

  Future<void> answerQuestion(int selectedIndex) async {
    if (!state.canAnswer || state.session?.currentProblem == null) return;

    final currentEpoch = state.epoch + 1;
    debugPrint('[$_tag] 回答: $selectedIndex (epoch: $currentEpoch)');

    state = state.copyWith(
      phase: CommonGamePhase.processing,
      epoch: currentEpoch,
    );

    final problem = state.session!.currentProblem!;
    final isCorrect = selectedIndex == problem.correctAnswerIndex;
    final result = AnswerResult(
      selectedIndex: selectedIndex,
      correctIndex: problem.correctAnswerIndex,
      isCorrect: isCorrect,
      isPerfect: isCorrect && state.session!.wrongAnswers == 0,
    );

    if (isCorrect) {
      await _handleCorrectAnswer(result, currentEpoch);
    } else {
      await _handleWrongAnswer(result, currentEpoch);
    }
  }

  void restart() {
    if (state.settings != null) {
      startGame(state.settings!);
    }
  }

  void resetGame() {
    state = const SizeComparisonState();
  }

  void goToSettings() {
    state = const SizeComparisonState();
  }

  Future<void> _handleCorrectAnswer(AnswerResult result, int epoch) async {
    final session = state.session!;
    final updatedResults = List<bool?>.from(session.results);
    final finalResult = session.wrongAnswers == 0; // この問題で間違えていなければ完全正解
    updatedResults[session.index] = finalResult;

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
    updatedResults[session.index] = false; // 間違いとして記録

    await handleWrongAnswer(
      epoch: epoch,
      allowRetry: false, // 再試行なし、次の問題へ
      feedbackDuration: const Duration(milliseconds: 2000),
      updateState: () {
        state = state.copyWith(
          phase: CommonGamePhase.feedbackNg,
          lastResult: result,
          session: session.copyWith(
            results: updatedResults,
            wrongAnswers: session.wrongAnswers + 1,
          ),
        );
      },
    );
  }

  Future<void> _proceedToNext(bool isPerfect) async {
    state = state.copyWith(phase: CommonGamePhase.transitioning);

    await Future.delayed(const Duration(milliseconds: 350));

    final session = state.session!;
    if (session.index + 1 >= session.total) {
      // ゲーム完了
      state = state.copyWith(
        phase: CommonGamePhase.completed,
        session: session.copyWith(
          completedAt: DateTime.now(),
        ),
      );
      debugPrint('[$_tag] ゲーム完了 - スコア: ${state.session!.correctCount}/${session.total}');
    } else {
      // 次の問題へ
      final nextProblem = _generateProblem(state.settings!, session.index + 1);
      final nextSession = session.copyWith(
        index: session.index + 1,
        currentProblem: nextProblem,
        wrongAnswers: 0,
      );

      debugPrint('[$_tag] 次の問題へ: ${nextSession.index + 1}');

      state = state.copyWith(
        phase: CommonGamePhase.displaying,
        session: nextSession,
        lastResult: null,
      );

      await _enterQuestioning();
    }
  }

  Future<void> _enterQuestioning() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (state.phase == CommonGamePhase.displaying ||
        state.phase == CommonGamePhase.transitioning) {
      state = state.copyWith(phase: CommonGamePhase.questioning);
    }
  }

  SizeComparisonProblem _generateProblem(SizeComparisonSettings settings, int index) {
    // ランダムにアイコンを選択（毎問題異なるアイコン）
    final iconSlug = _availableIcons[_random.nextInt(_availableIcons.length)];
    final iconInfo = IconInfo(
      filename: '$iconSlug.png',
      slug: iconSlug,
    );

    // 問題の種類を設定に基づいて決定
    ComparisonType comparisonType;
    int targetRank;
    bool isPositionMode = false;
    
    switch (settings.comparisonChoice) {
      case ComparisonChoice.largest:
        comparisonType = ComparisonType.largest;
        targetRank = 1; // いちばん大きい
        break;
      case ComparisonChoice.smallest:
        comparisonType = ComparisonType.smallest;
        targetRank = 1; // いちばん小さい
        break;
      case ComparisonChoice.sizeRandom:
        comparisonType = _random.nextBool() ? ComparisonType.largest : ComparisonType.smallest;
        targetRank = _random.nextInt(2) + 2; // 2または3番目
        break;
      case ComparisonChoice.leftPosition:
        comparisonType = ComparisonType.largest; // サイズは任意（位置ベース）
        targetRank = _random.nextInt(5) + 1; // 1, 2, 3, 4, 5番目
        isPositionMode = true;
        break;
      case ComparisonChoice.rightPosition:
        comparisonType = ComparisonType.largest; // サイズは任意（位置ベース）
        targetRank = _random.nextInt(5) + 1; // 1, 2, 3, 4, 5番目
        isPositionMode = true;
        break;
      case ComparisonChoice.positionRandom:
        final positionModes = [ComparisonChoice.leftPosition, ComparisonChoice.rightPosition];
        final randomMode = positionModes[_random.nextInt(positionModes.length)];
        return _generateProblem(settings.copyWith(comparisonChoice: randomMode), index);
    }
    
    // 5つのサイズを生成（基準120px、指定された倍率）
    const baseSize = 120.0;
    
    // 指定された倍率を使用
    final List<double> sizeRatios = [
      0.6,    // x0.6
      0.8,    // x0.8
      1.0,    // x1.0
      1.175,  // x1.175
      1.35,   // x1.35
    ];
    
    // サイズ付きアイコンを作成
    final sizedIcons = List.generate(5, (i) {
      return SizedIcon(
        iconInfo: iconInfo,
        size: baseSize * sizeRatios[i],
        sizeRank: i + 1, // 1=最小, 5=最大
      );
    });

    // アイコンの位置をシャッフル（位置モードでもシャッフルする）
    final shuffledIcons = List<SizedIcon>.from(sizedIcons)..shuffle(_random);
    
    // 正解のインデックスを見つける
    int correctAnswerIndex;
    
    if (isPositionMode) {
      // 位置モードの場合は、左からまたは右からの位置で決定
      if (settings.comparisonChoice == ComparisonChoice.leftPosition) {
        // 左からtargetRank番目
        correctAnswerIndex = targetRank - 1;
      } else {
        // 右からtargetRank番目
        correctAnswerIndex = 5 - targetRank;
      }
    } else {
      // サイズモードの場合は従来通り
      int correctSizeRank;
      if (comparisonType == ComparisonType.largest) {
        // 大きい方からtargetRank番目
        correctSizeRank = 6 - targetRank;
      } else {
        // 小さい方からtargetRank番目
        correctSizeRank = targetRank;
      }
      
      correctAnswerIndex = shuffledIcons.indexWhere(
        (icon) => icon.sizeRank == correctSizeRank
      );
    }

    // 質問文を生成
    final questionText = isPositionMode 
        ? _generatePositionQuestionText(settings.comparisonChoice, targetRank)
        : _generateQuestionText(comparisonType, targetRank);

    return SizeComparisonProblem(
      questionText: questionText,
      comparisonType: comparisonType,
      targetRank: targetRank,
      icons: shuffledIcons,
      correctAnswerIndex: correctAnswerIndex,
      isPositionMode: isPositionMode,
    );
  }

  int _getTargetRankForDifficulty(SizeComparisonDifficulty difficulty) {
    // シンプルに1番目（最大・最小）のみ
    return 1;
  }

  String _generateQuestionText(ComparisonType type, int rank) {
    final typeText = type.displayName;
    if (rank == 1) {
      return 'いちばん\n${typeText}のは？';
    } else {
      final rankText = _getRankText(rank);
      return '${rankText}に\n${typeText}のは？';
    }
  }

  String _getRankText(int rank) {
    switch (rank) {
      case 1: return '1ばんめ';
      case 2: return '2ばんめ';
      case 3: return '3ばんめ';
      case 4: return '4ばんめ';
      case 5: return '5ばんめ';
      default: return '${rank}ばんめ';
    }
  }
  
  String _generatePositionQuestionText(ComparisonChoice choice, int rank) {
    final rankText = _getRankText(rank);
    if (choice == ComparisonChoice.leftPosition) {
      return 'ひだりから\n${rankText}は？';
    } else {
      return 'みぎから\n${rankText}は？';
    }
  }
}

final modernSizeComparisonLogicProvider = StateNotifierProvider.autoDispose<ModernSizeComparisonLogic, SizeComparisonState>((ref) {
  return ModernSizeComparisonLogic();
});