# 🎮 ゲーム開発ガイドライン

このドキュメントは、`comparison_game`と`counting_game`の分析に基づいて、新しいゲームを実装する際に守るべきアーキテクチャとルールを定義しています。

## 📁 ディレクトリ構造の規則

新しいゲームは以下の構造に従って実装してください：

```
your_game/
├── models/
│   ├── your_game_models.dart        # データモデル（設定、問題、セッション）
│   └── your_game_phase.dart         # ゲーム状態フェーズの定義
├── widgets/                         # （オプション）ゲーム専用ウィジェット
│   ├── custom_widget1.dart
│   └── custom_widget2.dart
├── your_game_screen.dart            # メインゲーム画面
├── your_game_settings_screen.dart   # 設定画面（必要に応じて）
└── modern_your_game_logic.dart      # ステート管理ロジック
```

## 🏗️ アーキテクチャの基本原則

### 1. BaseGameScreenの活用

すべてのゲームは`BaseGameScreen<TSettings, TState, TLogic>`を継承してください：

```dart
class YourGameScreen extends BaseGameScreen<YourGameSettings, YourGameState, ModernYourGameLogic> {
  const YourGameScreen({Key? key}) : super(key: key);

  @override
  YourGameState watchState(WidgetRef ref) => ref.watch(modernYourGameLogicProvider);

  @override
  ModernYourGameLogic readLogic(WidgetRef ref) => ref.read(modernYourGameLogicProvider.notifier);

  @override
  GameUiPhase phaseOf(YourGameState s) {
    return s.phase.toGameUiPhase; // CommonGamePhase拡張メソッドを使用
  }

  @override
  Widget buildSettingsView(BuildContext context, WidgetRef ref) {
    // 設定画面のUI実装
  }

  @override
  Widget buildPlayingView(BuildContext context, WidgetRef ref) {
    // ゲーム画面のUI実装
  }
}
```

### 2. フェーズベース状態管理

ゲームの状態は`CommonGamePhase`で管理してください：

```dart
// lib/ui/games/base/common_game_phase.dart で定義済み
enum CommonGamePhase {
  ready,         // 初期設定画面
  displaying,    // 問題表示中
  questioning,   // ユーザー操作可能
  processing,    // 回答処理中
  feedbackOk,    // 正解フィードバック
  feedbackNg,    // 不正解フィードバック（再試行可能）
  transitioning, // 次の問題への遷移
  completed,     // 全問題完了
}

// GameUiPhaseへの変換は拡張メソッドで自動対応
extension CommonGamePhaseExtension on CommonGamePhase {
  GameUiPhase get toGameUiPhase {
    switch (this) {
      case CommonGamePhase.ready: return GameUiPhase.settings;
      case CommonGamePhase.completed: return GameUiPhase.result;
      default: return GameUiPhase.playing;
    }
  }
}
```

### 3. 状態クラスの構造

状態クラスは以下の構造に従ってください：

```dart
@freezed
class YourGameState with _$YourGameState {
  const factory YourGameState({
    @Default(CommonGamePhase.ready) CommonGamePhase phase,
    YourGameSettings? settings,
    YourGameSession? session,
    @Default(0) int epoch,              // 競合状態防止
  }) = _YourGameState;

  const YourGameState._();

  // UI向けの派生プロパティ
  bool get canAnswer => phase == CommonGamePhase.questioning;
  bool get isProcessing => phase == CommonGamePhase.processing || phase == CommonGamePhase.transitioning;
  double get progress => session != null ? session!.index / session!.total : 0.0;
  String? get questionText => session?.currentProblem?.questionText;
}
```

## 📊 データモデルの規則

### 1. 設定モデル（Settings）

