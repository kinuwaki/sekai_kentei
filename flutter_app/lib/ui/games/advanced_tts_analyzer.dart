/// 高度なTTSテキスト解析システム
/// 
/// 実際のゲームロジックから動的テキスト生成パターンを解析し、
/// 全ての可能な音声テキストを網羅的に抽出します。

import 'package:flutter/foundation.dart';
import 'dart:collection';

// ゲーム固有のロジックファイルの参照が必要な場合のインポート（コメントアウト）
// import 'comparison_game/modern_comparison_logic.dart';
// import 'size_comparison_game/modern_size_comparison_logic.dart';

/// 高度なTTSテキスト解析結果
class AdvancedTTSAnalysisResult {
  final Map<String, List<String>> gameSpecificTexts;
  final Map<String, Map<String, dynamic>> textGenerationPatterns;
  final List<String> allPossibleTexts;
  final Map<String, int> textFrequency;

  const AdvancedTTSAnalysisResult({
    required this.gameSpecificTexts,
    required this.textGenerationPatterns,
    required this.allPossibleTexts,
    required this.textFrequency,
  });
}

/// 比較ゲームの高度TTS解析
class ComparisonGameAdvancedAnalyzer {
  /// 比較ゲームで生成される全ての可能な問題文を解析
  static List<String> analyzeComparisonQuestionPatterns() {
    final List<String> questionTexts = [];
    
    // 基本的な比較タイプ
    final comparisonTypes = [
      {'order': 'いちばん', 'size': 'おおきい'},
      {'order': 'いちばん', 'size': 'ちいさい'},
      {'order': 'にばんめに', 'size': 'おおきい'},
      {'order': 'にばんめに', 'size': 'ちいさい'},
      {'order': 'さんばんめに', 'size': 'おおきい'},
      {'order': 'さんばんめに', 'size': 'ちいさい'},
      {'order': 'よんばんめに', 'size': 'おおきい'},
      {'order': 'よんばんめに', 'size': 'ちいさい'},
      {'order': 'ごばんめに', 'size': 'おおきい'},
      {'order': 'ごばんめに', 'size': 'ちいさい'},
    ];
    
    // 問題文パターン生成
    for (final type in comparisonTypes) {
      final questionText = '${type['order']} ${type['size']} ばんごうは どれかな？';
      questionTexts.add(questionText);
    }
    
    return questionTexts;
  }
}

/// サイズ比較ゲームの高度TTS解析
class SizeComparisonGameAdvancedAnalyzer {
  /// サイズ比較ゲームで生成される全ての可能な問題文を解析
  static List<String> analyzeSizeComparisonQuestionPatterns() {
    final List<String> questionTexts = [];
    
    // サイズベースの比較
    final sizeComparisons = [
      'いちばん おおきいのは どれかな？',
      'いちばん ちいさいのは どれかな？',
      'にばんめに おおきいのは どれかな？',
      'にばんめに ちいさいのは どれかな？',
      'さんばんめに おおきいのは どれかな？',
      'さんばんめに ちいさいのは どれかな？',
      'よんばんめに おおきいのは どれかな？',
      'よんばんめに ちいさいのは どれかな？',
      'ごばんめに おおきいのは どれかな？',
      'ごばんめに ちいさいのは どれかな？',
    ];
    
    // ポジションベースの比較
    final positionComparisons = [
      'ひだりから いちばんめは どれかな？',
      'ひだりから にばんめは どれかな？',
      'ひだりから さんばんめは どれかな？',
      'ひだりから よんばんめは どれかな？',
      'ひだりから ごばんめは どれかな？',
      'みぎから いちばんめは どれかな？',
      'みぎから にばんめは どれかな？',
      'みぎから さんばんめは どれかな？',
      'みぎから よんばんめは どれかな？',
      'みぎから ごばんめは どれかな？',
    ];
    
    questionTexts.addAll(sizeComparisons);
    questionTexts.addAll(positionComparisons);
    
    return questionTexts;
  }
}

/// 数字認識ゲームの高度TTS解析
class NumberRecognitionGameAdvancedAnalyzer {
  /// 数字認識ゲームで生成される全ての可能な問題文を解析
  static List<String> analyzeNumberRecognitionQuestionPatterns() {
    final List<String> questionTexts = [];
    
    // 0-9の各数字に対する問題文
    for (int i = 0; i <= 9; i++) {
      questionTexts.add('$i を書いてください');
      questionTexts.add('すうじの $i を かいてください');
    }
    
    // 10-99の数字（より高度な問題）
    for (int i = 10; i <= 99; i++) {
      questionTexts.add('$i を書いてください');
    }
    
    return questionTexts;
  }
}

