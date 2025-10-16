import 'models/dot_copy_models.dart';

/// D4変換関数型
typedef _XY = DotPosition Function(int x, int y);

/// トポロジー判定ユーティリティ
/// 図形の形状を平行移動・回転・鏡映不変で比較
class TopologyUtils {
  /// 単一閉路（全頂点の次数=2、自己交差なし）かチェック
  static bool isSimpleSingleCycle(List<LineSegment> segs) {
    if (segs.isEmpty) return false;

    // 1) 端点次数を集計（全頂点の次数=2）
    final deg = <DotPosition, int>{};
    for (final s in segs) {
      final n = s.normalize();
      deg[n.start] = (deg[n.start] ?? 0) + 1;
      deg[n.end] = (deg[n.end] ?? 0) + 1;
    }
    if (deg.values.any((d) => d != 2)) return false;

    // 2) 自己交差なし（端点共有はOK）
    final set = segs.map((e) => e.normalize()).toSet();
    if (set.length != segs.length) return false; // 重複辺禁止

    for (final a in set) {
      for (final b in set) {
        if (identical(a, b)) continue;
        // 端点共有ならOK
        final share = a.start == b.start ||
            a.start == b.end ||
            a.end == b.start ||
            a.end == b.end;
        if (share) continue;
        if (segmentsIntersect(a, b)) return false;
      }
    }

    // 3) 連結性（エッジ数=頂点数、次数=2なら一周の閉路）
    final adj = <DotPosition, List<DotPosition>>{};
    for (final e in set) {
      adj.putIfAbsent(e.start, () => []).add(e.end);
      adj.putIfAbsent(e.end, () => []).add(e.start);
    }
    final start = adj.keys.first;
    final visited = <DotPosition>{};
    final stack = [start];
    while (stack.isNotEmpty) {
      final v = stack.removeLast();
      if (!visited.add(v)) continue;
      for (final w in adj[v] ?? const []) {
        if (!visited.contains(w)) stack.add(w);
      }
    }
    return visited.length == adj.length;
  }

  /// 線分交差判定（CCW法）
  static int _orientation(DotPosition p, DotPosition q, DotPosition r) {
    final vx1 = q.x - p.x, vy1 = q.y - p.y;
    final vx2 = r.x - q.x, vy2 = r.y - q.y;
    final cross = vx1 * vy2 - vy1 * vx2;
    return cross == 0 ? 0 : (cross > 0 ? 1 : -1);
  }

  static bool _onSegment(DotPosition p, DotPosition q, DotPosition r) =>
      q.x >= (p.x < r.x ? p.x : r.x) &&
      q.x <= (p.x > r.x ? p.x : r.x) &&
      q.y >= (p.y < r.y ? p.y : r.y) &&
      q.y <= (p.y > r.y ? p.y : r.y);

  static bool segmentsIntersect(LineSegment a, LineSegment b) {
    final p1 = a.start, q1 = a.end, p2 = b.start, q2 = b.end;
    final o1 = _orientation(p1, q1, p2);
    final o2 = _orientation(p1, q1, q2);
    final o3 = _orientation(p2, q2, p1);
    final o4 = _orientation(p2, q2, q1);
    if (o1 != o2 && o3 != o4) return true;
    if (o1 == 0 && _onSegment(p1, p2, q1)) return true;
    if (o2 == 0 && _onSegment(p1, q2, q1)) return true;
    if (o3 == 0 && _onSegment(p2, p1, q2)) return true;
    if (o4 == 0 && _onSegment(p2, q1, q2)) return true;
    return false;
  }

  /// D4変換（回転90°刻み＋鏡映）
  static final List<_XY> _transformsWithMirror = [
    (x, y) => DotPosition(x: x, y: y), // id
    (x, y) => DotPosition(x: y, y: -x), // rot90
    (x, y) => DotPosition(x: -x, y: -y), // rot180
    (x, y) => DotPosition(x: -y, y: x), // rot270
    (x, y) => DotPosition(x: -x, y: y), // mirror X
    (x, y) => DotPosition(x: y, y: x), // mirror diag y=x
    (x, y) => DotPosition(x: x, y: -y), // mirror Y
    (x, y) => DotPosition(x: -y, y: -x), // mirror diag y=-x
  ];

  static final List<_XY> _transformsNoMirror = [
    (x, y) => DotPosition(x: x, y: y), // id
    (x, y) => DotPosition(x: y, y: -x), // rot90
    (x, y) => DotPosition(x: -x, y: -y), // rot180
    (x, y) => DotPosition(x: -y, y: x), // rot270
  ];

  /// カノニカル署名（最小辞書順の文字列表現）
  static String canonicalSignature(
    List<LineSegment> segs, {
    bool allowMirror = true,
  }) {
    if (segs.isEmpty) return "Ø";

    final transforms =
        allowMirror ? _transformsWithMirror : _transformsNoMirror;
    String? best;

    for (final t in transforms) {
      // 1) 変換
      final transformed = segs.map((e) {
        final a = t(e.start.x, e.start.y);
        final b = t(e.end.x, e.end.y);
        return LineSegment(start: a, end: b).normalize();
      }).toList();

      // 2) 平行移動基準化（全点のmin x,yを原点に寄せる）
      int minX = 1 << 30, minY = 1 << 30;
      for (final e in transformed) {
        minX = [minX, e.start.x, e.end.x].reduce((a, b) => a < b ? a : b);
        minY = [minY, e.start.y, e.end.y].reduce((a, b) => a < b ? a : b);
      }
      final shifted = transformed.map((e) {
        final s = DotPosition(x: e.start.x - minX, y: e.start.y - minY);
        final d = DotPosition(x: e.end.x - minX, y: e.end.y - minY);
        return LineSegment(start: s, end: d).normalize();
      }).toList();

      // 3) 重複除去＋ソート
      final uniq = shifted.toSet().toList()
        ..sort((a, b) {
          final c = a.start.x.compareTo(b.start.x);
          if (c != 0) return c;
          final d = a.start.y.compareTo(b.start.y);
          if (d != 0) return d;
          final e = a.end.x.compareTo(b.end.x);
          if (e != 0) return e;
          return a.end.y.compareTo(b.end.y);
        });

      // 4) シリアライズ
      final sig = uniq
          .map((e) => "${e.start.x},${e.start.y}-${e.end.x},${e.end.y}")
          .join("|");

      // 5) 最小辞書順を代表に
      if (best == null || sig.compareTo(best) < 0) best = sig;
    }

    return best!;
  }

  /// トポロジー的に等価か判定（平行移動・回転・鏡映不変）
  static bool isTopologicallyEqual({
    required List<LineSegment> answer,
    required List<LineSegment> user,
    bool allowMirror = true,
  }) {
    // 事前に単一閉路性を強制
    if (!isSimpleSingleCycle(answer)) return false;
    if (!isSimpleSingleCycle(user)) return false;

    final aSig = canonicalSignature(answer, allowMirror: allowMirror);
    final uSig = canonicalSignature(user, allowMirror: allowMirror);
    return aSig == uSig;
  }
}
