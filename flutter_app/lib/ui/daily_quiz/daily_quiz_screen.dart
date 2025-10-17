import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/sekai_kentei_json_loader.dart';
import '../../services/quiz_data_loader.dart';
import '../../services/audio_service.dart';
import '../../main.dart' show notificationService;

/// デイリー問題画面
/// 通知タップ時に特定の問題IDで起動され、その1問だけを出題
class DailyQuizScreen extends ConsumerStatefulWidget {
  const DailyQuizScreen({super.key});

  @override
  ConsumerState<DailyQuizScreen> createState() => _DailyQuizScreenState();
}

class _DailyQuizScreenState extends ConsumerState<DailyQuizScreen> {
  QuizQuestion? _question;
  List<String>? _options; // 4択の選択肢
  int? _correctIndex; // 正解のインデックス
  int? _selectedIndex; // ユーザーが選択した選択肢
  bool _isLoading = true;
  bool _hasAnswered = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadQuestion();
    });
  }

  Future<void> _loadQuestion() async {
    try {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final questionId = args?['questionId'] as String?;

      if (questionId == null) {
        setState(() {
          _error = '問題IDが見つかりません';
          _isLoading = false;
        });
        return;
      }

      // 問題データを読み込み
      final loader = SekaiKenteiJsonLoader();
      final allQuestions = await loader.loadQuestions();
      final question = allQuestions.firstWhere(
        (q) => q.id == questionId,
        orElse: () => throw Exception('問題が見つかりません: $questionId'),
      );

      // 4択の選択肢を生成
      final random = Random();
      final options = question.generateOptions(random: random);
      final correctIndex = question.getCorrectIndex(options);

      setState(() {
        _question = question;
        _options = options;
        _correctIndex = correctIndex;
        _isLoading = false;
      });

      // 次回の通知を予約（デイリー問題を開いたら翌朝分を予約）
      await notificationService.scheduleNextMorning();
    } catch (e) {
      setState(() {
        _error = 'エラー: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _handleAnswer(int index) async {
    if (_hasAnswered) return;

    setState(() {
      _selectedIndex = index;
      _hasAnswered = true;
    });

    final audioService = ref.read(audioServiceProvider);
    final isCorrect = index == _correctIndex;

    if (isCorrect) {
      await audioService.playCorrect();
    } else {
      await audioService.playIncorrect();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('本日の問題'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('本日の問題'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 80, color: Colors.red),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('戻る'),
              ),
            ],
          ),
        ),
      );
    }

    if (_question == null || _options == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('本日の問題')),
        body: const Center(child: Text('問題が見つかりません')),
      );
    }

    final isCorrect = _hasAnswered && _selectedIndex == _correctIndex;

    return Scaffold(
      appBar: AppBar(
        title: const Text('本日の問題'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ヘッダー部分
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.blue.shade50,
              child: Column(
                children: [
                  const Icon(Icons.wb_sunny, size: 48, color: Colors.orange),
                  const SizedBox(height: 8),
                  Text(
                    '今日の問題',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _question!.theme,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ),

            // 問題文
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 問題文
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        _question!.question,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          height: 1.6,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // 選択肢
                    ...List.generate(_options!.length, (index) {
                      final isSelected = _selectedIndex == index;
                      final isThisCorrect = index == _correctIndex;
                      final showResult = _hasAnswered;

                      Color? bgColor;
                      Color? borderColor;
                      if (showResult) {
                        if (isThisCorrect) {
                          bgColor = Colors.green.shade50;
                          borderColor = Colors.green;
                        } else if (isSelected && !isThisCorrect) {
                          bgColor = Colors.red.shade50;
                          borderColor = Colors.red;
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () => _handleAnswer(index),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: bgColor ?? Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: borderColor ?? Colors.grey.shade300,
                                width: showResult && (isThisCorrect || isSelected) ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: borderColor?.withOpacity(0.2) ?? Colors.blue.shade50,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      String.fromCharCode(65 + index), // A, B, C, D
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: borderColor ?? Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _options![index],
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                if (showResult && isThisCorrect)
                                  const Icon(Icons.check_circle, color: Colors.green),
                                if (showResult && isSelected && !isThisCorrect)
                                  const Icon(Icons.cancel, color: Colors.red),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    // 解説（回答後に表示）
                    if (_hasAnswered && _question!.explanation.isNotEmpty) ...[
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isCorrect ? Colors.green.shade50 : Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isCorrect ? Colors.green : Colors.orange,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  isCorrect ? Icons.check_circle : Icons.info,
                                  color: isCorrect ? Colors.green : Colors.orange,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '解説',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isCorrect ? Colors.green.shade900 : Colors.orange.shade900,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _question!.explanation,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // 画像（解説の後に表示）
                    if (_hasAnswered && _question!.imagePath != null && _question!.imagePath!.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          _question!.imagePath!,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image_not_supported, color: Colors.grey),
                                  SizedBox(width: 8),
                                  Text('画像を読み込めませんでした'),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],

                    if (_hasAnswered) ...[
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          '完了',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