/// ライティングゲームの高度TTS解析
class WritingGameAdvancedAnalyzer {
  /// ライティングゲームで生成される全ての可能な問題文を解析
  static List<String> analyzeWritingQuestionPatterns() {
    final List<String> questionTexts = [];
    
    // ひらがな文字リスト（50音）
    final hiraganaChars = [
      'あ', 'い', 'う', 'え', 'お',
      'か', 'き', 'く', 'け', 'こ',
      'が', 'ぎ', 'ぐ', 'げ', 'ご',
      'さ', 'し', 'す', 'せ', 'そ',
      'ざ', 'じ', 'ず', 'ぜ', 'ぞ',
      'た', 'ち', 'つ', 'て', 'と',
      'だ', 'ぢ', 'づ', 'で', 'ど',
      'な', 'に', 'ぬ', 'ね', 'の',
      'は', 'ひ', 'ふ', 'へ', 'ほ',
      'ば', 'び', 'ぶ', 'べ', 'ぼ',
      'ぱ', 'ぴ', 'ぷ', 'ぺ', 'ぽ',
      'ま', 'み', 'む', 'め', 'も',
      'や', 'ゆ', 'よ',
      'ら', 'り', 'る', 'れ', 'ろ',
      'わ', 'ゐ', 'ゑ', 'を', 'ん',
    ];
    
    // カタカナ文字リスト
    final katakanaChars = [
      'ア', 'イ', 'ウ', 'エ', 'オ',
      'カ', 'キ', 'ク', 'ケ', 'コ',
      'ガ', 'ギ', 'グ', 'ゲ', 'ゴ',
      'サ', 'シ', 'ス', 'セ', 'ソ',
      'ザ', 'ジ', 'ズ', 'ゼ', 'ゾ',
      'タ', 'チ', 'ツ', 'テ', 'ト',
      'ダ', 'ヂ', 'ヅ', 'デ', 'ド',
      'ナ', 'ニ', 'ヌ', 'ネ', 'ノ',
      'ハ', 'ヒ', 'フ', 'ヘ', 'ホ',
      'バ', 'ビ', 'ブ', 'ベ', 'ボ',
      'パ', 'ピ', 'プ', 'ペ', 'ポ',
      'マ', 'ミ', 'ム', 'メ', 'モ',
      'ヤ', 'ユ', 'ヨ',
      'ラ', 'リ', 'ル', 'レ', 'ロ',
      'ワ', 'ヰ', 'ヱ', 'ヲ', 'ン',
    ];
    
    // 各文字に対する練習モード別テキスト生成
    final modes = [
      {'name': 'tracing', 'template': '「{}」を なぞって かこう'},
      {'name': 'free_writing', 'template': '「{}」を かいてみよう'},
      {'name': 'practice', 'template': '「{}」の れんしゅうを しよう'},
    ];
    
    // ひらがな
    for (final char in hiraganaChars) {
      for (final mode in modes) {
        questionTexts.add(mode['template']!.replaceAll('{}', char));
      }
    }
    
    // カタカナ
    for (final char in katakanaChars) {
      for (final mode in modes) {
        questionTexts.add(mode['template']!.replaceAll('{}', char));
      }
    }
    
    return questionTexts;
  }
}

/// 図形マッチングゲームの高度TTS解析
class ShapeMatchingGameAdvancedAnalyzer {
  /// 図形マッチングゲームで生成される全ての可能なテキストを解析
  static List<String> analyzeShapeMatchingTexts() {
    final List<String> allTexts = [];
    
    // 色の定義
    final colors = [
      {'name': 'あか', 'code': 'red'},
      {'name': 'あお', 'code': 'blue'},
      {'name': 'きいろ', 'code': 'yellow'},
      {'name': 'みどり', 'code': 'green'},
    ];
    
    // 図形の定義
    final shapes = [
      {'name': 'ほし', 'code': 'star'},
      {'name': 'さんかく', 'code': 'triangle'},
      {'name': 'まる', 'code': 'circle'},
      {'name': 'しかく', 'code': 'square'},
      {'name': 'ごかっけい', 'code': 'pentagon'},
    ];
    
    // バリアントの定義
    final variants = [
      {'name': '', 'code': 'plain'},
      {'name': 'にじゅう', 'code': 'double'},
    ];
    
    // 全ての組み合わせのTTSテキストを生成
    for (final color in colors) {
      for (final shape in shapes) {
        for (final variant in variants) {
          if (variant['name']!.isEmpty) {
            allTexts.add('${color['name']}の${shape['name']}');
          } else {
            allTexts.add('${color['name']}の${variant['name']}${shape['name']}');
          }
        }
      }
    }
    
    // 問題文のバリエーション
    final questionTemplates = [
      'おなじものを ぜんぶ みつけよう',
      'おなじ いろの ものを みつけよう',
      'おなじ かたちの ものを みつけよう',
      'これと おなじものは どれかな？',
    ];
    
    allTexts.addAll(questionTemplates);
    
    return allTexts;
  }
}

