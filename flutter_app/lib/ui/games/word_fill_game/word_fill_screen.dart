import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart' as ink;
import '../base/base_game_screen.dart';
import '../base/common_game_phase.dart';
import '../../components/success_effect.dart';
import '../../components/drawing/drawing_models.dart';
import 'models/word_fill_models.dart';
import 'modern_word_fill_logic.dart';
import '../writing_game/writing_game_models.dart';
import '../writing_game/widgets/smooth_tracing_widget.dart';

class WordFillScreen extends BaseGameScreen<WordFillSettings,
    WordFillState, ModernWordFillLogic> {
  const WordFillScreen({super.key}) : super(enableHomeButton: false);

  @override
  WordFillScreenState createState() => WordFillScreenState();
}

class WordFillScreenState extends BaseGameScreenState<
    WordFillScreen,
    WordFillSettings,
    WordFillState,
    ModernWordFillLogic> {

  // 手書き認識用
  final ink.DigitalInkRecognizerModelManager _modelManager =
      ink.DigitalInkRecognizerModelManager();
  ink.DigitalInkRecognizer? _recognizer;
  final ink.Ink _ink = ink.Ink();

  // 描画データ管理
  DrawingData _drawingData = DrawingData(paths: const [], canvasSize: const Size(300, 300));
  int _clearCounter = 0;

  @override
  void initState() {
    super.initState();
    _initRecognizer();

    // すぐにゲームを開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final logic = readLogic(ref);
      logic.startGame(const WordFillSettings(questionCount: 3));
    });
  }

  Future<void> _initRecognizer() async {
    const languageCode = 'ja';
    final isDownloaded = await _modelManager.isModelDownloaded(languageCode);
    if (!isDownloaded) {
      await _modelManager.downloadModel(languageCode);
    }

    _recognizer = ink.DigitalInkRecognizer(languageCode: languageCode);
  }

  @override
  void dispose() {
    _recognizer?.close();
    super.dispose();
  }

  @override
  String get gameTitle => 'ことばあなうめ';

  @override
  WordFillState watchState(WidgetRef ref) =>
      ref.watch(modernWordFillLogicProvider);

  @override
  ModernWordFillLogic readLogic(WidgetRef ref) =>
      ref.read(modernWordFillLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(WordFillState s) {
    return s.phase.toGameUiPhase;
  }

  @override
  WordFillSettings? settingsOf(WordFillState s) => s.settings;

  @override
  int? scoreOf(WordFillState s) => s.session?.correctCount;

  @override
  int totalQuestionsOf(WordFillSettings s) => s.questionCount;

  @override
  String getSettingsDisplayName(WordFillSettings settings) => settings.displayName;

  @override
  List<Color> getBackgroundColors() {
    return const [
      Colors.white,
      Colors.white,
    ];
  }

  @override
  String? getQuestionText(WordFillState state) {
    if (state.session?.currentProblem == null) return null;
    return 'はてなのなかにはいる\nことばはなにかな';
  }

  @override
  String? getProgressText(WordFillState state) {
    return state.session != null && state.settings != null
        ? '${state.session!.index + 1}/${state.settings!.questionCount}'
        : null;
  }

  @override
  Widget buildSettingsView(BuildContext context, void Function(WordFillSettings) onStart) {
    final screenSize = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ことばあなうめ',
            style: TextStyle(
              fontSize: screenSize.width * 0.04,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4CAF50),
            ),
          ),
          SizedBox(height: screenSize.height * 0.05),
          ElevatedButton(
            onPressed: () {
              final settings = WordFillSettings(questionCount: 5);
              onStart(settings);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              minimumSize: Size(
                screenSize.width * 0.5,
                screenSize.height * 0.08,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'はじめる',
              style: TextStyle(
                fontSize: screenSize.width * 0.035,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildPlayingView(BuildContext context, WordFillState state, ModernWordFillLogic logic) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(color: Colors.white),
        Padding(
          padding: EdgeInsets.only(top: screenSize.height * 0.02),
          child: _buildGameContent(context, state, logic, screenSize),
        ),
        if (state.phase == CommonGamePhase.feedbackOk)
          SuccessEffect(
            onComplete: () {},
            hadWrongAnswer: (state.session?.wrongAttempts ?? 0) > 0,
          ),
      ],
    );
  }

  Widget _buildGameContent(
    BuildContext context,
    WordFillState state,
    ModernWordFillLogic logic,
    Size screenSize,
  ) {
    final session = state.session;
    final problem = session?.currentProblem;

    if (problem == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 左側：単語と画像
        _buildWordSection(problem, screenSize),
        SizedBox(width: screenSize.width * 0.05),
        // 中央：手書き領域
        _buildHandwritingArea(logic, screenSize),
        SizedBox(width: screenSize.width * 0.05),
        // 右側：ボタン
        _buildButtonSection(logic, screenSize),
      ],
    );
  }

  Widget _buildWordSection(WordFillProblem problem, Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 画像と答え
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: screenSize.width * 0.12,
                height: screenSize.width * 0.12,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Image.asset(
                  problem.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                problem.word,
                style: TextStyle(
                  fontSize: screenSize.width * 0.018,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(width: screenSize.width * 0.015),
          // 単語表示（縦書き風）
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.brown, width: 2),
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFF5E6D3),
            ),
            child: Column(
              children: problem.displayChars.map((char) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Container(
                    width: screenSize.width * 0.055,
                    height: screenSize.width * 0.055,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      color: char == '？' ? Colors.grey.shade300 : Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        char,
                        style: TextStyle(
                          fontSize: screenSize.width * 0.032,
                          fontWeight: FontWeight.bold,
                          color: char == '？' ? Colors.grey.shade600 : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandwritingArea(ModernWordFillLogic logic, Size screenSize) {
    final canvasSize = screenSize.width * 0.32;

    return Container(
      width: canvasSize,
      height: canvasSize,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SmoothTracingWidget(
          key: ValueKey('word_fill_canvas_$_clearCounter'),
          character: const CharacterData(
            character: '',
            category: CharacterCategory.hiragana,
            pronunciation: '',
          ),
          showTracing: false,
          showSilhouette: false,
          strokeWidth: 8.0,
          onEndDrawing: (_) {
            // 自動認識はしない
          },
          onDrawingDataChanged: (drawingData) {
            setState(() {
              _drawingData = drawingData;
            });
          },
        ),
      ),
    );
  }

  Widget _buildButtonSection(ModernWordFillLogic logic, Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _clearCounter++;
                _drawingData = DrawingData(paths: const [], canvasSize: const Size(300, 300));
                _ink.strokes.clear();
              });
              logic.clearInput();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              minimumSize: Size(screenSize.width * 0.12, 50),
            ),
            child: const Text(
              'やりなおし',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _drawingData.paths.isEmpty
                ? null
                : () async {
                    if (_recognizer == null) {
                      await _initRecognizer();
                    }

                    // 描画データをML Kit Inkに変換
                    _ink.strokes.clear();
                    for (final path in _drawingData.paths) {
                      final stroke = ink.Stroke();
                      stroke.points = path.points.map((p) => ink.StrokePoint(
                        x: p.dx,
                        y: p.dy,
                        t: DateTime.now().millisecondsSinceEpoch,
                      )).toList();
                      _ink.strokes.add(stroke);
                    }

                    final candidates = await _recognizer!.recognize(_ink);
                    if (candidates.isEmpty) return;

                    // ML Kitの結果をRecognitionResultに変換
                    final recognizedCandidates = <RecognizedCandidate>[];
                    for (int i = 0; i < candidates.length; i++) {
                      final candidate = candidates[i];
                      recognizedCandidates.add(RecognizedCandidate(
                        text: candidate.text,
                        confidence: candidate.score?.toDouble() ?? 0.0,
                        rank: i + 1,
                      ));
                    }

                    final result = RecognitionResult(
                      text: recognizedCandidates.first.text,
                      confidence: recognizedCandidates.first.confidence,
                      isRecognized: true,
                      candidates: recognizedCandidates,
                    );

                    logic.submitRecognition(result);

                    // クリア
                    setState(() {
                      _clearCounter++;
                      _drawingData = DrawingData(paths: const [], canvasSize: const Size(300, 300));
                      _ink.strokes.clear();
                    });
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              minimumSize: Size(screenSize.width * 0.12, 50),
            ),
            child: const Text(
              'できた',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
