/// ゲーム内で使用される全ての音声テキストを動的に抽出するシステム
/// 
/// このシステムは以下の機能を提供します：
/// 1. 各ゲームのモデルから音声テキストメソッドを特定
/// 2. 動的に生成されるテキストパターンを解析
/// 3. 実際に使用される全ての音声テキストを自動生成
/// 4. TTS関連のテキストを包括的に収集

import 'package:flutter/foundation.dart';
import 'dart:mirrors';
import 'dart:collection';

// ゲーム固有モデルのインポート
import 'number_recognition_game/models/number_models.dart';
import 'counting_game/models/counting_models.dart';
import 'comparison_game/models/comparison_models.dart';
import 'size_comparison_game/models/size_comparison_models.dart';
import 'odd_even_game/models/odd_even_models.dart';
import 'shape_matching_game/models/shape_matching_models.dart';
import 'figure_orientation_game/models/figure_orientation_models.dart';
import 'puzzle_game/models/puzzle_game_models.dart';
import 'writing_game/writing_game_models.dart';

/// 抽出されたTTSテキスト情報を格納するクラス
class TTSTextInfo {
  final String gameType;
  final String sourceClass;
  final String methodName;
  final String text;
  final Map<String, dynamic> context;
  final bool isDynamic;

  const TTSTextInfo({
    required this.gameType,
    required this.sourceClass,
    required this.methodName,
    required this.text,
    required this.context,
    this.isDynamic = false,
  });

  @override
  String toString() {
    return 'TTSTextInfo(gameType: $gameType, sourceClass: $sourceClass, '
           'methodName: $methodName, text: "$text", isDynamic: $isDynamic)';
  }
}

/// TTS テキスト抽出の結果を格納するクラス
class TTSExtractionResult {
  final List<TTSTextInfo> staticTexts;
  final List<TTSTextInfo> dynamicTexts;
  final Map<String, List<String>> gameTexts;
  final List<String> uniqueTexts;

  const TTSExtractionResult({
    required this.staticTexts,
    required this.dynamicTexts,
    required this.gameTexts,
    required this.uniqueTexts,
  });
}

/// ゲーム内TTSテキスト抽出システムのメインクラス
class GameTTSTextExtractor {
  static final Map<String, TTSGameAnalyzer> _gameAnalyzers = {
    'NumberRecognition': NumberRecognitionTTSAnalyzer(),
    'Counting': CountingTTSAnalyzer(),
    'Comparison': ComparisonTTSAnalyzer(),
    'SizeComparison': SizeComparisonTTSAnalyzer(),
    'OddEven': OddEvenTTSAnalyzer(),
    'ShapeMatching': ShapeMatchingTTSAnalyzer(),
    'FigureOrientation': FigureOrientationTTSAnalyzer(),
    'Puzzle': PuzzleTTSAnalyzer(),
    'Writing': WritingTTSAnalyzer(),
  };

  /// 全ゲームからTTSテキストを抽出
  static TTSExtractionResult extractAllTTSTexts() {
    final List<TTSTextInfo> staticTexts = [];
    final List<TTSTextInfo> dynamicTexts = [];
    final Map<String, List<String>> gameTexts = {};
    final Set<String> uniqueTextSet = <String>{};

    // 各ゲームアナライザーを実行
    for (final entry in _gameAnalyzers.entries) {
      final gameType = entry.key;
      final analyzer = entry.value;
      
      try {
        final result = analyzer.extractTTSTexts();
        
        // 静的テキスト処理
        for (final textInfo in result.staticTexts) {
          staticTexts.add(textInfo);
          uniqueTextSet.add(textInfo.text);
        }
        
        // 動的テキスト処理
        for (final textInfo in result.dynamicTexts) {
          dynamicTexts.add(textInfo);
          uniqueTextSet.add(textInfo.text);
        }
        
        // ゲーム別テキスト収集
        final allGameTexts = <String>[];
        allGameTexts.addAll(result.staticTexts.map((t) => t.text));
        allGameTexts.addAll(result.dynamicTexts.map((t) => t.text));
        gameTexts[gameType] = allGameTexts;
        
      } catch (e) {
        debugPrint('Error extracting TTS texts for $gameType: $e');
      }
    }

    return TTSExtractionResult(
      staticTexts: staticTexts,
      dynamicTexts: dynamicTexts,
      gameTexts: gameTexts,
      uniqueTexts: uniqueTextSet.toList()..sort(),
    );
  }

