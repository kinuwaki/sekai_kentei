import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../base/base_game_screen.dart';
import 'models/sekai_kentei_models.dart';
import 'modern_sekai_kentei_logic.dart';

/// CommonGamePhaseからGameUiPhaseへの変換拡張
extension CommonGamePhaseExtension on CommonGamePhase {
  GameUiPhase get toGameUiPhase {
    switch (this) {
      case CommonGamePhase.ready:
        return GameUiPhase.settings;
      case CommonGamePhase.completed:
        return GameUiPhase.result;
      default:
        return GameUiPhase.playing;
    }
  }
}

/// クイズモード
enum QuizMode {
  practice, // 問題演習
  review,   // 復習（間違えた問題）
  test,     // テスト（制限時間あり）
}

class SekaiKenteiScreen extends BaseGameScreen<SekaiKenteiSettings, SekaiKenteiState, ModernSekaiKenteiLogic> {
  final String themeKey;
  final int questionCount;
  final QuizMode mode;
  final int? timeLimitSeconds;

  const SekaiKenteiScreen({
    super.key,
    required this.themeKey,
    required this.questionCount,
    this.mode = QuizMode.practice,
    this.timeLimitSeconds,
    super.initialSettings,
  });

  @override
  BaseGameScreenState<SekaiKenteiScreen, SekaiKenteiSettings, SekaiKenteiState, ModernSekaiKenteiLogic>
      createState() => _SekaiKenteiScreenState();
}

