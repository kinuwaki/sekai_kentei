import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/responsive_theme.dart';
import '../base/base_game_screen.dart';
import '../writing_game/widgets/unified_writing_canvas_widget.dart';
import '../writing_game/widgets/canvas_design_presets.dart';
import '../../components/success_effect.dart';
import 'widgets/number_keypad.dart';
import 'modern_number_logic.dart';
import 'models/number_models.dart';
import '../base/common_game_phase.dart';

// BaseGameScreenパターンに合わせるための設定クラス
class NumberRecognitionGameSettings {
  final int problemCount;
  
  const NumberRecognitionGameSettings({
    this.problemCount = 3,
  });
  
  String get displayName => 'すうじをかこう';
}

class NumberRecognitionGameScreen extends BaseGameScreen<
    NumberRecognitionGameSettings, NumberState, ModernNumberLogic> {
  final int _problemCount;

  const NumberRecognitionGameScreen({
    super.key,
    int? problemCount,
  }) : _problemCount = problemCount ?? 3,
        super(
        enableHomeButton: false,
      );

  NumberRecognitionGameSettings get _settings => NumberRecognitionGameSettings(
    problemCount: _problemCount,
  );

  @override
  NumberRecognitionGameSettings? get initialSettings => _settings;

  @override
  NumberRecognitionGameScreenState createState() => NumberRecognitionGameScreenState();
}

