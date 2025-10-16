import 'package:flutter/material.dart';
import '../../base/common_game_phase.dart';

// 数値範囲
enum ComparisonRange {
  range1to5,
  range5to10,
  range10to20,
  range20to30,
  range30to40,
  range40to50,
  range50to60,
  range60to70,
  range70to80,
  range80to90,
  range90to100,
  // 新しい範囲
  range1to20,
  range20to50,
  range50to100,
  range100to120,
  range1to50,
  range1to120,
}

extension ComparisonRangeExtension on ComparisonRange {
  String get displayName {
    switch (this) {
      case ComparisonRange.range1to5:
        return '1-5';
      case ComparisonRange.range5to10:
        return '5-10';
      case ComparisonRange.range10to20:
        return '10-20';
      case ComparisonRange.range20to30:
        return '20-30';
      case ComparisonRange.range30to40:
        return '30-40';
      case ComparisonRange.range40to50:
        return '40-50';
      case ComparisonRange.range50to60:
        return '50-60';
      case ComparisonRange.range60to70:
        return '60-70';
      case ComparisonRange.range70to80:
        return '70-80';
      case ComparisonRange.range80to90:
        return '80-90';
      case ComparisonRange.range90to100:
        return '90-100';
      // 新しい範囲
      case ComparisonRange.range1to20:
        return '1-20';
      case ComparisonRange.range20to50:
        return '20-50';
      case ComparisonRange.range50to100:
        return '50-100';
      case ComparisonRange.range100to120:
        return '100-120';
      case ComparisonRange.range1to50:
        return '1-50';
      case ComparisonRange.range1to120:
        return '1-120';
    }
  }

  int get minValue {
    switch (this) {
      case ComparisonRange.range1to5:
        return 1;
      case ComparisonRange.range5to10:
        return 5;
      case ComparisonRange.range10to20:
        return 10;
      case ComparisonRange.range20to30:
        return 20;
      case ComparisonRange.range30to40:
        return 30;
      case ComparisonRange.range40to50:
        return 40;
      case ComparisonRange.range50to60:
        return 50;
      case ComparisonRange.range60to70:
        return 60;
      case ComparisonRange.range70to80:
        return 70;
      case ComparisonRange.range80to90:
        return 80;
      case ComparisonRange.range90to100:
        return 90;
      // 新しい範囲
      case ComparisonRange.range1to20:
        return 1;
      case ComparisonRange.range20to50:
        return 20;
      case ComparisonRange.range50to100:
        return 50;
      case ComparisonRange.range100to120:
        return 100;
      case ComparisonRange.range1to50:
        return 1;
      case ComparisonRange.range1to120:
        return 1;
    }
  }

  int get maxValue {
    switch (this) {
      case ComparisonRange.range1to5:
        return 5;
      case ComparisonRange.range5to10:
        return 10;
      case ComparisonRange.range10to20:
        return 20;
      case ComparisonRange.range20to30:
        return 30;
      case ComparisonRange.range30to40:
        return 40;
      case ComparisonRange.range40to50:
        return 50;
      case ComparisonRange.range50to60:
        return 60;
      case ComparisonRange.range60to70:
        return 70;
      case ComparisonRange.range70to80:
        return 80;
      case ComparisonRange.range80to90:
        return 90;
      case ComparisonRange.range90to100:
        return 100;
      // 新しい範囲
      case ComparisonRange.range1to20:
        return 20;
      case ComparisonRange.range20to50:
        return 50;
      case ComparisonRange.range50to100:
        return 100;
      case ComparisonRange.range100to120:
        return 120;
      case ComparisonRange.range1to50:
        return 50;
      case ComparisonRange.range1to120:
        return 120;
    }
  }
}

// 表示タイプ
enum ComparisonDisplayType {
  dots,
  digits,
}

// 比較問題タイプ
enum ComparisonQuestionType {
  fixedLargest,    // 固定で「おおきい」
  fixedSmallest,   // 固定で「ちいさい」
  advanced,        // 上級（ランダム）
  // 内部使用（上級モードで動的に選択される）
  largest,         // 一番大きい
  smallest,        // 一番小さい
  secondLargest,   // 二番目に大きい
  secondSmallest,  // 二番目に小さい
  thirdLargest,    // 三番目に大きい
  thirdSmallest,   // 三番目に小さい
}

// ドットの形状
enum DotShape {
  circle,
  square,
  star,
}

// ゲームの設定
class ComparisonGameSettings {
  final ComparisonRange range;
  final ComparisonDisplayType displayType;
  final int optionCount;
  final ComparisonQuestionType? questionType;
  final int questionCount;

  const ComparisonGameSettings({
    required this.range,
    required this.displayType,
    required this.optionCount,
    this.questionType,
    this.questionCount = 5,
  });

  String get displayName => 'おおきい・ちいさい ${range.displayName}';
}

