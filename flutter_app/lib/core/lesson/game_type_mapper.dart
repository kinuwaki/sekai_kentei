import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../ui/games/counting_game/counting_game_screen.dart';
import '../../ui/games/counting_game/models/counting_models.dart';
import '../../ui/games/comparison_game/comparison_game_screen.dart';
import '../../ui/games/comparison_game/models/comparison_models.dart';
import '../../ui/games/figure_orientation_game/figure_orientation_game_screen.dart';
import '../../ui/games/shape_matching_game/shape_matching_screen.dart';
import '../../ui/games/writing_game/writing_practice_screen.dart';
import '../../ui/games/writing_game/writing_practice_settings.dart';
import '../../ui/games/writing_game/writing_game_models.dart';
import '../../ui/games/word_game/word_game_screen.dart';
import '../../ui/games/word_game/models/word_game_models.dart';

/// ゲームタイプとウィジェットのマッピングシステム
class GameTypeMapper {

  /// YAMLのゲームタイプからゲーム画面を動的に生成
  static Widget? createGameScreen(Map<String, dynamic> gameConfig) {
    final gameType = gameConfig['type'] as String?;
    if (gameType == null) return null;

    switch (gameType) {
      case 'counting.v1':
        return _createCountingGame(gameConfig);
      case 'figureOrientation.v1':
        return _createFigureOrientationGame(gameConfig);
      case 'shapeMatching.v1':
        return _createShapeMatchingGame(gameConfig);
      case 'comparison.v1':
        return _createComparisonGame(gameConfig);
      case 'writing.v1':
        return _createWritingGame(gameConfig);
      case 'wordGame.v1':
        return _createWordGame(gameConfig);
      default:
        return null;
    }
  }

  /// カウンティングゲーム作成
  static Widget _createCountingGame(Map<String, dynamic> config) {
    final range = _parseCountingRange(config['range'] as String? ?? '1-5');
    final questionCount = config['questionCount'] as int? ?? 5;

    final settings = CountingGameSettings(
      range: range,
      questionCount: questionCount,
    );

    return CountingGameScreen(
      initialSettings: settings,
    );
  }

  /// 図形方向ゲーム作成
  static Widget _createFigureOrientationGame(Map<String, dynamic> config) {
    return FigureOrientationGameScreen();
  }

  /// 形マッチングゲーム作成
  static Widget _createShapeMatchingGame(Map<String, dynamic> config) {
    return ShapeMatchingScreen();
  }

  /// 比較ゲーム作成
  static Widget _createComparisonGame(Map<String, dynamic> config) {
    final range = _parseComparisonRange(config['range'] as String? ?? '1-5');
    final displayType = _parseDisplayType(config['displayType'] as String? ?? 'dots');
    final questionType = _parseQuestionType(config['questionType'] as String? ?? 'fixedLargest');
    final optionCount = config['optionCount'] as int? ?? 3;
    final questionCount = config['questionCount'] as int? ?? 5;

    final settings = ComparisonGameSettings(
      displayType: displayType,
      range: range,
      optionCount: optionCount,
      questionType: questionType,
      questionCount: questionCount,
    );

    return ComparisonGameScreen(
      initialSettings: settings,
    );
  }

  /// 文字練習ゲーム作成
  static Widget _createWritingGame(Map<String, dynamic> config) {
    final characterId = config['characterId'] as String? ?? 'あ';
    final sequence = (config['sequence'] as List?)?.cast<String>() ?? ['tracing'];

    // ProviderScopeでWritingPracticeSettingsを提供
    return ProviderScope(
      overrides: [
        writingPracticeSettingsProvider.overrideWith((ref) =>
          WritingPracticeSettings(
            character: characterId,
            sequence: sequence.map((mode) => _parseWritingMode(mode)).toList(),
          ),
        ),
      ],
      child: WritingPracticeScreen(),
    );
  }