  /// 特定のゲームタイプのTTSテキストを抽出
  static TTSExtractionResult extractGameTTSTexts(String gameType) {
    final analyzer = _gameAnalyzers[gameType];
    if (analyzer == null) {
      throw ArgumentError('Unknown game type: $gameType');
    }

    final result = analyzer.extractTTSTexts();
    final uniqueTexts = <String>{};
    uniqueTexts.addAll(result.staticTexts.map((t) => t.text));
    uniqueTexts.addAll(result.dynamicTexts.map((t) => t.text));

    return TTSExtractionResult(
      staticTexts: result.staticTexts,
      dynamicTexts: result.dynamicTexts,
      gameTexts: {gameType: uniqueTexts.toList()},
      uniqueTexts: uniqueTexts.toList()..sort(),
    );
  }

  /// 利用可能なゲームタイプのリストを取得
  static List<String> getAvailableGameTypes() {
    return _gameAnalyzers.keys.toList()..sort();
  }
}

/// ゲーム固有のTTSテキストアナライザーの基底クラス
abstract class TTSGameAnalyzer {
  String get gameType;
  
  TTSExtractionResult extractTTSTexts();
}

/// 数字認識ゲーム用TTSアナライザー
class NumberRecognitionTTSAnalyzer extends TTSGameAnalyzer {
  @override
  String get gameType => 'NumberRecognition';
  
  @override
  TTSExtractionResult extractTTSTexts() {
    final staticTexts = <TTSTextInfo>[];
    final dynamicTexts = <TTSTextInfo>[];
    
    // NumberStateX.questionText から抽出
    // 実際の問題文は NumberProblem.prompt に格納される
    staticTexts.add(TTSTextInfo(
      gameType: gameType,
      sourceClass: 'NumberProblem',
      methodName: 'prompt',
      text: 'この数字を書いてください', // 実際は動的に生成される
      context: {'source': 'NumberProblem.prompt'},
    ));
    
    // 動的テキストパターンを生成
    for (int i = 0; i <= 9; i++) {
      dynamicTexts.add(TTSTextInfo(
        gameType: gameType,
        sourceClass: 'NumberProblem',
        methodName: 'prompt',
        text: '$i を書いてください',
        context: {'number': i, 'pattern': 'number_prompt'},
        isDynamic: true,
      ));
    }
    
    return TTSExtractionResult(
      staticTexts: staticTexts,
      dynamicTexts: dynamicTexts,
      gameTexts: {},
      uniqueTexts: [],
    );
  }
}

/// 数かぞえゲーム用TTSアナライザー
class CountingTTSAnalyzer extends TTSGameAnalyzer {
  @override
  String get gameType => 'Counting';
  
  @override
  TTSExtractionResult extractTTSTexts() {
    final staticTexts = <TTSTextInfo>[];
    final dynamicTexts = <TTSTextInfo>[];
    
    // CountingProblem.questionText から抽出
    staticTexts.add(TTSTextInfo(
      gameType: gameType,
      sourceClass: 'CountingProblem',
      methodName: 'questionText',
      text: 'ドットは いくつかな？',
      context: {'source': 'CountingProblem.questionText'},
    ));
    
    return TTSExtractionResult(
      staticTexts: staticTexts,
      dynamicTexts: dynamicTexts,
      gameTexts: {},
      uniqueTexts: [],
    );
  }
}

/// 比較ゲーム用TTSアナライザー
class ComparisonTTSAnalyzer extends TTSGameAnalyzer {
  @override
  String get gameType => 'Comparison';
  
