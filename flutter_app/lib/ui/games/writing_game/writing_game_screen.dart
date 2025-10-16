import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/debug_logger.dart';
import '../../components/success_effect.dart';
import '../base/base_game_screen.dart';
import '../base/common_game_phase.dart';
import 'writing_game_logic.dart';
import 'writing_game_models.dart';
import 'widgets/category_selection_widget.dart';
import 'widgets/character_selection_widget.dart';
import 'widgets/mode_selection_widget.dart';
import 'widgets/tracing_canvas_widget.dart';
import 'widgets/tracing_free_canvas_widget.dart';
import 'widgets/free_writing_canvas_widget.dart';
import 'widgets/result_widget.dart';

class WritingGameScreen extends BaseGameScreen<
    WritingGameSettings, WritingGameState, WritingGameLogic> {
  final VoidCallback? onCompleted;  // 完了時コールバックを追加
  final bool skipResultScreen; // Orchestrator管理時はResult画面をスキップ
  
  const WritingGameScreen({
    super.key,
    super.initialSettings,
    this.onCompleted,
    this.skipResultScreen = false,
  }) : super(
        enableHomeButton: false, // Writing はホームボタンなし
      );

  @override
  WritingGameScreenState createState() => WritingGameScreenState();
}

class WritingGameScreenState extends BaseGameScreenState<
    WritingGameScreen, WritingGameSettings, WritingGameState, WritingGameLogic> {

  @override
  void initState() {
    super.initState();
    // 画面に入る時にリセット（initialSettingsがない場合、かつカテゴリ選択画面でない場合は維持）
    if (widget.initialSettings == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          final currentState = ref.read(writingGameLogicProvider);
          // カテゴリ選択画面の場合のみリセット（練習中の場合はリセットしない）
          if (currentState.phase == CommonGamePhase.ready) {
            readLogic(ref).resetGame();
          }
        }
      });
    }
    
    // Orchestratorモード設定（skipResultScreen=trueの場合）
    if (widget.skipResultScreen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          readLogic(ref).setOrchestratorMode(
            onCompleted: widget.onCompleted,
            skipResultScreen: true,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    // 画面を離れる時にもリセット（disposed後はrefアクセス不可のためtry-catchで保護）
    try {
      readLogic(ref).resetGame();
    } catch (e) {
      // disposed後はrefアクセス不可なので無視
    }
    super.dispose();
  }


  @override
  String get gameTitle => 'かきれんしゅう';

  // Riverpod: 状態購読
  @override
  WritingGameState watchState(WidgetRef ref) =>
      ref.watch(writingGameLogicProvider);

  // Riverpod: ロジック取得
  @override
  WritingGameLogic readLogic(WidgetRef ref) =>
      ref.read(writingGameLogicProvider.notifier);

  // 写像
  @override
  GameUiPhase phaseOf(WritingGameState s) {
    Log.d('WritingGameScreen.phaseOf: phase=${s.phase}, skipResultScreen=${widget.skipResultScreen}');

    // Orchestrator管理時の特別処理
    if (s.phase == CommonGamePhase.completed && widget.skipResultScreen) {
      Log.d('WritingGameScreen.phaseOf: Skipping result screen, calling onCompleted');
      // 完了コールバックを呼び出してplaying状態を維持
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && widget.onCompleted != null) {
          Log.d('WritingGameScreen: Calling onCompleted callback');
          widget.onCompleted!();
        }
      });
      return GameUiPhase.playing;
    }

    // 通常のフェーズマッピングは拡張メソッドを使用
    return s.phase.toGameUiPhase;
  }

  @override
  WritingGameSettings? settingsOf(WritingGameState s) {
    // プレイ中またはリザルト中の設定を返す
    if (s.selectedCategory != null && 
        s.selectedMode != null && 
        s.selectedCharacter != null) {
      return WritingGameSettings(
        category: s.selectedCategory!,
        mode: s.selectedMode!,
        character: s.selectedCharacter!,
      );
    }
    return null;
  }

  @override
  int? scoreOf(WritingGameState s) {
    // 完了した練習数をスコアとして返す
    if (s.phase == CommonGamePhase.completed) {
      // 結果画面では全ての練習が完了しているので、全練習数を返す
      return s.practiceSequence.length;
    }
    // プレイ中は現在のインデックス（0始まり）を返す
    return s.currentPracticeIndex + 1;
  }

  @override
  int totalQuestionsOf(WritingGameSettings s) {
    // practiceSequenceの長さが問題数
    final state = ref.read(writingGameLogicProvider);
    return state.practiceSequence.length;
  }

  @override
  String getSettingsDisplayName(WritingGameSettings settings) => settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFF6A5ACD), // 紫のグラデーション（上）
      Color(0xFF836FFF), // 紫のグラデーション（下）
    ];
  }

  // ヘッダー情報の実装
  @override
  String? getQuestionText(WritingGameState state) {
    if (state.phase == CommonGamePhase.questioning || 
        state.phase == CommonGamePhase.questioning ||
        state.phase == CommonGamePhase.questioning) {
      if (state.selectedCharacter != null) {
        // 「あをかいてみよう」のような指示文を表示
        return '${state.selectedCharacter!.character}をかいてみよう';
      }
    }
    return null;
  }

  @override
  String? getProgressText(WritingGameState state) {
    // 練習中の進捗を表示
    if (state.practiceSequence.isNotEmpty && 
        (state.phase == CommonGamePhase.questioning || 
         state.phase == CommonGamePhase.questioning ||
         state.phase == CommonGamePhase.questioning)) {
      final current = state.currentPracticeIndex + 1;
      final total = state.practiceSequence.length;
      return '$current/$total';
    }
    return null;
  }

  // 画面構築
  @override
  Widget buildSettingsView(BuildContext context, void Function(WritingGameSettings) onStart) {
    final state = watchState(ref);

    // 背景はBaseGameScreenで処理されるため、ここでは設定しない
    return _buildSettingsContent(context, state, onStart);
  }

  Widget _buildSettingsContent(BuildContext context, WritingGameState state, void Function(WritingGameSettings) onStart) {
    switch (state.internalPhase) {
      case WritingPhase.categorySelection:
        return CategorySelectionWidget(
          onCategorySelected: readLogic(ref).selectCategory,
        );

      case WritingPhase.modeSelection:
        return ModeSelectionWidget(
          category: state.selectedCategory!,
          onCombinationSelected: readLogic(ref).selectCombination,
        );

      case WritingPhase.characterSelection:
        return CharacterSelectionWidget(
          category: state.selectedCategory!,
          onCharacterSelected: (character) {
            // 文字選択完了時に設定オブジェクトを作成してゲーム開始
            final settings = WritingGameSettings(
              category: state.selectedCategory!,
              mode: state.selectedMode!,
              character: character,
            );
            onStart(settings);
          },
        );

      default:
        return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget buildPlayingView(BuildContext context, WritingGameState state, WritingGameLogic logic) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF6A5ACD),
            Color(0xFF836FFF),
          ],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // メインコンテンツ
            _buildPlayingContent(context, state, logic),
            
            // 成功エフェクト
            if (state.showSuccessEffect)
              SuccessEffect(
                onComplete: () {
                  // エフェクト完了後の処理
                },
                hadWrongAnswer: false,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayingContent(BuildContext context, WritingGameState state, WritingGameLogic logic) {
    switch (state.internalPhase) {
      case WritingPhase.tracing:
        return TracingCanvasWidget(
          character: state.selectedCharacter!,
          isAnimatingStrokes: state.isAnimatingStrokes,
          currentStrokeIndex: state.currentStrokeIndex,
          onEndDrawing: (size) => logic.endDrawing(size),
          onClearDrawing: logic.clearDrawing,
        );

      case WritingPhase.tracingFree:
        Log.d('WritingGameScreen: Building TracingFreeCanvasWidget with ${state.drawingData.paths.length} paths');
        return TracingFreeCanvasWidget(
          key: ValueKey('tracingFree_${state.selectedCharacter?.character}_${state.drawingData.paths.length}'),
          character: state.selectedCharacter!,
          drawingData: state.drawingData,
          onPathAdded: (path) {
            Log.d('WritingGameScreen: onPathAdded called, forwarding to logic');
            logic.addDrawingPath(path);
          },
          onClearDrawing: () {
            Log.d('WritingGameScreen: onClearDrawing called, forwarding to logic');
            logic.clearDrawing();
          },
          onComplete: () {
            Log.d('WritingGameScreen: onComplete called, forwarding to logic');
            logic.completeTracingFree();
          },
        );

      case WritingPhase.freeWriting:
        return FreeWritingCanvasWidget(
          character: state.selectedCharacter!,
          drawingData: state.drawingData,
          onPathAdded: logic.addDrawingPath,
          onClearDrawing: logic.clearDrawing,
          onRecognize: logic.recognizeFreeWriting,
          onRetry: logic.retryFreeWriting,
        );

      default:
        return const Center(child: CircularProgressIndicator());
    }
  }

  // 結果画面のオーバーライド
  @override
  Widget? buildResultViewOverride(BuildContext context, WritingGameState state, WritingGameLogic logic) {
    if (state.phase == CommonGamePhase.completed) {
      return ResultWidget(
        character: state.selectedCharacter!,
        mode: state.selectedMode!,
        recognitionResult: state.recognitionResult,
        onRetry: () {
          // Orchestratorで管理されている場合はコールバックを呼び出す
          if (widget.onCompleted != null) {
            widget.onCompleted!();
          } else {
            logic.retry();
          }
        },
        onSelectNewCharacter: () {
          if (widget.onCompleted != null) {
            widget.onCompleted!();
          } else {
            logic.backToCharacters();
          }
        },
        onSelectNewMode: () {
          if (widget.onCompleted != null) {
            widget.onCompleted!();
          } else {
            logic.backToModes();
          }
        },
      );
    }
    return null;
  }
}