  /// CountingRange列挙型への変換
  static CountingRange _parseCountingRange(String rangeStr) {
    switch (rangeStr) {
      case '1-5':
        return CountingRange.range1to5;
      case '5-10':
        return CountingRange.range5to10;
      case '1-10':
        return CountingRange.range1to10;
      default:
        return CountingRange.range1to5;
    }
  }

  /// ComparisonRange列挙型への変換
  static ComparisonRange _parseComparisonRange(String rangeStr) {
    switch (rangeStr) {
      case '1-5':
        return ComparisonRange.range1to5;
      case '5-10':
        return ComparisonRange.range5to10;
      case '10-20':
        return ComparisonRange.range10to20;
      case '20-30':
        return ComparisonRange.range20to30;
      case '30-40':
        return ComparisonRange.range30to40;
      default:
        return ComparisonRange.range1to5;
    }
  }

  /// ComparisonDisplayType列挙型への変換
  static ComparisonDisplayType _parseDisplayType(String typeStr) {
    switch (typeStr) {
      case 'dots':
        return ComparisonDisplayType.dots;
      case 'digits':
        return ComparisonDisplayType.digits;
      default:
        return ComparisonDisplayType.dots;
    }
  }

  /// ComparisonQuestionType列挙型への変換
  static ComparisonQuestionType _parseQuestionType(String typeStr) {
    switch (typeStr) {
      case 'fixedLargest':
        return ComparisonQuestionType.fixedLargest;
      case 'fixedSmallest':
        return ComparisonQuestionType.fixedSmallest;
      case 'advanced':
        return ComparisonQuestionType.advanced;
      default:
        return ComparisonQuestionType.fixedLargest;
    }
  }


  /// WritingMode列挙型への変換
  static WritingMode _parseWritingMode(String modeStr) {
    switch (modeStr) {
      case 'tracing':
        return WritingMode.tracing;
      case 'tracingFree':
        return WritingMode.tracingFree;
      case 'freeWrite':
        return WritingMode.freeWrite;
      default:
        return WritingMode.tracing;
    }
  }

  /// 単語ゲーム作成
  static Widget _createWordGame(Map<String, dynamic> config) {
    final mode = _parseWordGameMode(config['scriptType'] as String? ?? 'hiragana');
    final questionType = _parseWordGameQuestionType(config['questionType'] as String? ?? 'pictureToText');
    final questionCount = config['questionCount'] as int? ?? 5;

    final settings = WordGameSettings(
      mode: mode,
      questionType: questionType,
      questionCount: questionCount,
    );

    return WordGameScreen(
      initialSettings: settings,
    );
  }

  /// WordGameMode列挙型への変換
  static WordGameMode _parseWordGameMode(String modeStr) {
    switch (modeStr) {
      case 'hiragana':
        return WordGameMode.hiraganaMode;
      case 'katakana':
        return WordGameMode.katakanaMode;
      default:
        return WordGameMode.hiraganaMode;
    }
  }

  /// WordGame QuestionType列挙型への変換
  static QuestionType _parseWordGameQuestionType(String typeStr) {
    switch (typeStr) {
      case 'pictureToText':
        return QuestionType.pictureToText;
      case 'textToPicture':
        return QuestionType.textToPicture;
      default:
        return QuestionType.pictureToText;
    }
  }

  /// サポートされているゲームタイプ一覧
  static const List<String> supportedGameTypes = [
    'counting.v1',
    'figureOrientation.v1',
    'shapeMatching.v1',
    'comparison.v1',
    'writing.v1',
    'wordGame.v1',
  ];

  /// ゲームタイプの表示名
  static String getGameDisplayName(String gameType) {
    switch (gameType) {
      case 'counting.v1':
        return 'ドット数え';
      case 'figureOrientation.v1':
        return '図形向き';
      case 'shapeMatching.v1':
        return '形マッチング';
      case 'comparison.v1':
        return '大小比較';
      case 'writing.v1':
        return '文字練習';
      case 'wordGame.v1':
        return 'たんご';
      default:
        return '不明なゲーム';
    }
  }
}