```dart
enum YourGameRange {
  easy(1, 5, 'かんたん'),
  medium(6, 10, 'ふつう'),
  hard(11, 20, 'むずかしい');

  const YourGameRange(this.minValue, this.maxValue, this.displayName);
  
  final int minValue;
  final int maxValue; 
  final String displayName;
}

@freezed
class YourGameSettings with _$YourGameSettings {
  const factory YourGameSettings({
    @Default(YourGameRange.easy) YourGameRange range,
    @Default(5) int questionCount,
    // その他のゲーム固有設定
  }) = _YourGameSettings;

  const YourGameSettings._();

  String get displayName => '$rangeの${displayName}（$questionCount問）';
}
```

### 2. 問題モデル（Problem）

```dart
@freezed
class YourGameProblem with _$YourGameProblem {
  const factory YourGameProblem({
    required String questionText,       // TTS用の質問文
    required int correctAnswerIndex,    // 正解のインデックス
    required List<YourGameOption> options, // 選択肢
    // ゲーム固有の表示データ
  }) = _YourGameProblem;
}
```

### 3. セッションモデル（Session）

```dart
@freezed
class YourGameSession with _$YourGameSession {
  const factory YourGameSession({
    required int index,                 // 現在の問題番号 (0-based)
    required int total,                 // 総問題数
    required List<bool?> results,       // 結果配列（null=未回答, bool=完璧/不完璧）
    YourGameProblem? currentProblem,
    @Default(0) int wrongAnswers,       // 不正解回数
  }) = _YourGameSession;

  const YourGameSession._();

  bool get isCompleted => index >= total;
  int get correctCount => results.where((r) => r == true).length;
  int get incorrectCount => results.where((r) => r == false).length;
}
```

## 🎛️ ゲーム設定の分類と実装原則

### ゲーム設定の基本方針

ゲームは以下の2つのカテゴリーに分類されます：

#### 1. **設定必要ゲーム** - ユーザーが事前に選択する項目がある
- **数える (Counting)**: 範囲選択（1-5, 5-10, 1-10等）
- **比較する (Comparison)**: 範囲選択 + 選択肢数（2個/3個/4個）
- **文字を書く (Writing)**: カテゴリ選択 + 文字選択 + モード選択
- **きすう・ぐうすう (Odd/Even)**: 奇数/偶数選択 + 数値範囲選択
- **サイズ比較 (Size Comparison)**: 難易度選択（何番目に大きい/小さい）
- **数字認識 (Number Recognition)**: 練習する数字選択

#### 2. **即開始ゲーム** - 設定なしでランダム生成
- **ばらばらパズル (Puzzle)**: パズル種類・難易度はゲーム内でランダム決定
- **かたちさがし (Shape Matching)**: 形状・モードはゲーム内でランダム決定
- **ずけいむきまちがい (Figure Orientation)**: 図形・難易度はゲーム内でランダム決定
- **つみき数える (Tsumiki Counting)**: つみき配置はゲーム内でランダム決定
- **たんご (Word Game)**: 単語選択はゲーム内でランダム決定
- **もじめぐり (Word Trace)**: 文章・グリッド配置はゲーム内でランダム決定

### 設定実装の重要ルール

1. **設定画面でユーザーが選択する項目のみ**をConfigに含める
2. **ゲーム中にランダム決定される要素**はConfigに含めない
3. **実際の設定画面の実装とConfig定義を一致させる**
4. **不要な設定項目は追加しない**（難易度、カテゴリ等のメタ情報は除く）

### GameConfig実装パターン

```dart
// 例1: 設定必要ゲーム（きすう・ぐうすう）
class OddEvenGameConfig implements GameConfig {
  final OddEvenType targetType;  // 設定画面で選択: 奇数/偶数
  final OddEvenRange range;      // 設定画面で選択: 0-9, 10-19等

  @override
  Map<String, dynamic> get availableOptions => {
    'targetType': ['odd', 'even'],
    'range': ['0-9', '10-19', '20-29', ...], // 実際の選択肢と一致
  };
}

// 例2: 即開始ゲーム（かたちさがし）
class ShapeMatchingGameConfig implements GameConfig {
  // 設定項目なし - questionCountのみ
  @override
  Map<String, dynamic> get availableOptions => {}; // 空

  @override
  bool get hasSettings => false; // 設定画面を表示しない
}
```