class _SekaiKenteiScreenState extends BaseGameScreenState<
    SekaiKenteiScreen,
    SekaiKenteiSettings,
    SekaiKenteiState,
    ModernSekaiKenteiLogic> {

  Timer? _testTimer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    if (widget.mode == QuizMode.test && widget.timeLimitSeconds != null) {
      _remainingSeconds = widget.timeLimitSeconds!;
      _startTestTimer();
    }
  }

  @override
  void initializeGame() {
    super.initializeGame();
    // 復習モードの場合、isReviewMode=trueでゲームを開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && widget.initialSettings != null) {
        final logic = readLogic(ref);
        logic.resetGame();
        logic.startGame(
          widget.initialSettings!,
          isReviewMode: widget.mode == QuizMode.review,
        );
      }
    });
  }

  @override
  void dispose() {
    _testTimer?.cancel();
    super.dispose();
  }

  void _startTestTimer() {
    _testTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _remainingSeconds--;
          if (_remainingSeconds <= 0) {
            _testTimer?.cancel();
            // 時間切れ処理
            _handleTimeUp();
          }
        });
      }
    });
  }

  void _handleTimeUp() {
    // テスト終了処理
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('時間切れです！'),
        backgroundColor: Colors.red,
      ),
    );
    // 結果画面へ遷移などの処理を追加
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  String get gameTitle => '世界検定４級';

  @override
  SekaiKenteiState watchState(WidgetRef ref) =>
      ref.watch(modernSekaiKenteiLogicProvider);

  @override
  ModernSekaiKenteiLogic readLogic(WidgetRef ref) =>
      ref.read(modernSekaiKenteiLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(SekaiKenteiState s) {
    return s.phase.toGameUiPhase;
  }

  @override
  SekaiKenteiSettings? settingsOf(SekaiKenteiState s) => s.settings;

  @override
  int? scoreOf(SekaiKenteiState s) {
    if (s.session == null) return null;
    return s.session!.correctCount;
  }

  @override
  int totalQuestionsOf(SekaiKenteiSettings settings) => settings.questionCount;

  @override
  String getSettingsDisplayName(SekaiKenteiSettings settings) => settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFFE3F2FD), // 薄い青色で統一
      Color(0xFFE3F2FD), // 薄い青色で統一
    ];
  }

  @override
  String? getQuestionText(SekaiKenteiState state) {
    return state.questionText;
  }

  @override
  String? getProgressText(SekaiKenteiState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }

  @override
  Widget buildSettingsView(BuildContext context, void Function(SekaiKenteiSettings) onStart) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '世界検定４級',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'テーマを選んで開始',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF424242),
              ),
            ),
            const SizedBox(height: 48),

            // 3つのテーマボタン
            ...QuizTheme.values.map((theme) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildThemeButton(
                theme: theme,
                onPressed: () {
                  onStart(SekaiKenteiSettings(theme: theme));
                },
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeButton({
    required QuizTheme theme,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5B9BD5),
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        ),
        child: Text(
          theme.displayName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget buildPlayingView(BuildContext context, SekaiKenteiState state, ModernSekaiKenteiLogic logic) {
    final screenSize = MediaQuery.of(context).size;

    if (state.session?.currentProblem == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final problem = state.session!.currentProblem!;
    final session = state.session!;
    final showResult = state.phase == CommonGamePhase.feedbackOk || state.phase == CommonGamePhase.feedbackNg;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFE3F2FD), // 薄い青色で統一
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 問題文エリア
                _buildQuestionArea(problem, screenSize),
                const SizedBox(height: 16),

                // 四択選択肢（縦並び）
                _buildVerticalOptions(
                  problem,
                  session,
                  state,
                  logic,
                  screenSize,
                ),

                // 解説エリア
                if (showResult && problem.explanation.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildExplanationArea(problem, state),
                ],

                // 次の問題へボタン
                if (showResult) ...[
                  const SizedBox(height: 16),
                  _buildNextButton(logic),
                ],

                // テストモード時のタイマー表示
                if (widget.mode == QuizMode.test && widget.timeLimitSeconds != null) ...[
                  const SizedBox(height: 16),
                  _buildTimerDisplay(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionArea(SekaiKenteiProblem problem, Size screenSize) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF5B9BD5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              '問題',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            problem.question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalOptions(
    SekaiKenteiProblem problem,
    SekaiKenteiSession session,
    SekaiKenteiState state,
    ModernSekaiKenteiLogic logic,
    Size screenSize,
  ) {
    final showResult = state.phase == CommonGamePhase.feedbackOk ||
                       state.phase == CommonGamePhase.feedbackNg;

    return Column(
      children: List.generate(problem.options.length, (index) {
        final option = problem.options[index];
        final isCorrect = index == problem.correctIndex;
        final isSelected = state.lastResult?.selectedIndex == index;

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: _buildOptionButton(
            option: option,
            index: index,
            isCorrect: isCorrect,
            showResult: showResult,
            isSelected: isSelected,
            canAnswer: state.canAnswer,
            onTap: () => logic.answerQuestion(index),
          ),
        );
      }),
    );
  }

  Widget _buildExplanationArea(SekaiKenteiProblem problem, SekaiKenteiState state) {
    final isCorrect = state.phase == CommonGamePhase.feedbackOk;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isCorrect ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFF44336),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFF44336),
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                isCorrect ? '正解！' : '不正解…',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isCorrect ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            problem.explanation,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF424242),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton(ModernSekaiKenteiLogic logic) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () => logic.nextQuestion(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5B9BD5),
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          '次の問題へ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required String option,
    required int index,
    required bool isCorrect,
    required bool showResult,
    required bool isSelected,
    required bool canAnswer,
    required VoidCallback onTap,
  }) {
    Color backgroundColor = const Color(0xFFF5F5F5);
    Color borderColor = const Color(0xFFBDBDBD);
    Color textColor = const Color(0xFF424242);

    if (showResult) {
      if (isCorrect) {
        backgroundColor = const Color(0xFFC8E6C9);
        borderColor = const Color(0xFF4CAF50);
        textColor = const Color(0xFF2E7D32);
      } else if (isSelected) {
        backgroundColor = const Color(0xFFFFCDD2);
        borderColor = const Color(0xFFF44336);
        textColor = const Color(0xFFC62828);
      }
    }

    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: canAnswer ? onTap : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor,
              width: showResult && (isCorrect || isSelected) ? 3 : 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            option,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  /// テストモード時のタイマー表示
  Widget _buildTimerDisplay() {
    final isLowTime = _remainingSeconds <= 60; // 残り1分以下で警告色
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLowTime ? Colors.red.shade50 : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isLowTime ? Colors.red : Colors.orange,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timer,
            size: 32,
            color: isLowTime ? Colors.red : Colors.orange,
          ),
          const SizedBox(width: 12),
          Text(
            '残り時間: ${_formatTime(_remainingSeconds)}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isLowTime ? Colors.red.shade900 : Colors.orange.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
