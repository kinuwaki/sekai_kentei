import '../base/base_game_screen.dart';
import 'writing_practice_settings.dart';
import 'writing_game_models.dart';

/// セッション状態
class WritingSessionState {
  final GameUiPhase phase;
  final int stepIndex;
  final List<WritingMode> sequence;
  final String character;
  final bool isRunningMode;
  final String runId;
  final CharacterCategory selectedCategory;
  final PracticeCombination? selectedCombination;

  const WritingSessionState({
    required this.phase,
    required this.stepIndex,
    required this.sequence,
    required this.character,
    required this.isRunningMode,
    required this.runId,
    required this.selectedCategory,
    this.selectedCombination,
  });

  /// 現在のモード（シーケンス範囲内の場合）
  WritingMode? get currentMode {
    if (stepIndex >= 0 && stepIndex < sequence.length) {
      return sequence[stepIndex];
    }
    return null;
  }

  /// プログレステキスト
  String get progressText => '${stepIndex.clamp(0, sequence.length) + 1}/${sequence.length}';

  /// 完了しているか
  bool get isComplete => stepIndex >= sequence.length;

  WritingSessionState copyWith({
    GameUiPhase? phase,
    int? stepIndex,
    List<WritingMode>? sequence,
    String? character,
    bool? isRunningMode,
    String? runId,
    CharacterCategory? selectedCategory,
    PracticeCombination? selectedCombination,
  }) {
    return WritingSessionState(
      phase: phase ?? this.phase,
      stepIndex: stepIndex ?? this.stepIndex,
      sequence: sequence ?? this.sequence,
      character: character ?? this.character,
      isRunningMode: isRunningMode ?? this.isRunningMode,
      runId: runId ?? this.runId,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedCombination: selectedCombination ?? this.selectedCombination,
    );
  }
}

/// 初期状態を生成
WritingSessionState initialSessionState(WritingPracticeSettings settings) {
  return WritingSessionState(
    phase: GameUiPhase.settings,
    stepIndex: 0,
    sequence: settings.sequence,
    character: settings.character,
    isRunningMode: false,
    runId: DateTime.now().microsecondsSinceEpoch.toString(),
    selectedCategory: CharacterCategory.hiragana, // デフォルト
    selectedCombination: null,
  );
}