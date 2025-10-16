import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/responsive_theme.dart';
import '../../components/game_header.dart';
import 'models/comparison_models.dart';
import 'modern_comparison_logic.dart';
import 'comparison_game_screen.dart';

class ComparisonGameSettingsScreen extends ConsumerStatefulWidget {
  const ComparisonGameSettingsScreen({super.key});

  @override
  ConsumerState<ComparisonGameSettingsScreen> createState() => _ComparisonGameSettingsScreenState();
}

class _ComparisonGameSettingsScreenState extends ConsumerState<ComparisonGameSettingsScreen> {
  int currentStep = 1;
  ComparisonDisplayType? selectedDisplayType;
  ComparisonRange? selectedRange;
  int? selectedOptionCount;
  ComparisonQuestionType? selectedQuestionType;

  @override
  void initState() {
    super.initState();
    _resetAllSettings();
    // ゲームもリセットして前の設定が残らないようにする
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(modernComparisonLogicProvider.notifier).resetGame();
      }
    });
  }

  void _resetAllSettings() {
    currentStep = 1;
    selectedDisplayType = null;
    selectedRange = null;
    selectedOptionCount = null;
    selectedQuestionType = null;
  }

  void _selectDisplayType(ComparisonDisplayType type) {
    setState(() {
      selectedDisplayType = type;
      currentStep = 2; // 範囲選択へ
    });
  }

  void _selectRange(ComparisonRange range) {
    setState(() {
      selectedRange = range;
      currentStep = 3; // 選択肢数選択へ
    });
  }
  
  void _selectOptionCount(int count) {
    setState(() {
      selectedOptionCount = count;
      currentStep = 4; // 問題タイプ選択へ
    });
  }


  void _selectQuestionType(ComparisonQuestionType? type) {
    setState(() {
      selectedQuestionType = type;
    });
    _startGame();
  }

  void _startGame() {
    if (selectedRange != null && selectedDisplayType != null && selectedOptionCount != null) {
      final settings = ComparisonGameSettings(
        displayType: selectedDisplayType!,
        range: selectedRange!,
        optionCount: selectedOptionCount!,
        questionType: selectedQuestionType,
        questionCount: 5,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ComparisonGameScreen(initialSettings: settings),
        ),
      );
    }
  }

  void _goBack() {
    if (currentStep > 1) {
      setState(() {
        currentStep--;
        // ステップに応じて選択をリセット
        switch (currentStep) {
          case 1:
            selectedRange = null;
            selectedOptionCount = null;
            selectedQuestionType = null;
            break;
          case 2:
            selectedOptionCount = null;
            selectedQuestionType = null;
            break;
          case 3:
            selectedQuestionType = null;
            break;
        }
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Container(
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
            child: Column(
              children: [
                GameHeader(
                  title: 'おおきい・ちいさい',
                  subtitle: 'せってい',
                  onBack: _goBack,
                ),
                  
                // Main content
                Expanded(
                  child: _buildCurrentStep(),
                ),
              ],
            ),
          ),
        ),
        // Debug overlay
        Positioned(
          top: 40,
          right: 20,
          child: IgnorePointer(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'デバッグ情報',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ステップ: $currentStep',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  Text(
                    'ゲーム: おおきい・ちいさい',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  Text(
                    '表示タイプ: ${_getDisplayTypeJapanese(selectedDisplayType)}',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  Text(
                    '範囲: ${_getRangeJapanese(selectedRange)}',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  Text(
                    '選択肢数: ${selectedOptionCount ?? "未設定"}',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  Text(
                    '問題種類: ${_getQuestionTypeJapanese(selectedQuestionType)}',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String label,
    required String sublabel,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 50, color: color),
            ),
            const SizedBox(height: 15),
            Text(
              label,
              style: TextStyle(
                fontSize: context.fontSizes.gameContent,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              sublabel,
              style: TextStyle(
                fontSize: context.fontSizes.settingsLabel,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDisplayTypeJapanese(ComparisonDisplayType? type) {
    if (type == null) return "未設定";
    switch (type) {
      case ComparisonDisplayType.dots:
        return "ドット";
      case ComparisonDisplayType.digits:
        return "数字";
    }
  }

  String _getRangeJapanese(ComparisonRange? range) {
    if (range == null) return "未設定";
    return range.displayName;
  }

  String _getQuestionTypeJapanese(ComparisonQuestionType? type) {
    if (type == null) return "未設定";
    switch (type) {
      case ComparisonQuestionType.fixedLargest:
        return "おおきい";
      case ComparisonQuestionType.fixedSmallest:
        return "ちいさい";
      case ComparisonQuestionType.advanced:
        return "上級（ランダム）";
      default:
        return "未設定";
    }
  }


  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 1:
        return _buildDisplayTypeSelection();
      case 2:
        return _buildRangeSelection();
      case 3:
        return _buildOptionCountSelection();
      case 4:
        return _buildQuestionTypeSelection();
      default:
        return _buildDisplayTypeSelection();
    }
  }

  Widget _buildDisplayTypeSelection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'どんなひょうじがいい？',
          style: TextStyle(
            fontSize: context.fontSizes.gameTitle,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildOptionCard(
              icon: Icons.circle,
              label: 'ドット',
              sublabel: '●●●',
              color: Colors.orange,
              onTap: () => _selectDisplayType(ComparisonDisplayType.dots),
            ),
            _buildOptionCard(
              icon: Icons.looks_one,
              label: 'すうじ',
              sublabel: '123',
              color: Colors.green,
              onTap: () => _selectDisplayType(ComparisonDisplayType.digits),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRangeSelection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'どのはんいでやる？',
          style: TextStyle(
            fontSize: context.fontSizes.gameTitle,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: [
            _buildRangeCard('1-5', ComparisonRange.range1to5, Colors.lightBlue),
            _buildRangeCard('5-10', ComparisonRange.range5to10, Colors.blue),
            _buildRangeCard('10-20', ComparisonRange.range10to20, Colors.indigo),
            _buildRangeCard('20-30', ComparisonRange.range20to30, Colors.deepPurple),
            _buildRangeCard('30-40', ComparisonRange.range30to40, Colors.purple),
            _buildRangeCard('40-50', ComparisonRange.range40to50, Colors.red),
            _buildRangeCard('50-60', ComparisonRange.range50to60, Colors.orange),
            _buildRangeCard('60-70', ComparisonRange.range60to70, Colors.amber),
            _buildRangeCard('70-80', ComparisonRange.range70to80, Colors.green),
            _buildRangeCard('80-90', ComparisonRange.range80to90, Colors.teal),
            _buildRangeCard('90-100', ComparisonRange.range90to100, Colors.cyan),
            // 新しい範囲を追加
            _buildRangeCard('1-20', ComparisonRange.range1to20, Colors.pink),
            _buildRangeCard('20-50', ComparisonRange.range20to50, Colors.brown),
            _buildRangeCard('50-100', ComparisonRange.range50to100, Colors.grey),
            _buildRangeCard('100-120', ComparisonRange.range100to120, Colors.blueGrey),
            _buildRangeCard('1-50', ComparisonRange.range1to50, Colors.lime),
            _buildRangeCard('1-120', ComparisonRange.range1to120, Colors.deepOrange),
          ],
        ),
      ],
    );
  }

  Widget _buildOptionCountSelection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'せんたくしの かずは？',
          style: TextStyle(
            fontSize: context.fontSizes.gameTitle,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildOptionCountCard(2, '2', Colors.green),
            _buildOptionCountCard(3, '3', Colors.orange),
            _buildOptionCountCard(4, '4', Colors.red),
          ],
        ),
      ],
    );
  }


  Widget _buildQuestionTypeSelection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'どんなもんだい？',
          style: TextStyle(
            fontSize: context.fontSizes.gameTitle,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildQuestionTypeCard('おおきい', ComparisonQuestionType.fixedLargest, Colors.red),
            _buildQuestionTypeCard('ちいさい', ComparisonQuestionType.fixedSmallest, Colors.blue),
            _buildQuestionTypeCard('ランダム', ComparisonQuestionType.advanced, Colors.purple),
          ],
        ),
      ],
    );
  }


  Widget _buildRangeCard(String label, ComparisonRange range, Color color) {
    return GestureDetector(
      onTap: () => _selectRange(range),
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14, // 固定サイズに変更
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCountCard(int count, String label, Color color) {
    return GestureDetector(
      onTap: () => _selectOptionCount(count),
      child: Container(
        width: 160,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: context.fontSizes.settingsTitle,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildQuestionTypeCard(String label, ComparisonQuestionType? type, Color color) {
    return GestureDetector(
      onTap: () => _selectQuestionType(type),
      child: Container(
        width: 160,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: context.fontSizes.settingsTitle,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}