import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../base/base_game_screen.dart';
import '../base/common_game_phase.dart';
import '../../components/success_effect.dart';
import 'models/instant_memory_models.dart';
import 'modern_instant_memory_logic.dart';

class InstantMemoryScreen extends BaseGameScreen<InstantMemorySettings,
    InstantMemoryState, ModernInstantMemoryLogic> {
  const InstantMemoryScreen({super.key}) : super(enableHomeButton: false);

  @override
  InstantMemoryScreenState createState() => InstantMemoryScreenState();
}

class InstantMemoryScreenState extends BaseGameScreenState<
    InstantMemoryScreen,
    InstantMemorySettings,
    InstantMemoryState,
    ModernInstantMemoryLogic> {

  @override
  String get gameTitle => 'しゅんかんきおく';

  @override
  InstantMemoryState watchState(WidgetRef ref) =>
      ref.watch(modernInstantMemoryLogicProvider);

  @override
  ModernInstantMemoryLogic readLogic(WidgetRef ref) =>
      ref.read(modernInstantMemoryLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(InstantMemoryState s) {
    return s.phase.toGameUiPhase;
  }

  @override
  InstantMemorySettings? settingsOf(InstantMemoryState s) => s.settings;

  @override
  int? scoreOf(InstantMemoryState s) => s.session?.correctCount;

  @override
  int totalQuestionsOf(InstantMemorySettings s) => s.questionCount;

  @override
  String getSettingsDisplayName(InstantMemorySettings settings) =>
      settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Colors.white,
      Colors.white,
    ];
  }

  @override
  String? getQuestionText(InstantMemoryState state) {
    if (state.session?.currentProblem == null) return null;

    final problem = state.session!.currentProblem!;
    final showingAnswer = state.session!.showingAnswer;

    if (!showingAnswer) {
      // 記憶フェーズ: 記憶フェーズのテキストを読み上げ
      return problem.memoryPhaseText;
    } else if (state.canAnswer) {
      // 回答フェーズ: 変化タイプに応じた質問を読み上げ
      return problem.questionText;
    }
    return null;
  }

  @override
  String? getProgressText(InstantMemoryState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }

  @override
  Widget buildSettingsView(BuildContext context, void Function(InstantMemorySettings) onStart) {
    final screenSize = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'しゅんかんきおく',
            style: TextStyle(
              fontSize: screenSize.width * 0.04,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2196F3),
            ),
          ),
          SizedBox(height: screenSize.height * 0.05),
          ...InstantMemoryDifficulty.values.map((difficulty) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
              child: ElevatedButton(
                onPressed: () {
                  final settings = InstantMemorySettings(
                    difficulty: difficulty,
                    questionCount: 3,
                  );
                  onStart(settings);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  foregroundColor: Colors.white,
                  minimumSize: Size(
                    screenSize.width * 0.5,
                    screenSize.height * 0.08,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  difficulty.displayName,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget buildPlayingView(BuildContext context, InstantMemoryState state, ModernInstantMemoryLogic logic) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        // 白背景
        Container(
          color: Colors.white,
        ),

        // メインコンテンツ
        _buildGameContent(context, state, logic, screenSize),

        // 成功エフェクト
        if (state.phase == CommonGamePhase.feedbackOk)
          SuccessEffect(
            onComplete: () {},
            hadWrongAnswer: (state.session?.wrongAttempts ?? 0) > 0,
          ),
      ],
    );
  }

  Widget _buildGameContent(
    BuildContext context,
    InstantMemoryState state,
    ModernInstantMemoryLogic logic,
    Size screenSize,
  ) {
    final session = state.session;
    final problem = session?.currentProblem;

    if (problem == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final showingAnswer = session!.showingAnswer;
    final items = showingAnswer ? problem.changedItems : problem.initialItems;

    // 難易度に応じて画像サイズを調整（5%縮小）
    final difficulty = state.settings!.difficulty;
    final imageSizeRatio = difficulty == InstantMemoryDifficulty.easy
        ? 0.418  // かんたん: 3個、大きく (0.44 * 0.95)
        : difficulty == InstantMemoryDifficulty.normal
            ? 0.342  // ふつう: 5個 (0.36 * 0.95)
            : 0.285;  // むずかしい: 7個 (0.30 * 0.95)

    final shortSide = screenSize.width < screenSize.height ? screenSize.width : screenSize.height;
    final imageSize = shortSide * imageSizeRatio;

    // 描画領域を少し狭くする（左右10%、上5%、下20%の余白）
    final marginH = screenSize.width * 0.10;
    final marginTop = screenSize.height * 0.05;
    final marginBottom = screenSize.height * 0.20;
    final drawWidth = screenSize.width - marginH * 2;
    final drawHeight = screenSize.height - marginTop - marginBottom;

    // グリッド分割方式で配置（確実に重ならず、はみ出さない）
    final itemCount = items.length;

    // 1) ベースシード：itemsのハッシュ
    final itemsHash = items.map((e) => '${e.id}${e.word}${e.x}${e.y}').join().hashCode;

    // 2) フェーズ塩：epochを使用（初期表示と変化後で異なる値）
    final phaseSalt = state.epoch;

    // 3) ベースシードに塩を混ぜる
    final baseSeed = Object.hash(itemsHash, phaseSalt);

    // 4) セル内完全ランダム位置関数（アイテム単位＆軸単位で局所RNG）
    double cellRandomPosition({
      required int index,
      required int itemId,
      required String axis,
    }) {
      final mix = baseSeed ^ (itemId * 0x9E3779B9) ^ (index * 0x85EBCA77) ^ axis.hashCode;
      final rng = Random(mix);
      return rng.nextDouble(); // 0.0〜1.0の完全ランダム
    }

    // グリッド分割数を決定（3個→2x2、5個→3x2、7個→3x3）
    final cols = itemCount <= 3 ? 2 : itemCount <= 5 ? 3 : 3;
    final rows = (itemCount / cols).ceil();

    final cellWidth = drawWidth / cols;
    final cellHeight = drawHeight / rows;

    return Stack(
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final canTap = showingAnswer && state.canAnswer;

        // グリッドセルを決定
        final col = index % cols;
        final row = index ~/ cols;

        // セル内でランダム配置（画像がはみ出さない範囲）
        final cellLeft = marginH + col * cellWidth;
        final cellTop = marginTop + row * cellHeight;

        final maxLeftInCell = cellWidth - imageSize;
        final maxTopInCell = cellHeight - imageSize;

        // セル内完全ランダム位置
        final randomX = cellRandomPosition(index: index, itemId: item.id, axis: 'x');
        final randomY = cellRandomPosition(index: index, itemId: item.id, axis: 'y');

        // セル内に収まらない場合は中央配置
        final leftInCell = maxLeftInCell > 0 ? randomX * maxLeftInCell : (cellWidth - imageSize) / 2;
        final topInCell = maxTopInCell > 0 ? randomY * maxTopInCell : (cellHeight - imageSize) / 2;

        final left = cellLeft + leftInCell;
        final top = cellTop + topInCell;

        print('InstantMemory: Item $index(${item.word}) - epoch=${state.epoch}, baseSeed=$baseSeed, grid($row,$col) → left=$left, top=$top, randomX=$randomX, randomY=$randomY');

        // 正解判定（正解した画像に丸を表示）
        final isCorrect = state.phase == CommonGamePhase.feedbackOk &&
                         problem.changedIndex == index;

        return Positioned(
            left: left,
            top: top,
            child: GestureDetector(
              onTap: canTap
                  ? () => logic.answerQuestion(index)
                  : null,
              child: Stack(
                children: [
                  Container(
                    width: imageSize,
                    height: imageSize,
                    padding: const EdgeInsets.all(4),
                    child: Image.asset(
                      item.imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                  if (isCorrect)
                    Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.red,
                          width: 4,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
    );
  }
}
