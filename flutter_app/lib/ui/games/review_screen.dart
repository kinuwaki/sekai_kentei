import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/wrong_answer_storage.dart';
import 'sekai_kentei_game/sekai_kentei_screen.dart';
import 'sekai_kentei_game/models/sekai_kentei_models.dart';
import '../theme/app_theme.dart';

/// 復習画面（間違えた問題のリスト）
class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({super.key});

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  int _wrongAnswerCount = 0;

  @override
  void initState() {
    super.initState();
    _loadWrongAnswerCount();
  }

  Future<void> _loadWrongAnswerCount() async {
    final count = await WrongAnswerStorage.getWrongAnswerCount();
    if (mounted) {
      setState(() {
        _wrongAnswerCount = count;
      });
    }
  }

  /// 復習を始める
  void _startReview() {
    if (_wrongAnswerCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('間違えた問題がまだありません'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SekaiKenteiScreen(
          themeKey: '復習',
          questionCount: _wrongAnswerCount,
          mode: QuizMode.review,
          initialSettings: SekaiKenteiSettings(theme: QuizTheme.basic),
        ),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    ).then((_) => _loadWrongAnswerCount()); // 復習から戻ったら再読み込み
  }

  /// 間違えた問題をリセット
  Future<void> _resetWrongAnswers() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('確認', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('間違えた問題をすべてリセットしますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('リセット'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await WrongAnswerStorage.clearWrongAnswers();
      _loadWrongAnswerCount();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('間違えた問題をリセットしました'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              padding: const EdgeInsets.all(AppSizes.paddingLarge),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '復習',
                    style: AppTextStyles.title,
                  ),
                  const SizedBox(height: AppSizes.paddingLarge),
                  Container(
                    padding: const EdgeInsets.all(AppSizes.paddingLarge),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          '間違えた問題が${_wrongAnswerCount}問あります',
                          style: AppTextStyles.bodyBold,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSizes.paddingExtraLarge),
                        SizedBox(
                          width: double.infinity,
                          height: AppSizes.buttonHeightMedium,
                          child: ElevatedButton(
                            onPressed: _wrongAnswerCount > 0 ? _startReview : null,
                            style: AppButtonStyles.primaryMedium.copyWith(
                              backgroundColor: WidgetStateProperty.resolveWith((states) {
                                if (states.contains(WidgetState.disabled)) {
                                  return AppButtonStyles.disabledBackgroundColor;
                                }
                                return AppColors.primary;
                              }),
                            ),
                            child: const Text(
                              '復習を始める',
                              style: AppTextStyles.buttonMedium,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.paddingMedium),
                        SizedBox(
                          width: double.infinity,
                          height: AppSizes.buttonHeightMedium,
                          child: ElevatedButton(
                            onPressed: _wrongAnswerCount > 0 ? _resetWrongAnswers : null,
                            style: AppButtonStyles.danger.copyWith(
                              backgroundColor: WidgetStateProperty.resolveWith((states) {
                                if (states.contains(WidgetState.disabled)) {
                                  return AppButtonStyles.disabledBackgroundColor;
                                }
                                return Colors.red.shade400;
                              }),
                            ),
                            child: const Text(
                              '間違えた問題をリセット',
                              style: AppTextStyles.buttonMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
