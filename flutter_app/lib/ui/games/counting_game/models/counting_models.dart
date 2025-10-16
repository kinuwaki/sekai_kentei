import 'package:flutter/material.dart';
import '../../base/common_game_phase.dart';

// 数値範囲
enum CountingRange {
  range1to5,
  range5to10,
  range1to10,
}

extension CountingRangeExtension on CountingRange {
  String get displayName {
    switch (this) {
      case CountingRange.range1to5:
        return '1-5';
      case CountingRange.range5to10:
        return '5-10';
      case CountingRange.range1to10:
        return '1-10';
    }
  }

  int get minValue {
    switch (this) {
      case CountingRange.range1to5:
        return 1;
      case CountingRange.range5to10:
        return 5;
      case CountingRange.range1to10:
        return 1;
    }
  }

  int get maxValue {
    switch (this) {
      case CountingRange.range1to5:
        return 5;
      case CountingRange.range5to10:
        return 10;
      case CountingRange.range1to10:
        return 10;
    }
  }
}

// ドットの形状
enum DotShape {
  circle,
  square,
  star,
}

// ゲームの設定
class CountingGameSettings {
  final CountingRange range;
  final int questionCount;

  const CountingGameSettings({
    required this.range,
    this.questionCount = 5,
  });

  String get displayName => 'かずかぞえ ${range.displayName}';
}

/// 数かぞえゲームの問題データ（immutable版）
class CountingProblem {
  final int targetNumber;
  final List<int> options;
  final int correctAnswerIndex;
  final DotShape dotShape;
  final Color dotColor;
  final Map<int, List<Offset>> dotPositions;
  final Map<int, double> dotSizes;

  const CountingProblem({
    required this.targetNumber,
    required this.options,
    required this.correctAnswerIndex,
    required this.dotShape,
    required this.dotColor,
    required this.dotPositions,
    required this.dotSizes,
  });
  
  String get questionText => 'ドットは いくつかな？';
  
  CountingProblem copyWith({
    int? targetNumber,
    List<int>? options,
    int? correctAnswerIndex,
    DotShape? dotShape,
    Color? dotColor,
    Map<int, List<Offset>>? dotPositions,
    Map<int, double>? dotSizes,
  }) {
    return CountingProblem(
      targetNumber: targetNumber ?? this.targetNumber,
      options: options ?? this.options,
      correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
      dotShape: dotShape ?? this.dotShape,
      dotColor: dotColor ?? this.dotColor,
      dotPositions: dotPositions ?? this.dotPositions,
      dotSizes: dotSizes ?? this.dotSizes,
    );
  }
}

/// 数かぞえゲームのセッション（問題進行状況）
class CountingSession {
  final int index;               // 0-based
  final int total;
  final CountingProblem current;
  final List<bool?> results;     // 各問題の結果（未回答null、完全正解true、不完全正解false）
  final bool currentWrong;       // 現在の問題で一度でも間違えたか

  const CountingSession({
    required this.index,
    required this.total,
    required this.current,
    required this.results,
    this.currentWrong = false,
  });
  
  bool get isLast => index + 1 >= total;
  int get score => results.where((r) => r == true).length;
  
  CountingSession next(CountingProblem nextProblem) =>
      copyWith(
        index: index + 1, 
        current: nextProblem,
        currentWrong: false,
      );
  
  CountingSession copyWith({
    int? index,
    int? total,
    CountingProblem? current,
    List<bool?>? results,
    bool? currentWrong,
  }) {
    return CountingSession(
      index: index ?? this.index,
      total: total ?? this.total,
      current: current ?? this.current,
      results: results ?? this.results,
      currentWrong: currentWrong ?? this.currentWrong,
    );
  }
}

/// 回答結果
class CountingAnswerResult {
  final int selectedIndex;
  final bool isCorrect;
  final int correctIndex;

  const CountingAnswerResult({
    required this.selectedIndex,
    required this.isCorrect,
    required this.correctIndex,
  });
  
  CountingAnswerResult copyWith({
    int? selectedIndex,
    bool? isCorrect,
    int? correctIndex,
  }) {
    return CountingAnswerResult(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isCorrect: isCorrect ?? this.isCorrect,
      correctIndex: correctIndex ?? this.correctIndex,
    );
  }
}

/// 数かぞえゲームの統合状態
class CountingState {
  final CommonGamePhase phase;
  final CountingGameSettings? settings;
  final CountingSession? session;
  final CountingAnswerResult? lastResult;
  final int epoch; // 非同期競合ガード用

  const CountingState({
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
  
  CountingState copyWith({
    CommonGamePhase? phase,
    CountingGameSettings? settings,
    CountingSession? session,
    CountingAnswerResult? lastResult,
    int? epoch,
  }) {
    return CountingState(
      phase: phase ?? this.phase,
      settings: settings ?? this.settings,
      session: session ?? this.session,
      lastResult: lastResult ?? this.lastResult,
      epoch: epoch ?? this.epoch,
    );
  }
}