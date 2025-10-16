import 'dart:math' as math;
import 'models/dot_copy_models.dart';
import 'topology_utils.dart';

/// プロシージュアル図形生成器
class ProceduralShapeGenerator {
  final math.Random random;

  ProceduralShapeGenerator(this.random);

  /// ランダムウォークで単一閉路を生成
  /// targetEdges: 目標辺数（±3の範囲で柔軟）
  /// maxAttempts: 生成試行回数
  /// allowDiagonal: 斜め線を許可するか（デフォルト: true）
  List<LineSegment>? generateLoop({
    required int gridSize,
    required int targetEdges,
    int maxAttempts = 100,
    bool allowDiagonal = true,
  }) {
    for (int attempt = 0; attempt < maxAttempts; attempt++) {
      final result = _tryGenerateLoop(gridSize, targetEdges, allowDiagonal);
      if (result != null) return result;
    }
    return null; // 生成失敗
  }

  List<LineSegment>? _tryGenerateLoop(int gridSize, int targetEdges, bool allowDiagonal) {
    final segments = <LineSegment>[];
    final visitedEdges = <LineSegment>{};

    // 開始位置（グリッド中央付近）
    final startX = (gridSize ~/ 2) + random.nextInt(3) - 1;
    final startY = (gridSize ~/ 2) + random.nextInt(3) - 1;
    var current = DotPosition(x: startX.clamp(0, gridSize - 1), y: startY.clamp(0, gridSize - 1));
    final startPos = current;

    // ランダムウォーク
    for (int i = 0; i < targetEdges - 1; i++) {
      // 後半（半分以上進んだら）始点に戻れるようにする
      final allowReturnToStart = i >= targetEdges ~/ 2;

      final nextPos = _findValidNextPosition(
        current,
        startPos,
        gridSize,
        visitedEdges,
        allowReturnToStart: allowReturnToStart,
        allowDiagonal: allowDiagonal,
      );

      if (nextPos == null) break; // 行き詰まり

      final segment = LineSegment(start: current, end: nextPos);
      segments.add(segment);
      visitedEdges.add(segment.normalize());
      current = nextPos;
    }

    // 最後に始点に戻れるかチェック
    if (_canConnectToStart(current, startPos, visitedEdges, allowDiagonal)) {
      segments.add(LineSegment(start: current, end: startPos));

      // 辺数が目標に近い場合は採用（±3の範囲）
      if ((segments.length - targetEdges).abs() <= 3) {
        // 単一閉路かチェック
        if (TopologyUtils.isSimpleSingleCycle(segments)) {
          return segments;
        }
      }
    }

    return null;
  }

  /// 次の有効な位置を探す
  DotPosition? _findValidNextPosition(
    DotPosition current,
    DotPosition startPos,
    int gridSize,
    Set<LineSegment> visitedEdges, {
    bool allowReturnToStart = false,
    bool allowDiagonal = true,
  }) {
    // 4方向（上下左右）
    final directions = [
      DotPosition(x: 0, y: -1), // 上
      DotPosition(x: 1, y: 0), // 右
      DotPosition(x: 0, y: 1), // 下
      DotPosition(x: -1, y: 0), // 左
    ];

    // 斜め線を許可する場合は斜め方向も追加
    if (allowDiagonal) {
      directions.addAll([
        DotPosition(x: 1, y: -1), // 右上
        DotPosition(x: 1, y: 1), // 右下
        DotPosition(x: -1, y: 1), // 左下
        DotPosition(x: -1, y: -1), // 左上
      ]);
    }

    directions.shuffle(random); // ランダム順に試行

    for (final dir in directions) {
      final next = DotPosition(
        x: current.x + dir.x,
        y: current.y + dir.y,
      );

      // グリッド外チェック
      if (next.x < 0 || next.x >= gridSize || next.y < 0 || next.y >= gridSize) {
        continue;
      }

      // 始点への戻りチェック
      if (next == startPos && !allowReturnToStart) {
        continue;
      }

      final segment = LineSegment(start: current, end: next);
      final normalized = segment.normalize();

      // 既存の辺と重複チェック
      if (visitedEdges.contains(normalized)) {
        continue;
      }

      // 交差チェック（既存の辺と交差しないか）
      if (_checkIntersection(segment, visitedEdges)) {
        continue;
      }

      // 次数チェック（各頂点の次数が2を超えないように）
      if (!_checkDegreeConstraint(next, startPos, visitedEdges, allowReturnToStart)) {
        continue;
      }

      return next;
    }

    return null;
  }

