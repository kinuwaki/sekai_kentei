import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/debug_logger.dart';
import '../../../services/instant_feedback_service.dart';
import '../base/common_game_phase.dart';
import 'models/puzzle_game_models.dart';

/// パズルゲームロジック
class ModernPuzzleGameLogic extends StateNotifier<PuzzleGameState> {
  static const String _tag = 'PuzzleGameLogic';
  static const String _imageBasePath = 'assets/images/figures/puzzle/';
  
  final InstantFeedbackService _feedbackService = InstantFeedbackService();
  List<int> _selectedImageIndices = []; // ランダムに選択された画像インデックス

  ModernPuzzleGameLogic() : super(const PuzzleGameState());

  // BaseGameScreen互換プロパティ
  String? get questionText => state.questionText;
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  /// ゲーム開始
  void startGame(PuzzleGameSettings settings) {
    Log.d('[$_tag] ゲーム開始: ${settings.displayName}', tag: _tag);
    
    state = state.copyWith(
      phase: CommonGamePhase.displaying,
      settings: settings,
      epoch: state.epoch + 1,
    );

    _loadImagesAndStart();
  }

  /// 画像の事前読み込み
  Future<void> _loadImagesAndStart() async {
    final settings = state.settings;
    if (settings == null) return;

    try {
      // 最初にランダムに3つのインデックスを選択
      final totalImageCount = 12;
      final allIndices = List.generate(totalImageCount, (i) => i);
      allIndices.shuffle(Random(DateTime.now().millisecondsSinceEpoch));
      _selectedImageIndices = allIndices.take(3).toList();
      
      Log.d('[$_tag] Selected random images: $_selectedImageIndices', tag: _tag);

      // 選択された3枚のみ読み込み
      final images = <ui.Image?>[];
      for (final index in _selectedImageIndices) {
        final imagePath = '${_imageBasePath}${index.toString().padLeft(4, '0')}.jpg';
        Log.d('[$_tag] Loading image: $imagePath', tag: _tag);
        
        try {
          final data = await rootBundle.load(imagePath);
          final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
          final frame = await codec.getNextFrame();
          images.add(frame.image);
          Log.d('[$_tag] Image loaded successfully: $imagePath (${frame.image.width}x${frame.image.height})', tag: _tag);
        } catch (e) {
          Log.e('[$_tag] Failed to load image: $imagePath - $e', tag: _tag);
          images.add(null);
        }
      }

      final loadedCount = images.where((img) => img != null).length;
      Log.d('[$_tag] Loaded $loadedCount/3 selected images', tag: _tag);

      if (loadedCount == 0) {
        state = state.copyWith(
          phase: CommonGamePhase.ready,
          errorMessage: '画像を読み込めませんでした（0/3）',
        );
        return;
      }

      // セッション初期化
      final session = PuzzleGameSession(
        index: 0,
        total: settings.questionCount,
        results: List.filled(settings.questionCount, null),
      );

      state = state.copyWith(
        phase: CommonGamePhase.displaying,
        preloadedImages: images,
        session: session,
      );

      // 最初の問題を生成
      _generateNextProblem();
      
    } catch (e) {
      Log.e('[$_tag] Error loading images: $e', tag: _tag);
      state = state.copyWith(
        phase: CommonGamePhase.ready,
        errorMessage: '画像の読み込みに失敗しました',
      );
    }
  }

  /// 問題生成
  void _generateNextProblem() {
    final session = state.session;
    if (session == null) return;

    // 現在の問題のインデックス
    final currentQuestionIndex = session.index % state.preloadedImages.length;
    final image = state.preloadedImages[currentQuestionIndex];
    
    if (image == null) {
      Log.e('[$_tag] Image not found for question index: $currentQuestionIndex', tag: _tag);
      _proceedToNext(false);
      return;
    }

    // 元の画像インデックス（0000-0011の範囲）を取得
    final originalImageIndex = _selectedImageIndices[currentQuestionIndex];
    
    // 3つのピースを作成
    final pieces = _generatePuzzlePieces(originalImageIndex);
    
    // 問題を作成
    final problem = PuzzleProblem(
      imagePath: '${_imageBasePath}${originalImageIndex.toString().padLeft(4, '0')}.jpg',
      imageIndex: originalImageIndex,
      pieces: pieces,
      fullImage: image,
    );

    state = state.copyWith(
      phase: CommonGamePhase.displaying, // フェーズを displaying に設定
      session: session.copyWith(
        currentProblem: problem,
        selectedPieceIndices: [],
        questionStartTime: DateTime.now(),
      ),
    );

    // 問題表示後、操作可能状態へ
    Future.delayed(const Duration(milliseconds: 500), () {
      if (state.phase == CommonGamePhase.displaying) {
        state = state.copyWith(phase: CommonGamePhase.questioning);
      }
    });
  }

