/// ゲーム内TTS音声テキスト自動生成システム
/// 
/// このシステムは以下の機能を提供します：
/// 1. 全ゲームの音声テキストを統合して自動生成
/// 2. JSON、Dart、CSV形式での出力サポート
/// 3. 重複排除と使用頻度分析
/// 4. デバッグ・テスト用のテキストリスト生成

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tts_text_extractor.dart';
import 'advanced_tts_analyzer.dart';

/// TTSテキスト生成の設定オプション
class TTSGenerationOptions {
  final bool includeStaticTexts;
  final bool includeDynamicTexts;
  final bool includeMeta;
  final bool sortAlphabetically;
  final bool includeFrequency;
  final List<String>? gameTypeFilter;

  const TTSGenerationOptions({
    this.includeStaticTexts = true,
    this.includeDynamicTexts = true,
    this.includeMeta = true,
    this.sortAlphabetically = true,
    this.includeFrequency = false,
    this.gameTypeFilter,
  });
}

/// 生成された音声テキストデータ
class GeneratedTTSData {
  final List<String> allTexts;
  final Map<String, List<String>> gameSpecificTexts;
  final Map<String, int> textFrequency;
  final Map<String, dynamic> metadata;

  const GeneratedTTSData({
    required this.allTexts,
    required this.gameSpecificTexts,
    required this.textFrequency,
    required this.metadata,
  });

  /// JSON形式でシリアライズ
  Map<String, dynamic> toJson() {
    return {
      'metadata': metadata,
      'statistics': {
        'total_texts': allTexts.length,
        'games_count': gameSpecificTexts.keys.length,
        'generated_at': DateTime.now().toIso8601String(),
      },
      'all_texts': allTexts,
      'game_specific_texts': gameSpecificTexts,
      'text_frequency': textFrequency,
    };
  }

  /// 人間が読みやすいフォーマットで出力
  String toReadableFormat() {
    final buffer = StringBuffer();
    
    buffer.writeln('=== ゲーム内音声テキスト一覧 ===');
    buffer.writeln('生成日時: ${DateTime.now()}');
    buffer.writeln('総テキスト数: ${allTexts.length}');
    buffer.writeln('ゲーム数: ${gameSpecificTexts.keys.length}');
    buffer.writeln();
    
    buffer.writeln('=== 全テキスト一覧 ===');
    for (int i = 0; i < allTexts.length; i++) {
      buffer.writeln('${(i + 1).toString().padLeft(3)}. ${allTexts[i]}');
    }
    buffer.writeln();
    
    buffer.writeln('=== ゲーム別テキスト ===');
    for (final entry in gameSpecificTexts.entries) {
      buffer.writeln('--- ${entry.key} (${entry.value.length}件) ---');
      for (final text in entry.value) {
        buffer.writeln('  • $text');
      }
      buffer.writeln();
    }
    
    if (textFrequency.isNotEmpty) {
      buffer.writeln('=== 使用頻度（重複テキスト） ===');
      final sortedByFreq = textFrequency.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      
      for (final entry in sortedByFreq.where((e) => e.value > 1)) {
        buffer.writeln('${entry.value}回: ${entry.key}');
      }
    }
    
    return buffer.toString();
  }

  /// CSV形式で出力
  String toCsv() {
    final buffer = StringBuffer();
    buffer.writeln('テキスト,ゲーム,使用回数');
    
    for (final entry in gameSpecificTexts.entries) {
      final gameType = entry.key;
      for (final text in entry.value) {
        final frequency = textFrequency[text] ?? 1;
        // CSVエスケープ処理
        final escapedText = text.contains(',') ? '"$text"' : text;
        buffer.writeln('$escapedText,$gameType,$frequency');
      }
    }
    
    return buffer.toString();
  }
}

