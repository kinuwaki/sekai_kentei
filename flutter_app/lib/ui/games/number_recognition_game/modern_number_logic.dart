import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/drawing/drawing_models.dart';
import '../../../services/character_recognition_service.dart';
import '../../../services/character_recognition_service_native.dart' as native;
import '../../../services/instant_feedback_service.dart';
import '../../../core/debug_logger.dart';
import 'models/number_models.dart';
import '../base/common_game_phase.dart';
import 'number_character_judge.dart';
import '../writing_game/writing_game_models.dart';

/// 新しい状態マシンベースの数字認識ゲームロジック
class ModernNumberLogic extends StateNotifier<NumberState> {
  ModernNumberLogic({int total = 3})
      : super(NumberState(
          phase: CommonGamePhase.ready,
          session: NumberSession(
            index: 0,
            total: total,
            current: _generateProblem(0),
          ),
          drawing: DrawingData(paths: const [], canvasSize: const Size(300, 200)),
        )) {
    _enterDrawing(); // 初手で drawing に入る
  }

  // ---- BaseGameScreen用の互換インターフェース ----
  String? get questionText => state.questionText;
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;
  
  // ---- 互換アダプタ用のパブリック状態アクセス ----
  NumberState get currentState => state;
  
  // ---- 旧インターフェース互換（段階的移行用）----
  bool get isProcessing => state.isProcessing;
  DrawingData get drawingData => state.drawing;
  bool get showSuccessEffect => state.showSuccessEffect;
  bool get hadWrongAnswer => state.showWrongEffect;
  
  // ---- 入力系（手書き/テンキー）----
  void addDrawingPath(DrawingPath path) {
    if (!state.canDraw) return;
    state = state.copyWith(drawing: state.drawing.addPath(path));
  }

  void clearDrawing() {
    state = state.copyWith(drawing: state.drawing.clear());
  }

  void setCanvasSize(Size size) {
    state = state.copyWith(
      drawing: DrawingData(paths: state.drawing.paths, canvasSize: size),
    );
  }

  Future<void> recognizeHandwriting() async {
    if (!state.canDraw || state.drawing.isEmpty) return;
    final recognizedNumber = await _runRecognizer(state.drawing, state.session.current.correct);
    await _submitAnswer(recognizedNumber);
  }

  Future<void> inputNumber(int number) async {
    if (!state.canInput) return;
    await _submitAnswer(number);
  }

  // ---- 内部：認識・判定・演出・自動進行 ----
  Future<void> _submitAnswer(int recognizedNumber) async {
    // フェーズ遷移：recognizing
    final snap = state;                   // 問題スナップショット
    final epoch = state.epoch + 1;        // 競合排除トークン
    state = state.copyWith(phase: CommonGamePhase.processing, epoch: epoch);

    final correct = recognizedNumber == snap.session.current.correct;
    final result = AnswerResult(
      recognizedNumber: recognizedNumber,
      isCorrect: correct,
      correctAnswer: snap.session.current.correct,
    );
    
    if (correct) {
      // 正解時の演出
      state = state.copyWith(
        phase: CommonGamePhase.feedbackOk,
        lastResult: result,
      );

      // フィードバック待機（演出時間）
      await Future.delayed(const Duration(milliseconds: 1500));

      // 競合ガード：古い非同期待ちが戻ってきたら捨てる
      if (state.epoch != epoch) return;

      await _autoAdvance();
    } else {
      // 間違い時 → 即座にブザー音を鳴らしてキャンバスをクリア
      state = state.copyWith(
        phase: CommonGamePhase.feedbackNg,
        lastResult: result,
      );

      try {
        final feedbackService = InstantFeedbackService();
        feedbackService.playWrongAnswerFeedback(); // awaitを削除して非同期で実行
      } catch (e) {
        Log.e('フィードバック音声エラー: $e', tag: 'ModernNumberLogic');
      }

      // 即座にキャンバスをクリアして描画に戻す
      state = state.copyWith(
        phase: CommonGamePhase.questioning,
        drawing: DrawingData(paths: const [], canvasSize: state.drawing.canvasSize),
      );
    }
  }

