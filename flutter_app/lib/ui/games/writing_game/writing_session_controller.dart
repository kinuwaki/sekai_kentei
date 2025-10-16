import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/debug_logger.dart';
import '../base/base_game_screen.dart';
import 'writing_practice_settings.dart';
import 'writing_session_state.dart';
import 'writing_game_models.dart';
import 'writing_single_mode_logic.dart';

/// モード実行結果
class ModeResult {
  final bool success;
  final double? score;
  final Map<String, dynamic>? extra;

  const ModeResult({
    required this.success,
    this.score,
    this.extra,
  });
}

/// セッション制御
class WritingSessionController extends StateNotifier<WritingSessionState> {
  WritingPracticeSettings _settings;
  final WritingSingleModeLogic Function(WritingMode mode, String character) _logicFactory;
  
  WritingSingleModeLogic? _currentLogic;

  WritingSessionController(this._settings, this._logicFactory)
      : super(initialSessionState(_settings));

  /// セッション開始
  void start() {
    Log.d('WritingSession ${state.runId}: Starting session for character "${_settings.character}", sequence: ${_settings.sequence.map((m) => m.name).join(", ")}');
    
    state = state.copyWith(phase: GameUiPhase.playing);
    _runCurrentStep();
  }

  /// 現在のステップを実行
  void _runCurrentStep() {
    if (state.stepIndex >= state.sequence.length) {
      _toResult();
      return;
    }

    final mode = state.sequence[state.stepIndex];
    Log.d('WritingSession ${state.runId}: Starting step ${state.stepIndex + 1}/${state.sequence.length} - ${mode.displayName}');

    // 新しいロジックを作成
    _currentLogic?.dispose();
    _currentLogic = _logicFactory(mode, state.character);
    
    state = state.copyWith(isRunningMode: true);

    // モード実行開始
    _currentLogic!.run(
      onCompleted: (result) {
        Log.d('WritingSession ${state.runId}: Completed step ${state.stepIndex + 1}/${state.sequence.length} - ${mode.displayName}');
        _advance();
      },
      onError: (error, stackTrace) {
        Log.e('WritingSession ${state.runId}: Error in step ${state.stepIndex + 1}/${state.sequence.length} - ${mode.displayName}: $error');
        // エラー時は自動進行しない - ユーザーが手動で操作する必要がある
        Log.w('WritingSession ${state.runId}: Staying in current step due to error - user must manually complete');
      },
    );
  }

  /// 次のステップへ進む
  void _advance() {
    _currentLogic?.dispose();
    _currentLogic = null;
    
    state = state.copyWith(
      isRunningMode: false,
      stepIndex: state.stepIndex + 1,
    );
    
    _runCurrentStep();
  }

  /// 結果画面へ遷移
  void _toResult() {
    if (_settings.continuousMode) {
      // 連続モード：Result画面をスキップして完了コールバック
      Log.d('WritingSession ${state.runId}: Session complete (continuous mode) - calling completion callback');
      _settings.onSessionComplete?.call();
    } else {
      // 通常モード：Result画面表示
      Log.d('WritingSession ${state.runId}: Session complete (normal mode) - showing result screen');
      state = state.copyWith(phase: GameUiPhase.result);
    }
  }

  /// リトライ
  void retry() {
    Log.d('WritingSession ${state.runId}: Retrying session');
    state = state.copyWith(
      stepIndex: 0,
      isRunningMode: false,
      phase: GameUiPhase.playing,
    );
    _runCurrentStep();
  }

  /// リセット
  void reset() {
    Log.d('WritingSession ${state.runId}: Resetting session');
    _currentLogic?.dispose();
    _currentLogic = null;
    state = initialSessionState(_settings);
  }

  /// BaseGameScreen互換のリセット
  void resetGame() {
    reset();
  }

  /// BaseGameScreen互換の開始
  void startGame(WritingPracticeSettings settings) {
    Log.d('WritingSession: startGame called with character "${settings.character}"');
    _settings = settings;
    state = initialSessionState(settings);
    start();
  }

  /// 現在のモードを完了
  void completeCurrentMode() {
    if (_currentLogic != null) {
      Log.d('WritingSession ${state.runId}: Drawing completed, notifying logic');
      _currentLogic!.onDrawingCompleted();
    }
  }

  /// 練習組み合わせを選択
  void selectCombination(PracticeCombination combination) {
    Log.d('WritingSession ${state.runId}: Selected combination: ${combination.displayName}');
    state = state.copyWith(
      selectedCombination: combination,
    );
  }

  /// 文字を選択して開始
  void selectCharacterAndStart(String character) {
    if (state.selectedCombination != null) {
      Log.d('WritingSession ${state.runId}: Selected character: $character');
      
      // 新しい設定で更新
      _settings = WritingPracticeSettings(
        character: character,
        sequence: state.selectedCombination!.generateSequence(),
      );
      
      state = state.copyWith(
        character: character,
        sequence: state.selectedCombination!.generateSequence(),
        stepIndex: 0,
        phase: GameUiPhase.playing,
      );
      
      _runCurrentStep();
    } else {
      Log.e('WritingSession ${state.runId}: No combination selected');
    }
  }

  @override
  void dispose() {
    Log.d('WritingSession ${state.runId}: Disposing controller');
    _currentLogic?.dispose();
    super.dispose();
  }
}