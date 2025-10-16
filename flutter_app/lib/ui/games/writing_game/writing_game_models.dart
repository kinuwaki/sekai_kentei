import 'package:flutter/material.dart';
import '../../components/drawing/drawing_models.dart';
import '../base/common_game_phase.dart';

// 文字カテゴリ
enum CharacterCategory {
  hiragana,
  numbers,
  alphabet,
}

extension CharacterCategoryExtension on CharacterCategory {
  String get displayName {
    switch (this) {
      case CharacterCategory.hiragana:
        return 'ひらがな';
      case CharacterCategory.numbers:
        return 'すうじ';
      case CharacterCategory.alphabet:
        return 'アルファベット';
    }
  }

  Color get color {
    switch (this) {
      case CharacterCategory.hiragana:
        return const Color(0xFF4A90E2);
      case CharacterCategory.numbers:
        return const Color(0xFF50C878);
      case CharacterCategory.alphabet:
        return const Color(0xFFFF6B6B);
    }
  }

  IconData get icon {
    switch (this) {
      case CharacterCategory.hiragana:
        return Icons.translate;
      case CharacterCategory.numbers:
        return Icons.numbers;
      case CharacterCategory.alphabet:
        return Icons.abc;
    }
  }
}

// 練習モード
enum WritingMode {
  tracing,      // なぞり書き（オレンジボール）
  tracingFree,  // なぞり書き２（自由になぞる）
  freeWrite,    // 自由書き
}

extension WritingModeExtension on WritingMode {
  String get displayName {
    switch (this) {
      case WritingMode.tracing:
        return 'なぞりがき';
      case WritingMode.tracingFree:
        return 'なぞりがき２';
      case WritingMode.freeWrite:
        return 'じゆうがき';
    }
  }

  String get description {
    switch (this) {
      case WritingMode.tracing:
        return 'せんをなぞって もじを かこう';
      case WritingMode.tracingFree:
        return 'じゆうになぞって もじを かこう';
      case WritingMode.freeWrite:
        return 'じゆうに もじを かいて みよう';
    }
  }
}

// 文字データ
class CharacterData {
  final String character;
  final CharacterCategory category;
  final List<String>? strokeOrder; // 書き順のパスID
  final String pronunciation;     // 読み方

  const CharacterData({
    required this.character,
    required this.category,
    this.strokeOrder,
    required this.pronunciation,
  });
}

// 描画データ
class DrawingStroke {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;
  final DateTime timestamp;

  DrawingStroke({
    required this.points,
    this.color = Colors.black,
    this.strokeWidth = 3.0,
    required this.timestamp,
  });
}

class Drawing {
  final List<DrawingStroke> strokes;
  final Size canvasSize;

  Drawing({
    required this.strokes,
    required this.canvasSize,
  });

  bool get isEmpty => strokes.isEmpty;
}

// 認識結果
class RecognitionResult {
  final String text;  // recognizedCharacterから変更
  final double confidence;
  final bool isRecognized;
  final List<RecognizedCandidate> candidates;  // RecognitionCandidateから変更
  final String? debugInfo;

  RecognitionResult({
    required this.text,
    required this.confidence,
    this.isRecognized = false,
    this.candidates = const [],
    this.debugInfo,
  });
  
  // 後方互換性のためのゲッター
  String get recognizedCharacter => text;
}

class RecognizedCandidate {  // RecognitionCandidateから名前変更
  final String text;  // characterから変更
  final double confidence;
  final int rank;

  RecognizedCandidate({
    required this.text,
    required this.confidence,
    this.rank = 0,
  });
  
  // 後方互換性のためのゲッター
  String get character => text;
}

// 後方互換性のためのエイリアス
typedef RecognitionCandidate = RecognizedCandidate;

// ゲーム状態
// 練習モードの組み合わせ
class PracticeCombination {
  final int tracingCount;       // なぞりがきの回数
  final int tracingFreeCount;   // なぞりがき２の回数
  final int freeWriteCount;     // じゆうがきの回数

  const PracticeCombination({
    required this.tracingCount,
    required this.tracingFreeCount,
    required this.freeWriteCount,
  });

  // プリセットの組み合わせ
  static const List<PracticeCombination> presets = [
    PracticeCombination(tracingCount: 1, tracingFreeCount: 0, freeWriteCount: 0),
    PracticeCombination(tracingCount: 0, tracingFreeCount: 1, freeWriteCount: 0),
    PracticeCombination(tracingCount: 0, tracingFreeCount: 0, freeWriteCount: 1),
    PracticeCombination(tracingCount: 4, tracingFreeCount: 0, freeWriteCount: 0),
    PracticeCombination(tracingCount: 2, tracingFreeCount: 1, freeWriteCount: 1),
    PracticeCombination(tracingCount: 1, tracingFreeCount: 2, freeWriteCount: 1),
    PracticeCombination(tracingCount: 1, tracingFreeCount: 1, freeWriteCount: 2),
    PracticeCombination(tracingCount: 0, tracingFreeCount: 2, freeWriteCount: 2),
    PracticeCombination(tracingCount: 0, tracingFreeCount: 0, freeWriteCount: 4),
  ];

  String get displayName {
    return '$tracingCount-$tracingFreeCount-$freeWriteCount';
  }