  Future<void> _autoAdvance() async {
    state = state.copyWith(phase: CommonGamePhase.transitioning);
    await Future.delayed(const Duration(milliseconds: 350));

    if (state.session.isLast) {
      state = state.copyWith(phase: CommonGamePhase.completed);
    } else {
      final nextProblem = _generateProblem(state.session.index + 1);
      state = state.copyWith(
        session: state.session.next(nextProblem),
        drawing: DrawingData(paths: const [], canvasSize: state.drawing.canvasSize),
      );
      _enterDrawing(); // questionText が変わる → Base が読み上げ
    }
  }

  void _enterDrawing() {
    state = state.copyWith(phase: CommonGamePhase.questioning);
  }

  // ---- BaseGameScreen互換メソッド（段階的移行用）----
  void startGame(dynamic settings) {
    // 新しい問題セットで再開始
    final problemCount = (settings is Map && settings.containsKey('problemCount')) 
        ? settings['problemCount'] as int 
        : 3;
        
    state = NumberState(
      phase: CommonGamePhase.ready,
      session: NumberSession(
        index: 0,
        total: problemCount,
        current: _generateProblem(0),
      ),
      drawing: DrawingData(paths: const [], canvasSize: const Size(300, 200)),
    );
    _enterDrawing();
  }

  void resetGame() {
    // 状態を初期化（ゲームを再開始しない）
    state = NumberState(
      phase: CommonGamePhase.ready,
      session: NumberSession(
        index: 0,
        total: 3,
        current: _generateProblem(0),
      ),
      drawing: DrawingData(paths: const [], canvasSize: const Size(300, 200)),
    );
  }

  void hideSuccessEffect() {
    // 新しい状態マシンでは不要（フェーズ遷移で自動管理）
    // ただし、旧UIとの互換性のため空実装を提供
  }

  // ---- ヘルパーメソッド ----
  
  /// 問題生成（既存ロジックを流用）
  static NumberProblem _generateProblem(int index) {
    final baseNumber = 3 + (index % 7) + 1; // 4-10の範囲
    final difference = 3;
    final correctAnswer = baseNumber - difference; // 1-7の範囲
    final prompt = '${baseNumber}より${difference}つ\nちいさいかずをかきましょう';
    
    return NumberProblem(
      correct: correctAnswer,
      prompt: prompt,
    );
  }

  /// 手書き認識（ストロークベース判定）
  Future<int> _runRecognizer(DrawingData drawing, int targetNumber) async {
    try {
      Log.d('手書き認識開始: パス数=${drawing.paths.length}, キャンバスサイズ=${drawing.canvasSize}', tag: 'ModernNumberLogic');
      if (drawing.paths.isEmpty) {
        Log.e('描画パスが空です', tag: 'ModernNumberLogic');
        throw Exception('No drawing data');
      }

      // パスの詳細をログ出力
      for (int i = 0; i < drawing.paths.length; i++) {
        final path = drawing.paths[i];
        Log.d('パス$i: ポイント数=${path.points.length}', tag: 'ModernNumberLogic');
      }

      // ストロークデータに変換して認識
      final strokeData = _convertDrawingToStrokes(drawing);
      Log.d('ストロークデータ数: ${strokeData.length}', tag: 'ModernNumberLogic');
      return await _recognizeNumberFromStrokes(strokeData, targetNumber);
    } catch (e) {
      Log.e('手書き認識エラー: $e', tag: 'ModernNumberLogic');
      // 認識失敗時はランダムな間違い（テスト用）
      return math.Random().nextInt(10);
    }
  }

  /// 描画データを画像に変換（文字練習と同じ実装）
  Future<Uint8List> _convertDrawingToImage(DrawingData drawing) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = drawing.canvasSize;