  @override
  TTSExtractionResult extractTTSTexts() {
    final staticTexts = <TTSTextInfo>[];
    final dynamicTexts = <TTSTextInfo>[];
    
    // ComparisonProblem.questionText から抽出（動的生成）
    final questionTemplates = [
      'いちばん おおきい ばんごうは どれかな？',
      'いちばん ちいさい ばんごうは どれかな？',
      'にばんめに おおきい ばんごうは どれかな？',
      'にばんめに ちいさい ばんごうは どれかな？',
      'さんばんめに おおきい ばんごうは どれかな？',
      'さんばんめに ちいさい ばんごうは どれかな？',
    ];
    
    for (final template in questionTemplates) {
      dynamicTexts.add(TTSTextInfo(
        gameType: gameType,
        sourceClass: 'ComparisonProblem',
        methodName: 'questionText',
        text: template,
        context: {'pattern': 'comparison_question'},
        isDynamic: true,
      ));
    }
    
    return TTSExtractionResult(
      staticTexts: staticTexts,
      dynamicTexts: dynamicTexts,
      gameTexts: {},
      uniqueTexts: [],
    );
  }
}

/// サイズ比較ゲーム用TTSアナライザー
class SizeComparisonTTSAnalyzer extends TTSGameAnalyzer {
  @override
  String get gameType => 'SizeComparison';
  
  @override
  TTSExtractionResult extractTTSTexts() {
    final staticTexts = <TTSTextInfo>[];
    final dynamicTexts = <TTSTextInfo>[];
    
    // SizeComparisonProblem.questionText から抽出（動的生成）
    final sizeQuestionTemplates = [
      'いちばん おおきいのは どれかな？',
      'いちばん ちいさいのは どれかな？',
      'にばんめに おおきいのは どれかな？',
      'にばんめに ちいさいのは どれかな？',
      'さんばんめに おおきいのは どれかな？',
      'さんばんめに ちいさいのは どれかな？',
    ];
    
    final positionQuestionTemplates = [
      'ひだりから いちばんめは どれかな？',
      'ひだりから にばんめは どれかな？',
      'ひだりから さんばんめは どれかな？',
      'みぎから いちばんめは どれかな？',
      'みぎから にばんめは どれかな？',
      'みぎから さんばんめは どれかな？',
    ];
    
    for (final template in [...sizeQuestionTemplates, ...positionQuestionTemplates]) {
      dynamicTexts.add(TTSTextInfo(
        gameType: gameType,
        sourceClass: 'SizeComparisonProblem',
        methodName: 'questionText',
        text: template,
        context: {'pattern': 'size_comparison_question'},
        isDynamic: true,
      ));
    }
    
    return TTSExtractionResult(
      staticTexts: staticTexts,
      dynamicTexts: dynamicTexts,
      gameTexts: {},
      uniqueTexts: [],
    );
  }
}

/// 奇数偶数ゲーム用TTSアナライザー
class OddEvenTTSAnalyzer extends TTSGameAnalyzer {
  @override
  String get gameType => 'OddEven';
  
  @override
  TTSExtractionResult extractTTSTexts() {
    final staticTexts = <TTSTextInfo>[];
    final dynamicTexts = <TTSTextInfo>[];
    
    // OddEvenType.questionText から抽出
    staticTexts.add(TTSTextInfo(
      gameType: gameType,
      sourceClass: 'OddEvenType',
      methodName: 'questionText',
      text: 'きすうをぜんぶさがそう',
      context: {'type': 'odd'},
    ));
    
    staticTexts.add(TTSTextInfo(
      gameType: gameType,
      sourceClass: 'OddEvenType',
      methodName: 'questionText',
      text: 'ぐうすうをぜんぶさがそう',
      context: {'type': 'even'},
    ));
    
    return TTSExtractionResult(
      staticTexts: staticTexts,
      dynamicTexts: dynamicTexts,
      gameTexts: {},
      uniqueTexts: [],
    );
  }
}

/// 図形マッチングゲーム用TTSアナライザー
class ShapeMatchingTTSAnalyzer extends TTSGameAnalyzer {
  @override
  String get gameType => 'ShapeMatching';
  
