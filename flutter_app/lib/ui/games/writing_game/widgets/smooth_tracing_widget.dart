import 'package:flutter/material.dart';
import '../writing_game_models.dart';
import 'bezier_tracing_system.dart';
import '../data/hiragana_data.dart';
import '../data/hiragana_data_registry.dart';
import '../../../components/drawing/drawing_models.dart';
import 'writing_colors.dart';
import 'dart:math' as math;

/// スムーズベジェカーブベースのトレーシングウィジェット
class SmoothTracingWidget extends StatefulWidget {
  final CharacterData character;
  final Function(Size size) onEndDrawing;
  final Function(int strokeIndex)? onStrokeComplete;
  final Function(double progress)? onProgressChanged;
  final bool showTracing; // オレンジのトレース線を表示するか
  final bool showSilhouette; // 文字のシルエットを表示するか
  final Function(DrawingData)? onDrawingDataChanged; // 描画データ変更時のコールバック
  final double strokeWidth; // ペンの太さ

  const SmoothTracingWidget({
    super.key,
    required this.character,
    required this.onEndDrawing,
    this.onStrokeComplete,
    this.onProgressChanged,
    this.showTracing = true, // デフォルトは表示
    this.showSilhouette = true, // デフォルトは表示
    this.onDrawingDataChanged,
    this.strokeWidth = 12.0, // デフォルトは統一設定
  });

  @override
  State<SmoothTracingWidget> createState() => _SmoothTracingWidgetState();
}

class _SmoothTracingWidgetState extends State<SmoothTracingWidget> {
  List<BezierStroke> _bezierStrokes = [];
  int _currentStrokeIndex = 0;
  double _currentStrokeProgress = 0.0;
  List<double> _strokeProgresses = [];
  bool _isDrawing = false;
  Offset? _lastDrawPosition;
  
  // 共通描画システム用
  DrawingData _drawingData = const DrawingData(paths: [], canvasSize: Size(300, 300));
  List<Offset> _currentPath = [];
  
  // アニメーション用
  late List<double> _maxStrokeProgresses;

  // シンプルな進行度管理
  double _animatedProgress = 0.0;
  bool _hasStartedDrawing = false;

  // デバッグ用フレームカウンター
  int _debugFrameCount = 0;

  // iOS自動完了防止用
  int _touchPointCount = 0;
  DateTime? _firstTouchTime;
  double _totalDistanceMoved = 0.0;
  
  
  @override
  void initState() {
    super.initState();
    
    // ステップ2: データマネージャーのテスト（既存の動作には影響しない）
    _testHiraganaDataManager();
    
    _initializeBezierStrokes();
    
    // 描画データの初期化（デフォルトサイズで初期化）
    _drawingData = const DrawingData(paths: [], canvasSize: Size(400, 400));
  }
  
  /// 新しいデータマネージャーのテスト（デバッグ用）
  void _testHiraganaDataManager() {
    // データを登録
    HiraganaDataRegistry.registerAllCharacters();
    
    // マネージャーのインスタンスを取得
    final manager = HiraganaDataManager();
    
    // データが正しく取得できるかテスト
    final targetChar = widget.character.character;
    if (manager.isSupported(targetChar)) {  // ステップ3: 動的チェックに変更
      print('=== HiraganaDataManager テスト（文字: $targetChar） ===');
      
      // ストロークパスの比較
      final newStrokePaths = manager.getStrokePaths(targetChar);
      print('新システムのストローク数: ${newStrokePaths.length}');
      
      // 輪郭パスの比較
      final newOutlinePaths = manager.getOutlinePaths(targetChar);
      print('新システムの輪郭数: ${newOutlinePaths.length}');
      
      // マッピングの確認
      final mapping = manager.getStrokeToOutlineMapping(targetChar);
      print('新システムのマッピング: $mapping');
      
      print('=========================================');
    }
  }