    Log.d('画像変換開始: キャンバスサイズ=${size.width}x${size.height}', tag: 'ModernNumberLogic');

    // 白背景
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.white,
    );

    // パスを描画
    for (final path in drawing.paths) {
      if (path.points.isEmpty) continue;

      final paint = Paint()
        ..color = Colors.black // 固定色で描画
        ..strokeWidth = math.max(path.strokeWidth, 4.0) // 最小4px
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final uiPath = Path();
      uiPath.moveTo(path.points.first.dx, path.points.first.dy);
      for (int i = 1; i < path.points.length; i++) {
        uiPath.lineTo(path.points[i].dx, path.points[i].dy);
      }
      canvas.drawPath(uiPath, paint);
    }

    // 固定サイズで画像生成
    final imageSize = 300;
    final picture = recorder.endRecording();
    final img = await picture.toImage(imageSize, imageSize);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    picture.dispose();
    img.dispose();

    final result = byteData?.buffer.asUint8List() ?? Uint8List(0);
    Log.d('画像変換完了: ${result.length}バイト', tag: 'ModernNumberLogic');
    return result;
  }

  /// 描画データをストロークデータに変換
  List<List<Offset>> _convertDrawingToStrokes(DrawingData drawing) {
    return drawing.paths.map((path) => path.points).toList();
  }

  /// 数字認識（ストロークベース判定）
  Future<int> _recognizeNumberFromStrokes(List<List<Offset>> strokeData, int targetNumber) async {
    try {
      final recognitionService = getRecognizer();

      // AndroidCharacterRecognizerのrecognizeStrokesメソッドを使用
      late RecognitionResult result;

      if (recognitionService is native.AndroidCharacterRecognizer) {
        result = await (recognitionService as native.AndroidCharacterRecognizer).recognizeStrokes(
          strokeData,
          type: RecognitionType.numbers,
        );
      } else {
        // 他のプラットフォーム用のフォールバック
        final imageData = await _convertDrawingToImage(DrawingData(
          paths: strokeData.map((stroke) => DrawingPath(
            points: stroke,
            color: Colors.black,
            strokeWidth: 4.0,
          )).toList(),
          canvasSize: state.drawing.canvasSize,
        ));
        result = await recognitionService.recognize(
          imageData,
          type: RecognitionType.numbers,
        );
      }

      Log.d('数字認識結果取得: ${result.candidates.length}個の候補', tag: 'ModernNumberLogic');

      // 候補ベース判定を実行
      final judgment = NumberCharacterJudge.judge(
        targetNumber: targetNumber,
        result: result,
      );

      Log.d('数字判定結果: $judgment', tag: 'ModernNumberLogic');

      if (judgment.isAccepted) {
        Log.d('数字認識成功: 目標数字 $targetNumber が候補リストに含まれていました (ランク: ${judgment.targetRank})', tag: 'ModernNumberLogic');
        return targetNumber;
      } else {
        Log.d('数字認識失敗: 目標数字 $targetNumber が候補リストに含まれていませんでした', tag: 'ModernNumberLogic');
        // 判定失敗時は最も信頼度の高い候補を返す（従来の動作を維持）
        if (judgment.numberRanking.isNotEmpty) {
          final bestCandidate = judgment.numberRanking.first.number;
          final bestNumber = int.tryParse(bestCandidate);
          if (bestNumber != null && bestNumber >= 0 && bestNumber <= 9) {
            return bestNumber;
          }
        }
        throw Exception('No valid number candidates found');
      }
    } catch (e) {
      Log.e('数字認識処理エラー: $e', tag: 'ModernNumberLogic');
      rethrow;
    }
  }
}

/// 新しいロジック用のプロバイダー
final modernNumberLogicProvider = StateNotifierProvider.autoDispose<ModernNumberLogic, NumberState>((ref) {
  return ModernNumberLogic(total: 3);
});