## 🔧 ロジック層の実装規則

### 1. AnswerHandlerMixinの活用

正解・不正解処理を統一するため、`AnswerHandlerMixin`を使用してください：

```dart
class ModernYourGameLogic extends StateNotifier<YourGameState>
    with AnswerHandlerMixin {
  static const String _tag = 'YourGameLogic';

  ModernYourGameLogic() : super(const YourGameState());

  // AnswerHandlerMixin実装（必須）
  @override
  String get gameTitle => _tag;

  @override
  bool checkEpoch(int epoch) => state.epoch == epoch;

  @override
  Future<void> proceedToNext() => _autoAdvance();

  @override
  void returnToQuestioning() {
    if (state.session == null) return;
    state = state.copyWith(
      phase: CommonGamePhase.questioning,
      session: state.session!.copyWith(selectedAnswer: null),
    );
  }

  // BaseGameScreen互換プロパティ
  String? get questionText => state.questionText;
  double get progress => state.progress;
  bool get isBusy => state.isProcessing;

  // ゲーム制御メソッド
  void startGame(YourGameSettings settings) {
    Log.d('ゲーム開始: ${settings.displayName}', tag: _tag);
    final firstProblem = _generateProblem(settings, 0);
    final session = YourGameSession(
      index: 0,
      total: settings.questionCount,
      results: List.filled(settings.questionCount, null),
      currentProblem: firstProblem,
    );

    state = state.copyWith(
      phase: CommonGamePhase.displaying,
      settings: settings,
      session: session,
      epoch: state.epoch + 1,
    );

    _enterQuestioning();
  }

  void answerQuestion(int selectedIndex) {
    if (!state.canAnswer || state.session?.currentProblem == null) return;

    final currentEpoch = state.epoch;
    final session = state.session!;
    final problem = session.currentProblem!;

    Log.d('回答: $selectedIndex (epoch: $currentEpoch)', tag: _tag);

    // 回答判定
    final isCorrect = selectedIndex == problem.correctAnswerIndex;

    if (isCorrect) {
      handleCorrectAnswer(
        epoch: currentEpoch,
        updateState: () {
          final updatedResults = List<bool?>.from(session.results);
          updatedResults[session.index] = true;

          state = state.copyWith(
            phase: CommonGamePhase.feedbackOk,
            session: session.copyWith(results: updatedResults),
          );
        },
      );
    } else {
      handleWrongAnswer(
        epoch: currentEpoch,
        updateState: () {
          final updatedResults = List<bool?>.from(session.results);
          updatedResults[session.index] = false;

          state = state.copyWith(
            phase: CommonGamePhase.feedbackNg,
            session: session.copyWith(
              results: updatedResults,
              wrongAttempts: session.wrongAttempts + 1,
            ),
          );
        },
        allowRetry: session.wrongAttempts < 2, // 2回まで再試行可能
      );
    }
  }

  Future<void> _autoAdvance() async {
    if (!mounted || state.session == null || state.settings == null) return;

    final session = state.session!;
    final settings = state.settings!;

    await waitForTransition(); // AnswerHandlerMixinの共通待機処理

    if (session.isLast) {
      Log.d('ゲーム完了', tag: _tag);
      state = state.copyWith(phase: CommonGamePhase.completed);
      return;
    }

    final nextIndex = session.index + 1;
    Log.d('次の問題へ移動: ${nextIndex + 1}', tag: _tag);

    final nextProblem = _generateProblem(settings, nextIndex);

    state = state.copyWith(
      phase: CommonGamePhase.displaying,
      session: YourGameSession(
        index: nextIndex,
        total: settings.questionCount,
        results: session.results,
        currentProblem: nextProblem,
      ),
      epoch: state.epoch + 1,
    );

    _enterQuestioning();
  }

  void _enterQuestioning() {
    state = state.copyWith(phase: CommonGamePhase.questioning);
  }

  YourGameProblem _generateProblem(YourGameSettings settings, int index) {
    // 問題生成ロジック
    // ランダムシードを使って一貫性のある生成を行う
  }
}
```