  /// パズルピース生成（シャッフル込み）
  List<PuzzlePiece> _generatePuzzlePieces(int imageIndex) {
    final random = Random(DateTime.now().millisecondsSinceEpoch);
    
    // 3つのピースを作成
    final pieces = [
      PuzzlePiece(
        type: PuzzlePieceType.top,
        imageIndex: imageIndex,
        uvRect: PuzzlePiece.getUvRect(PuzzlePieceType.top),
        gridPosition: 0,
      ),
      PuzzlePiece(
        type: PuzzlePieceType.bottom,
        imageIndex: imageIndex,
        uvRect: PuzzlePiece.getUvRect(PuzzlePieceType.bottom),
        gridPosition: 1,
      ),
      PuzzlePiece(
        type: PuzzlePieceType.middle,
        imageIndex: imageIndex,
        uvRect: PuzzlePiece.getUvRect(PuzzlePieceType.middle),
        gridPosition: 2,
      ),
    ];

    // 2x2グリッドの4つの位置から3つをランダム選択
    final positions = [0, 1, 2, 3];
    positions.shuffle(random);
    
    // 最初の3つの位置を使用
    final assignedPositions = positions.take(3).toList();
    
    // ピースをシャッフルして位置を割り当て
    pieces.shuffle(random);
    for (int i = 0; i < pieces.length; i++) {
      pieces[i] = pieces[i].copyWith(gridPosition: assignedPositions[i]);
    }
    
    return pieces;
  }

  /// ピース選択
  void selectPiece(int pieceIndex) {
    if (!state.canAnswer) return;
    
    final session = state.session;
    final problem = session?.currentProblem;
    if (session == null || problem == null) return;

    var selectedIndices = List<int>.from(session.selectedPieceIndices);
    
    if (selectedIndices.contains(pieceIndex)) {
      // 既に選択されている場合は選択解除
      selectedIndices.remove(pieceIndex);
    } else if (selectedIndices.length < 2) {
      // 2枚まで選択可能
      selectedIndices.add(pieceIndex);
    } else {
      // 既に2枚選択されている場合は最初の選択を解除して新しく選択
      selectedIndices.removeAt(0);
      selectedIndices.add(pieceIndex);
    }

    // ピースの選択状態を更新
    final updatedPieces = problem.pieces.asMap().map((index, piece) {
      return MapEntry(
        index,
        piece.copyWith(isSelected: selectedIndices.contains(index)),
      );
    }).values.toList();

    state = state.copyWith(
      session: session.copyWith(
        selectedPieceIndices: selectedIndices,
        currentProblem: problem.copyWith(pieces: updatedPieces),
      ),
    );

    // 2枚選択されたら自動判定
    if (selectedIndices.length == 2) {
      _judgeAnswer();
    }
  }

