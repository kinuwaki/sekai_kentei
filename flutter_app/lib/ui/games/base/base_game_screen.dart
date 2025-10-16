import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/game_result_screen.dart';
import '../../../core/debug_logger.dart';
import 'navigation_utils.dart';
import '../sekai_kentei_game/sekai_kentei_screen.dart';

// 共通のUIフェーズ（ゲーム固有のPhaseから写像する）
enum GameUiPhase { settings, playing, result }

abstract class BaseGameScreen<TSettings, TState, TLogic>
    extends ConsumerStatefulWidget {
  const BaseGameScreen({
    super.key,
    this.initialSettings,
    this.enableHomeButton = false, // Counting だけ true など
  });

  final TSettings? initialSettings;
  final bool enableHomeButton;

  @override
  BaseGameScreenState<BaseGameScreen<TSettings, TState, TLogic>, TSettings, TState, TLogic>
      createState();
}

abstract class BaseGameScreenState<W extends BaseGameScreen<TSettings, TState, TLogic>,
    TSettings, TState, TLogic> extends ConsumerState<W> {

  // ---------- 具象側が実装する抽象プロパティ/メソッド ----------
  String get gameTitle;

  /// Riverpod: 状態購読（watch）
  TState watchState(WidgetRef ref);

  /// Riverpod: ロジック操作（read）
  TLogic readLogic(WidgetRef ref);

  /// 状態→UIフェーズ写像
  GameUiPhase phaseOf(TState s);

  /// 状態→設定 (playing/result で使用)。無い場合は null。
  TSettings? settingsOf(TState s);

  /// 状態→スコア（Result 用）。無い場合は null（= Result 非表示など）。
  int? scoreOf(TState s);

  /// 設定→総問数（Result の total）
  int totalQuestionsOf(TSettings settings);

  /// 設定UI（「はじめる」押下で start）
  Widget buildSettingsView(BuildContext context, void Function(TSettings) onStart);

  /// プレイ中UI
  Widget buildPlayingView(BuildContext context, TState state, TLogic logic);

  /// 既定 Result を使わない/差し替える場合に override（null を返すと既定を使用）
  Widget? buildResultViewOverride(BuildContext context, TState state, TLogic logic) => null;

  /// 既定の戻るボタン挙動を変えたい場合は override
  void onBack(BuildContext context) {
    final state = watchState(ref);
    final currentPhase = phaseOf(state);
    final settings = settingsOf(state);
    final score = scoreOf(state);

    // 常にゲーム完了データを作成
    Map<String, dynamic>? gameResult;
    if (currentPhase == GameUiPhase.result && settings != null && score != null) {
      gameResult = {
        'completed': true,
        'score': score,
        'totalQuestions': totalQuestionsOf(settings),
        'scoreRatio': score / totalQuestionsOf(settings),
      };
    }

    // Navigator.popを実行（resetGame()は呼ばない）
    // autoDisposeプロバイダーの場合、画面が破棄されると自動的にリセットされる
    Navigator.pop(context, gameResult);
  }

  /// 「ホーム」ボタン（必要なゲームのみ true にする）
  void onHome(BuildContext context) {
    Log.d('Going back to menu', tag: 'BaseGameScreen');
    
    // 統一されたホームページ処理を使用
    GameNavigationUtils.handleHomePage(context);
  }

  // ---------- 共通実装 ----------
  TSettings? _lastSettings;

  @override
  void initState() {
    super.initState();
    
    // 必要なら TTS 初期化などをここに（mixin で提供してもOK）
    initializeGame();

    // initialSettings があれば初回だけ直接開始（build に副作用を置かない）
    final init = widget.initialSettings;
    if (init != null) {
      _lastSettings = init;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          final logic = readLogic(ref);
          _silentResetAndStart(logic, init);
          Log.d('Auto-started game with ${getSettingsDisplayName(init)}', tag: gameTitle);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = watchState(ref);
    final logic = readLogic(ref);
    final phase = phaseOf(state);

    switch (phase) {
      case GameUiPhase.settings:
        return _wrapWithScaffold(
          body: buildSettingsView(context, (s) => _startNewGame(logic, s)),
        );
      case GameUiPhase.playing:
        return _wrapWithScaffold(
          body: buildPlayingView(context, state, logic),
        );
      case GameUiPhase.result:
        final override = buildResultViewOverride(context, state, logic);
        return _wrapWithScaffold(
          body: override ?? _buildDefaultResult(context, state, logic),
        );
    }
  }

  // 共通ヘッダ＋戻る
  Widget _wrapWithScaffold({required Widget body}) {
    final backgroundColors = getBackgroundColors();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: backgroundColors,
          ),
        ),
        child: SafeArea(
          child: body,
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    // 現在のモードに応じてインデックスを設定
    int currentIndex = 0;

    // モードを判定（SekaiKenteiScreenの場合）
    if (widget is SekaiKenteiScreen) {
      final screen = widget as SekaiKenteiScreen;
      switch (screen.mode) {
        case QuizMode.practice:
          currentIndex = 0;
          break;
        case QuizMode.review:
          currentIndex = 1;
          break;
        case QuizMode.test:
          currentIndex = 2;
          break;
      }
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      onTap: (index) {
        print('[BaseGameScreen] BottomNav tapped: index=$index, currentIndex=$currentIndex');
        // 現在のタブと同じタブをタップした場合は何もしない
        if (currentIndex == index) {
          print('[BaseGameScreen] Same tab, ignoring');
          return;
        }
        print('[BaseGameScreen] Popping with target tab index: $index');
        // DailyChallengeScreenまで戻り、タップされたタブのインデックスを返す
        Navigator.of(context).pop({'targetTabIndex': index});
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.school, size: 24),
          label: '問題演習',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_edu, size: 24),
          label: '復習',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment, size: 24),
          label: 'テスト',
        ),
      ],
    );
  }

  Widget _buildDefaultResult(BuildContext context, TState state, TLogic logic) {
    final s = settingsOf(state);
    final score = scoreOf(state);
    if (s == null || score == null) {
      // 設定やスコアが無いなら設定へ戻す等のフォールバック
      return Center(
        child: FilledButton(
          onPressed: () => _backToSettings(logic),
          child: const Text('もういちど はじめる'),
        ),
      );
    }

    return GameResultScreen(
      score: score,
      totalQuestions: totalQuestionsOf(s),
      onRetry: () => _restartWithLastSettings(logic),
      onHome: widget.enableHomeButton ? () => onHome(context) : null,
      onBack: () => onBack(context),
    );
  }


  // —— 状態操作（silent reset + start を1トランザクションに）——

  void _startNewGame(TLogic logic, TSettings settings) {
    _lastSettings = settings;
    Log.d('Starting new game with ${getSettingsDisplayName(settings)}', tag: gameTitle);
    _silentResetAndStart(logic, settings);
  }

  void _restartWithLastSettings(TLogic logic) {
    final s = _lastSettings ?? widget.initialSettings;
    if (s == null) {
      Log.w('No settings available for restart', tag: gameTitle);
      _backToSettings(logic);
      return;
    }
    Log.d('_restartWithLastSettings called - Restarting game with ${getSettingsDisplayName(s)}', tag: gameTitle);
    _startNewGame(logic, s);
  }

  void _backToSettings(TLogic logic) {
    // ロジック側で settings 画面状態へ戻すAPIがあれば呼ぶ
    // 無ければ reset のみでOK（UI側で settings へ写像される設計に）
    Log.d('Going back to settings', tag: gameTitle);
    _silentResetOnly(logic);
  }

  // ここは具象のロジック型に依存しない"呼び出し順"だけを保証
  void _silentResetAndStart(TLogic logic, TSettings s) {
    // 期待インタフェース：
    //  - resetGame()
    //  - startGame(TSettings)
    (logic as dynamic).resetGame();
    (logic as dynamic).startGame(s);
  }

  void _silentResetOnly(TLogic logic) {
    (logic as dynamic).resetGame();
  }

  // —— 具象側で override 可能なフック ——

  /// ゲーム初期化（TTS等）
  void initializeGame() {
    // 既定では何もしない。必要なゲームで override
    // 状態のリセットを行う（Claude Code の癖対応）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final logic = readLogic(ref);
        _resetGameState(logic);
      }
    });
  }

  /// ゲーム状態をリセット（Claude Code の癖対応）
  void _resetGameState(TLogic logic) {
    // リフレクションを使ってresetGameメソッドがあれば呼び出す
    try {
      final resetMethod = (logic as dynamic).resetGame;
      if (resetMethod != null && resetMethod is Function) {
        resetMethod();
        Log.d('Game state reset successfully', tag: 'BaseGameScreen');
      }
    } catch (e) {
      // resetGameメソッドがない場合は何もしない
      Log.d('No resetGame method found or error: $e', tag: 'BaseGameScreen');
    }
  }

  /// 設定の表示名取得
  String getSettingsDisplayName(TSettings settings) {
    return settings.toString(); // 既定実装。具象側で override 推奨
  }

  /// ゲーム完了記録用のキー
  String? getGameCompletionKey() {
    // デフォルトではゲームタイトルを使用、必要に応じてオーバーライド
    return gameTitle;
  }

  /// 背景グラデーション色取得（各ゲームで必須実装）
  List<Color> getBackgroundColors();

  /// ゲーム固有のヘッダー情報取得（プレイ中のみ）
  String? getQuestionText(TState state) => null; // 既定では質問テキストなし
  String? getProgressText(TState state) => null; // 既定では進捗なし
}