/// メインのTTSテキスト生成システム
class GameTTSTextGenerator {
  /// 全ゲームの音声テキストを統合生成
  static Future<GeneratedTTSData> generateAllTTSTexts({
    TTSGenerationOptions options = const TTSGenerationOptions(),
  }) async {
    // 基本抽出システムからデータを取得
    final basicResult = GameTTSTextExtractor.extractAllTTSTexts();
    
    // 高度解析システムからデータを取得
    final advancedResult = AdvancedTTSTextAnalyzer.performAdvancedAnalysis();
    
    // データを統合
    final Map<String, List<String>> gameSpecificTexts = {};
    final Map<String, int> textFrequency = {};
    final Set<String> allTextsSet = <String>{};
    
    // 基本システムからのデータ統合
    if (options.includeStaticTexts) {
      for (final textInfo in basicResult.staticTexts) {
        if (_shouldIncludeGame(textInfo.gameType, options.gameTypeFilter)) {
          _addToGameTexts(gameSpecificTexts, textInfo.gameType, textInfo.text);
          allTextsSet.add(textInfo.text);
          textFrequency[textInfo.text] = (textFrequency[textInfo.text] ?? 0) + 1;
        }
      }
    }
    
    if (options.includeDynamicTexts) {
      for (final textInfo in basicResult.dynamicTexts) {
        if (_shouldIncludeGame(textInfo.gameType, options.gameTypeFilter)) {
          _addToGameTexts(gameSpecificTexts, textInfo.gameType, textInfo.text);
          allTextsSet.add(textInfo.text);
          textFrequency[textInfo.text] = (textFrequency[textInfo.text] ?? 0) + 1;
        }
      }
    }
    
    // 高度解析システムからのデータ統合
    for (final entry in advancedResult.gameSpecificTexts.entries) {
      if (_shouldIncludeGame(entry.key, options.gameTypeFilter)) {
        for (final text in entry.value) {
          _addToGameTexts(gameSpecificTexts, entry.key, text);
          allTextsSet.add(text);
          textFrequency[text] = (textFrequency[text] ?? 0) + 1;
        }
      }
    }
    
    // ソート処理
    final List<String> allTexts = allTextsSet.toList();
    if (options.sortAlphabetically) {
      allTexts.sort();
      for (final key in gameSpecificTexts.keys) {
        gameSpecificTexts[key]!.sort();
      }
    }
    
    // メタデータ作成
    final metadata = {
      'generation_timestamp': DateTime.now().toIso8601String(),
      'options': {
        'include_static_texts': options.includeStaticTexts,
        'include_dynamic_texts': options.includeDynamicTexts,
        'include_meta': options.includeMeta,
        'sort_alphabetically': options.sortAlphabetically,
        'include_frequency': options.includeFrequency,
        'game_type_filter': options.gameTypeFilter,
      },
      'statistics': {
        'total_unique_texts': allTexts.length,
        'games_analyzed': gameSpecificTexts.keys.length,
        'text_patterns_analyzed': advancedResult.textGenerationPatterns.keys.length,
      },
    };
    
    return GeneratedTTSData(
      allTexts: allTexts,
      gameSpecificTexts: gameSpecificTexts,
      textFrequency: options.includeFrequency ? textFrequency : {},
      metadata: metadata,
    );
  }

  /// 特定のゲームタイプのみの音声テキストを生成
  static Future<GeneratedTTSData> generateGameTTSTexts(
    String gameType, {
    TTSGenerationOptions options = const TTSGenerationOptions(),
  }) async {
    final modifiedOptions = TTSGenerationOptions(
      includeStaticTexts: options.includeStaticTexts,
      includeDynamicTexts: options.includeDynamicTexts,
      includeMeta: options.includeMeta,
      sortAlphabetically: options.sortAlphabetically,
      includeFrequency: options.includeFrequency,
      gameTypeFilter: [gameType],
    );
    
    return generateAllTTSTexts(options: modifiedOptions);
  }

