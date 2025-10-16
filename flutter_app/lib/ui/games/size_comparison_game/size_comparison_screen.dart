import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../base/base_game_screen.dart';
import '../../components/success_effect.dart';
import 'models/size_comparison_models.dart';
import 'models/size_comparison_phase.dart';
import 'modern_size_comparison_logic.dart';

class SizeComparisonScreen extends BaseGameScreen<SizeComparisonSettings, SizeComparisonState, ModernSizeComparisonLogic> {
  const SizeComparisonScreen({
    super.key,
    super.initialSettings,
  });

  @override
  BaseGameScreenState<SizeComparisonScreen, SizeComparisonSettings, SizeComparisonState, ModernSizeComparisonLogic>
      createState() => _SizeComparisonScreenState();
}

class _SizeComparisonScreenState extends BaseGameScreenState<
    SizeComparisonScreen,
    SizeComparisonSettings,
    SizeComparisonState,
    ModernSizeComparisonLogic> {
  
  @override
  String get gameTitle => 'なんばんめ';

  @override
  SizeComparisonState watchState(WidgetRef ref) =>
      ref.watch(modernSizeComparisonLogicProvider);

  @override
  ModernSizeComparisonLogic readLogic(WidgetRef ref) =>
      ref.read(modernSizeComparisonLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(SizeComparisonState s) {
    switch (s.phase) {
      case SizeComparisonPhase.ready:
        return GameUiPhase.settings;
      case SizeComparisonPhase.completed:
        return GameUiPhase.result;
      default:
        return GameUiPhase.playing;
    }
  }

  @override
  SizeComparisonSettings? settingsOf(SizeComparisonState s) => s.settings;

  @override
  int? scoreOf(SizeComparisonState s) {
    if (s.session == null) return null;
    return s.session!.correctCount;
  }

  @override
  int totalQuestionsOf(SizeComparisonSettings settings) => settings.questionCount;

  @override
  String getSettingsDisplayName(SizeComparisonSettings settings) => settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFFF0F8FF), // 水色のグラデーション（上）
      Color(0xFFE6F3FF), // 水色のグラデーション（下）
    ];
  }

  @override
  String? getQuestionText(SizeComparisonState state) {
    return state.session?.currentProblem?.questionText;
  }

  @override
  String? getProgressText(SizeComparisonState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }

  @override
  Widget buildSettingsView(BuildContext context, void Function(SizeComparisonSettings) onStart) {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.width * 0.025;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'どれをさがしますか？',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize * 1.8,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 40),

            Expanded(
              child: Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // 横幅いっぱいを使って6個を1列に配置
                    final availableWidth = constraints.maxWidth;
                    final spacing = 8.0;
                    final totalSpacing = spacing * 5; // 6個の間に5つのスペース
                    final buttonWidth = (availableWidth - totalSpacing) / 6;
                    final buttonHeight = constraints.maxHeight * 0.5; // 高さは画面の半分まで

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCompactButton(
                          context,
                          title: 'いちばん\nおおきい',
                          color: Colors.red,
                          choice: ComparisonChoice.largest,
                          onTap: (choice) => onStart(SizeComparisonSettings(comparisonChoice: choice)),
                          width: buttonWidth,
                          height: buttonHeight,
                        ),
                        SizedBox(width: spacing),
                        _buildCompactButton(
                          context,
                          title: 'いちばん\nちいさい',
                          color: Colors.blue,
                          choice: ComparisonChoice.smallest,
                          onTap: (choice) => onStart(SizeComparisonSettings(comparisonChoice: choice)),
                          width: buttonWidth,
                          height: buttonHeight,
                        ),
                        SizedBox(width: spacing),
                        _buildCompactButton(
                          context,
                          title: 'おおきいちいさい\nランダム',
                          color: Colors.deepPurple,
                          choice: ComparisonChoice.sizeRandom,
                          onTap: (choice) => onStart(SizeComparisonSettings(comparisonChoice: choice)),
                          width: buttonWidth,
                          height: buttonHeight,
                        ),
                        SizedBox(width: spacing),
                        _buildCompactButton(
                          context,
                          title: 'ひだりから',
                          color: Colors.green,
                          choice: ComparisonChoice.leftPosition,
                          onTap: (choice) => onStart(SizeComparisonSettings(comparisonChoice: choice)),
                          width: buttonWidth,
                          height: buttonHeight,
                        ),
                        SizedBox(width: spacing),
                        _buildCompactButton(
                          context,
                          title: 'みぎから',
                          color: Colors.orange,
                          choice: ComparisonChoice.rightPosition,
                          onTap: (choice) => onStart(SizeComparisonSettings(comparisonChoice: choice)),
                          width: buttonWidth,
                          height: buttonHeight,
                        ),
                        SizedBox(width: spacing),
                        _buildCompactButton(
                          context,
                          title: 'ひだりみぎ\nランダム',
                          color: Colors.purple,
                          choice: ComparisonChoice.positionRandom,
                          onTap: (choice) => onStart(SizeComparisonSettings(comparisonChoice: choice)),
                          width: buttonWidth,
                          height: buttonHeight,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactButton(
    BuildContext context, {
    required String title,
    required Color color,
    required ComparisonChoice choice,
    required Function(ComparisonChoice) onTap,
    required double width,
    required double height,
  }) {
    final fontSize = width * 0.15; // ボタン幅に応じたフォントサイズ

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(choice),
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildPlayingView(BuildContext context, SizeComparisonState state, ModernSizeComparisonLogic logic) {
    if (state.session?.currentProblem == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final problem = state.session!.currentProblem!;
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF0F8FF), Color(0xFFE6F3FF)],
            ),
          ),
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // 画面全体の横幅を使って1列に配置
                final screenWidth = MediaQuery.of(context).size.width;
                final iconCount = problem.icons.length;
                final spacing = 4.0; // 最小スペース
                final totalSpacing = spacing * (iconCount - 1);
                final availableWidth = screenWidth - totalSpacing;

                // 各アイコンの最大サイズを計算
                final maxIconSize = availableWidth / iconCount;

                // 縦幅の制限も考慮（縦が狭い場合は縦に合わせる）
                final maxHeight = constraints.maxHeight * 0.9;
                final finalSize = maxIconSize > maxHeight ? maxHeight : maxIconSize;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(problem.icons.length, (index) {
                    final icon = problem.icons[index];
                    final isSelected = state.lastResult?.selectedIndex == index;
                    final isCorrect = problem.correctAnswerIndex == index;
                    final showResult = state.phase == SizeComparisonPhase.feedbackOk ||
                                      state.phase == SizeComparisonPhase.feedbackNg;

                    // アイコンのサイズを相対比率で調整
                    final sizeRatio = icon.size / problem.icons.map((i) => i.size).reduce((a, b) => a > b ? a : b);
                    final displaySize = finalSize * sizeRatio;

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: spacing / 2),
                      child: _buildIconButton(
                        context,
                        icon: icon,
                        isSelected: isSelected,
                        isCorrect: isCorrect,
                        showResult: showResult,
                        onTap: state.canAnswer ? () => logic.answerQuestion(index) : null,
                        displaySize: displaySize,
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ),
        
        // 正解エフェクト
        if (state.phase == SizeComparisonPhase.feedbackOk)
          SuccessEffect(
            onComplete: () {
              // エフェクト完了後の処理はロジック側で管理
            },
            hadWrongAnswer: state.session?.wrongAnswers != null && state.session!.wrongAnswers > 0,
          ),
      ],
    );
  }

  Widget _buildIconButton(
    BuildContext context, {
    required SizedIcon icon,
    required bool isSelected,
    required bool isCorrect,
    required bool showResult,
    required VoidCallback? onTap,
    required double displaySize,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: displaySize,
        height: displaySize,
        child: Stack(
          children: [
            // 画像を中央に配置（枠なし、アルファ抜き）
            Center(
              child: Image.asset(
                icon.iconInfo.assetPath,
                width: displaySize * 0.9, // 少し小さくして余白を確保
                height: displaySize * 0.9,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // 画像が見つからない場合はテキストで表示
                  return Text(
                    icon.iconInfo.slug,
                    style: TextStyle(
                      fontSize: displaySize * 0.15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),

            // 選択時のオーバーレイ
            if (isSelected)
              Container(
                width: displaySize,
                height: displaySize,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(displaySize / 2),
                  border: Border.all(
                    color: Colors.blue,
                    width: 3,
                  ),
                ),
              ),

            // 結果表示時のオーバーレイ
            if (showResult && isCorrect && !isSelected)
              Container(
                width: displaySize,
                height: displaySize,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(displaySize / 2),
                  border: Border.all(
                    color: Colors.green,
                    width: 3,
                  ),
                ),
              ),

            // 間違った選択のオーバーレイ
            if (showResult && !isCorrect && isSelected)
              Container(
                width: displaySize,
                height: displaySize,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(displaySize / 2),
                  border: Border.all(
                    color: Colors.red,
                    width: 3,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void startGameWith(SizeComparisonSettings settings) {
    readLogic(ref).startGame(settings);
  }
}