  void _initializeBezierStrokes([Size? targetSize]) {
    // ステップ5: HiraganaDataManagerから輪郭データとストロークパスを取得
    final manager = HiraganaDataManager();
    manager.initialize(); // データを確実に初期化
    
    List<String> strokePaths;
    
    if (manager.isSupported(widget.character.character)) {
      // 新しいシステムから両方を取得
      _outlinePaths = manager.getOutlinePaths(widget.character.character);
      strokePaths = manager.getStrokePaths(widget.character.character);
      print('ステップ5: ${widget.character.character}の輪郭パス・ストロークパスを新システムから取得');
    } else {
      // サポートされていない文字は従来のシステムを使用
      _outlinePaths = [];
      switch (widget.character.character) {
        case '1':
          strokePaths = [
            "M 200,80 L 200,320",
            "M 120,350 L 280,350",
          ];
          break;
        default:
          strokePaths = [
            "M 100,200 L 300,200",
          ];
      }
    }

    // サイズが指定されていない場合はデフォルト値を使用
    final size = targetSize ?? const Size(400, 400);

    // SVGパスからベジェストロークを生成（スケーリング付き）
    _bezierStrokes = strokePaths
        .map((path) => SmoothPathGenerator.fromSvgPath(path, size))
        .toList();
        
    _strokeProgresses = List.filled(_bezierStrokes.length, 0.0);
    _maxStrokeProgresses = List.filled(_bezierStrokes.length, 0.0);
  }

