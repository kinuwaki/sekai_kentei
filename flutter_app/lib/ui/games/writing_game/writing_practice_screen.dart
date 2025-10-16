import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math' as math;
import '../../../core/debug_logger.dart';
import '../../../services/character_recognition_service_native.dart';
import '../../../services/character_recognition_service_interface.dart';
import '../../../services/instant_feedback_service.dart';
import 'advanced_character_judge.dart';
import '../../components/success_effect.dart';
import '../base/base_game_screen.dart';
import 'writing_practice_settings.dart';
import 'writing_session_state.dart';
import 'writing_session_controller.dart';
import 'writing_single_mode_logic.dart';
import 'writing_game_models.dart';
import 'widgets/character_selection_widget.dart';
import 'widgets/unified_writing_canvas_widget.dart';
import 'widgets/canvas_design_presets.dart';
import 'widgets/mode_selection_widget.dart';
import '../../components/drawing/drawing_models.dart';

/// Riverpod providers
final writingPracticeSettingsProvider = Provider<WritingPracticeSettings>((ref) {
  throw UnimplementedError('Override this provider with actual settings');
});

final writingSessionProvider = StateNotifierProvider<WritingSessionController, WritingSessionState>((ref) {
  final settings = ref.watch(writingPracticeSettingsProvider);
  return WritingSessionController(
    settings,
    (mode, character) => WritingSingleModeLogic(mode: mode, character: character),
  );
}, dependencies: [writingPracticeSettingsProvider]);

/// 書き練習メイン画面
class WritingPracticeScreen extends BaseGameScreen<
    WritingPracticeSettings, WritingSessionState, WritingSessionController> {

  const WritingPracticeScreen({super.key});

  @override
  WritingPracticeScreenState createState() => WritingPracticeScreenState();
}