### 2. Riverpodプロバイダーの定義

```dart
final modernYourGameLogicProvider = StateNotifierProvider<ModernYourGameLogic, YourGameState>((ref) {
  return ModernYourGameLogic();
});
```

## 🎨 UI実装の規則

### 1. レスポンシブデザイン定数

```dart
class YourGameConstants {
  // 画面サイズに対する比率で定義
  static const double buttonSizeRatio = 0.0898;
  static const double spacingRatio = 0.02;
  static const double fontSizeRatio = 0.48;
  static const double containerPaddingRatio = 0.02;
}
```

### 2. ウィジェット構造パターン

```dart
@override
Widget buildPlayingView(BuildContext context, WidgetRef ref) {
  final state = watchState(ref);
  final screenSize = MediaQuery.of(context).size;

  return Stack(
    children: [
      // 背景グラデーション
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF0F8FF), Color(0xFFE6F3FF)],
          ),
        ),
      ),

      // メインコンテンツ
      _buildGameContent(context, state, screenSize),

      // エフェクトオーバーレイ
      if (state.phase == CommonGamePhase.feedbackOk)
        SuccessEffect(
          onComplete: () {},
          hadWrongAnswer: state.session?.wrongAttempts ?? 0 > 0,
        ),

      // デバッグオーバーレイ
      if (kDebugMode) DebugOverlay(),
    ],
  );
}
```

### 3. カスタムウィジェットの設計

```dart
class YourGameAnswerButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;

  const YourGameAnswerButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isSelected = false,
    this.isCorrect = false,
    this.showResult = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: _getGradient(),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  LinearGradient _getGradient() {
    if (showResult) {
      return isCorrect
          ? const LinearGradient(colors: [Color(0xFF4CAF50), Color(0xFF45A049)])
          : const LinearGradient(colors: [Color(0xFFFF5252), Color(0xFFE53935)]);
    } else if (isSelected) {
      return const LinearGradient(colors: [Color(0xFF2196F3), Color(0xFF1976D2)]);
    } else {
      return const LinearGradient(colors: [Color(0xFF9E9E9E), Color(0xFF757575)]);
    }
  }
}
```

## 🔊 サービス統合の規則

### 1. 音声フィードバック

```dart
// AnswerHandlerMixinを使う場合、自動的にフィードバック音が再生される
// handleCorrectAnswer/handleWrongAnswerが内部で処理

// 特殊な効果音が必要な場合のみ手動で再生
InstantFeedbackService.instance.playCustomSound('your_game_sound.wav');
```

### 2. TTS統合

```dart
// BaseGameScreenが自動でquestionTextを読み上げる
// questionTextプロパティを適切に実装するだけでOK
String? get questionText => state.session?.currentProblem?.questionText;
```

### 3. レイアウトサービス（必要に応じて）

```dart
class YourGameLayoutService {
  static final YourGameLayoutService _instance = YourGameLayoutService._internal();
  factory YourGameLayoutService() => _instance;
  YourGameLayoutService._internal();

  static YourGameLayoutService get instance => _instance;

  List<Offset> calculatePositions(Size containerSize, int count) {
    // レイアウト計算ロジック
  }
}
```

## 🎯 Universal Game Runner統合

新しいゲームをUniversal Game Runnerでサポートするには以下の手順が必要です：

### 1. ゲーム設定クラス（Config）の実装

```dart
// lib/core/game_session/game_configs.dart に追加
@freezed
class YourGameConfig with _$YourGameConfig {
  const factory YourGameConfig({
    @Default(YourGameRange.easy) YourGameRange range,
    @Default(5) int questionCount,
  }) = _YourGameConfig;

  const YourGameConfig._();

  @override
  GameType get type => GameType.yourGame; // GameTypeに追加必要

  YourGameSettings toYourGameSettings() {
    return YourGameSettings(
      range: range,
      questionCount: questionCount,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'type': 'your_game',
    'range': range.name,
    'questionCount': questionCount,
  };

  static YourGameConfig fromJson(Map<String, dynamic> json) {
    return YourGameConfig(
      range: YourGameRange.values.byName(json['range']),
      questionCount: json['questionCount'],
    );
  }
}
```

