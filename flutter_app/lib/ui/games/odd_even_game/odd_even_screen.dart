import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../base/base_game_screen.dart';
import '../../components/success_effect.dart';
import 'models/odd_even_models.dart';
import '../base/common_game_phase.dart';
import '../base/common_game_widgets.dart';
import 'modern_odd_even_logic.dart';

class OddEvenScreen extends BaseGameScreen<OddEvenSettings, OddEvenState, ModernOddEvenLogic> {
  final bool skipResultScreen;
  
  const OddEvenScreen({
    super.key,
    super.initialSettings,
    this.skipResultScreen = false,
  }) : super(
    enableHomeButton: false,
  );

  @override
  OddEvenScreenState createState() => OddEvenScreenState();
}

class OddEvenScreenState extends BaseGameScreenState<
    OddEvenScreen, OddEvenSettings, OddEvenState, ModernOddEvenLogic> {
  
  @override
  String get gameTitle => 'きすう・ぐうすう';

  @override
  OddEvenState watchState(WidgetRef ref) => ref.watch(modernOddEvenLogicProvider);

  @override
  ModernOddEvenLogic readLogic(WidgetRef ref) => ref.read(modernOddEvenLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(OddEvenState s) {
    switch (s.phase) {
      case CommonGamePhase.ready:
        return GameUiPhase.playing; // 設定は OddEvenSettingsScreen で完了済み
      case CommonGamePhase.completed:
        return widget.skipResultScreen ? GameUiPhase.playing : GameUiPhase.result;
      default:
        return GameUiPhase.playing;
    }
  }

  @override
  OddEvenSettings? settingsOf(OddEvenState s) => s.settings;

  @override
  int? scoreOf(OddEvenState s) {
    if (s.session == null) return null;
    return s.session!.correctCount;
  }

  @override
  int totalQuestionsOf(OddEvenSettings s) => s.questionCount;

  @override
  String getSettingsDisplayName(OddEvenSettings settings) => settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFFF0F8FF), // 水色のグラデーション（上）
      Color(0xFFE6F3FF), // 水色のグラデーション（下）
    ];
  }

  @override
  String? getQuestionText(OddEvenState state) {
    return state.session?.currentProblem?.questionText;
  }

  @override
  String? getProgressText(OddEvenState state) {
    return state.session != null && state.session!.total > 0
        ? '${state.session!.index + 1}/${state.session!.total}'
        : null;
  }

  @override
  Widget buildSettingsView(BuildContext context, void Function(OddEvenSettings) onStart) {
    final screenSize = MediaQuery.of(context).size;
    final buttonSize = screenSize.shortestSide * 0.08;
    final fontSize = screenSize.shortestSide * 0.04;
    final largeFontSize = screenSize.shortestSide * 0.06;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'きすう・ぐうすう',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: largeFontSize * 1.5,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSettingSection(
                      context,
                      'さがすもの',
                      [
                        _SettingOption('きすう', OddEvenType.odd),
                        _SettingOption('ぐうすう', OddEvenType.even),
                        _SettingOption('ランダム', null),
                      ],
                      (option) {
                        // Settings update logic would go here
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    _buildSettingSection(
                      context,
                      'すうじのはんい',
                      [
                        _SettingOption('0-9', OddEvenRange.range0to9),
                        _SettingOption('10-19', OddEvenRange.range10to19),
                        _SettingOption('20-29', OddEvenRange.range20to29),
                      ],
                      (range) {
                        // Settings update logic would go here
                      },
                    ),
                    
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final settings = const OddEvenSettings();
                  onStart(settings);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(buttonSize * 3, buttonSize),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'スタート',
                  style: TextStyle(
                    fontSize: fontSize * 1.2,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingSection(
    BuildContext context,
    String title,
    List<_SettingOption> options,
    Function(dynamic) onSelected,
  ) {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.shortestSide * 0.04;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize * 1.2,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((option) {
            return InkWell(
              onTap: () => onSelected(option.value),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: Text(
                  option.label,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.black87,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget buildPlayingView(BuildContext context, OddEvenState state, ModernOddEvenLogic logic) {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.shortestSide * 0.04;
    
    if (state.session?.currentProblem == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    final problem = state.session!.currentProblem!;
    final settings = state.settings!;
    final gridSize = settings.gridSize;
    
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
        ),
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return _buildRandomNumberLayout(
                              constraints, 
                              problem, 
                              state, 
                              logic
                            );
                          },
                        ),
                      ),
                  
                  const SizedBox(height: 30),
                  
                  _buildActionButtons(context, state, logic),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    
    // 正解エフェクト（統一された表示）
    if (state.phase == CommonGamePhase.feedbackOk)
      SuccessEffect(
        onComplete: () {
          // エフェクト完了後の処理はロジック側で管理
        },
        hadWrongAnswer: state.session?.wrongAttempts != null && state.session!.wrongAttempts > 0,
      ),
    ],
    );
  }

  // 10種類の配置パターン（各パターンに10個の位置）
  static const List<List<Offset>> _layoutPatterns = [
    // パターン1: 散らばり配置
    [
      Offset(0.15, 0.2), Offset(0.7, 0.15), Offset(0.35, 0.35),
      Offset(0.85, 0.4), Offset(0.1, 0.55), Offset(0.6, 0.6),
      Offset(0.25, 0.75), Offset(0.8, 0.75), Offset(0.45, 0.25),
      Offset(0.5, 0.5), // 10個目追加
    ],
    // パターン2: 円形配置
    [
      Offset(0.5, 0.15), Offset(0.75, 0.25), Offset(0.9, 0.45),
      Offset(0.85, 0.65), Offset(0.7, 0.8), Offset(0.5, 0.85), 
      Offset(0.3, 0.8), Offset(0.15, 0.65), Offset(0.1, 0.45),
      Offset(0.25, 0.25), // 10個目追加
    ],
    // パターン3: 波形配置
    [
      Offset(0.1, 0.3), Offset(0.3, 0.2), Offset(0.5, 0.35),
      Offset(0.7, 0.25), Offset(0.9, 0.4), Offset(0.8, 0.6),
      Offset(0.6, 0.75), Offset(0.4, 0.65), Offset(0.2, 0.8),
      Offset(0.05, 0.5), // 10個目追加
    ],
    // パターン4: L字配置
    [
      Offset(0.15, 0.15), Offset(0.15, 0.3), Offset(0.15, 0.45),
      Offset(0.15, 0.6), Offset(0.15, 0.75), Offset(0.3, 0.75), 
      Offset(0.45, 0.75), Offset(0.6, 0.75), Offset(0.75, 0.75),
      Offset(0.6, 0.4), // 10個目追加
    ],
    // パターン5: X字配置
    [
      Offset(0.2, 0.2), Offset(0.35, 0.35), Offset(0.5, 0.5),
      Offset(0.65, 0.65), Offset(0.8, 0.8), Offset(0.8, 0.2),
      Offset(0.65, 0.35), Offset(0.35, 0.65), Offset(0.2, 0.8),
      Offset(0.5, 0.2), // 10個目追加
    ],
    // パターン6: 花形配置
    [
      Offset(0.5, 0.5), Offset(0.5, 0.15), Offset(0.7, 0.25),
      Offset(0.85, 0.5), Offset(0.7, 0.75), Offset(0.5, 0.85),
      Offset(0.3, 0.75), Offset(0.15, 0.5), Offset(0.3, 0.25),
      Offset(0.5, 0.35), // 10個目追加
    ],
    // パターン7: ジグザグ配置
    [
      Offset(0.1, 0.2), Offset(0.4, 0.15), Offset(0.7, 0.25),
      Offset(0.9, 0.35), Offset(0.8, 0.55), Offset(0.5, 0.6),
      Offset(0.2, 0.65), Offset(0.05, 0.75), Offset(0.35, 0.8),
      Offset(0.65, 0.45), // 10個目追加
    ],
    // パターン8: ダイヤモンド配置
    [
      Offset(0.5, 0.1), Offset(0.3, 0.25), Offset(0.7, 0.25),
      Offset(0.15, 0.45), Offset(0.85, 0.45), Offset(0.1, 0.65),
      Offset(0.9, 0.65), Offset(0.3, 0.8), Offset(0.7, 0.8),
      Offset(0.5, 0.9), // 10個目追加
    ],
    // パターン9: らせん配置
    [
      Offset(0.5, 0.5), Offset(0.6, 0.45), Offset(0.65, 0.35),
      Offset(0.6, 0.25), Offset(0.5, 0.2), Offset(0.4, 0.25),
      Offset(0.35, 0.35), Offset(0.4, 0.45), Offset(0.45, 0.55),
      Offset(0.55, 0.55), // 10個目追加
    ],
    // パターン10: ランダム散布
    [
      Offset(0.2, 0.25), Offset(0.8, 0.2), Offset(0.4, 0.4),
      Offset(0.9, 0.6), Offset(0.15, 0.65), Offset(0.6, 0.35),
      Offset(0.3, 0.8), Offset(0.75, 0.85), Offset(0.55, 0.7),
      Offset(0.05, 0.4), // 10個目追加
    ],
  ];

  // 数字の色を決める関数
  Color _getNumberColor(int index) {
    final colors = [
      const Color(0xFFFF8C42), // オレンジ
      const Color(0xFF7CB342), // 黄緑
      const Color(0xFF42A5F5), // 青
      const Color(0xFFEC407A), // ピンク
      const Color(0xFFAB47BC), // 紫
    ];
    return colors[index % colors.length];
  }

  Widget _buildRandomNumberLayout(
    BoxConstraints constraints,
    OddEvenProblem problem,
    OddEvenState state,
    ModernOddEvenLogic logic,
  ) {
    final numbers = problem.numbers;
    final screenWidth = constraints.maxWidth;
    final screenHeight = constraints.maxHeight;
    final numberSize = math.min(screenWidth, screenHeight) * 0.3;

    // 問題番号と数字の組み合わせだけでシードを作成（時刻を除外）
    // これにより同じ問題では常に同じ配置になる
    final seed = (state.session?.index ?? 0) * 12345 + 
                 numbers.fold(0, (sum, num) => sum + num * 7); // 固定係数を使用
    final random = math.Random(seed.toInt());
    
    // 重複しない位置を生成
    final positions = <Offset>[];
    final minDistance = 0.15; // 最小距離
    
    for (int i = 0; i < numbers.length; i++) {
      bool validPosition = false;
      int attempts = 0;
      double dx = 0, dy = 0;
      
      while (!validPosition && attempts < 100) {
        dx = 0.1 + random.nextDouble() * 0.8;
        dy = 0.1 + random.nextDouble() * 0.8;
        
        // 他の位置との距離をチェック
        validPosition = true;
        for (final existingPos in positions) {
          final distance = math.sqrt(
            math.pow(dx - existingPos.dx, 2) + 
            math.pow(dy - existingPos.dy, 2)
          );
          if (distance < minDistance) {
            validPosition = false;
            break;
          }
        }
        attempts++;
      }
      
      positions.add(Offset(dx, dy));
    }
    
    return Stack(
      children: List.generate(numbers.length, (index) {
        final number = numbers[index];
        final position = positions[index];
        final isSelected = state.session!.selectedIndices.contains(index);
        final showResult = state.phase == CommonGamePhase.feedbackOk;
        final isCorrect = problem.correctIndices.contains(index);

        return Positioned(
          left: position.dx * screenWidth - numberSize / 2,
          top: position.dy * screenHeight - numberSize / 2,
          child: _RandomNumberCard(
            number: number,
            size: numberSize,
            color: _getNumberColor(index),
            isSelected: isSelected,
            isCorrect: isCorrect,
            showResult: showResult,
            onTap: state.canAnswer ? () => logic.toggleNumber(index) : null,
          ),
        );
      }),
    );
  }

  Widget _buildActionButtons(BuildContext context, OddEvenState state, ModernOddEvenLogic logic) {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.shortestSide * 0.04;
    final buttonSize = screenSize.shortestSide * 0.08;
    
    // こたえあわせボタンのみ表示、やりなおしボタンは削除
    // フィードバック中でも常にボタンを表示してレイアウトを保持
    return Center(
      child: ElevatedButton(
        onPressed: (state.phase == CommonGamePhase.feedbackOk || state.phase == CommonGamePhase.feedbackNg) 
          ? null 
          : logic.checkAnswer,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          disabledBackgroundColor: Colors.orange.withOpacity(0.5),
          minimumSize: Size(buttonSize * 2.5, buttonSize),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'こたえあわせ',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildResultView(BuildContext context, WidgetRef ref) {
    final state = watchState(ref);
    final logic = readLogic(ref);
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.shortestSide * 0.04;
    final buttonSize = screenSize.shortestSide * 0.08;
    
    final session = state.session!;
    final isPerfect = session.correctCount == session.total && session.wrongAnswers == 0;
    
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPerfect ? Icons.star : Icons.check_circle,
              size: screenSize.shortestSide * 0.3,
              color: isPerfect ? Colors.amber : Colors.green,
            ),
            const SizedBox(height: 30),
            
            Text(
              isPerfect ? 'かんぺき！' : 'クリア！',
              style: TextStyle(
                fontSize: fontSize * 2,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            
            if (session.totalTime != null) ...[
              const SizedBox(height: 20),
              Text(
                'じかん: ${session.totalTime!.inSeconds}びょう',
                style: TextStyle(
                  fontSize: fontSize * 1.2,
                  color: Colors.black87,
                ),
              ),
            ],
            
            if (session.wrongAnswers > 0) ...[
              const SizedBox(height: 10),
              Text(
                'まちがい: ${session.wrongAnswers}かい',
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.orange,
                ),
              ),
            ],
            
            const SizedBox(height: 40),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: logic.goToSettings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    minimumSize: Size(buttonSize * 2, buttonSize),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'せってい',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: logic.restart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(buttonSize * 2, buttonSize),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'もういちど',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void startGameWith(OddEvenSettings settings) {
    readLogic(ref).startGame(settings);
  }
}

class _SettingOption {
  final String label;
  final dynamic value;
  
  _SettingOption(this.label, this.value);
}

class _NumberCard extends StatefulWidget {
  final int number;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;
  final VoidCallback? onTap;
  
  const _NumberCard({
    Key? key,
    required this.number,
    required this.isSelected,
    required this.isCorrect,
    required this.showResult,
    this.onTap,
  }) : super(key: key);
  
  @override
  State<_NumberCard> createState() => _NumberCardState();
}

class _NumberCardState extends State<_NumberCard> {
  DateTime? _lastTapTime;
  
  void _handleTap() {
    if (widget.onTap == null) return;
    
    final now = DateTime.now();
    if (_lastTapTime != null &&
        now.difference(_lastTapTime!).inMilliseconds < 500) {
      // ダブルクリック: 選択されている場合は解除
      if (widget.isSelected) {
        widget.onTap!();
      }
    } else {
      // シングルクリック: 通常の選択/選択解除
      widget.onTap!();
    }
    _lastTapTime = now;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final fontSize = screenSize.shortestSide * 0.04;
    
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    
    if (widget.showResult) {
      if (widget.isCorrect) {
        backgroundColor = widget.isSelected ? Colors.green.shade100 : Colors.green.shade50;
        borderColor = Colors.green;
        textColor = Colors.green.shade900;
      } else if (widget.isSelected) {
        backgroundColor = Colors.red.shade100;
        borderColor = Colors.red;
        textColor = Colors.red.shade900;
      } else {
        backgroundColor = Colors.white;
        borderColor = Colors.grey.shade300;
        textColor = Colors.black87;
      }
    } else {
      backgroundColor = widget.isSelected ? Colors.blue.withOpacity(0.1) : Colors.white;
      borderColor = widget.isSelected ? Colors.blue : Colors.grey.shade300;
      textColor = widget.isSelected ? Colors.blue : Colors.black87;
    }
    
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: _handleTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor,
              width: widget.isSelected || (widget.showResult && widget.isCorrect) ? 3 : 2,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  widget.number.toString(),
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              if (widget.isSelected && !widget.showResult)
                const Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                    size: 24,
                  ),
                ),
              if (widget.showResult && widget.isCorrect && !widget.isSelected)
                const Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.circle_outlined,
                    color: Colors.green,
                    size: 24,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ランダム配置用の新しい数字カード
class _RandomNumberCard extends StatefulWidget {
  final int number;
  final double size;
  final Color color;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;
  final VoidCallback? onTap;
  
  const _RandomNumberCard({
    Key? key,
    required this.number,
    required this.size,
    required this.color,
    required this.isSelected,
    required this.isCorrect,
    required this.showResult,
    this.onTap,
  }) : super(key: key);
  
  @override
  State<_RandomNumberCard> createState() => _RandomNumberCardState();
}

class _RandomNumberCardState extends State<_RandomNumberCard> {
  DateTime? _lastTapTime;
  
  void _handleTap() {
    if (widget.onTap == null) return;
    
    final now = DateTime.now();
    if (_lastTapTime != null &&
        now.difference(_lastTapTime!).inMilliseconds < 500) {
      // ダブルクリック: 選択されている場合は解除
      if (widget.isSelected) {
        widget.onTap!();
      }
    } else {
      // シングルクリック: 通常の選択/選択解除
      widget.onTap!();
    }
    _lastTapTime = now;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: widget.size,
        height: widget.size,
        child: Stack(
          children: [
            // 数字文字のみ表示（最初は無背景）
            Center(
              child: Text(
                widget.number.toString(),
                style: TextStyle(
                  fontSize: widget.size * 0.6, // 数字をもっと大きく
                  fontWeight: FontWeight.bold,
                  color: widget.color,
                ),
              ),
            ),
            
            // 選択時の赤い丸いオーバーレイ
            if (widget.isSelected)
              Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.withOpacity(0.3),
                  border: Border.all(
                    color: Colors.red,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.number.toString(),
                    style: TextStyle(
                      fontSize: widget.size * 0.6,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              
            // 正解表示用のハイライト
            if (widget.showResult && widget.isCorrect && !widget.isSelected)
              Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.withOpacity(0.2),
                  border: Border.all(
                    color: Colors.green,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.number.toString(),
                    style: TextStyle(
                      fontSize: widget.size * 0.6,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}