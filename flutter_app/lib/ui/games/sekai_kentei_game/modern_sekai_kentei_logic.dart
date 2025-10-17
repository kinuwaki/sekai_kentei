import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/debug_logger.dart';
import '../../../services/quiz_data_loader.dart';
import '../../../services/sekai_kentei_csv_loader.dart';
import '../../../services/wrong_answer_storage.dart';
import '../../../services/audio_service.dart';
import 'models/sekai_kentei_models.dart';

class ModernSekaiKenteiLogic extends StateNotifier<SekaiKenteiState> {
  static const String _tag = 'SekaiKenteiLogic';
  final Random _random = Random();
  final QuizDataLoader _dataLoader;

  List<QuizQuestion>? _allQuestions;
  List<QuizQuestion>? _currentThemeQuestions;
  bool _isReviewMode = false;

  ModernSekaiKenteiLogic({QuizDataLoader? dataLoader})
      : _dataLoader = dataLoader ?? SekaiKenteiCsvLoader(),
        super(const SekaiKenteiState());

  String? get questionText => state.questionText;
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  Future<void> startGame(SekaiKenteiSettings settings, {bool isReviewMode = false}) async {
    _isReviewMode = isReviewMode;
    Log.d('ゲーム開始: ${settings.displayName}${isReviewMode ? ' (復習モード)' : ''}', tag: _tag);

    // データローダーから問題を読み込む
    try {
      _allQuestions ??= await _dataLoader.loadQuestions();

      // 復習モードの場合、間違えた問題のIDでフィルタリング
      if (isReviewMode) {
        final wrongAnswerIds = await WrongAnswerStorage.getWrongAnswerIds();
        Log.d('復習モード: 間違えた問題ID数 = ${wrongAnswerIds.length}', tag: _tag);

        if (wrongAnswerIds.isEmpty) {
          throw Exception('復習する問題がありません');
        }

        _currentThemeQuestions = _allQuestions!
            .where((q) => wrongAnswerIds.contains(q.id))
            .toList();

        Log.d('復習モード: 読み込んだ問題数 = ${_currentThemeQuestions!.length}', tag: _tag);
      } else {
        // 通常モード: テーマでフィルタリング
        final themeName = _getThemeName(settings.theme);
        _currentThemeQuestions = _dataLoader.filterByTheme(_allQuestions!, themeName);
        Log.d('テーマ「$themeName」の問題: ${_currentThemeQuestions!.length}問', tag: _tag);
      }

      if (_currentThemeQuestions!.isEmpty) {
        throw Exception('問題が見つかりませんでした');
      }

      final firstProblem = _generateProblem(settings, 0);
      final session = SekaiKenteiSession(
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
    } catch (e) {
      Log.e('ゲーム開始エラー: $e', tag: _tag);
      // エラー時はフォールバック（固定の問題データベース使用）
      _startGameWithFallback(settings);
    }
  }

  /// CSVロード失敗時のフォールバック
  void _startGameWithFallback(SekaiKenteiSettings settings) {
    Log.w('フォールバックモードで開始', tag: _tag);

    final firstProblem = _generateFallbackProblem(settings, 0);
    final session = SekaiKenteiSession(
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

  String _getThemeName(QuizTheme theme) {
    switch (theme) {
      case QuizTheme.basic:
        return QuizThemeNames.basic;
      case QuizTheme.japan:
        return QuizThemeNames.japan;
      case QuizTheme.world:
        return QuizThemeNames.world;
    }
  }

  Future<void> answerQuestion(int selectedIndex) async {
    if (!state.canAnswer || state.session?.currentProblem == null) return;

    final currentEpoch = state.epoch;
    final session = state.session!;
    final problem = session.currentProblem!;

    Log.d('回答: $selectedIndex (epoch: $currentEpoch)', tag: _tag);

    state = state.copyWith(phase: CommonGamePhase.processing);

    final isCorrect = selectedIndex == problem.correctIndex;
    final result = AnswerResult(
      selectedIndex: selectedIndex,
      correctIndex: problem.correctIndex,
      isCorrect: isCorrect,
      isPerfect: isCorrect && session.wrongAnswers == 0,
    );

    // 結果を状態に反映
    final updatedResults = List<bool?>.from(session.results);

    if (isCorrect) {
      // 正解音を再生
      await AudioService.playCorrect();

      updatedResults[session.index] = result.isPerfect;
      state = state.copyWith(
        phase: CommonGamePhase.feedbackOk,
        lastResult: result,
        session: session.copyWith(results: updatedResults),
      );

      // 復習モードの場合、正解した問題を削除
      if (_isReviewMode) {
        await WrongAnswerStorage.removeWrongAnswer(problem.id);
        Log.d('復習モード: 正解した問題を削除しました (ID: ${problem.id})', tag: _tag);
      }
    } else {
      // 不正解音を再生
      await AudioService.playIncorrect();

      updatedResults[session.index] = false;
      state = state.copyWith(
        phase: CommonGamePhase.feedbackNg,
        lastResult: result,
        session: session.copyWith(
          results: updatedResults,
          wrongAnswers: session.wrongAnswers + 1,
        ),
      );

      // 間違えた問題を保存（IDベース）
      await WrongAnswerStorage.addWrongAnswer(problem.id);
    }

    // 自動では次に進まない（ユーザーが「次の問題へ」ボタンを押すまで待機）
  }

  /// 次の問題へ進む（外部から呼び出し可能）
  Future<void> nextQuestion() async {
    if (state.phase != CommonGamePhase.feedbackOk &&
        state.phase != CommonGamePhase.feedbackNg) {
      return;
    }

    final lastResult = state.lastResult;
    await _proceedToNext(lastResult?.isPerfect ?? false);
  }

  Future<void> _proceedToNext(bool isPerfect) async {
    if (!mounted || state.session == null || state.settings == null) return;

    final session = state.session!;
    final settings = state.settings!;

    // 遷移待機
    await Future.delayed(const Duration(milliseconds: 300));

    if (session.index + 1 >= session.total) {
      Log.d('ゲーム完了', tag: _tag);
      state = state.copyWith(phase: CommonGamePhase.completed);
      return;
    }

    final nextIndex = session.index + 1;
    Log.d('次の問題へ移動: ${nextIndex + 1}', tag: _tag);

    final nextProblem = _generateProblem(settings, nextIndex);

    state = state.copyWith(
      phase: CommonGamePhase.displaying,
      lastResult: null,
      session: session.copyWith(
        index: nextIndex,
        currentProblem: nextProblem,
        wrongAnswers: 0,
      ),
      epoch: state.epoch + 1,
    );

    _autoAdvance();
  }

  Future<void> _autoAdvance() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    if (state.phase == CommonGamePhase.displaying || state.phase == CommonGamePhase.transitioning) {
      state = state.copyWith(phase: CommonGamePhase.questioning);
    }
  }

  SekaiKenteiProblem _generateProblem(SekaiKenteiSettings settings, int index) {
    if (_currentThemeQuestions == null || _currentThemeQuestions!.isEmpty) {
      throw Exception('問題データがありません');
    }

    // ランダムに問題を選択（重複しないように）
    final availableQuestions = List<QuizQuestion>.from(_currentThemeQuestions!);
    availableQuestions.shuffle(_random);

    // インデックスが範囲外の場合は循環
    final questionIndex = index % availableQuestions.length;
    final csvQuestion = availableQuestions[questionIndex];

    // 4択の選択肢を生成（3つの不正解 + 1つの正解をシャッフル）
    final options = csvQuestion.generateOptions(random: _random);
    final correctIndex = csvQuestion.getCorrectIndex(options);

    Log.d('問題生成: ${csvQuestion.question}', tag: _tag);

    return SekaiKenteiProblem(
      id: csvQuestion.id,
      question: csvQuestion.question,
      options: options,
      correctIndex: correctIndex,
      explanation: csvQuestion.explanation,
    );
  }

  /// フォールバック用の問題生成
  SekaiKenteiProblem _generateFallbackProblem(SekaiKenteiSettings settings, int index) {
    final questions = QuizDatabase.getQuestions(settings.theme);
    final shuffledQuestions = List<Map<String, dynamic>>.from(questions);
    shuffledQuestions.shuffle(_random);

    final questionIndex = index % shuffledQuestions.length;
    final questionData = shuffledQuestions[questionIndex];

    return SekaiKenteiProblem(
      id: 'fallback_${settings.theme.name}_$questionIndex',
      question: questionData['question'] as String,
      options: List<String>.from(questionData['options'] as List),
      correctIndex: questionData['correctIndex'] as int,
    );
  }

  void reset() {
    debugPrint('[$_tag] ゲームリセット');
    state = const SekaiKenteiState();
  }

  void resetGame() {
    debugPrint('[$_tag] ゲームリセット');
    state = const SekaiKenteiState();
  }

  void skipToCompletion() {
    if (state.session != null) {
      state = state.copyWith(
        phase: CommonGamePhase.completed,
      );
    }
  }
}

final modernSekaiKenteiLogicProvider = StateNotifierProvider.autoDispose<ModernSekaiKenteiLogic, SekaiKenteiState>((ref) {
  return ModernSekaiKenteiLogic();
});