class WritingPracticeScreenState extends BaseGameScreenState<
    WritingPracticeScreen, WritingPracticeSettings, WritingSessionState, WritingSessionController> {

  // Drawing data for tracing free and free write modes
  DrawingData _drawingData = const DrawingData(paths: [], canvasSize: Size(300, 300));
  bool _showSuccessEffect = false;
  int _lastStepIndex = -1;

  // Character recognition
  final CharacterRecognizer _recognitionService = AndroidCharacterRecognizer();
  bool _isRecognizing = false;
  int _recognitionAttempts = 0; // 認識試行回数のカウント
  int _canvasResetCounter = 0; // キャンバス強制リセット用カウンター

  @override
  String get gameTitle => 'かきれんしゅう';

  @override
  WritingSessionState watchState(WidgetRef ref) => ref.watch(writingSessionProvider);

  @override
  WritingSessionController readLogic(WidgetRef ref) => ref.read(writingSessionProvider.notifier);

  @override
  GameUiPhase phaseOf(WritingSessionState state) => state.phase;

  @override
  WritingPracticeSettings? settingsOf(WritingSessionState state) {
    // 実際のセッション状態から正しい設定を構築
    return WritingPracticeSettings(
      character: state.character,
      sequence: state.sequence, // 実際の実行シーケンスを使用
    );
  }

  @override
  int? scoreOf(WritingSessionState state) {
    if (state.isComplete) {
      // 完了したモード数を返す
      return state.sequence.length;
    }
    return null;
  }

  @override
  int totalQuestionsOf(WritingPracticeSettings settings) => settings.sequence.length;

  @override
  String getSettingsDisplayName(WritingPracticeSettings settings) => settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Color(0xFF6A5ACD), // 紫のグラデーション（上）
      Color(0xFF836FFF), // 紫のグラデーション（下）
    ];
  }

  @override
  String? getQuestionText(WritingSessionState state) {
    final currentMode = state.currentMode;
    if (currentMode != null) {
      // 最初の練習（stepIndex == 0）の時だけ音声を出す
      if (state.stepIndex == 0) {
        // 最初だけ文字を読み上げる
        return state.character;
      }
      // 2回目以降は音声なし
      return null;
    }
    return null;
  }

  @override
  String? getProgressText(WritingSessionState state) {
    // 練習中の進捗を表示
    if (state.phase == GameUiPhase.playing && state.sequence.isNotEmpty) {
      final current = state.stepIndex + 1;
      final total = state.sequence.length;
      return '$current/$total';
    }
    return null;
  }

  @override
  Widget buildSettingsView(BuildContext context, void Function(WritingPracticeSettings) onStart) {
    final controller = readLogic(ref);
    final state = watchState(ref);
    
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF6A5ACD),
            Color(0xFF836FFF),
          ],
        ),
      ),
      child: SafeArea(
        child: state.selectedCombination == null 
          ? _buildCombinationSelection(context, controller, state)
          : _buildCharacterSelection(context, controller, state, onStart),
      ),
    );
  }

  Widget _buildCombinationSelection(BuildContext context, WritingSessionController controller, WritingSessionState state) {
    return ModeSelectionWidget(
      category: state.selectedCategory,
      onCombinationSelected: (combination) {
        controller.selectCombination(combination);
      },
    );
  }

  Widget _buildCharacterSelection(BuildContext context, WritingSessionController controller, WritingSessionState state, void Function(WritingPracticeSettings) onStart) {
    return CharacterSelectionWidget(
      category: state.selectedCategory,
      onCharacterSelected: (character) {
        controller.selectCharacterAndStart(character.character);
        // BaseGameScreen互換のため、ここでも onStart を呼ぶ
        final settings = WritingPracticeSettings(
          character: character.character,
          sequence: state.selectedCombination!.generateSequence(),
        );
        onStart(settings);
      },
    );
  }

  @override
  Widget buildPlayingView(BuildContext context, WritingSessionState state, WritingSessionController controller) {
    return Stack(
      children: [
        _buildDrawingArea(context, state, controller),
        if (_showSuccessEffect)
          SuccessEffect(
            onComplete: () {
              setState(() {
                _showSuccessEffect = false;
              });
            },
          ),
      ],
    );
  }


  // 共通の完了処理
  void _handleModeComplete(WritingSessionController controller, String modeName) {
    // Log.d('WritingPracticeScreen: $modeName completed');
    // 成功エフェクトを表示
    setState(() {
      _showSuccessEffect = true;
      _drawingData = _drawingData.clear();
    });
    // 遅延をかけてから次へ
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        controller.completeCurrentMode();
      }
    });
  }

  // 認識失敗時の処理（ブッブー音 + キャンバスリセット）
  Future<void> _handleRecognitionFailure() async {
    // Log.d('WritingPracticeScreen: Handling recognition failure - playing buzzer and clearing canvas');

    // ブッブー音を再生
    await InstantFeedbackService().playWrongAnswerFeedback();

    // キャンバスをクリア（カウンターもインクリメントして強制再作成）
    setState(() {
      _drawingData = _drawingData.clear();
      _canvasResetCounter++; // キャンバスを強制的に再作成
    });

    // Log.d('WritingPracticeScreen: Canvas reset completed, counter: $_canvasResetCounter');
  }

  Widget _buildDrawingArea(BuildContext context, WritingSessionState state, WritingSessionController controller) {
    if (!state.isRunningMode) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final currentMode = state.currentMode;
    if (currentMode == null) {
      return const Center(child: Text('モードが選択されていません'));
    }

    // モードが変わった時に描画データとエフェクトをリセット
    // ただしbuild内でsetStateを呼ぶとエラーになるので、次のフレームで実行
    if (_lastStepIndex != state.stepIndex) {
      _lastStepIndex = state.stepIndex;
      _recognitionAttempts = 0; // 試行回数もリセット
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _showSuccessEffect = false;
            _drawingData = _drawingData.clear();
          });
        }
      });
    }

    // 文字データを作成
    final characterData = CharacterData(
      character: state.character,
      category: CharacterCategory.hiragana,
      pronunciation: state.character,
    );

    // モードに応じたキャンバスモードを決定
    WritingCanvasMode canvasMode;
    switch (currentMode) {
      case WritingMode.tracing:
        canvasMode = WritingCanvasMode.tracing;
        break;
      case WritingMode.tracingFree:
        canvasMode = WritingCanvasMode.tracingFree;
        break;
      case WritingMode.freeWrite:
        canvasMode = WritingCanvasMode.freeWrite;
        break;
    }

    return UnifiedWritingCanvasWidget(
      key: ValueKey('${currentMode.name}_${state.stepIndex}_$_canvasResetCounter'),
      character: characterData,
      mode: canvasMode,
      drawingData: _drawingData,
      customization: CanvasDesignPresets.writingGame, // 統一されたプリセット適用
      onPathAdded: (DrawingPath path) {
        setState(() {
          _drawingData = _drawingData.addPath(path);
        });
      },
      onDrawingDataChanged: (DrawingData drawingData) {
        setState(() {
          _drawingData = drawingData;
        });
      },
      onClearDrawing: () {
        setState(() {
          _drawingData = _drawingData.clear();
        });
      },
      onRecognize: () => _performCharacterRecognition(controller, state),
      onComplete: () => _handleModeComplete(controller, currentMode.name),
      isProcessing: _isRecognizing,
      onRetry: () {
        setState(() {
          _drawingData = _drawingData.clear();
        });
      },
    );
  }

  /// 文字認識を実行
  Future<void> _performCharacterRecognition(WritingSessionController controller, WritingSessionState state) async {
    // Log.d('🔥 WritingPracticeScreen: _performCharacterRecognition CALLED');
    // Log.d('Target: ${state.character}, Paths: ${_drawingData.paths.length}, isRecognizing: $_isRecognizing');

    if (_isRecognizing || _drawingData.paths.isEmpty) {
      Log.w('WritingPracticeScreen: Cannot perform recognition - already recognizing or no drawing data');

      // 描画データが空の場合は警告を表示
      if (_drawingData.paths.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('描画データがありません。文字を描いてから「できた」を押してください。'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    setState(() {
      _isRecognizing = true;
    });

    try {
      // Log.d('WritingPracticeScreen: Starting character recognition for "${state.character}"');

      // ストロークデータを抽出
      final strokeData = _drawingData.paths.map((path) => path.points).toList();

      // 文字認識サービスを初期化
      await _recognitionService.initialize();

      // ストローク認識実行（手書き専用）
      var result = await (_recognitionService as AndroidCharacterRecognizer).recognizeStrokes(
        strokeData,
        // type: RecognitionType.hiragana, // TODO: Fix recognition type
      );

      // Log.d('WritingPracticeScreen: Recognition result: "${result.text}" (confidence: ${result.confidence})');
      // Log.d('WritingPracticeScreen: All candidates: ${result.candidates.map((c) => '"${c.text}" (${c.confidence})').join(', ')}');
      // Log.d('WritingPracticeScreen: Debug info: ${result.debugInfo}');

      // 認識結果のログ出力のみ
      final hiraganaRegex = RegExp(r'^[\u3041-\u3096\u3099-\u309F]+$');
      final hiraganaOnlyCandidates = result.candidates
          .where((c) => c.text.length == 1 && hiraganaRegex.hasMatch(c.text))
          .take(5)
          .map((c) => '${c.text}(${c.confidence.toStringAsFixed(2)})')
          .join(', ');

      // Log.d('Recognition result: "${result.text}" (${result.confidence.toStringAsFixed(2)})');
      // Log.d('Hiragana candidates: $hiraganaOnlyCandidates');

      // 相対スコア方式の文字判定システムを使用
      final judgment = AdvancedCharacterJudge.judge(
        targetChar: state.character,
        result: result,
        scriptType: ScriptType.hiragana, // ひらがな練習を想定
        ratioThreshold: 0.3, // トップスコアの30%以上で合格（テスト用甘め設定）
      );

      Log.d('WritingPracticeScreen: Advanced judgment: $judgment');

      // シミュレーターでの特別処理
      final isSimulatorMock = result.debugInfo?.contains('Simulator fallback') == true;
      final isCorrect = isSimulatorMock ? true : judgment.isAccepted;

      // Log.d('WritingPracticeScreen: Target="${state.character}", TopCandidate="${result.text}", Accepted=$isCorrect, isSimulatorMock=$isSimulatorMock');

      if (isSimulatorMock) {
        // シミュレーターのモック結果を問題の文字に更新
        result = RecognitionResult(
          text: state.character,
          confidence: result.confidence,
          isRecognized: result.isRecognized,
          candidates: result.candidates.map((c) =>
            RecognizedCandidate(text: state.character, confidence: c.confidence, rank: c.rank)
          ).toList(),
          debugInfo: result.debugInfo,
        );
      }

      final finalIsCorrect = judgment.isAccepted; // 判定システムの結果を使用

      // デバッグ用：認識結果が空の場合でも、3回試行したらクリアにする
      _recognitionAttempts++;

      if (finalIsCorrect) {
        // Log.d('WritingPracticeScreen: Character recognition successful');
        _recognitionAttempts = 0; // リセット
        _handleModeComplete(controller, 'FreeWrite');
      } else if (_recognitionAttempts >= 3) {
        // Log.d('WritingPracticeScreen: Auto-passing after 3 attempts (recognition under development)');
        _recognitionAttempts = 0; // リセット
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('デバッグ: 認識機能開発中のため自動的にクリアします'),
            duration: Duration(seconds: 1),
          ),
        );
        _handleModeComplete(controller, 'FreeWrite');
      } else {
        // Log.d('WritingPracticeScreen: Character recognition failed - expected "${state.character}", got "${result.text}" (attempt $_recognitionAttempts/1)');
        // Log.d('WritingPracticeScreen: Rejection reason: ${judgment.reason}');

        // 失敗時の効果音とキャンバスリセット
        await _handleRecognitionFailure();

        // 失敗した場合はユーザーに再描画を促す（フィルタリングされたひらがなのみ表示）
        final hiraganaOnly = judgment.characterRanking.where((cs) => cs.character.length == 1).take(5).map((cs) => cs.character).join('・');
        final displayCandidates = hiraganaOnly.isNotEmpty ? hiraganaOnly : 'ひらがなの候補が見つかりません';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('「${state.character}」と認識されませんでした。\nひらがな候補: $displayCandidates\n${judgment.reason}'),
            duration: const Duration(seconds: 4),
          ),
        );
      }

    } catch (error, stackTrace) {
      Log.e('WritingPracticeScreen: Character recognition error: $error');

      // エラー時の効果音とキャンバスリセット
      await _handleRecognitionFailure();

      // エラー時はやり直しを促す
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('認識に失敗しました。もう一度書いてみてください。'),
          duration: const Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        _isRecognizing = false;
      });
    }
  }

  /// 描画を画像に変換（認識用に最適化）
  Future<Uint8List> _convertDrawingToImage(DrawingData drawing) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = drawing.canvasSize;

    // Log.d('WritingPracticeScreen: Converting drawing to image - canvas size: ${size.width}x${size.height}');
    // Log.d('WritingPracticeScreen: Number of drawing paths: ${drawing.paths.length}');

    // 簡潔なログ
    // Log.d('WritingPracticeScreen: Converting ${drawing.paths.length} paths to image');

    // 高解像度で認識精度を向上（768x768）
    final outputSize = 768;

    // 座標変換のスケール計算
    final scaleX = outputSize / size.width;
    final scaleY = outputSize / size.height;
    // Log.d('WritingPracticeScreen: Coordinate transformation - Canvas: ${size.width}x${size.height} -> Image: ${outputSize}x${outputSize}');
    // Log.d('WritingPracticeScreen: Scale factors - scaleX: $scaleX, scaleY: $scaleY');

    // 描画データが空の場合はエラーメッセージを表示
    if (drawing.paths.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('エラー: 描画データが空です'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }

    // 白い背景（認識用に純白）- 384x384サイズに合わせる
    canvas.drawRect(
      Rect.fromLTWH(0, 0, outputSize.toDouble(), outputSize.toDouble()),
      Paint()..color = Colors.white,
    );

    // 描画パスを濃い黒で描く（認識精度向上）
    for (int i = 0; i < drawing.paths.length; i++) {
      final path = drawing.paths[i];

      final paint = Paint()
        ..color = Colors.black // 認識用に純黒に統一
        ..strokeWidth = math.max(path.strokeWidth, 12.0) * scaleX // スケール変換を適用
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final uiPath = Path();
      for (int j = 0; j < path.points.length; j++) {
        // 座標を384x384の画像座標系に変換
        final scaledX = path.points[j].dx * scaleX;
        final scaledY = path.points[j].dy * scaleY;

        if (j == 0) {
          uiPath.moveTo(scaledX, scaledY);
        } else {
          uiPath.lineTo(scaledX, scaledY);
        }
      }
      canvas.drawPath(uiPath, paint);
    }

    final picture = recorder.endRecording();

    final img = await picture.toImage(outputSize, outputSize);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    final imageBytes = byteData!.buffer.asUint8List();
    // Log.d('WritingPracticeScreen: Converted to PNG image - size: ${imageBytes.length} bytes, dimensions: ${outputSize}x${outputSize}');

    // デバッグ用：32x32縮小画像でピクセル確認（不要）
    // await _debugImageContent(imageBytes);

    return imageBytes;
  }

  // デバッグ用：生成された画像の内容を32x32で確認（廃止済み）
  // Future<void> _debugImageContent(Uint8List imageBytes) async { ... }

}