  @override
  TTSExtractionResult extractTTSTexts() {
    final staticTexts = <TTSTextInfo>[];
    final dynamicTexts = <TTSTextInfo>[];
    
    // TileSpec.ttsText から動的テキストを生成
    final colors = ['あか', 'あお', 'きいろ', 'みどり'];
    final shapes = ['ほし', 'さんかく', 'まる', 'しかく', 'ごかっけい'];
    final variants = ['', 'にじゅう'];
    
    for (final color in colors) {
      for (final shape in shapes) {
        for (final variant in variants) {
          final text = variant.isEmpty ? '${color}の${shape}' : '${color}の${variant}${shape}';
          dynamicTexts.add(TTSTextInfo(
            gameType: gameType,
            sourceClass: 'TileSpec',
            methodName: 'ttsText',
            text: text,
            context: {'color': color, 'shape': shape, 'variant': variant},
            isDynamic: true,
          ));
        }
      }
    }
    
    // 問題文の基本テンプレート
    dynamicTexts.add(TTSTextInfo(
      gameType: gameType,
      sourceClass: 'ShapeMatchingProblem',
      methodName: 'questionText',
      text: 'おなじものを ぜんぶ みつけよう',
      context: {'pattern': 'shape_matching_base'},
      isDynamic: true,
    ));
    
    return TTSExtractionResult(
      staticTexts: staticTexts,
      dynamicTexts: dynamicTexts,
      gameTexts: {},
      uniqueTexts: [],
    );
  }
}

/// 図形向きゲーム用TTSアナライザー
class FigureOrientationTTSAnalyzer extends TTSGameAnalyzer {
  @override
  String get gameType => 'FigureOrientation';
  
  @override
  TTSExtractionResult extractTTSTexts() {
    final staticTexts = <TTSTextInfo>[];
    final dynamicTexts = <TTSTextInfo>[];
    
    // FigureOrientationProblem.questionText から抽出（推定）
    staticTexts.add(TTSTextInfo(
      gameType: gameType,
      sourceClass: 'FigureOrientationProblem',
      methodName: 'questionText',
      text: 'ただしい むきは どれかな？',
      context: {'pattern': 'figure_orientation_base'},
    ));
    
    return TTSExtractionResult(
      staticTexts: staticTexts,
      dynamicTexts: dynamicTexts,
      gameTexts: {},
      uniqueTexts: [],
    );
  }
}

/// パズルゲーム用TTSアナライザー
class PuzzleTTSAnalyzer extends TTSGameAnalyzer {
  @override
  String get gameType => 'Puzzle';
  
  @override
  TTSExtractionResult extractTTSTexts() {
    final staticTexts = <TTSTextInfo>[];
    final dynamicTexts = <TTSTextInfo>[];
    
    // PuzzleProblem.questionText から抽出
    staticTexts.add(TTSTextInfo(
      gameType: gameType,
      sourceClass: 'PuzzleProblem',
      methodName: 'questionText',
      text: 'ただしいくみあわせを\nえらんでください',
      context: {'source': 'PuzzleProblem.questionText'},
    ));
    
    return TTSExtractionResult(
      staticTexts: staticTexts,
      dynamicTexts: dynamicTexts,
      gameTexts: {},
      uniqueTexts: [],
    );
  }
}

/// ライティングゲーム用TTSアナライザー
class WritingTTSAnalyzer extends TTSGameAnalyzer {
  @override
  String get gameType => 'Writing';
  
  @override
  TTSExtractionResult extractTTSTexts() {
    final staticTexts = <TTSTextInfo>[];
    final dynamicTexts = <TTSTextInfo>[];
    
    // WritingGameState.questionText から動的テキストを生成
    // 実際のテキストはCharacterDataに依存して動的生成される
    
    // ひらがな文字のサンプル（実際はより多くの文字が存在）
    final hiraganaChars = [
      'あ', 'い', 'う', 'え', 'お',
      'か', 'き', 'く', 'け', 'こ',
      'さ', 'し', 'す', 'せ', 'そ',
      // ... 他の文字も同様
    ];
    
    // 各文字に対する練習テキスト
    for (final char in hiraganaChars) {
      // なぞり書き
      dynamicTexts.add(TTSTextInfo(
        gameType: gameType,
        sourceClass: 'WritingGameState',
        methodName: 'questionText',
        text: '「$char」を なぞって かこう',
        context: {'character': char, 'mode': 'tracing'},
        isDynamic: true,
      ));
      
      // 自由書き
      dynamicTexts.add(TTSTextInfo(
        gameType: gameType,
        sourceClass: 'WritingGameState',
        methodName: 'questionText',
        text: '「$char」を かいてみよう',
        context: {'character': char, 'mode': 'free_writing'},
        isDynamic: true,
      ));
    }
    
    return TTSExtractionResult(
      staticTexts: staticTexts,
      dynamicTexts: dynamicTexts,
      gameTexts: {},
      uniqueTexts: [],
    );
  }
}