/// 比較ゲームの問題データ（immutable版）
class ComparisonProblem {
  final List<int> options;
  final int correctAnswerIndex;
  final String questionText;
  final DotShape dotShape;
  final Color dotColor;
  final Map<int, List<Offset>> dotPositions;
  final Map<int, double> dotSizes;

  const ComparisonProblem({
    required this.options,
    required this.correctAnswerIndex,
    required this.questionText,
    required this.dotShape,
    required this.dotColor,
    required this.dotPositions,
    required this.dotSizes,
  });
  
  ComparisonProblem copyWith({
    List<int>? options,
    int? correctAnswerIndex,
    String? questionText,
    DotShape? dotShape,
    Color? dotColor,
    Map<int, List<Offset>>? dotPositions,
    Map<int, double>? dotSizes,
  }) {
    return ComparisonProblem(
      options: options ?? this.options,
      correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
      questionText: questionText ?? this.questionText,
      dotShape: dotShape ?? this.dotShape,
      dotColor: dotColor ?? this.dotColor,
      dotPositions: dotPositions ?? this.dotPositions,
      dotSizes: dotSizes ?? this.dotSizes,
    );
  }
}

/// 比較ゲームのセッション（問題進行状況）
class ComparisonSession {
  final int index;               // 0-based
  final int total;
  final ComparisonProblem current;
  final List<bool?> results;     // 各問題の結果（未回答null、完全正解true、不完全正解false）
  final bool currentWrong;       // 現在の問題で一度でも間違えたか

  const ComparisonSession({
    required this.index,
    required this.total,
    required this.current,
    required this.results,
    this.currentWrong = false,
  });
  
  bool get isLast => index + 1 >= total;
  int get score => results.where((r) => r == true).length;
  
  ComparisonSession next(ComparisonProblem nextProblem) =>
      copyWith(
        index: index + 1, 
        current: nextProblem,
        currentWrong: false,
      );
  
  ComparisonSession copyWith({
    int? index,
    int? total,
    ComparisonProblem? current,
    List<bool?>? results,
    bool? currentWrong,
  }) {
    return ComparisonSession(
      index: index ?? this.index,
      total: total ?? this.total,
      current: current ?? this.current,
      results: results ?? this.results,
      currentWrong: currentWrong ?? this.currentWrong,
    );
  }
}

/// 回答結果
class ComparisonAnswerResult {
  final int selectedIndex;
  final bool isCorrect;
  final int correctIndex;

  const ComparisonAnswerResult({
    required this.selectedIndex,
    required this.isCorrect,
    required this.correctIndex,
  });
  
  ComparisonAnswerResult copyWith({
    int? selectedIndex,
    bool? isCorrect,
    int? correctIndex,
  }) {
    return ComparisonAnswerResult(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isCorrect: isCorrect ?? this.isCorrect,
      correctIndex: correctIndex ?? this.correctIndex,
    );
  }
}

/// 比較ゲームの統合状態
class ComparisonState {
  final CommonGamePhase phase;
  final ComparisonGameSettings? settings;
  final ComparisonSession? session;
  final ComparisonAnswerResult? lastResult;
  final int epoch; // 非同期競合ガード用

  const ComparisonState({
    required this.phase,
    this.settings,
    this.session,
    this.lastResult,
    this.epoch = 0,
  });
  
  // UI用の派生プロパティ
  
  /// 回答選択可能か
  bool get canAnswer => phase == CommonGamePhase.questioning;
  
  /// 処理中（何らかの入力をブロック）
  bool get isProcessing =>
      phase == CommonGamePhase.processing || 
      phase == CommonGamePhase.transitioning;
  
  /// 成功エフェクト表示中
  bool get showSuccessEffect => phase == CommonGamePhase.feedbackOk;
  
  /// 間違いエフェクト表示中
  bool get showWrongEffect => phase == CommonGamePhase.feedbackNg;
  
  /// ゲーム進行度
  double get progress => 
      session != null && session!.total > 0 
          ? session!.index / session!.total 
          : 0.0;
  
  /// 問題文（BaseGameScreenのTTS用）
  String? get questionText => session?.current.questionText;
  
  /// ゲーム完了済み
  bool get isCompleted => phase == CommonGamePhase.completed;
  
  /// 全問正解かどうか（完了した問題が全て完全正解）
  bool get isPerfect => 
      session != null && 
      session!.results.take(session!.index + 1).every((r) => r == true);
  
  /// 現在までに間違えたことがあるか
  bool get hadAnyWrongAnswer => 
      session != null && session!.results.contains(false);
  
  ComparisonState copyWith({
    CommonGamePhase? phase,
    ComparisonGameSettings? settings,
    ComparisonSession? session,
    ComparisonAnswerResult? lastResult,
    int? epoch,
  }) {
    return ComparisonState(
      phase: phase ?? this.phase,
      settings: settings ?? this.settings,
      session: session ?? this.session,
      lastResult: lastResult ?? this.lastResult,
      epoch: epoch ?? this.epoch,
    );
  }
}