  void _onPanStart(DragStartDetails details) {
    final localPosition = details.localPosition;
    _isDrawing = true;
    _hasStartedDrawing = true;
    _lastDrawPosition = localPosition;

    // iOS自動完了防止: 実際のユーザー操作を追跡
    _touchPointCount = 1;
    _firstTouchTime = DateTime.now();
    _totalDistanceMoved = 0.0;
    
    // 共通描画システム用：新しいパスを開始
    setState(() {
      _currentPath = [localPosition];
    });
    
    // タッチ開始時のログは削除
    
    // 現在のストロークとの接触確認
    if (_currentStrokeIndex < _bezierStrokes.length) {
      final currentStroke = _bezierStrokes[_currentStrokeIndex];
      
      // ストロークの開始位置にいるかチェック
      final canStart = BezierCollisionDetector.canStartStroke(
        localPosition,
        currentStroke,
      );
      
      if (canStart) {
        // ストローク開始ログは削除
      } else {
        // 既に進行中の位置からの再開も許可
        final isOnStroke = BezierCollisionDetector.isPointOnStroke(
          localPosition,
          currentStroke,
        );
        if (isOnStroke) {
          print('✅ Resumed on current stroke $_currentStrokeIndex');
        } else {
          // print('❌ Started off stroke. Distance too far.');
        }
      }
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (!_isDrawing || _currentStrokeIndex >= _bezierStrokes.length) return;

    final localPosition = details.localPosition;
    final currentStroke = _bezierStrokes[_currentStrokeIndex];
    
    // 共通描画システム用：現在のパスに点を追加
    setState(() {
      _currentPath.add(localPosition);
    });

    // iOS自動完了防止: 移動距離を追跡
    if (_lastDrawPosition != null) {
      _totalDistanceMoved += (localPosition - _lastDrawPosition!).distance;
    }
    _touchPointCount++;
    
    // トレース表示モードの場合のみ進行度を計算・更新
    if (widget.showTracing) {
      // ベジェカーブベースの進行度計算
      final newProgress = BezierCollisionDetector.calculateProgress(
        localPosition,
        currentStroke,
        _currentStrokeProgress,
      );
      
      // 十分な距離を移動した場合のみ更新（ジッター防止）
      if (_lastDrawPosition != null) {
        final distance = (localPosition - _lastDrawPosition!).distance;
        if (distance < 5.0 && newProgress <= _currentStrokeProgress + 0.01) {
          return; // 小さな変化は無視
        }
      }
      
      // 進行度更新（戻らないように制限）
      // 常に前進のみ許可（newProgressが現在の進行度より大きい場合のみ更新）
      if (newProgress > _currentStrokeProgress) {
      _debugFrameCount++;
      
      // セグメント1専用のデバッグ（3画目かつ進行度0.5以上）
      if (_currentStrokeIndex == 2 && newProgress > 0.5 && _debugFrameCount % 50 == 0) {
        final currentStroke = _bezierStrokes[_currentStrokeIndex];
        final arrowPos = currentStroke.getPointAt(newProgress);
        print('    Animated progress: ${_animatedProgress.toStringAsFixed(3)}');
      }
      
      if (_debugFrameCount % 150 == 0) { // 30から150に変更（1/5に減らす）
        print('🎨 Arrow position: ${newProgress.toStringAsFixed(3)}');
        print('    Paint position: ${_animatedProgress.toStringAsFixed(3)}');
      }
      
      setState(() {
        // 現在の進行度より大きい場合のみ更新（戻りを防ぐ）
        _currentStrokeProgress = math.max(_currentStrokeProgress, newProgress);
        _strokeProgresses[_currentStrokeIndex] = _currentStrokeProgress;
        _maxStrokeProgresses[_currentStrokeIndex] = math.max(
          _maxStrokeProgresses[_currentStrokeIndex],
          _currentStrokeProgress,
        );
        // 矢印の位置と正確に同期させる（戻らない）
        _animatedProgress = _currentStrokeProgress;
      });
      
      widget.onProgressChanged?.call(_currentStrokeProgress);
    }
    }
    
    _lastDrawPosition = localPosition;
  }

  void _onPanEnd(DragEndDetails details) {
    _isDrawing = false;
    _lastDrawPosition = null;
    
    // 共通描画システム用：完成したパスを追加
    if (_currentPath.isNotEmpty) {
      final path = DrawingPath(
        points: List.from(_currentPath),
        color: Colors.black,
        strokeWidth: widget.strokeWidth,
        timestamp: DateTime.now(),
      );
      
      setState(() {
        _drawingData = _drawingData.addPath(path);
        _currentPath.clear();
      });

      // 描画データを親ウィジェットに通知
      // print('📝 Adding path to drawing data. Total paths: ${_drawingData.paths.length}');
      widget.onDrawingDataChanged?.call(_drawingData);
    }
    
    // パン終了時のログは削除
    
    // ストローク完了判定（90%以上で完了とみなす）
    // print('📊 Pan end: hasStarted=$_hasStartedDrawing, progress=${_currentStrokeProgress.toStringAsFixed(3)}, stroke=$_currentStrokeIndex/${_bezierStrokes.length}');

    // iOS自動完了防止: 実際のユーザー操作を検証
    final currentTime = DateTime.now();
    final touchDuration = _firstTouchTime != null
        ? currentTime.difference(_firstTouchTime!).inMilliseconds
        : 0;

    final hasValidUserInput = _touchPointCount >= 3 && // 最低3ポイントの入力
                             _totalDistanceMoved >= 30.0 && // 最低30ピクセルの移動
                             touchDuration >= 100; // 最低100ms の操作時間

    // print('🔍 Touch validation: points=$_touchPointCount, distance=${_totalDistanceMoved.toStringAsFixed(1)}, duration=${touchDuration}ms, valid=$hasValidUserInput');
    // print('🔍 Stroke info: strokes=${_bezierStrokes.length}, showTracing=${widget.showTracing}, progress=${_currentStrokeProgress.toStringAsFixed(3)}');

    // 特別ケース：ストロークが0の場合（じゆうがき等で未対応文字）
    if (_bezierStrokes.isEmpty) {
      print('⚠️ No strokes defined for this character - skipping auto-completion');
      return;
    }

    if (_hasStartedDrawing && _currentStrokeProgress >= 0.90 && hasValidUserInput) {
      widget.onStrokeComplete?.call(_currentStrokeIndex);

      // 次のストロークに進む（最後のストローク以外）
      // 「あ」もそれ以外も_bezierStrokesの数がストローク数
      final maxStrokes = _bezierStrokes.length;

      if (_currentStrokeIndex < maxStrokes - 1) {
        print('🔄 Moving to next stroke: $_currentStrokeIndex → ${_currentStrokeIndex + 1}');
        setState(() {
          _currentStrokeIndex++;
          _currentStrokeProgress = 0.0;
          _animatedProgress = 0.0; // アニメーションもリセット
          _hasStartedDrawing = false; // 新しいストロークのため描画フラグもリセット
          // iOS自動完了防止: 新しいストローク用にリセット
          _touchPointCount = 0;
          _firstTouchTime = null;
          _totalDistanceMoved = 0.0;
        });
      } else {
        // 最後のストロークが完了した場合のみゲームロジックに完了通知
        print('✅ All strokes completed for character: ${widget.character.character}');
        final size = _lastSize ?? const Size(400, 400);

        // 描画データをコールバックで通知（じゆうがき用）
        // 完了時は蓄積された全ての描画データを送信
        print('✅ Sending accumulated drawing data to recognition: ${_drawingData.paths.length} paths');
        widget.onDrawingDataChanged?.call(_drawingData);

        widget.onEndDrawing(size);
      }
    } else {
      // print('❌ Stroke completion failed: hasStarted=$_hasStartedDrawing, progress=${_currentStrokeProgress.toStringAsFixed(3)} (need >= 0.90), validInput=$hasValidUserInput');
    }
  }

  // サイズ変更により再初期化が必要かチェック
  Size? _lastSize;
  List<String> _outlinePaths = []; // AnimCJK輪郭パスを保存
  bool _needsReinitialize(Size newSize) {
    if (_lastSize == null) {
      _lastSize = newSize;
      return true;
    }
    
    final sizeChanged = (_lastSize!.width - newSize.width).abs() > 1.0 ||
                       (_lastSize!.height - newSize.height).abs() > 1.0;
    
    if (sizeChanged) {
      _lastSize = newSize;
      return true;
    }
    
    return false;
  }

  
  /// ストロークインデックスから対応する輪郭パスのインデックス範囲を取得
  List<int> _getOutlineIndicesForStroke(String character, int strokeIndex) {
    // ステップ6: HiraganaDataManagerから取得を試みる
    final manager = HiraganaDataManager();
    if (manager.isSupported(character)) {
      final mapping = manager.getStrokeToOutlineMapping(character);
      return mapping[strokeIndex] ?? [];
    }
    // フォールバック: 空のリスト（新システムがサポートしていない文字の場合）
    return [];
  }
  
  
  /// ストロークと輪郭の分割比率を取得
  List<double> _getSegmentRatios(String character, int strokeIndex) {
    // ステップ6: HiraganaDataManagerから取得を試みる
    final manager = HiraganaDataManager();
    if (manager.isSupported(character)) {
      final ratios = manager.getSegmentRatios(character);
      return ratios[strokeIndex] ?? [1.0];
    }
    // フォールバック: デフォルト値
    return [1.0];
  }
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        
        // サイズが確定したらベジェストロークを再初期化（スケーリング適用）
        if (_bezierStrokes.isEmpty || _needsReinitialize(size)) {
          // フレーム内で直接実行（setState不要）
          _initializeBezierStrokes(size);
        }
        
        return GestureDetector(
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                // 従来の描画方式の場合のみ完了済み・未完了ストロークを表示
                // 完了済みストロークと未完了ストロークの描画を無効化
                
                // AnimCJK輪郭データを使った書道スタイル描画（対応文字の場合）
                // ステップ3: HiraganaDataManagerで動的にチェック
                if (widget.showSilhouette && HiraganaDataManager().isSupported(widget.character.character) && _outlinePaths.isNotEmpty)
                  CustomPaint(
                    painter: CalligraphyTracingPainter(
                      outlinePaths: _outlinePaths,
                      progress: _animatedProgress,
                      currentStrokeIndex: _currentStrokeIndex,
                      fillColor: WritingColors.characterFill,
                      backgroundColor: WritingColors.characterBackground,
                      character: widget.character.character,
                      getOutlineIndicesForStroke: _getOutlineIndicesForStroke,
                      getSegmentRatios: _getSegmentRatios,
                      arrowPosition: widget.showTracing && _currentStrokeIndex < _bezierStrokes.length 
                        ? _bezierStrokes[_currentStrokeIndex].getPointAt(_currentStrokeProgress)
                        : null,
                    ),
                    size: size,
                  ),
                // その他の文字の従来描画方式も無効化
                
                // ユーザーの描画データを表示（リアルタイム描画）
                CustomPaint(
                  painter: UserDrawingPainter(
                    drawingData: _drawingData,
                    currentPath: _currentPath,
                    strokeWidth: widget.strokeWidth,
                  ),
                  size: size,
                ),
                
                // 進行方向を示す矢印（トレース表示時のみ）
                if (widget.showTracing && _currentStrokeIndex < _bezierStrokes.length)
                  CustomPaint(
                    painter: ProgressArrowPainter(
                      stroke: _bezierStrokes[_currentStrokeIndex],
                      progress: _currentStrokeProgress,
                      arrowColor: WritingColors.arrow,
                    ),
                    size: size,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  
  @override
  void dispose() {
    super.dispose();
  }
}

/// ユーザーの描画を表示するペインター
class UserDrawingPainter extends CustomPainter {
  final DrawingData drawingData;
  final List<Offset> currentPath;
  final double strokeWidth;

  UserDrawingPainter({
    required this.drawingData,
    this.currentPath = const [],
    this.strokeWidth = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 完成した描画パスを描画
    for (final path in drawingData.paths) {
      _drawPath(canvas, path);
    }
    
    // 現在描画中のパスを描画（リアルタイム）
    if (currentPath.isNotEmpty) {
      _drawCurrentPath(canvas, currentPath);
    }
  }

  void _drawPath(Canvas canvas, DrawingPath drawingPath) {
    if (drawingPath.points.isEmpty) return;

    final paint = Paint()
      ..color = drawingPath.color
      ..strokeWidth = drawingPath.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    if (drawingPath.points.length == 1) {
      // 単一点の場合は円を描画
      canvas.drawCircle(
        drawingPath.points.first,
        drawingPath.strokeWidth / 2,
        paint..style = PaintingStyle.fill,
      );
    } else {
      // 複数点の場合はパスを描画
      final path = Path();
      path.moveTo(drawingPath.points.first.dx, drawingPath.points.first.dy);

      for (int i = 1; i < drawingPath.points.length; i++) {
        path.lineTo(drawingPath.points[i].dx, drawingPath.points[i].dy);
      }

      canvas.drawPath(path, paint);
    }
  }

  /// 現在描画中のパスを描画（リアルタイム表示用）
  void _drawCurrentPath(Canvas canvas, List<Offset> points) {
    if (points.isEmpty) return;

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    if (points.length == 1) {
      // 単一点の場合は円を描画
      canvas.drawCircle(
        points.first,
        strokeWidth / 2,
        paint..style = PaintingStyle.fill,
      );
    } else {
      // 複数点の場合はパスを描画
      final path = Path();
      path.moveTo(points.first.dx, points.first.dy);

      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(UserDrawingPainter oldDelegate) {
    return oldDelegate.drawingData != drawingData ||
           oldDelegate.currentPath != currentPath;
  }
}

/// 複数ストローク用のペインター
class MultiStrokePainter extends CustomPainter {
  final List<BezierStroke> strokes;
  final List<double> progresses;
  final Color strokeColor;
  final Color backgroundColor;
  final double strokeWidth;

  MultiStrokePainter({
    required this.strokes,
    required this.progresses,
    required this.strokeColor,
    required this.backgroundColor,
    this.strokeWidth = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < strokes.length && i < progresses.length; i++) {
      final painter = SmoothTracingPainter(
        stroke: strokes[i],
        progress: progresses[i],
        strokeColor: strokeColor,
        backgroundColor: backgroundColor,
        strokeWidth: strokeWidth,
      );
      painter.paint(canvas, size);
    }
  }

  @override
  bool shouldRepaint(MultiStrokePainter oldDelegate) {
    return strokes != oldDelegate.strokes ||
           progresses != oldDelegate.progresses ||
           strokeColor != oldDelegate.strokeColor ||
           backgroundColor != oldDelegate.backgroundColor;
  }
}

/// 進行矢印ペインター（旧モード互換）
class ProgressArrowPainter extends CustomPainter {
  final BezierStroke stroke;
  final double progress;
  final Color arrowColor;
  final double arrowSize;
  
  // デバッグ用フレームカウンター
  static int _debugFrameCount = 0;

  ProgressArrowPainter({
    required this.stroke,
    required this.progress,
    required this.arrowColor,
    this.arrowSize = 20.0, // 旧モードと同じ円のサイズ
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress >= 1.0 || stroke.segments.isEmpty) return;

    // 矢印の実座標を計算してデバッグ出力
    final currentT = progress;
    final currentPoint = stroke.getPointAt(currentT);
    
    _debugFrameCount++;
    if (_debugFrameCount % 150 == 0) { // 30から150に変更
      print('🧡 Arrow pos: (${currentPoint.dx.toInt()}, ${currentPoint.dy.toInt()}) at progress=${progress.toStringAsFixed(3)}');
    }
    final nextT = math.min(1.0, currentT + 0.02);
    final nextPoint = stroke.getPointAt(nextT);
    
    // 方向ベクトルを計算
    final direction = nextPoint - currentPoint;
    if (direction.distance < 0.1) return;
    
    final normalizedDirection = direction / direction.distance;
    final directionAngle = math.atan2(normalizedDirection.dy, normalizedDirection.dx);
    
    // 旧モードと同じ丸いオレンジ背景に黒い矢印
    _drawCircularArrow(canvas, currentPoint, directionAngle);
  }
  
  /// 旧モードと同じ丸い矢印を描画
  void _drawCircularArrow(Canvas canvas, Offset position, double angle) {
    final circleRadius = arrowSize;
    
    // オレンジ円
    final fillPaint = Paint()
      ..color = Colors.orange.shade600
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(position, circleRadius, fillPaint);
    
    // 白い縁取り
    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;
    
    canvas.drawCircle(position, circleRadius, borderPaint);
    
    // 黒矢印（進行方向を向くように修正）
    final arrowLength = 10.0;
    
    // 矢印の先端（進行方向）
    final arrowTip = Offset(
      position.dx + arrowLength * math.cos(angle),
      position.dy + arrowLength * math.sin(angle),
    );
    
    // 矢印の両翼（先端から後ろ向きに描画）
    final arrowWing1 = Offset(
      arrowTip.dx - arrowLength * 0.7 * math.cos(angle - 0.5),
      arrowTip.dy - arrowLength * 0.7 * math.sin(angle - 0.5),
    );
    final arrowWing2 = Offset(
      arrowTip.dx - arrowLength * 0.7 * math.cos(angle + 0.5),
      arrowTip.dy - arrowLength * 0.7 * math.sin(angle + 0.5),
    );
    
    final arrowPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    
    // 矢印を描画：先端から両翼へ
    canvas.drawLine(arrowTip, arrowWing1, arrowPaint);
    canvas.drawLine(arrowTip, arrowWing2, arrowPaint);
  }

  @override
  bool shouldRepaint(ProgressArrowPainter oldDelegate) {
    return progress != oldDelegate.progress ||
           arrowColor != oldDelegate.arrowColor;
  }
}