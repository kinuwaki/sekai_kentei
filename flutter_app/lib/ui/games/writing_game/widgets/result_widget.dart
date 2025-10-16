import 'package:flutter/material.dart';
import '../writing_game_models.dart';
import '../../../components/common_game_result.dart';

class ResultWidget extends StatelessWidget {
  final CharacterData character;
  final WritingMode mode;
  final RecognitionResult? recognitionResult;
  final Function() onRetry;
  final Function() onSelectNewCharacter;
  final Function() onSelectNewMode;

  const ResultWidget({
    super.key,
    required this.character,
    required this.mode,
    this.recognitionResult,
    required this.onRetry,
    required this.onSelectNewCharacter,
    required this.onSelectNewMode,
  });

  @override
  Widget build(BuildContext context) {
    return CommonGameResult(
      content: _buildResultContent(),
      onRetry: onRetry,
      // onBackはnullでOK - デフォルトでGameNavigationUtils.handleBackPressが使われる
    );
  }

  Widget _buildResultContent() {
    if (mode == WritingMode.tracing) {
      // なぞり書きの場合
      return Column(
        children: [
          const Icon(
            Icons.celebration,
            size: 50,
            color: Color(0xFF4A90E2),
          ),
          const SizedBox(height: 10),
          const Text(
            'よくできました！',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E3A59),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '「${character.character}」のなぞりがき',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A90E2),
            ),
          ),
          const Text(
            'かんせい！',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF666666),
            ),
          ),
        ],
      );
    } else {
      // 自由書きの場合 - 認識結果
      if (recognitionResult != null) {
        return _buildRecognitionResult();
      } else {
        return _buildLoadingResult();
      }
    }
  }

  Widget _buildRecognitionResult() {
    final result = recognitionResult!;
    final isCorrect = result.recognizedCharacter == character.character;
    
    return Column(
      children: [
        // アイコン - GameResultScreenと同じサイズ
        Icon(
          isCorrect ? Icons.celebration : Icons.info_outline,
          size: 50,
          color: isCorrect ? const Color(0xFF4A90E2) : Colors.orange,
        ),
        
        const SizedBox(height: 10),
        
        // メッセージ
        Text(
          isCorrect ? 'せいかい！' : 'にんしきしました',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2E3A59),
          ),
        ),
        
        const SizedBox(height: 10),
        
        // 認識結果
        Text(
          'にんしき: ${result.recognizedCharacter}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A90E2),
          ),
        ),
        
        if (!isCorrect)
          Text(
            'せいかい: ${character.character}',
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF666666),
            ),
          ),
      ],
    );
  }

  Widget _buildLoadingResult() {
    return const Column(
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 20),
        Text(
          'もじをにんしきちゅう...',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}