### 2. Orchestratorの実装

```dart
// lib/core/game_session/game_orchestrators.dart に追加
class YourGameOrchestrator extends ChangeNotifier {
  final YourGameConfig config;
  final int totalQuestions;
  int _currentQuestion = 0;
  final List<GameResult> _results = [];

  YourGameOrchestrator({
    required this.config,
    required this.totalQuestions,
  });

  bool get isDone => _currentQuestion >= totalQuestions;
  int get questionNo => _currentQuestion + 1;
  List<GameResult> get results => List.unmodifiable(_results);

  YourGameSettings toSettings() {
    Log.d('YourGameOrchestrator: Generating settings for question $questionNo/$totalQuestions');
    return config.toYourGameSettings();
  }

  void onSingleGameCompleted({bool correct = true, Duration? time}) {
    final result = GameResult(
      type: GameType.yourGame,
      correct: correct,
      time: time ?? const Duration(seconds: 1),
      meta: {
        'range': config.range.name,
        'questionNo': questionNo,
      },
    );
    
    _results.add(result);
    _currentQuestion++;
    
    Log.d('YourGameOrchestrator: Question $questionNo completed. isDone: $isDone');
    notifyListeners();
  }
  
  void reset() {
    _currentQuestion = 0;
    _results.clear();
    notifyListeners();
  }
}
```

### 3. Task Runnerの追加

```dart
// lib/core/game_session/universal_game_runner.dart に追加
class _YourGameTaskRunner extends ConsumerStatefulWidget {
  final YourGameConfig config;
  final int repeatCount;
  final Function(List<GameResult>) onTaskDone;
  
  const _YourGameTaskRunner({
    required this.config,
    required this.repeatCount,
    required this.onTaskDone,
  });
  
  @override
  ConsumerState<_YourGameTaskRunner> createState() => _YourGameTaskRunnerState();
}

class _YourGameTaskRunnerState extends ConsumerState<_YourGameTaskRunner> {
  late YourGameOrchestrator _orchestrator;
  
  @override
  void initState() {
    super.initState();
    _orchestrator = YourGameOrchestrator(
      config: widget.config,
      totalQuestions: widget.repeatCount,
    );
  }
  
  @override
  void dispose() {
    _orchestrator.dispose();
    super.dispose();
  }
  
  void _checkGameCompletion(YourGameState state) {
    if (state.isCompleted && !_orchestrator.isDone) {
      _orchestrator.onSingleGameCompleted(correct: state.isPerfect, time: const Duration(seconds: 1));
      
      if (_orchestrator.isDone) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            widget.onTaskDone(_orchestrator.results);
          }
        });
      } else {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {});
          }
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final yourGameState = ref.watch(modernYourGameLogicProvider);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkGameCompletion(yourGameState);
    });
    
    return YourGameScreen(
      key: ValueKey('your_game_${_orchestrator.questionNo}'),
      initialSettings: _orchestrator.toSettings(),
      fromDailyChallenge: false,
      skipResultScreen: true,
    );
  }
}
```

### 4. デバッグメニューへの統合

ゲームを追加する場合はデバッグメニューから直接アクセスできるようにしてください。

## 🔗 その他の統合パターン

### レッスンカタログへの追加

`assets/lessons/game_settings_catalog.json`に追加：

```json
{
  "games": {
    "your_game.v1": {
      "displayName": "あなたのゲーム",
      "description": "ゲームの説明",
      "options": {
        "range": {
          "type": "enum",
          "values": ["easy", "medium", "hard"],
          "default": "easy",
          "displayNames": {
            "easy": "かんたん",
            "medium": "ふつう", 
            "hard": "むずかしい"
          }
        },
        "questionCount": {
          "type": "integer",
          "min": 1,
          "max": 20,
          "default": 5
        }
      }
    }
  }
}
```

