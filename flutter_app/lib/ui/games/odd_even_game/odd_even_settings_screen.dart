import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/debug_logger.dart';
import '../../../core/responsive_theme.dart';
import '../../components/game_header.dart';
import 'models/odd_even_models.dart';
import 'modern_odd_even_logic.dart';
import 'odd_even_screen.dart';

class OddEvenSettingsScreen extends ConsumerStatefulWidget {
  const OddEvenSettingsScreen({super.key});

  @override
  ConsumerState<OddEvenSettingsScreen> createState() => _OddEvenSettingsScreenState();
}

class _OddEvenSettingsScreenState extends ConsumerState<OddEvenSettingsScreen> {
  int currentStep = 1;
  OddEvenType? selectedTargetType;
  OddEvenRange? selectedRange;
  bool? selectedRandomTargetType;

  @override
  void initState() {
    super.initState();
    _resetAllSettings();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Reset game state - create new initial state
        ref.read(modernOddEvenLogicProvider.notifier);
      }
    });
    Log.d('🔄 OddEvenSettingsScreen: All settings reset on init');
  }

  void _resetAllSettings() {
    currentStep = 1;
    selectedTargetType = null;
    selectedRange = null;
    selectedRandomTargetType = null;
  }

  void _selectTargetType(OddEvenType? type, bool isRandom) {
    setState(() {
      selectedTargetType = type;
      selectedRandomTargetType = isRandom;
      currentStep = 2; // 範囲選択へ
    });
    Log.d('🎯 Selected target type: ${isRandom ? "random" : type?.name}');
  }

  void _selectRange(OddEvenRange range) {
    setState(() {
      selectedRange = range;
    });
    Log.d('📊 Selected range: ${range.name}');
    _startGame();
  }

  void _startGame() {
    if (selectedRange != null && selectedRandomTargetType != null) {
      final settings = OddEvenSettings(
        targetType: selectedTargetType ?? OddEvenType.odd,
        range: selectedRange!,
        gridSize: OddEvenGridSize.grid10, // 固定で10個
        randomTargetType: selectedRandomTargetType!,
      );
      
      Log.d('🚀 Starting odd even game with settings: ${settings.displayName}');
      
      // ゲームを実際に開始
      ref.read(modernOddEvenLogicProvider.notifier).startGame(settings);
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OddEvenScreen(initialSettings: settings),
        ),
      );
    }
  }

  void _goBack() {
    Log.d('🔙 OddEvenSettings: _goBack called, currentStep: $currentStep');
    
    if (currentStep > 1) {
      setState(() {
        currentStep--;
        if (currentStep == 1) {
          selectedTargetType = null;
          selectedRandomTargetType = null;
        }
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveTheme(context);
    
    return Scaffold(
      body: Stack(
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
                GameHeader(
                  title: 'きすう・ぐうすう',
                  subtitle: _getStepTitle(),
                  onBack: _goBack,
                  progressText: '$currentStep/2',
                ),
                Expanded(
                  child: _buildCurrentStep(responsive),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (currentStep) {
      case 1:
        return 'さがすすうじを えらんでね';
      case 2:
        return 'すうじのはんいを えらんでね';
      default:
        return '';
    }
  }

  Widget _buildCurrentStep(ResponsiveTheme responsive) {
    switch (currentStep) {
      case 1:
        return _buildTargetTypeSelection(responsive);
      case 2:
        return _buildRangeSelection(responsive);
      default:
        return Container();
    }
  }

  Widget _buildTargetTypeSelection(ResponsiveTheme responsive) {
    return Padding(
      padding: responsive.spacing.screenPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'さがすすうじを えらんでね',
            style: TextStyle(
              fontSize: responsive.fontSizes.gameTitle,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTargetTypeButton(
                responsive,
                title: 'きすう',
                subtitle: '1,3,5...',
                color: Colors.orange,
                onTap: () => _selectTargetType(OddEvenType.odd, false),
              ),
              _buildTargetTypeButton(
                responsive,
                title: 'ぐうすう',
                subtitle: '0,2,4...',
                color: Colors.green,
                onTap: () => _selectTargetType(OddEvenType.even, false),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTargetTypeButton(
    ResponsiveTheme responsive, {
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: responsive.fontSizes.settingsTitle,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
              if (subtitle.isNotEmpty) ...[
                SizedBox(height: responsive.spacing.smallSpacing / 2),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: responsive.fontSizes.settingsLabel * 0.8,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRangeSelection(ResponsiveTheme responsive) {
    return Padding(
      padding: responsive.spacing.screenPadding,
      child: Center(
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: [
            _buildCompactRangeButton(responsive, '0-9', OddEvenRange.range0to9, Colors.lightBlue),
            _buildCompactRangeButton(responsive, '10-19', OddEvenRange.range10to19, Colors.blue),
            _buildCompactRangeButton(responsive, '20-29', OddEvenRange.range20to29, Colors.indigo),
            _buildCompactRangeButton(responsive, '30-39', OddEvenRange.range30to39, Colors.deepPurple),
            _buildCompactRangeButton(responsive, '40-49', OddEvenRange.range40to49, Colors.purple),
            _buildCompactRangeButton(responsive, '50-59', OddEvenRange.range50to59, Colors.red),
            _buildCompactRangeButton(responsive, '60-69', OddEvenRange.range60to69, Colors.orange),
            _buildCompactRangeButton(responsive, '70-79', OddEvenRange.range70to79, Colors.amber),
            _buildCompactRangeButton(responsive, '80-89', OddEvenRange.range80to89, Colors.green),
            _buildCompactRangeButton(responsive, '90-99', OddEvenRange.range90to99, Colors.teal),
            _buildCompactRangeButton(responsive, '100-109', OddEvenRange.range100to109, Colors.cyan),
            _buildCompactRangeButton(responsive, '110-119', OddEvenRange.range110to119, Colors.pink),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactRangeButton(ResponsiveTheme responsive, String label, OddEvenRange range, Color color) {
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
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRangeButton(ResponsiveTheme responsive, OddEvenRange range) {
    return Container(
      height: responsive.spacing.buttonHeight,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: responsive.smallBorderRadius,
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
          onTap: () => _selectRange(range),
          borderRadius: responsive.smallBorderRadius,
          child: Center(
            child: Text(
              range.displayName,
              style: TextStyle(
                fontSize: responsive.fontSizes.gameContent * 1.1,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

}