/// メインの高度TTS解析システム
class AdvancedTTSTextAnalyzer {
  /// 全ゲームの高度解析を実行
  static AdvancedTTSAnalysisResult performAdvancedAnalysis() {
    final Map<String, List<String>> gameSpecificTexts = {};
    final Map<String, Map<String, dynamic>> textGenerationPatterns = {};
    final List<String> allTexts = [];
    final Map<String, int> textFrequency = {};
    
    // 各ゲームの解析実行
    
    // 1. 比較ゲーム
    final comparisonTexts = ComparisonGameAdvancedAnalyzer.analyzeComparisonQuestionPatterns();
    gameSpecificTexts['Comparison'] = comparisonTexts;
    allTexts.addAll(comparisonTexts);
    textGenerationPatterns['Comparison'] = {
      'pattern_type': 'order_size_combination',
      'variables': ['order', 'size'],
      'template': '{order} {size} ばんごうは どれかな？',
    };
    
    // 2. サイズ比較ゲーム
    final sizeComparisonTexts = SizeComparisonGameAdvancedAnalyzer.analyzeSizeComparisonQuestionPatterns();
    gameSpecificTexts['SizeComparison'] = sizeComparisonTexts;
    allTexts.addAll(sizeComparisonTexts);
    textGenerationPatterns['SizeComparison'] = {
      'pattern_type': 'size_position_combination',
      'variables': ['size_order', 'position_direction'],
      'templates': [
        '{order} {size}のは どれかな？',
        '{direction}から {position}は どれかな？'
      ],
    };
    
    // 3. 数字認識ゲーム
    final numberRecognitionTexts = NumberRecognitionGameAdvancedAnalyzer.analyzeNumberRecognitionQuestionPatterns();
    gameSpecificTexts['NumberRecognition'] = numberRecognitionTexts;
    allTexts.addAll(numberRecognitionTexts);
    textGenerationPatterns['NumberRecognition'] = {
      'pattern_type': 'number_prompt',
      'variables': ['number'],
      'template': '{number} を書いてください',
    };
    
    // 4. ライティングゲーム
    final writingTexts = WritingGameAdvancedAnalyzer.analyzeWritingQuestionPatterns();
    gameSpecificTexts['Writing'] = writingTexts;
    allTexts.addAll(writingTexts);
    textGenerationPatterns['Writing'] = {
      'pattern_type': 'character_mode_combination',
      'variables': ['character', 'mode'],
      'templates': [
        '「{character}」を なぞって かこう',
        '「{character}」を かいてみよう',
      ],
    };
    
    // 5. 図形マッチングゲーム
    final shapeMatchingTexts = ShapeMatchingGameAdvancedAnalyzer.analyzeShapeMatchingTexts();
    gameSpecificTexts['ShapeMatching'] = shapeMatchingTexts;
    allTexts.addAll(shapeMatchingTexts);
    textGenerationPatterns['ShapeMatching'] = {
      'pattern_type': 'color_shape_variant_combination',
      'variables': ['color', 'shape', 'variant'],
      'template': '{color}の{variant}{shape}',
    };
    
    // 6. その他の固定テキスト
    final staticTexts = [
      'ドットは いくつかな？', // Counting
      'きすうをぜんぶさがそう', // OddEven (odd)
      'ぐうすうをぜんぶさがそう', // OddEven (even)
      'ただしい むきは どれかな？', // FigureOrientation
      'ただしいくみあわせを\nえらんでください', // Puzzle
    ];
    
    gameSpecificTexts['Static'] = staticTexts;
    allTexts.addAll(staticTexts);
    
    // 頻度カウント
    for (final text in allTexts) {
      textFrequency[text] = (textFrequency[text] ?? 0) + 1;
    }
    
    return AdvancedTTSAnalysisResult(
      gameSpecificTexts: gameSpecificTexts,
      textGenerationPatterns: textGenerationPatterns,
      allPossibleTexts: allTexts.toSet().toList()..sort(),
      textFrequency: textFrequency,
    );
  }
  
  /// 特定のゲームタイプの解析結果を取得
  static List<String> getGameSpecificTexts(String gameType) {
    final result = performAdvancedAnalysis();
    return result.gameSpecificTexts[gameType] ?? [];
  }
  
  /// 全ユニークテキストの取得
  static List<String> getAllUniqueTexts() {
    final result = performAdvancedAnalysis();
    return result.allPossibleTexts;
  }
  
  /// テキスト生成パターンの取得
  static Map<String, Map<String, dynamic>> getTextGenerationPatterns() {
    final result = performAdvancedAnalysis();
    return result.textGenerationPatterns;
  }
}