  /// データを各種フォーマットでファイルに出力
  static Future<void> exportTTSTexts(
    GeneratedTTSData data, {
    required String basePath,
    bool exportJson = true,
    bool exportReadable = true,
    bool exportCsv = true,
    bool exportDart = true,
  }) async {
    try {
      if (exportJson) {
        final jsonContent = jsonEncode(data.toJson());
        await _writeFile('${basePath}_tts_texts.json', jsonContent);
      }
      
      if (exportReadable) {
        final readableContent = data.toReadableFormat();
        await _writeFile('${basePath}_tts_texts.txt', readableContent);
      }
      
      if (exportCsv) {
        final csvContent = data.toCsv();
        await _writeFile('${basePath}_tts_texts.csv', csvContent);
      }
      
      if (exportDart) {
        final dartContent = _generateDartConstants(data);
        await _writeFile('${basePath}_tts_constants.dart', dartContent);
      }
      
      debugPrint('TTS texts exported successfully to $basePath');
    } catch (e) {
      debugPrint('Error exporting TTS texts: $e');
      rethrow;
    }
  }

  /// デバッグ・テスト用のサンプルTTSテキスト生成
  static Future<List<String>> generateTestTTSTexts({
    int maxTexts = 50,
  }) async {
    final data = await generateAllTTSTexts();
    final allTexts = data.allTexts;
    
    if (allTexts.length <= maxTexts) {
      return allTexts;
    }
    
    // ランダムサンプリングまたは重要度ベースの選択
    final selectedTexts = <String>[];
    
    // 各ゲームから均等に選択
    final gamesCount = data.gameSpecificTexts.keys.length;
    final textsPerGame = maxTexts ~/ gamesCount;
    final remainder = maxTexts % gamesCount;
    
    int totalAdded = 0;
    for (final entry in data.gameSpecificTexts.entries) {
      final gameTexts = entry.value;
      final numToTake = textsPerGame + (totalAdded < remainder ? 1 : 0);
      
      for (int i = 0; i < numToTake && i < gameTexts.length; i++) {
        selectedTexts.add(gameTexts[i]);
      }
      totalAdded++;
    }
    
    return selectedTexts;
  }

  // ヘルパーメソッド
  static bool _shouldIncludeGame(String gameType, List<String>? filter) {
    return filter == null || filter.contains(gameType);
  }

  static void _addToGameTexts(
    Map<String, List<String>> gameTexts,
    String gameType,
    String text,
  ) {
    gameTexts.putIfAbsent(gameType, () => <String>[]);
    if (!gameTexts[gameType]!.contains(text)) {
      gameTexts[gameType]!.add(text);
    }
  }

  static Future<void> _writeFile(String path, String content) async {
    if (kIsWeb) {
      // Web環境では直接ファイル書き込みはできないため、ログ出力
      debugPrint('Would write to $path:\n$content');
    } else {
      // ネイティブ環境でのファイル出力
      final file = File(path);
      await file.writeAsString(content, encoding: utf8);
    }
  }

  static String _generateDartConstants(GeneratedTTSData data) {
    final buffer = StringBuffer();
    
    buffer.writeln('// Generated TTS text constants');
    buffer.writeln('// Generated at: ${DateTime.now()}');
    buffer.writeln('// Total texts: ${data.allTexts.length}');
    buffer.writeln();
    
    buffer.writeln('class GameTTSConstants {');
    
    // 全テキストリスト
    buffer.writeln('  static const List<String> allTexts = [');
    for (final text in data.allTexts) {
      final escapedText = text.replaceAll('\'', '\\\'');
      buffer.writeln('    \'$escapedText\',');
    }
    buffer.writeln('  ];');
    buffer.writeln();
    
    // ゲーム別テキスト
    for (final entry in data.gameSpecificTexts.entries) {
      final gameType = entry.key.toLowerCase();
      final texts = entry.value;
      
      buffer.writeln('  static const List<String> ${gameType}Texts = [');
      for (final text in texts) {
        final escapedText = text.replaceAll('\'', '\\\'');
        buffer.writeln('    \'$escapedText\',');
      }
      buffer.writeln('  ];');
      buffer.writeln();
    }
    
    buffer.writeln('}');
    
    return buffer.toString();
  }
}