## ✅ 実装チェックリスト

新しいゲームを実装する際は、以下の項目をすべて満たしていることを確認してください：

### 必須項目
- [ ] BaseGameScreen<TSettings, TState, TLogic>を継承
- [ ] CommonGamePhaseを使用したフェーズ管理
- [ ] AnswerHandlerMixinの実装（正解・不正解処理の統一）
- [ ] freezedを使った不変データモデル
- [ ] epochによる競合状態防止
- [ ] Log.d()による構造化ログ出力
- [ ] TTS対応のquestionTextプロパティ
- [ ] レスポンシブサイズ比率の使用
- [ ] Riverpodプロバイダーの実装

### 推奨項目
- [ ] カスタムウィジェットの分離
- [ ] サービスクラスの単一責任原則
- [ ] エラーハンドリングの実装
- [ ] パフォーマンス最適化
- [ ] アクセシビリティ対応

### 統合項目
- [ ] デバッグメニューからのアクセス
- [ ] レッスンカタログへの追加（必要に応じて）
- [ ] Universal Game Runner対応（マルチセッション用）
- [ ] Daily Challenge対応（必要に応じて）
- [ ] Orchestrator実装（複数問題対応）

## 🎨 特殊パターン：複雑なマルチフェーズゲーム

一部のゲーム（例：かきれんしゅう）は複数のモードと状態管理が必要です。以下は高度なパターンです：

### 1. 複数モード対応の状態管理

```dart
@freezed
class WritingGameState with _$WritingGameState {
  const factory WritingGameState({
    @Default(WritingGamePhase.categorySelection) WritingGamePhase phase,
    CharacterCategory? selectedCategory,
    CharacterData? selectedCharacter,
    WritingMode? selectedMode,
    DrawingData? drawingData,
    RecognitionResult? recognitionResult,
    
    // マルチシーケンス対応
    PracticeCombination? selectedCombination,
    @Default([]) List<WritingMode> practiceSequence,
    @Default(0) int currentPracticeIndex,
    
    // アニメーション状態
    @Default(false) bool isAnimatingStrokes,
    @Default(0) int currentStrokeIndex,
    @Default(0.0) double maxStrokeProgress,
    @Default(false) bool showSuccessEffect,
  }) = _WritingGameState;

  const WritingGameState._();

  // UI派生プロパティ
  WritingMode? get currentMode => 
    practiceSequence.isNotEmpty && currentPracticeIndex < practiceSequence.length 
      ? practiceSequence[currentPracticeIndex] 
      : null;
      
  bool get isComplete => currentPracticeIndex >= practiceSequence.length;
  String get progressText => '${currentPracticeIndex + 1}/${practiceSequence.length}';
}
```

### 2. Session Controller パターン

```dart
class WritingSessionController extends StateNotifier<WritingSessionState> {
  final WritingPracticeSettings settings;
  final WritingSingleModeLogic Function(WritingMode, String) logicFactory;

  WritingSessionController(this.settings, this.logicFactory) 
    : super(WritingSessionState.initial());

  void selectCombination(PracticeCombination combination) {
    state = state.copyWith(
      selectedCombination: combination,
      sequence: combination.generateSequence(),
    );
  }

  void selectCharacterAndStart(String character) {
    state = state.copyWith(
      character: character,
      phase: GameUiPhase.playing,
      currentIndex: 0,
    );
    _startNextMode();
  }

  void onModeCompleted() {
    if (state.currentIndex + 1 >= state.sequence.length) {
      // 全モード完了
      state = state.copyWith(phase: GameUiPhase.result);
    } else {
      // 次のモードへ
      state = state.copyWith(currentIndex: state.currentIndex + 1);
      _startNextMode();
    }
  }

  void _startNextMode() {
    final mode = state.sequence[state.currentIndex];
    // モード固有のロジック初期化
  }
}
```

### 3. 共通描画データ統合

