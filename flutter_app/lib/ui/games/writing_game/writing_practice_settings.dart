import 'package:flutter/foundation.dart';
import 'writing_game_models.dart';

/// 書き練習の設定
class WritingPracticeSettings {
  final String character;
  final List<WritingMode> sequence;
  final bool showResultPerMode;
  final bool continuousMode;
  final VoidCallback? onSessionComplete;

  const WritingPracticeSettings({
    required this.character,
    this.sequence = const [WritingMode.tracing, WritingMode.tracingFree, WritingMode.freeWrite],
    this.showResultPerMode = false,
    this.continuousMode = false,
    this.onSessionComplete,
  });

  String get displayName => '$character - ${sequence.map((m) => m.displayName).join('→')}';

  WritingPracticeSettings copyWith({
    String? character,
    List<WritingMode>? sequence,
    bool? showResultPerMode,
    bool? continuousMode,
    VoidCallback? onSessionComplete,
  }) {
    return WritingPracticeSettings(
      character: character ?? this.character,
      sequence: sequence ?? this.sequence,
      showResultPerMode: showResultPerMode ?? this.showResultPerMode,
      continuousMode: continuousMode ?? this.continuousMode,
      onSessionComplete: onSessionComplete ?? this.onSessionComplete,
    );
  }
}