  /// 始点に戻れるかチェック（1x1斜め線のみ許可）
  bool _canConnectToStart(
    DotPosition current,
    DotPosition startPos,
    Set<LineSegment> visitedEdges,
    bool allowDiagonal,
  ) {
    if (current == startPos) return false; // すでに始点にいる

    final dx = (startPos.x - current.x).abs();
    final dy = (startPos.y - current.y).abs();

    // 1マス離れていない場合は接続不可
    if (dx > 1 || dy > 1) return false;
    if (dx == 0 && dy == 0) return false;

    // 斜め線禁止の場合は直線のみ許可
    if (!allowDiagonal && dx > 0 && dy > 0) return false;

    final segment = LineSegment(start: current, end: startPos);
    final normalized = segment.normalize();

    // 既存の辺と重複しない、かつ交差しない
    return !visitedEdges.contains(normalized) &&
        !_checkIntersection(segment, visitedEdges);
  }

  /// 線分の交差判定
  bool _checkIntersection(LineSegment newSegment, Set<LineSegment> existingEdges) {
    for (final existing in existingEdges) {
      // 端点を共有する場合は交差とみなさない
      if (newSegment.start == existing.start ||
          newSegment.start == existing.end ||
          newSegment.end == existing.start ||
          newSegment.end == existing.end) {
        continue;
      }

      if (TopologyUtils.segmentsIntersect(newSegment, existing)) {
        return true;
      }
    }
    return false;
  }

  /// 次数制約チェック（各頂点の次数≤2）
  bool _checkDegreeConstraint(
    DotPosition next,
    DotPosition startPos,
    Set<LineSegment> visitedEdges,
    bool allowReturnToStart,
  ) {
    // 始点以外の頂点の次数を計算
    final deg = <DotPosition, int>{};
    for (final e in visitedEdges) {
      deg[e.start] = (deg[e.start] ?? 0) + 1;
      deg[e.end] = (deg[e.end] ?? 0) + 1;
    }

    // 次の頂点が始点の場合
    if (next == startPos) {
      // 始点に戻る場合は、始点の次数が1以下であることが必要
      return allowReturnToStart && (deg[startPos] ?? 0) <= 1;
    }

    // 次の頂点がすでに次数2の場合は追加不可
    return (deg[next] ?? 0) < 2;
  }

  /// 複数の図形を合成（2つの閉路を組み合わせる）
  List<LineSegment>? generateCompositeShapes({
    required int gridSize,
    required int targetEdges,
    bool allowDiagonal = true,
    int maxAttempts = 100,
  }) {
    for (int attempt = 0; attempt < maxAttempts; attempt++) {
      // 小さい閉路を2つ生成
      final edges1 = targetEdges ~/ 2;
      final edges2 = targetEdges - edges1;

      final shape1 = generateLoop(
        gridSize: gridSize,
        targetEdges: edges1,
        maxAttempts: 50,
        allowDiagonal: allowDiagonal,
      );

      final shape2 = generateLoop(
        gridSize: gridSize,
        targetEdges: edges2,
        maxAttempts: 50,
        allowDiagonal: allowDiagonal,
      );

      if (shape1 == null || shape2 == null) continue;

      // 2つの図形が重ならないかチェック
      final points1 = _getAllPoints(shape1);
      final points2 = _getAllPoints(shape2);

      // 共通点がない（離れている）か、共通点が少ない（接している）場合のみ採用
      final common = points1.where((p) => points2.contains(p)).length;
      if (common <= 2) {
        final combined = [...shape1, ...shape2];
        // 重複削除
        final unique = combined.toSet().toList();
        return unique;
      }
    }
    return null;
  }

  /// 線分から全ての頂点を取得
  Set<DotPosition> _getAllPoints(List<LineSegment> segments) {
    final points = <DotPosition>{};
    for (final seg in segments) {
      points.add(seg.start);
      points.add(seg.end);
    }
    return points;
  }
}