```dart
// 複数の描画システムで共通して使用
class DrawingData {
  final List<DrawingPath> paths;
  final Size canvasSize;
  
  const DrawingData({
    required this.paths,
    required this.canvasSize,
  });
  
  bool get isEmpty => paths.isEmpty;
  
  DrawingData copyWith({
    List<DrawingPath>? paths,
    Size? canvasSize,
  }) {
    return DrawingData(
      paths: paths ?? this.paths,
      canvasSize: canvasSize ?? this.canvasSize,
    );
  }
}
```

### 4. モード固有ウィジェット統合

```dart
Widget _buildDrawingArea(BuildContext context, WritingSessionState state, WritingSessionController controller) {
  final currentMode = state.currentMode;
  if (currentMode == null) return const SizedBox();

  switch (currentMode) {
    case WritingMode.tracing:
      return TracingCanvasWidget(
        character: state.character,
        onStrokeCompleted: () => controller.onStrokeCompleted(),
        onAllStrokesCompleted: () => controller.onModeCompleted(),
      );
      
    case WritingMode.tracingFree:
      return TracingFreeCanvasWidget(
        character: state.character,
        drawingData: _drawingData,
        onDrawingUpdate: (data) {
          setState(() => _drawingData = data);
        },
        onCompleted: () => controller.onModeCompleted(),
      );
      
    case WritingMode.freeWrite:
      return FreeWritingCanvasWidget(
        drawingData: _drawingData,
        onDrawingUpdate: (data) {
          setState(() => _drawingData = data);
        },
        onCompleted: () => controller.onModeCompleted(),
      );
  }
}
```

### 5. 認識・評価システム統合

```dart
class WritingRecognitionService {
  static final WritingRecognitionService _instance = WritingRecognitionService._internal();
  factory WritingRecognitionService() => _instance;
  WritingRecognitionService._internal();

  Future<RecognitionResult> recognizeCharacter(
    DrawingData drawingData, 
    String targetCharacter,
  ) async {
    // 文字認識ロジック
    // OpenCVやML Kitなどを使用
    
    return RecognitionResult(
      text: recognizedText,
      confidence: confidence,
      isRecognized: confidence > 0.7,
      candidates: alternatives,
    );
  }

  bool evaluateWriting(DrawingData drawingData, String targetCharacter) {
    // 書字評価ロジック
    // ストロークの順序、方向、形状を分析
  }
}
```

## 🚫 避けるべきパターン

以下のパターンは使用しないでください：

1. **直接的なUI状態変更**: StateNotifier以外での状態変更
2. **固定サイズの使用**: ハードコーディングされたピクセル値
3. **同期的な重い処理**: UIをブロックする処理
4. **グローバル変数**: 状態はすべてRiverpodで管理
5. **例外の無視**: 適切なエラーハンドリングを行う

## 📝 命名規則

### ファイル命名
- `your_game_screen.dart` - メイン画面
- `your_game_models.dart` - データモデル
- `modern_your_game_logic.dart` - ロジック層
- `your_game_phase.dart` - フェーズ定義

### クラス命名
- `YourGameScreen` - 画面クラス
- `YourGameSettings` - 設定クラス
- `YourGameState` - 状態クラス
- `ModernYourGameLogic` - ロジッククラス

### 変数・メソッド命名
- `questionText` - TTS用質問文
- `canAnswer` - 回答可能状態
- `isProcessing` - 処理中状態
- `_handleCorrectAnswer` - 内部メソッドは_プレフィックス

---

## 🎯 参考実装

以下のゲームが最新のアーキテクチャに準拠しています：

### 完全準拠ゲーム
- **word_trace_game** - AnswerHandlerMixin, CommonGamePhase, SuccessEffectの最新実装
- **comparison_game** - 基本的なゲームアーキテクチャの参考実装
- **counting_game** - シンプルなゲームの参考実装

### 特殊パターン
- **writing_game** - 複雑なマルチフェーズゲームの実装例

新しいゲームを実装する際は、特に`word_trace_game`を参考にしてください。

---

このガイドラインに従うことで、既存ゲームとの一貫性を保ちながら、保守性の高い新しいゲームを開発できます。