  // 練習順序を生成
  List<WritingMode> generateSequence() {
    final sequence = <WritingMode>[];
    for (int i = 0; i < tracingCount; i++) {
      sequence.add(WritingMode.tracing);
    }
    for (int i = 0; i < tracingFreeCount; i++) {
      sequence.add(WritingMode.tracingFree);
    }
    for (int i = 0; i < freeWriteCount; i++) {
      sequence.add(WritingMode.freeWrite);
    }
    return sequence;
  }
}

// BaseGameScreen用の設定クラス
class WritingGameSettings {
  final CharacterCategory category;
  final WritingMode mode;
  final CharacterData character;
  final PracticeCombination? combination;  // 組み合わせ設定を追加
  
  const WritingGameSettings({
    required this.category,
    required this.mode, 
    required this.character,
    this.combination,
  });
  
  String get displayName => '${category.displayName} - ${mode.displayName} - ${character.character}';
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WritingGameSettings &&
          runtimeType == other.runtimeType &&
          category == other.category &&
          mode == other.mode &&
          character == other.character &&
          combination == other.combination;
  
  @override
  int get hashCode => category.hashCode ^ mode.hashCode ^ character.hashCode ^ combination.hashCode;
}

// 書字ゲーム内部フェーズ（詳細状態管理用）
enum WritingPhase {
  categorySelection,
  modeSelection,
  characterSelection,
  tracing,
  tracingFree,
  freeWriting,
  result,
}

extension WritingPhaseExtension on WritingPhase {
  // CommonGamePhaseへのマッピング
  CommonGamePhase get toCommonGamePhase {
    switch (this) {
      case WritingPhase.categorySelection:
        return CommonGamePhase.ready;
      case WritingPhase.modeSelection:
      case WritingPhase.characterSelection:
        return CommonGamePhase.displaying;
      case WritingPhase.tracing:
      case WritingPhase.tracingFree:
      case WritingPhase.freeWriting:
        return CommonGamePhase.questioning;
      case WritingPhase.result:
        return CommonGamePhase.completed;
    }
  }
}

class WritingGameState {
  final CommonGamePhase phase;       // BaseGameScreen用の統一フェーズ
  final WritingPhase internalPhase;  // 内部詳細フェーズ
  final CharacterCategory? selectedCategory;
  final CharacterData? selectedCharacter;
  final WritingMode? selectedMode;
  final Drawing? currentDrawing; // 後方互換性のため保持
  final DrawingData drawingData; // 新しい共通描画データ
  final RecognitionResult? recognitionResult;
  final bool isAnimatingStrokes;
  final int currentStrokeIndex;
  final double maxStrokeProgress; // 現在のストロークでの最大進行度を保持
  final bool showSuccessEffect;
  
  // 練習進行状況
  final PracticeCombination? selectedCombination;
  final List<WritingMode> practiceSequence;
  final int currentPracticeIndex;

  const WritingGameState({
    this.phase = CommonGamePhase.ready,
    this.internalPhase = WritingPhase.categorySelection,
    this.selectedCategory,
    this.selectedCharacter,
    this.selectedMode,
    this.currentDrawing,
    this.drawingData = const DrawingData(paths: [], canvasSize: Size(300, 300)),
    this.recognitionResult,
    this.isAnimatingStrokes = false,
    this.currentStrokeIndex = 0,
    this.maxStrokeProgress = 0.0,
    this.showSuccessEffect = false,
    this.selectedCombination,
    this.practiceSequence = const [],
    this.currentPracticeIndex = 0,
  });

  WritingGameState copyWith({
    CommonGamePhase? phase,
    WritingPhase? internalPhase,
    CharacterCategory? selectedCategory,
    CharacterData? selectedCharacter,
    WritingMode? selectedMode,
    Drawing? currentDrawing,
    DrawingData? drawingData,
    RecognitionResult? recognitionResult,
    bool? isAnimatingStrokes,
    int? currentStrokeIndex,
    double? maxStrokeProgress,
    bool? showSuccessEffect,
    PracticeCombination? selectedCombination,
    List<WritingMode>? practiceSequence,
    int? currentPracticeIndex,
  }) {
    return WritingGameState(
      phase: phase ?? this.phase,
      internalPhase: internalPhase ?? this.internalPhase,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedCharacter: selectedCharacter ?? this.selectedCharacter,
      selectedMode: selectedMode ?? this.selectedMode,
      currentDrawing: currentDrawing ?? this.currentDrawing,
      drawingData: drawingData ?? this.drawingData,
      recognitionResult: recognitionResult ?? this.recognitionResult,
      isAnimatingStrokes: isAnimatingStrokes ?? this.isAnimatingStrokes,
      currentStrokeIndex: currentStrokeIndex ?? this.currentStrokeIndex,
      maxStrokeProgress: maxStrokeProgress ?? this.maxStrokeProgress,
      showSuccessEffect: showSuccessEffect ?? this.showSuccessEffect,
      selectedCombination: selectedCombination ?? this.selectedCombination,
      practiceSequence: practiceSequence ?? this.practiceSequence,
      currentPracticeIndex: currentPracticeIndex ?? this.currentPracticeIndex,
    );
  }
}