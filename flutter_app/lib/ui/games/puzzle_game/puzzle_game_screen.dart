import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/success_effect.dart';
import '../base/base_game_screen.dart';
import '../base/common_game_phase.dart';
import 'models/puzzle_game_models.dart';
import 'modern_puzzle_game_logic.dart';
import 'widgets/puzzle_piece_widget.dart';

/// パズルゲーム画面
class PuzzleGameScreen extends BaseGameScreen<PuzzleGameSettings, PuzzleGameState, ModernPuzzleGameLogic> {
  final bool skipResultScreen;

  const PuzzleGameScreen({
    super.key,
    super.initialSettings,
    this.skipResultScreen = false,
  });

  @override
  PuzzleGameScreenState createState() => PuzzleGameScreenState();
}

class PuzzleGameScreenState extends BaseGameScreenState<
    PuzzleGameScreen, PuzzleGameSettings, PuzzleGameState, ModernPuzzleGameLogic> {
  
  @override
  String get gameTitle => 'ばらばらパズル';
  
  @override
  PuzzleGameState watchState(WidgetRef ref) => ref.watch(modernPuzzleGameLogicProvider);

  @override
  ModernPuzzleGameLogic readLogic(WidgetRef ref) => 
      ref.read(modernPuzzleGameLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(PuzzleGameState state) {
    switch (state.phase) {
      case CommonGamePhase.ready:
        return GameUiPhase.settings;
      case CommonGamePhase.completed:
        return widget.skipResultScreen ? GameUiPhase.settings : GameUiPhase.result;
      default:
        return GameUiPhase.playing;
    }
  }
  
  @override
  PuzzleGameSettings? settingsOf(PuzzleGameState state) => state.settings;
  
  @override
  int? scoreOf(PuzzleGameState state) {
    if (state.isCompleted && state.session != null) {
      return state.session!.correctCount;
    }
    return null;
  }
  
  @override
  int totalQuestionsOf(PuzzleGameSettings settings) => settings.questionCount;

  @override
  String? getProgressText(PuzzleGameState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }

  @override
  String getSettingsDisplayName(PuzzleGameSettings settings) => settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFFFFF9C4), // 黄色いグラデーション（上）
      Color(0xFFFFE082), // 黄色いグラデーション（下）
    ];
  }

  @override
  String? getQuestionText(PuzzleGameState state) => state.questionText;

  @override
  Widget buildSettingsView(BuildContext context, void Function(PuzzleGameSettings) onStart) {
    // 常に自動開始（設定画面をスキップ）
    final settings = widget.initialSettings ?? const PuzzleGameSettings(questionCount: 3);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onStart(settings);
    });
    
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFF9C4), Color(0xFFFFE082)],
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'パズルをよみこんでいます...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildPlayingView(BuildContext context, PuzzleGameState state, ModernPuzzleGameLogic logic) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        // 背景グラデーション
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFF9C4), Color(0xFFFFE082)],
            ),
          ),
        ),

        // メインコンテンツ
        SafeArea(
          child: Column(
            children: [
              // ゲームコンテンツ
              Expanded(
                child: state.phase == CommonGamePhase.displaying
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text(
                              'がぞうをよみこんでいます...',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : state.errorMessage != null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error,
                                  size: 64,
                                  color: Colors.red,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'エラー',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  state.errorMessage!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('もどる'),
                                ),
                              ],
                            ),
                          )
                        : _buildGameContent(context, state, logic, screenSize),
              ),
            ],
          ),
        ),

        // フィードバックエフェクト
        if (state.phase == CommonGamePhase.feedbackOk) ...[
          const SuccessEffect(),
        ] else if (state.phase == CommonGamePhase.feedbackNg) ...[
          _buildErrorEffect(),
        ],
      ],
    );
  }


  Widget _buildGameContent(
    BuildContext context,
    PuzzleGameState state,
    ModernPuzzleGameLogic logic,
    Size screenSize,
  ) {
    final problem = state.session?.currentProblem;
    if (problem == null) return const SizedBox();

    final isLandscape = screenSize.width > screenSize.height;

    if (isLandscape) {
      // 横向きレイアウト
      return Row(
        children: [
          // 左側：お手本画像
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'おてほん',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 2.0 / 3.0, // 2:3のアスペクト比
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: PuzzleReferenceWidget(
                              image: problem.fullImage,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 右側：パズルピース
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    '${state.selectedCount}/2 えらんだよ',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: _buildPuzzlePiecesList(
                      context,
                      problem.pieces,
                      problem.fullImage,
                      logic,
                      state.phase == CommonGamePhase.feedbackOk ||
                                   state.phase == CommonGamePhase.feedbackNg,
                      state.lastResult?.isCorrect == true
                          ? state.session?.selectedPieceIndices ?? []
                          : [],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      // 縦向きレイアウト
      return Column(
        children: [
          // 上部：お手本画像（余白を詰める）
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0), // 上下の余白を詰める
              child: Column(
                children: [
                  const Text(
                    'おてほん',
                    style: TextStyle(
                      fontSize: 18, // フォントサイズを少し小さく
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4), // 間隔を詰める
                  Expanded(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 2.0 / 3.0, // 2:3のアスペクト比
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: PuzzleReferenceWidget(
                              image: problem.fullImage,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 下部：パズルピース（余白を詰める）
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0), // パディングを元に戻す
              child: Column(
                children: [
                  Text(
                    '${state.selectedCount}/2 えらんだよ',
                    style: const TextStyle(
                      fontSize: 16, // フォントサイズを少し小さく
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4), // 間隔を詰める
                  Expanded(
                    child: _buildPuzzlePiecesList(
                      context,
                      problem.pieces,
                      problem.fullImage,
                      logic,
                      state.phase == CommonGamePhase.feedbackOk ||
                                   state.phase == CommonGamePhase.feedbackNg,
                      state.lastResult?.isCorrect == true
                          ? state.session?.selectedPieceIndices ?? []
                          : [],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildErrorEffect() {
    return Container(
      color: Colors.red.withOpacity(0.3),
      child: const Center(
        child: Icon(
          Icons.close,
          size: 100,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPuzzlePiecesList(
    BuildContext context,
    List<PuzzlePiece> pieces,
    ui.Image? image,
    ModernPuzzleGameLogic logic,
    bool showFeedback,
    List<int> correctIndices,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 利用可能な領域の計算（制約を基準に）
        final availableWidth = constraints.maxWidth;
        final availableHeight = constraints.maxHeight;

        // 縦横の間隔を割合で計算（魔法数字を排除）
        final verticalSpacing = availableHeight * 0.02; // 高さの2%
        final horizontalSpacing = availableWidth * 0.02; // 幅の2%

        // 下段の横並びピース用の計算
        final bottomRowPieces = pieces.length > 2 ? 2 : (pieces.length > 1 ? 1 : 0);

        // ピースサイズの計算（制約内に収まるように）
        double pieceWidth, pieceHeight;

        if (bottomRowPieces > 0) {
          // 下段に複数ピースがある場合：横幅から逆算
          final totalHorizontalSpacing = horizontalSpacing * (bottomRowPieces - 1);
          pieceWidth = (availableWidth - totalHorizontalSpacing) / bottomRowPieces;

          // 高さは上段＋下段＋間隔から逆算
          final totalVerticalSpacing = verticalSpacing;
          pieceHeight = (availableHeight - totalVerticalSpacing) / 2;

          // アスペクト比を維持するため、より制限の厳しい方に合わせる
          final maxWidthBasedHeight = pieceWidth * 0.75; // 4:3のアスペクト比想定
          if (maxWidthBasedHeight < pieceHeight) {
            pieceHeight = maxWidthBasedHeight;
          } else {
            pieceWidth = pieceHeight / 0.75;
          }
        } else {
          // 上段のみの場合
          pieceWidth = availableWidth * 0.8; // 幅の80%を使用
          pieceHeight = availableHeight * 0.8; // 高さの80%を使用

          // アスペクト比調整
          final maxWidthBasedHeight = pieceWidth * 0.75;
          if (maxWidthBasedHeight < pieceHeight) {
            pieceHeight = maxWidthBasedHeight;
          } else {
            pieceWidth = pieceHeight / 0.75;
          }
        }

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 上段：1個のピース（中央配置）
              if (pieces.isNotEmpty)
                SizedBox(
                  width: pieceWidth,
                  height: pieceHeight,
                  child: PuzzlePieceWidget(
                    piece: pieces[0],
                    image: image,
                    onTap: () => logic.selectPiece(0),
                    showFeedback: showFeedback,
                    isCorrect: correctIndices.contains(0),
                  ),
                ),

              // 縦間隔（動的）
              if (pieces.length > 1) SizedBox(height: verticalSpacing),

              // 下段：ピース（中央配置）
              if (pieces.length >= 2)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 1つ目のピース
                    SizedBox(
                      width: pieceWidth,
                      height: pieceHeight,
                      child: PuzzlePieceWidget(
                        piece: pieces[1],
                        image: image,
                        onTap: () => logic.selectPiece(1),
                        showFeedback: showFeedback,
                        isCorrect: correctIndices.contains(1),
                      ),
                    ),

                    // 横間隔（動的）＋2つ目のピース
                    if (pieces.length > 2) ...[
                      SizedBox(width: horizontalSpacing),
                      SizedBox(
                        width: pieceWidth,
                        height: pieceHeight,
                        child: PuzzlePieceWidget(
                          piece: pieces[2],
                          image: image,
                          onTap: () => logic.selectPiece(2),
                          showFeedback: showFeedback,
                          isCorrect: correctIndices.contains(2),
                        ),
                      ),
                    ],
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}

/// パズル設定画面
class _PuzzleSettingsView extends StatefulWidget {
  final Function(PuzzleGameSettings) onStart;

  const _PuzzleSettingsView({
    required this.onStart,
  });

  @override
  State<_PuzzleSettingsView> createState() => _PuzzleSettingsViewState();
}

class _PuzzleSettingsViewState extends State<_PuzzleSettingsView> {
  int _questionCount = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFF9C4), Color(0xFFFFE082)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.extension,
                size: 80,
                color: Colors.orange,
              ),
              const SizedBox(height: 24),
              const Text(
                'ばらばらパズル',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 40),
              
              // 問題数表示（固定）
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'もんだいのかず: $_questionCount問',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'パズルを3回とくよ！',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // スタートボタン
              ElevatedButton(
                onPressed: () {
                  final settings = PuzzleGameSettings(
                    questionCount: _questionCount,
                  );
                  widget.onStart(settings);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: const Text(
                  'はじめる',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}