class NumberRecognitionGameScreenState extends BaseGameScreenState<
    NumberRecognitionGameScreen, NumberRecognitionGameSettings, NumberState, ModernNumberLogic> {
  
  bool _initialized = false;

  @override
  String get gameTitle => 'すうじをかこう';

  // 直接ModernNumberLogicを使用（他のゲームと同じパターン）
  @override
  NumberState watchState(WidgetRef ref) {
    return ref.watch(modernNumberLogicProvider);
  }

  @override
  ModernNumberLogic readLogic(WidgetRef ref) {
    // 直接ModernNumberLogicを返す（他のゲームと同じパターン）
    return ref.read(modernNumberLogicProvider.notifier);
  }
  

  // 写像（新しいパターン）
  @override
  GameUiPhase phaseOf(NumberState s) {
    switch (s.phase) {
      case CommonGamePhase.ready: return GameUiPhase.settings;
      case CommonGamePhase.displaying:
      case CommonGamePhase.questioning:
      case CommonGamePhase.processing:
      case CommonGamePhase.feedbackOk:
      case CommonGamePhase.feedbackNg:
      case CommonGamePhase.transitioning:
        return GameUiPhase.playing;
      case CommonGamePhase.completed: return GameUiPhase.result;
    }
  }

  @override
  NumberRecognitionGameSettings? settingsOf(NumberState s) {
    if (s.phase == CommonGamePhase.ready) return null;
    return NumberRecognitionGameSettings(problemCount: s.session.total);
  }

  @override
  String? getProgressText(NumberState state) {
    return state.phase != CommonGamePhase.ready
        ? '${state.session.index + 1}/${state.session.total}'
        : null;
  }

  @override
  int? scoreOf(NumberState s) => s.session.index + 1; // 現在の問題番号

  @override
  int totalQuestionsOf(NumberRecognitionGameSettings s) => s.problemCount;

  @override
  String getSettingsDisplayName(NumberRecognitionGameSettings settings) => settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFF4A90E2), // 青いグラデーション（上）
      Color(0xFF357ABD), // 青いグラデーション（下）
    ];
  }

  // ヘッダーに問題文を表示
  @override
  String? getQuestionText(NumberState state) {
    if (phaseOf(state) == GameUiPhase.playing) {
      return state.session.current.prompt;
    }
    return null;
  }

  // getSpeakerCallback, getIsSpeaking, _handleSpeakerPressed は BaseGameScreen が自動実装

  // ゲーム初期化
  @override
  void initializeGame() {
    if (_initialized) return; // 重複初期化を防ぐ
    _initialized = true;
    
    // initializeGame は BaseGameScreen 内で適切なタイミングで呼ばれるため
    // PostFrameCallback は不要。直接初期化する。
    // startGameメソッドをオーバーライドして、そこで初期化を行う
  }

  // 画面構築
  @override
  Widget buildSettingsView(BuildContext context, void Function(NumberRecognitionGameSettings) onStart) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.edit_outlined,
                  size: 80,
                  color: Colors.blue[400],
                ),
                const SizedBox(height: 24),
                Text(
                  'すうじをかこう！',
                  style: TextStyle(
                    fontSize: context.fontSizes.gameTitle,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2E3A59),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '3もんの もんだいに こたえよう',
                  style: TextStyle(
                    fontSize: context.fontSizes.gameContent,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    onStart(widget._settings);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'はじめる',
                    style: TextStyle(
                      fontSize: context.fontSizes.keypadNumber,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildPlayingView(BuildContext context, NumberState state, ModernNumberLogic logic) {
    final session = state.session;
    final problem = session.current;
    
    Widget playingContent = Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF4A90E2),
            Color(0xFF357ABD),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0), // 下のパディングを完全削除
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth > 600;

            return isTablet
                ? _buildTabletLayout(problem, logic)
                : _buildMobileLayout(problem, logic);
          },
        ),
      ),
    );

    return Stack(
      children: [
        playingContent,
        // 成功エフェクト（他のゲームと統一）
        if (logic.showSuccessEffect)
          SuccessEffect(
            onComplete: () => logic.hideSuccessEffect(),
            hadWrongAnswer: logic.hadWrongAnswer,
          ),
      ],
    );
  }

  /// タブレット用レイアウト
  Widget _buildTabletLayout(NumberProblem problem, ModernNumberLogic logic) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final buttonWidth = screenWidth * 0.25;
    final availableWidth = screenWidth - buttonWidth;
    final margin = screenWidth * 0.025; // 画面幅の2.5%をマージンに
    final smallerDimension = availableWidth < screenHeight ? availableWidth : screenHeight;
    final canvasSize = (smallerDimension * 0.9 - margin * 2).clamp(screenWidth * 0.65, screenWidth * 1.1);

    return Column(
      children: [
        // 0-9テンキー（ヘッダーギリギリ）
        CompactNumberKeypad(
          onNumberPressed: logic.inputNumber,
          enabled: !logic.isProcessing,
        ),

        const SizedBox(height: 4),

        // メインエリア（描画パッド + ボタンエリア）
        Expanded(
          child: Stack(
            children: [
              // 描画キャンバス（中央配置）
              Center(
                child: Container(
                  width: canvasSize * 0.7, // 横幅を0.7倍に
                  height: canvasSize * 1.3, // 縦幅を1.3倍に戻す
                  margin: EdgeInsets.symmetric(horizontal: margin, vertical: margin * 0.2), // 縦マージンを大幅削減
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // キャンバスサイズを設定
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        logic.setCanvasSize(Size(constraints.maxWidth, constraints.maxHeight));
                      });

                      return UnifiedWritingCanvasWidget(
                        character: null, // 数字認識用なのでnull
                        mode: WritingCanvasMode.freeWrite, // 自由書きモード
                        drawingData: logic.drawingData,
                        onPathAdded: logic.addDrawingPath,
                        onRecognize: logic.recognizeHandwriting,
                        onClearDrawing: logic.clearDrawing,
                        isProcessing: logic.isProcessing,
                        customization: CanvasDesignPresets.numberRecognitionGame(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                        ),
                      );
                    },
                  ),
                ),
              ),

              // ボタンエリア（右側）
              Positioned(
                right: -buttonWidth * 0.14, // ボタン幅の14%分右にはみ出し
                top: 0,
                bottom: 0,
                width: buttonWidth,
                child: Container(
                  padding: EdgeInsets.zero, // ボタンエリアのパディング完全削除
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // できたボタン
                      SizedBox(
                        width: buttonWidth * 0.7182, // 0.756 * 0.95 = 0.7182 (5%縮小)
                        height: screenHeight * 0.1134, // 0.108 * 1.05 = 0.1134 (5%拡大)
                        child: ElevatedButton(
                          onPressed: logic.recognizeHandwriting,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            'できた',
                            style: TextStyle(
                              fontSize: screenWidth * 0.03, // 0.035 → 0.03に縮小
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.08),

                      // やりなおしボタン
                      SizedBox(
                        width: buttonWidth * 0.7182, // 0.756 * 0.95 = 0.7182 (5%縮小)
                        height: screenHeight * 0.1134, // 0.108 * 1.05 = 0.1134 (5%拡大)
                        child: ElevatedButton(
                          onPressed: logic.clearDrawing,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            'やりなおし',
                            style: TextStyle(
                              fontSize: screenWidth * 0.024, // 0.028 → 0.024に縮小
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }

  /// モバイル用レイアウト（縦並び）
  Widget _buildMobileLayout(NumberProblem problem, ModernNumberLogic logic) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final buttonWidth = screenWidth * 0.25;
    final availableWidth = screenWidth - buttonWidth;
    final margin = screenWidth * 0.025; // 画面幅の2.5%をマージンに
    final smallerDimension = availableWidth < screenHeight ? availableWidth : screenHeight;
    final canvasSize = (smallerDimension * 0.9 - margin * 2).clamp(screenWidth * 0.65, screenWidth * 1.1);

    return Column(
      children: [
        // 0-9テンキー（ヘッダーギリギリ）
        CompactNumberKeypad(
          onNumberPressed: logic.inputNumber,
          enabled: !logic.isProcessing,
        ),

        const SizedBox(height: 4),

        // メインエリア（描画パッド + ボタンエリア）
        Expanded(
          child: Stack(
            children: [
              // 描画キャンバス（中央配置）
              Center(
                child: Container(
                  width: canvasSize * 0.7, // 横幅を0.7倍に
                  height: canvasSize * 1.3, // 縦幅を1.3倍に戻す
                  margin: EdgeInsets.symmetric(horizontal: margin, vertical: margin * 0.2), // 縦マージンを大幅削減
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // キャンバスサイズを設定
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        logic.setCanvasSize(Size(constraints.maxWidth, constraints.maxHeight));
                      });

                      return UnifiedWritingCanvasWidget(
                        character: null, // 数字認識用なのでnull
                        mode: WritingCanvasMode.freeWrite, // 自由書きモード
                        drawingData: logic.drawingData,
                        onPathAdded: logic.addDrawingPath,
                        onRecognize: logic.recognizeHandwriting,
                        onClearDrawing: logic.clearDrawing,
                        isProcessing: logic.isProcessing,
                        customization: CanvasDesignPresets.numberRecognitionGame(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                        ),
                      );
                    },
                  ),
                ),
              ),

              // ボタンエリア（右側）
              Positioned(
                right: -buttonWidth * 0.14, // ボタン幅の14%分右にはみ出し
                top: 0,
                bottom: 0,
                width: buttonWidth,
                child: Container(
                  padding: EdgeInsets.zero, // ボタンエリアのパディング完全削除
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // できたボタン
                      SizedBox(
                        width: buttonWidth * 0.7182, // 0.756 * 0.95 = 0.7182 (5%縮小)
                        height: screenHeight * 0.1134, // 0.108 * 1.05 = 0.1134 (5%拡大)
                        child: ElevatedButton(
                          onPressed: logic.recognizeHandwriting,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            'できた',
                            style: TextStyle(
                              fontSize: screenWidth * 0.03, // 0.035 → 0.03に縮小
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.08),

                      // やりなおしボタン
                      SizedBox(
                        width: buttonWidth * 0.7182, // 0.756 * 0.95 = 0.7182 (5%縮小)
                        height: screenHeight * 0.1134, // 0.108 * 1.05 = 0.1134 (5%拡大)
                        child: ElevatedButton(
                          onPressed: logic.clearDrawing,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            'やりなおし',
                            style: TextStyle(
                              fontSize: screenWidth * 0.024, // 0.028 → 0.024に縮小
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}