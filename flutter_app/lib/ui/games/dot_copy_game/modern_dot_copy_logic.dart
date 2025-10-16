import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/debug_logger.dart';
import 'models/dot_copy_models.dart';
import '../base/common_game_phase.dart';
import '../base/answer_handler_mixin.dart';
import 'procedural_shape_generator.dart';

/// ドット図形模写ゲームロジック
class ModernDotCopyLogic extends StateNotifier<DotCopyState>
    with AnswerHandlerMixin {
  static const String _tag = 'DotCopyGame';
  final math.Random _random = math.Random();

  ModernDotCopyLogic()
      : super(const DotCopyState(phase: CommonGamePhase.ready)) {
    Log.d('Created new instance', tag: _tag);
  }

  // ---- AnswerHandlerMixin実装 ----
  @override
  String get gameTitle => _tag;

  @override
  bool checkEpoch(int epoch) => state.epoch == epoch;

  @override
  Future<void> proceedToNext() => _autoAdvance();

  @override
  void returnToQuestioning() {
    state = state.copyWith(phase: CommonGamePhase.questioning);
  }

  // ---- BaseGameScreen互換プロパティ ----
  String? get questionText => state.questionText;
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  // ---- ゲーム制御 ----

  /// ゲーム開始
  void startGame(DotCopySettings settings) {
    Log.d('Starting game: ${settings.displayName}', tag: _tag);

    final initialResults = List<bool?>.filled(settings.questionCount, null);
    final firstProblem = _generateProblem(settings, 0);

    Log.d('=== FIRST PROBLEM GENERATED ===', tag: _tag);
    Log.d('Pattern has ${firstProblem.patternLines.length} lines:', tag: _tag);
    for (var i = 0; i < firstProblem.patternLines.length; i++) {
      final line = firstProblem.patternLines[i];
      Log.d('  Line $i: ${line.start} -> ${line.end}', tag: _tag);
    }

    state = DotCopyState(
      phase: CommonGamePhase.displaying,
      settings: settings,
      session: DotCopySession(
        index: 0,
        total: settings.questionCount,
        results: initialResults,
        currentProblem: firstProblem,
        drawnLines: [],
      ),
      epoch: state.epoch + 1,
    );

    _enterQuestioning();
  }

  void _enterQuestioning() {
    state = state.copyWith(phase: CommonGamePhase.questioning);
  }

  /// ドラッグ開始（ドットを押した時）
  void onDragStart(DotPosition dot) {
    if (!state.canDrawLine || state.session == null) return;

    final session = state.session!;
    Log.d('Drag started from dot: $dot', tag: _tag);

    state = state.copyWith(
      session: session.copyWith(selectedDot: dot),
    );
  }

  /// ドラッグ中（位置更新）
  void onDragUpdate(Offset position, {DotPosition? dotAtPosition}) {
    if (!state.canDrawLine || state.session == null) return;

    final session = state.session!;
    if (session.selectedDot == null) return;

    // ドラッグ位置を更新
    state = state.copyWith(
      session: session.copyWith(dragPosition: position),
    );

    // ドットに触れた場合は線を追加
    if (dotAtPosition != null) {
      final firstDot = session.selectedDot!;

      // 同じドットなら何もしない
      if (firstDot == dotAtPosition) return;

      Log.d('Drag update to dot: $dotAtPosition, drawing line from $firstDot', tag: _tag);

      // 線を距離1の線分に分割
      final newSegments = _splitLineIntoSegments(firstDot, dotAtPosition);

      // 既存の線と重複しない線分のみを追加
      final updatedLines = [...session.drawnLines];
      for (final segment in newSegments) {
        final normalized = segment.normalize();
        if (!updatedLines.any((line) => line.normalize() == normalized)) {
          updatedLines.add(segment);
        }
      }

      state = state.copyWith(
        session: session.copyWith(
          drawnLines: updatedLines,
          selectedDot: dotAtPosition, // 新しいドットから続けられるように
          dragPosition: null, // 一時線をクリア
        ),
      );
    }
  }

  /// 2点間を距離1の線分に分割（斜め線は1x1のみ）
  List<LineSegment> _splitLineIntoSegments(DotPosition start, DotPosition end) {
    final segments = <LineSegment>[];

    final dx = end.x - start.x;
    final dy = end.y - start.y;

    // 斜め45度かつ距離1の場合のみ直接線を引く
    if (dx.abs() == dy.abs() && dx.abs() == 1) {
      segments.add(LineSegment(start: start, end: end));
    } else if (dx.abs() == dy.abs() && dx != 0) {
      // 1x1以外の斜め線は横→縦で分割（斜め線禁止）
      var current = start;
      // 横方向
      final xStep = dx > 0 ? 1 : -1;
      for (int i = 0; i < dx.abs(); i++) {
        final next = DotPosition(x: current.x + xStep, y: current.y);
        segments.add(LineSegment(start: current, end: next));
        current = next;
      }
      // 縦方向
      final yStep = dy > 0 ? 1 : -1;
      for (int i = 0; i < dy.abs(); i++) {
        final next = DotPosition(x: current.x, y: current.y + yStep);
        segments.add(LineSegment(start: current, end: next));
        current = next;
      }
    } else if (dx != 0 && dy != 0) {
      // 斜めでない場合は、横→縦の順で移動
      var current = start;
      // 横方向
      final xStep = dx > 0 ? 1 : -1;
      for (int i = 0; i < dx.abs(); i++) {
        final next = DotPosition(x: current.x + xStep, y: current.y);
        segments.add(LineSegment(start: current, end: next));
        current = next;
      }
      // 縦方向
      final yStep = dy > 0 ? 1 : -1;
      for (int i = 0; i < dy.abs(); i++) {
        final next = DotPosition(x: current.x, y: current.y + yStep);
        segments.add(LineSegment(start: current, end: next));
        current = next;
      }
    } else if (dx != 0) {
      // 横方向のみ
      final step = dx > 0 ? 1 : -1;
      var current = start;
      for (int i = 0; i < dx.abs(); i++) {
        final next = DotPosition(x: current.x + step, y: current.y);
        segments.add(LineSegment(start: current, end: next));
        current = next;
      }
    } else if (dy != 0) {
      // 縦方向のみ
      final step = dy > 0 ? 1 : -1;
      var current = start;
      for (int i = 0; i < dy.abs(); i++) {
        final next = DotPosition(x: current.x, y: current.y + step);
        segments.add(LineSegment(start: current, end: next));
        current = next;
      }
    }

    return segments;
  }

  /// ドラッグ終了
  void onDragEnd() {
    if (state.session == null) return;

    final session = state.session!;
    Log.d('Drag ended', tag: _tag);

    state = state.copyWith(
      session: session.copyWith(
        selectedDot: null,
        dragPosition: null,
      ),
    );
  }

  /// 線を削除（最後の線を削除）
  void undoLastLine() {
    if (state.session == null || state.session!.drawnLines.isEmpty) return;

    final session = state.session!;
    final updatedLines = List<LineSegment>.from(session.drawnLines)
      ..removeLast();

    Log.d('Undo last line, remaining: ${updatedLines.length}', tag: _tag);

    state = state.copyWith(
      session: session.copyWith(
        drawnLines: updatedLines,
        selectedDot: null, // 選択もリセット
      ),
    );
  }

  /// 全消去
  void clearAllLines() {
    if (state.session == null) return;

    Log.d('Clear all lines', tag: _tag);

    state = state.copyWith(
      session: state.session!.copyWith(
        drawnLines: [],
        selectedDot: null,
      ),
    );
  }

  /// 答え合わせ（かたちさがしと同じパターン）
  Future<void> checkAnswer() async {
    if (!state.canAnswer || state.session?.currentProblem == null) {
      return;
    }

    final currentEpoch = state.epoch;
    final session = state.session!;
    final problem = session.currentProblem!;

    Log.d('Checking answer: drawn=${session.drawnLines.length}, pattern=${problem.patternLines.length} (epoch: $currentEpoch)',
        tag: _tag);

    // 処理中状態に変更
    state = state.copyWith(
      phase: CommonGamePhase.processing,
      epoch: currentEpoch,
    );

    // 正解判定：描いた線分とお手本の線分が一致するか
    final isCorrect = _checkLinesMatch(session.drawnLines, problem.patternLines);

    Log.d('Answer is ${isCorrect ? "correct" : "wrong"}', tag: _tag);

    if (isCorrect) {
      await _handleCorrectAnswer(currentEpoch);
    } else {
      await _handleWrongAnswer(currentEpoch);
    }
  }

  /// 正解処理
  Future<void> _handleCorrectAnswer(int epoch) async {
    final session = state.session!;

    // この問題で間違えていなければ完全正解
    final updatedResults = List<bool?>.from(session.results);
    final isPerfect = session.wrongAttempts == 0;
    updatedResults[session.index] = isPerfect;

    Log.d('Correct answer for question ${session.index + 1}: wrongAttempts=${session.wrongAttempts}, perfect=$isPerfect',
        tag: _tag);

    await handleCorrectAnswer(
      epoch: epoch,
      updateState: () {
        state = state.copyWith(
          phase: CommonGamePhase.feedbackOk,
          session: session.copyWith(results: updatedResults),
        );
      },
    );
  }

  /// 不正解処理
  Future<void> _handleWrongAnswer(int epoch) async {
    final session = state.session!;

    Log.d('Wrong answer for question ${session.index + 1}, attempts: ${session.wrongAttempts + 1}', tag: _tag);

    // 2回失敗したら次の問題へ
    final allowRetry = session.wrongAttempts < 1; // 1回目の失敗まで再挑戦可能

    await handleWrongAnswer(
      epoch: epoch,
      allowRetry: allowRetry,
      updateState: () {
        state = state.copyWith(
          phase: CommonGamePhase.feedbackNg,
          session: session.copyWith(
            wrongAttempts: session.wrongAttempts + 1,
          ),
        );
      },
    );
  }

  /// 次の問題または完了
  Future<void> _autoAdvance() async {
    state = state.copyWith(phase: CommonGamePhase.transitioning);

    await Future.delayed(const Duration(milliseconds: 350));

    final session = state.session!;
    if (session.isLast) {
      // ゲーム完了
      state = state.copyWith(phase: CommonGamePhase.completed);
      Log.d('Game completed - score: ${session.score}/${session.total}',
          tag: _tag);
    } else {
      // 次の問題
      final nextProblem = _generateProblem(state.settings!, session.index + 1);
      final nextSession = DotCopySession(
        index: session.index + 1,
        total: session.total,
        results: session.results,
        currentProblem: nextProblem,
        drawnLines: [], // 線をリセット
      );

      Log.d('Advancing to question ${nextSession.index + 1}', tag: _tag);

      state = state.copyWith(
        phase: CommonGamePhase.displaying,
        session: nextSession,
      );

      _enterQuestioning();
    }
  }

  /// 問題生成
  DotCopyProblem _generateProblem(DotCopySettings settings, int index) {
    final gridSize = settings.gridSize;
    final difficulty = settings.difficulty;

    // パターンリスト（三角形、正方形、長方形、組み合わせ）
    final patterns = <List<LineSegment>>[];
    final patternNames = <String>[];

    // 小さい三角形（サイズ1）
    if (gridSize >= 2) {
      patterns.add(_generateSmallTriangle(gridSize, _random));
      patternNames.add('小三角形▲');
      patterns.add(_generateSmallInvertedTriangle(gridSize, _random));
      patternNames.add('小逆三角形▼');
    }

    // 中三角形（サイズ2）
    if (gridSize >= 3) {
      patterns.add(_generateTriangle(gridSize, _random));
      patternNames.add('三角形▲');
      patterns.add(_generateInvertedTriangle(gridSize, _random));
      patternNames.add('逆三角形▼');
    }

    // 大三角形（サイズ3）
    if (gridSize >= 4) {
      patterns.add(_generateLargeTriangle(gridSize, _random));
      patternNames.add('大三角形▲');
      patterns.add(_generateLargeInvertedTriangle(gridSize, _random));
      patternNames.add('大逆三角形▼');
    }

    // 正方形（1x1, 2x2, 3x3）
    if (gridSize >= 2) {
      patterns.add(_generateSquare(gridSize, _random, 1));
      patternNames.add('小正方形□');
    }
    if (gridSize >= 3) {
      patterns.add(_generateSquare(gridSize, _random, 2));
      patternNames.add('正方形□');
    }
    if (gridSize >= 4) {
      patterns.add(_generateSquare(gridSize, _random, 3));
      patternNames.add('大正方形□');
    }

    // 長方形（1x2, 2x1）
    if (gridSize >= 3) {
      patterns.add(_generateRectangle(gridSize, _random));
      patternNames.add('長方形▭');
    }

    // 組み合わせパターン
    if (gridSize >= 3) {
      patterns.add(_generateTriangleSquareCombo(gridSize, _random));
      patternNames.add('三角+四角');
    }
    if (gridSize >= 4) {
      patterns.add(_generateDoubleTriangle(gridSize, _random));
      patternNames.add('二重三角');
      patterns.add(_generateHouseShape(gridSize, _random));
      patternNames.add('家型');
    }

    // プロシージュアルパターン（ふつう・むずかしいのみ）
    final proceduralPatterns = <List<LineSegment>>[];
    final proceduralNames = <String>[];

    if (gridSize >= 3 && difficulty != DotCopyDifficulty.easy) {
      final generator = ProceduralShapeGenerator(_random);
      Log.d('Generating procedural shapes for gridSize=$gridSize, ${difficulty.displayName}', tag: _tag);

      // 難易度に応じた辺数の範囲と斜め線設定
      int minEdges, maxEdges;
      bool allowDiagonal;
      if (difficulty == DotCopyDifficulty.normal) {
        minEdges = 7;
        maxEdges = 14;
        allowDiagonal = false; // ふつう: 斜め線禁止
      } else {
        // hard
        minEdges = 10;
        maxEdges = 20;
        allowDiagonal = true; // むずかしい: 斜め線あり
      }

      // 単一閉路を生成
      for (int targetEdges = minEdges; targetEdges <= maxEdges; targetEdges += 2) {
        final proceduralShape = generator.generateLoop(
          gridSize: gridSize,
          targetEdges: targetEdges,
          maxAttempts: 150,
          allowDiagonal: allowDiagonal,
        );

        if (proceduralShape != null) {
          proceduralPatterns.add(proceduralShape);
          proceduralNames.add('複雑図形(${proceduralShape.length}辺)');
          Log.d('Added single loop with ${proceduralShape.length} edges (diagonal: $allowDiagonal)', tag: _tag);
        }
      }

      // 図形合成パターン（2つの閉路を組み合わせ）
      if (gridSize >= 4) {
        for (int attempt = 0; attempt < 5; attempt++) {
          final composite = generator.generateCompositeShapes(
            gridSize: gridSize,
            targetEdges: (minEdges + maxEdges) ~/ 2,
            allowDiagonal: allowDiagonal,
            maxAttempts: 100,
          );

          if (composite != null) {
            proceduralPatterns.add(composite);
            proceduralNames.add('合成図形(${composite.length}辺)');
            Log.d('Added composite shape with ${composite.length} edges', tag: _tag);
          }
        }
      }

      Log.d('Total procedural patterns generated: ${proceduralPatterns.length}', tag: _tag);
    }

    // 難易度別パターン選択
    List<List<LineSegment>> finalPatterns;
    List<String> finalNames;

    if (difficulty == DotCopyDifficulty.easy) {
      // かんたん → 固定パターンのみ（辺数でフィルタ）
      finalPatterns = <List<LineSegment>>[];
      finalNames = <String>[];

      for (int i = 0; i < patterns.length; i++) {
        final edgeCount = patterns[i].length;
        if (edgeCount >= difficulty.minEdges && edgeCount <= difficulty.maxEdges) {
          finalPatterns.add(patterns[i]);
          finalNames.add(patternNames[i]);
        }
      }
      Log.d('Easy mode: using ${finalPatterns.length}/${patterns.length} fixed patterns', tag: _tag);

      // かんたんでパターンがない場合のみフォールバック
      if (finalPatterns.isEmpty) {
        Log.w('No easy patterns available, using all patterns', tag: _tag);
        finalPatterns = patterns;
        finalNames = patternNames;
      }
    } else {
      // ふつう・むずかしい → プロシージュアルのみ
      finalPatterns = proceduralPatterns;
      finalNames = proceduralNames;
      Log.d('Normal/Hard mode: using ${finalPatterns.length} procedural patterns only', tag: _tag);

      // プロシージュアルが生成できなかった場合は緊急措置として再生成
      if (finalPatterns.isEmpty) {
        Log.e('No procedural patterns generated! Retrying with relaxed constraints...', tag: _tag);
        final generator = ProceduralShapeGenerator(_random);
        final allowDiagonal = difficulty == DotCopyDifficulty.hard;

        // より広い範囲で再試行
        for (int targetEdges = 6; targetEdges <= 20; targetEdges += 2) {
          final shape = generator.generateLoop(
            gridSize: gridSize,
            targetEdges: targetEdges,
            maxAttempts: 200,
            allowDiagonal: allowDiagonal,
          );
          if (shape != null) {
            finalPatterns.add(shape);
            finalNames.add('緊急図形(${shape.length}辺)');
            if (finalPatterns.length >= 3) break; // 3つ生成できたら十分
          }
        }

        if (finalPatterns.isEmpty) {
          Log.e('Emergency procedural generation also failed! Using easy patterns as last resort', tag: _tag);
          // 最終手段：かんたんの固定パターンを使う
          finalPatterns = patterns.take(5).toList();
          finalNames = patternNames.take(5).toList();
        }
      }
    }

    // ランダムに選択
    final selectedIndex = _random.nextInt(finalPatterns.length);
    final pattern = finalPatterns[selectedIndex];
    final patternName = finalNames[selectedIndex];

    Log.d('Pattern type for index $index: $patternName', tag: _tag);

    Log.d('Generated problem $index: $patternName with ${pattern.length} lines', tag: _tag);
    Log.d('Pattern lines: ${pattern.map((l) => '${l.start}->${l.end}').join(', ')}', tag: _tag);

    // 重複チェック
    final normalized = pattern.map((l) => l.normalize()).toSet();
    Log.d('Unique normalized pattern lines: ${normalized.length}', tag: _tag);
    if (normalized.length != pattern.length) {
      Log.w('WARNING: Pattern has duplicate lines! ${pattern.length} -> ${normalized.length}', tag: _tag);
    }

    return DotCopyProblem(
      gridSize: gridSize,
      patternLines: pattern,
    );
  }

  /// 正三角形パターン生成（▲）- 直角三角形
  List<LineSegment> _generateTriangle(int gridSize, math.Random random) {
    // サイズ: 2または4（偶数で斜めが描きやすい）
    final possibleSizes = [2].where((s) => s < gridSize).toList();
    final size = possibleSizes.isNotEmpty
        ? possibleSizes[random.nextInt(possibleSizes.length)]
        : 2;

    // 位置を調整してグリッド内に収める
    final x = random.nextInt(gridSize - size);
    final y = random.nextInt(gridSize - size);

    final segments = <LineSegment>[];

    Log.d('Generating triangle at ($x,$y) with size $size', tag: _tag);
    Log.d('Triangle points: bottom-left=($x,${y + size}), bottom-right=(${x + size},${y + size}), top-right=(${x + size},$y)', tag: _tag);

    // 底辺（左下→右下）横線
    segments.addAll(_splitLineIntoSegments(
      DotPosition(x: x, y: y + size),
      DotPosition(x: x + size, y: y + size),
    ));

    // 右辺（右下→右上）縦線
    segments.addAll(_splitLineIntoSegments(
      DotPosition(x: x + size, y: y + size),
      DotPosition(x: x + size, y: y),
    ));

    // 斜辺（右上→左下）斜め線
    segments.addAll(_splitLineIntoSegments(
      DotPosition(x: x + size, y: y),
      DotPosition(x: x, y: y + size),
    ));

    Log.d('Total segments before dedup: ${segments.length}', tag: _tag);

    // 重複する線分を削除
    final result = _removeDuplicateSegments(segments);
    Log.d('Total segments after dedup: ${result.length}', tag: _tag);
    return result;
  }

  /// 逆三角形パターン生成（▼）- 直角三角形
  List<LineSegment> _generateInvertedTriangle(int gridSize, math.Random random) {
    // サイズ: 2または4（偶数で斜めが描きやすい）
    final possibleSizes = [2].where((s) => s < gridSize).toList();
    final size = possibleSizes.isNotEmpty
        ? possibleSizes[random.nextInt(possibleSizes.length)]
        : 2;

    final x = random.nextInt(gridSize - size);
    final y = random.nextInt(gridSize - size);

    final segments = <LineSegment>[];

    Log.d('Generating inverted triangle at ($x,$y) with size $size', tag: _tag);
    Log.d('Inverted triangle points: top-left=($x,$y), top-right=(${x + size},$y), bottom-left=($x,${y + size})', tag: _tag);

    // 上辺（左上→右上）横線
    segments.addAll(_splitLineIntoSegments(
      DotPosition(x: x, y: y),
      DotPosition(x: x + size, y: y),
    ));

    // 左辺（左上→左下）縦線
    segments.addAll(_splitLineIntoSegments(
      DotPosition(x: x, y: y),
      DotPosition(x: x, y: y + size),
    ));

    // 斜辺（左下→右上）斜め線
    segments.addAll(_splitLineIntoSegments(
      DotPosition(x: x, y: y + size),
      DotPosition(x: x + size, y: y),
    ));

    // 重複する線分を削除
    return _removeDuplicateSegments(segments);
  }

  /// 小さい三角形パターン生成（▲）サイズ1
  List<LineSegment> _generateSmallTriangle(int gridSize, math.Random random) {
    final size = 1;
    final x = random.nextInt(gridSize - size);
    final y = random.nextInt(gridSize - size);

    return _removeDuplicateSegments([
      LineSegment(start: DotPosition(x: x, y: y + size), end: DotPosition(x: x + size, y: y + size)),
      LineSegment(start: DotPosition(x: x + size, y: y + size), end: DotPosition(x: x + size, y: y)),
      LineSegment(start: DotPosition(x: x + size, y: y), end: DotPosition(x: x, y: y + size)),
    ]);
  }

  /// 小さい逆三角形パターン生成（▼）サイズ1
  List<LineSegment> _generateSmallInvertedTriangle(int gridSize, math.Random random) {
    final size = 1;
    final x = random.nextInt(gridSize - size);
    final y = random.nextInt(gridSize - size);

    return _removeDuplicateSegments([
      LineSegment(start: DotPosition(x: x, y: y), end: DotPosition(x: x + size, y: y)),
      LineSegment(start: DotPosition(x: x, y: y), end: DotPosition(x: x, y: y + size)),
      LineSegment(start: DotPosition(x: x, y: y + size), end: DotPosition(x: x + size, y: y)),
    ]);
  }

  /// 正方形パターン生成
  List<LineSegment> _generateSquare(int gridSize, math.Random random, int size) {
    final x = random.nextInt(gridSize - size);
    final y = random.nextInt(gridSize - size);

    final segments = <LineSegment>[];

    segments.addAll(_splitLineIntoSegments(DotPosition(x: x, y: y), DotPosition(x: x + size, y: y)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x + size, y: y), DotPosition(x: x + size, y: y + size)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x + size, y: y + size), DotPosition(x: x, y: y + size)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x, y: y + size), DotPosition(x: x, y: y)));

    return _removeDuplicateSegments(segments);
  }

  /// 長方形パターン生成（1x2または2x1）
  List<LineSegment> _generateRectangle(int gridSize, math.Random random) {
    final isHorizontal = random.nextBool();
    final width = isHorizontal ? 2 : 1;
    final height = isHorizontal ? 1 : 2;

    final x = random.nextInt(gridSize - width);
    final y = random.nextInt(gridSize - height);

    final segments = <LineSegment>[];

    segments.addAll(_splitLineIntoSegments(DotPosition(x: x, y: y), DotPosition(x: x + width, y: y)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x + width, y: y), DotPosition(x: x + width, y: y + height)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x + width, y: y + height), DotPosition(x: x, y: y + height)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x, y: y + height), DotPosition(x: x, y: y)));

    return _removeDuplicateSegments(segments);
  }

  /// 大三角形パターン生成（▲）サイズ3
  List<LineSegment> _generateLargeTriangle(int gridSize, math.Random random) {
    final size = 3;
    final x = random.nextInt(gridSize - size);
    final y = random.nextInt(gridSize - size);

    final segments = <LineSegment>[];
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x, y: y + size), DotPosition(x: x + size, y: y + size)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x + size, y: y + size), DotPosition(x: x + size, y: y)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x + size, y: y), DotPosition(x: x, y: y + size)));

    return _removeDuplicateSegments(segments);
  }

  /// 大逆三角形パターン生成（▼）サイズ3
  List<LineSegment> _generateLargeInvertedTriangle(int gridSize, math.Random random) {
    final size = 3;
    final x = random.nextInt(gridSize - size);
    final y = random.nextInt(gridSize - size);

    final segments = <LineSegment>[];
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x, y: y), DotPosition(x: x + size, y: y)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x, y: y), DotPosition(x: x, y: y + size)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x, y: y + size), DotPosition(x: x + size, y: y)));

    return _removeDuplicateSegments(segments);
  }

  /// 三角形+四角形の組み合わせ
  List<LineSegment> _generateTriangleSquareCombo(int gridSize, math.Random random) {
    final segments = <LineSegment>[];

    // 小さい四角形（1x1）
    final x1 = random.nextInt(gridSize - 1);
    final y1 = random.nextInt(gridSize - 2);
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x1, y: y1), DotPosition(x: x1 + 1, y: y1)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x1 + 1, y: y1), DotPosition(x: x1 + 1, y: y1 + 1)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x1 + 1, y: y1 + 1), DotPosition(x: x1, y: y1 + 1)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x1, y: y1 + 1), DotPosition(x: x1, y: y1)));

    // その上に小さい三角形
    segments.add(LineSegment(start: DotPosition(x: x1, y: y1 + 1), end: DotPosition(x: x1 + 1, y: y1 + 1)));
    segments.add(LineSegment(start: DotPosition(x: x1 + 1, y: y1 + 1), end: DotPosition(x: x1 + 1, y: y1 + 2)));
    segments.add(LineSegment(start: DotPosition(x: x1 + 1, y: y1 + 2), end: DotPosition(x: x1, y: y1 + 1)));

    return _removeDuplicateSegments(segments);
  }

  /// 二重三角形（大小の三角形）
  List<LineSegment> _generateDoubleTriangle(int gridSize, math.Random random) {
    final segments = <LineSegment>[];

    // 外側の大きい三角形（サイズ2）
    final x = random.nextInt(gridSize - 2);
    final y = random.nextInt(gridSize - 2);
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x, y: y + 2), DotPosition(x: x + 2, y: y + 2)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x + 2, y: y + 2), DotPosition(x: x + 2, y: y)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x + 2, y: y), DotPosition(x: x, y: y + 2)));

    // 内側の小さい三角形（サイズ1）
    segments.add(LineSegment(start: DotPosition(x: x + 1, y: y + 1), end: DotPosition(x: x + 2, y: y + 1)));
    segments.add(LineSegment(start: DotPosition(x: x + 2, y: y + 1), end: DotPosition(x: x + 2, y: y)));
    segments.add(LineSegment(start: DotPosition(x: x + 2, y: y), end: DotPosition(x: x + 1, y: y + 1)));

    return _removeDuplicateSegments(segments);
  }

  /// 家型（四角+三角の屋根）
  List<LineSegment> _generateHouseShape(int gridSize, math.Random random) {
    final segments = <LineSegment>[];

    // 四角形の本体（2x2）
    final x = random.nextInt(gridSize - 2);
    final y = random.nextInt(gridSize - 3);
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x, y: y + 1), DotPosition(x: x + 2, y: y + 1)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x + 2, y: y + 1), DotPosition(x: x + 2, y: y + 3)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x + 2, y: y + 3), DotPosition(x: x, y: y + 3)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x, y: y + 3), DotPosition(x: x, y: y + 1)));

    // 三角の屋根
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x, y: y + 1), DotPosition(x: x + 1, y: y)));
    segments.addAll(_splitLineIntoSegments(DotPosition(x: x + 1, y: y), DotPosition(x: x + 2, y: y + 1)));

    return _removeDuplicateSegments(segments);
  }

  /// 重複する線分を削除（正規化して比較）
  List<LineSegment> _removeDuplicateSegments(List<LineSegment> segments) {
    final seen = <LineSegment>{};
    final result = <LineSegment>[];

    for (final segment in segments) {
      final normalized = segment.normalize();
      if (!seen.contains(normalized)) {
        seen.add(normalized);
        result.add(segment);
      }
    }

    return result;
  }

  /// 線分一致判定（辺集合の完全一致）
  bool _checkLinesMatch(
      List<LineSegment> drawnLines, List<LineSegment> patternLines) {
    if (drawnLines.length != patternLines.length) {
      Log.d('Line count mismatch: drawn=${drawnLines.length}, pattern=${patternLines.length}', tag: _tag);
      return false;
    }

    // 正規化した線分のセットで比較
    final drawnSet = drawnLines.map((line) => line.normalize()).toSet();
    final patternSet = patternLines.map((line) => line.normalize()).toSet();

    Log.d('Drawn lines: ${drawnLines.map((l) => '${l.start}->${l.end}').join(', ')}', tag: _tag);
    Log.d('Pattern lines: ${patternLines.map((l) => '${l.start}->${l.end}').join(', ')}', tag: _tag);
    Log.d('Normalized drawn: ${drawnSet.map((l) => '${l.start}->${l.end}').join(', ')}', tag: _tag);
    Log.d('Normalized pattern: ${patternSet.map((l) => '${l.start}->${l.end}').join(', ')}', tag: _tag);

    final result = drawnSet.difference(patternSet).isEmpty &&
        patternSet.difference(drawnSet).isEmpty;

    Log.d('Match result: $result', tag: _tag);
    return result;
  }

  /// ゲームリセット
  void resetGame() {
    Log.d('Resetting game', tag: _tag);
    state = const DotCopyState(phase: CommonGamePhase.ready);
  }
}

/// プロバイダー
final modernDotCopyLogicProvider =
    StateNotifierProvider.autoDispose<ModernDotCopyLogic, DotCopyState>((ref) {
  return ModernDotCopyLogic();
});