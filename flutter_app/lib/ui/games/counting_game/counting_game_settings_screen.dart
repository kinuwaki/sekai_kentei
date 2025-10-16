import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/game_header.dart';
import 'models/counting_models.dart';
import 'modern_counting_logic.dart';
import 'counting_game_screen.dart';

class CountingGameSettingsScreen extends ConsumerStatefulWidget {
  const CountingGameSettingsScreen({super.key});

  @override
  ConsumerState<CountingGameSettingsScreen> createState() => _CountingGameSettingsScreenState();
}

class _CountingGameSettingsScreenState extends ConsumerState<CountingGameSettingsScreen> {
  CountingRange? selectedRange;

  @override
  void initState() {
    super.initState();
    selectedRange = null;
    // プロバイダーを即座にリセット
    // addPostFrameCallbackを使わずに即座に実行
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(modernCountingLogicProvider);
    });
  }

  void _selectRange(CountingRange range) {
    setState(() {
      selectedRange = range;
    });
    _startGame();
  }

  void _startGame() {
    if (selectedRange != null) {
      final settings = CountingGameSettings(
        range: selectedRange!,
        questionCount: 5,
      );
      
      
      // ゲームを開始する前にプロバイダーをリセット
      ref.invalidate(modernCountingLogicProvider);
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => CountingGameScreen(initialSettings: settings),
        ),
      );
    }
  }

  void _goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              title: 'かずかぞえ',
              subtitle: 'せってい',
              onBack: _goBack,
            ),

            // Main content
            Expanded(
              child: _buildRangeSelection(),
            ),
          ],
        ),
      ),
    );
  }

  String _getRangeJapanese(CountingRange? range) {
    if (range == null) return "未設定";
    switch (range) {
      case CountingRange.range1to5:
        return "1-5";
      case CountingRange.range5to10:
        return "5-10";
      case CountingRange.range1to10:
        return "1-10";
    }
  }

  Widget _buildRangeSelection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'どのはんいでやる？',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildRangeCard('1-5', CountingRange.range1to5, Colors.lightBlue),
            _buildRangeCard('5-10', CountingRange.range5to10, Colors.blue),
            _buildRangeCard('1-10', CountingRange.range1to10, Colors.indigo),
          ],
        ),
      ],
    );
  }

  Widget _buildRangeCard(String label, CountingRange range, Color color) {
    return GestureDetector(
      onTap: () => _selectRange(range),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
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
            Text(
              label,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}