  /// 回答判定
  Future<void> _judgeAnswer() async {
    if (!state.canJudge) return;
    
    final currentEpoch = state.epoch;
    final session = state.session!;
    final problem = session.currentProblem!;
    final selectedIndices = session.selectedPieceIndices;

    Log.d('[$_tag] 判定: 選択ピース $selectedIndices (epoch: $currentEpoch)', tag: _tag);

    // 処理中状態に変更
    state = state.copyWith(
      phase: CommonGamePhase.processing,
      epoch: currentEpoch,
    );

    // 選択されたピースのタイプを確認
    final selectedTypes = selectedIndices
        .map((i) => problem.pieces[i].type)
        .toSet();

    // 正解判定：TOPとBOTTOMが選択されている
    final isCorrect = selectedTypes.contains(PuzzlePieceType.top) && 
                      selectedTypes.contains(PuzzlePieceType.bottom) &&
                      !selectedTypes.contains(PuzzlePieceType.middle);

    final timeTaken = session.questionStartTime != null 
        ? DateTime.now().difference(session.questionStartTime!)
        : Duration.zero;

    final result = PuzzleAnswerResult(
      selectedIndices: selectedIndices,
      isCorrect: isCorrect,
      isPerfect: isCorrect && session.wrongAnswers == 0,
      timeTaken: timeTaken,
    );

    // フィードバック音
    if (isCorrect) {
      await _feedbackService.playCorrectAnswerFeedback();
    } else {
      await _feedbackService.playWrongAnswerFeedback();
    }

    if (isCorrect) {
      await _handleCorrectAnswer(result, currentEpoch);
    } else {
      await _handleWrongAnswer(result, currentEpoch);
    }
  }

  /// 正解処理
  Future<void> _handleCorrectAnswer(PuzzleAnswerResult result, int epoch) async {
    if (state.epoch != epoch) return;
    
    state = state.copyWith(
      phase: CommonGamePhase.feedbackOk,
      lastResult: result,
    );

    await Future.delayed(const Duration(milliseconds: 1500));
    if (state.epoch != epoch) return;

    _proceedToNext(result.isPerfect);
  }

  /// 不正解処理
  Future<void> _handleWrongAnswer(PuzzleAnswerResult result, int epoch) async {
    if (state.epoch != epoch) return;
    
    final session = state.session!;
    
    state = state.copyWith(
      phase: CommonGamePhase.feedbackNg,
      lastResult: result,
      session: session.copyWith(
        wrongAnswers: session.wrongAnswers + 1,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 2000));
    if (state.epoch != epoch) return;

    // 選択を解除して再試行可能状態に
    final problem = session.currentProblem!;
    final resetPieces = problem.pieces.map((p) => p.copyWith(isSelected: false)).toList();
    
    state = state.copyWith(
      phase: CommonGamePhase.questioning,
      lastResult: null,
      session: session.copyWith(
        selectedPieceIndices: [],
        currentProblem: problem.copyWith(pieces: resetPieces),
      ),
    );
  }

  /// 次の問題へ進む
  void _proceedToNext(bool isPerfect) {
    final session = state.session!;
    final newResults = List<bool?>.from(session.results);
    newResults[session.index] = isPerfect;

    final newTotalTime = session.totalTime + (session.questionStartTime != null 
        ? DateTime.now().difference(session.questionStartTime!)
        : Duration.zero);

    if (session.index + 1 >= session.total) {
      // ゲーム完了
      state = state.copyWith(
        phase: CommonGamePhase.completed,
        session: session.copyWith(
          results: newResults,
          totalTime: newTotalTime,
        ),
      );
    } else {
      // 次の問題へ
      state = state.copyWith(
        phase: CommonGamePhase.transitioning,
        session: session.copyWith(
          index: session.index + 1,
          results: newResults,
          wrongAnswers: 0,
          totalTime: newTotalTime,
        ),
      );
      
      // 次の問題を生成
      Future.delayed(const Duration(milliseconds: 500), () {
        _generateNextProblem();
      });
    }
  }

  /// ゲームリセット（BaseGameScreen互換）
  void resetGame() {
    // 状態を初期化（ゲームを再開始しない）
    Log.d('[$_tag] Game reset', tag: _tag);
    state = const PuzzleGameState();
  }

  /// リセット
  void reset() {
    resetGame();
  }

  @override
  void dispose() {
    Log.d('[$_tag] Disposing puzzle game logic', tag: _tag);
    // 画像リソースのクリーンアップ
    state = state.copyWith(preloadedImages: []);
    // 完全にリセット
    state = const PuzzleGameState();
    super.dispose();
  }
}

/// Riverpodプロバイダー
final modernPuzzleGameLogicProvider = 
    StateNotifierProvider.autoDispose<ModernPuzzleGameLogic, PuzzleGameState>((ref) {
  return ModernPuzzleGameLogic();
});