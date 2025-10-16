import 'package:flutter/material.dart';
import 'number_recognition_game_screen.dart';
import 'number_recognition_game_models.dart';

/// 数字認識ゲームの設定画面
class NumberRecognitionGameConfigScreen extends StatefulWidget {
  const NumberRecognitionGameConfigScreen({super.key});

  @override
  State<NumberRecognitionGameConfigScreen> createState() => _NumberRecognitionGameConfigScreenState();
}

class _NumberRecognitionGameConfigScreenState extends State<NumberRecognitionGameConfigScreen> {
  int _problemCount = 3;
  ProblemType _problemType = ProblemType.smaller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('すうじをかこう'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 80,
                          color: Colors.blue[400],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'すうじをかこう！',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E3A59),
                          ),
                        ),
                        const SizedBox(height: 40),
                        
                        // 問題タイプ選択
                        const Text(
                          'もんだいのしゅるい',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E3A59),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _ProblemTypeCard(
                                type: ProblemType.smaller,
                                title: 'ちいさいかず',
                                description: '3ちいさいかず',
                                icon: Icons.remove,
                                isSelected: _problemType == ProblemType.smaller,
                                onTap: () => setState(() => _problemType = ProblemType.smaller),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _ProblemTypeCard(
                                type: ProblemType.larger,
                                title: 'おおきいかず',
                                description: '3おおきいかず',
                                icon: Icons.add,
                                isSelected: _problemType == ProblemType.larger,
                                onTap: () => setState(() => _problemType = ProblemType.larger),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        
                        // 問題数選択
                        const Text(
                          'もんだいのかず',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E3A59),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(5, (index) {
                            final count = index + 1;
                            return _CountCard(
                              count: count,
                              isSelected: _problemCount == count,
                              onTap: () => setState(() => _problemCount = count),
                            );
                          }),
                        ),
                        const SizedBox(height: 40),
                        
                        // 開始ボタン
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => NumberRecognitionGameScreen(
                                  problemCount: _problemCount,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 問題タイプ選択カード
class _ProblemTypeCard extends StatelessWidget {
  final ProblemType type;
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ProblemTypeCard({
    required this.type,
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[100] : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected ? Colors.blue[800] : Colors.grey[600],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue[800] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.blue[600] : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 問題数選択カード
class _CountCard extends StatelessWidget {
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const _CountCard({
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[400]!,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }
}