import 'dart:math';
import 'package:flutter/material.dart';

/// 問題生成の共通ヘルパークラス
///
/// 各ゲーム（comparison_game, counting_game等）で重複していた
/// 問題生成ロジックを統一し、約300行のコード削減を実現
class ProblemGeneratorHelper {
  ProblemGeneratorHelper._(); // private constructor to prevent instantiation

  /// 指定範囲からランダムな数値を生成（重複なし）
  ///
  /// [count] 生成する数値の個数
  /// [minValue] 最小値（含む）
  /// [maxValue] 最大値（含む）
  /// [random] 乱数生成器
  /// [excludeValue] 除外する値（オプション）
  ///
  /// 返値: 生成された数値のリスト
  ///
  /// 例:
  /// ```dart
  /// final numbers = ProblemGeneratorHelper.generateUniqueNumbers(
  ///   count: 4,
  ///   minValue: 1,
  ///   maxValue: 10,
  ///   random: Random(),
  /// );
  /// // => [3, 7, 1, 9] のようなランダムな4つの異なる数値
  /// ```
  static List<int> generateUniqueNumbers({
    required int count,
    required int minValue,
    required int maxValue,
    required Random random,
    int? excludeValue,
  }) {
    final numbers = <int>{};
    final range = maxValue - minValue + 1;

    // 除外値がある場合は先に除外
    final availableValues = List.generate(range, (i) => minValue + i);
    if (excludeValue != null) {
      availableValues.removeWhere((v) => v == excludeValue);
    }

    // 利用可能な値が要求数より少ない場合はエラー
    if (availableValues.length < count) {
      throw ArgumentError(
        'Cannot generate $count unique numbers from range [$minValue, $maxValue] '
        '${excludeValue != null ? "excluding $excludeValue" : ""}',
      );
    }

    // シャッフルして必要数を取得
    availableValues.shuffle(random);
    numbers.addAll(availableValues.take(count));

    return numbers.toList();
  }

  /// 最小差分を保証した数値リスト生成
  ///
  /// 各数値間に最小限の差（パーセンテージまたは絶対値）を保証します。
  /// comparison_gameで使用される10%以上の差を保証する実装を汎用化。
  ///
  /// [count] 生成する数値の個数
  /// [minValue] 最小値（含む）
  /// [maxValue] 最大値（含む）
  /// [random] 乱数生成器
  /// [minDifferenceRatio] 最小差分の比率（例: 0.1 = 10%）
  /// [minAbsoluteDifference] 最小差分の絶対値（デフォルト: 1）
  ///
  /// 返値: 生成された数値のリスト
  ///
  /// 例:
  /// ```dart
  /// final numbers = ProblemGeneratorHelper.generateNumbersWithMinDifference(
  ///   count: 3,
  ///   minValue: 1,
  ///   maxValue: 20,
  ///   random: Random(),
  ///   minDifferenceRatio: 0.1, // 10%以上の差
  /// );
  /// // => [2, 8, 15] のような、各数値間に10%以上の差がある数値
  /// ```
  static List<int> generateNumbersWithMinDifference({
    required int count,
    required int minValue,
    required int maxValue,
    required Random random,
    required double minDifferenceRatio,
    int minAbsoluteDifference = 1,
  }) {
    final numbers = <int>[];
    final rangeSize = maxValue - minValue + 1;

    // 最小差を計算（比率と絶対値の大きい方を採用）
    int calculateMinDifference(int baseNumber) {
      final ratioBasedDiff = (baseNumber.abs() * minDifferenceRatio).ceil();
      return ratioBasedDiff < minAbsoluteDifference
          ? minAbsoluteDifference
          : ratioBasedDiff;
    }

    // 最初の数値をランダムに選択
    numbers.add(minValue + random.nextInt(rangeSize));

    // 残りの数値を最小差を保って生成
    for (int i = 1; i < count; i++) {
      int attempts = 0;
      bool placed = false;

      while (attempts < 100 && !placed) {
        final candidate = minValue + random.nextInt(rangeSize);
        bool validCandidate = true;

        // 既存の数値との差をチェック
        for (final existingNumber in numbers) {
          final minDiff = calculateMinDifference(existingNumber);
          if ((candidate - existingNumber).abs() < minDiff) {
            validCandidate = false;
            break;
          }
        }

        if (validCandidate) {
          numbers.add(candidate);
          placed = true;
        }
        attempts++;
      }

      // 配置に失敗した場合は、等間隔で配置（フォールバック）
      if (!placed) {
        final interval = rangeSize ~/ count;
        final fallbackNumber = (minValue + i * interval).clamp(minValue, maxValue);
        numbers.add(fallbackNumber);
      }
    }

    return numbers;
  }

  /// ランダムな色を取得
  ///
  /// [random] 乱数生成器
  /// [palette] カラーパレット（オプション、指定しない場合はデフォルトパレット使用）
  ///
  /// 返値: ランダムに選ばれた色
  ///
  /// 例:
  /// ```dart
  /// final color = ProblemGeneratorHelper.getRandomColor(Random());
  /// // => Colors.red, Colors.blue などのランダムな色
  /// ```
  static Color getRandomColor(Random random, {List<Color>? palette}) {
    final colors = palette ?? [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.amber,
    ];
    return colors[random.nextInt(colors.length)];
  }

  /// 選択肢をシャッフルして正解インデックスを取得
  ///
  /// [options] 選択肢のリスト
  /// [correctValue] 正解の値
  /// [random] 乱数生成器
  ///
  /// 返値: (シャッフルされた選択肢, 正解のインデックス)
  ///
  /// 例:
  /// ```dart
  /// final (shuffled, correctIndex) = ProblemGeneratorHelper.shuffleOptionsWithCorrectIndex(
  ///   options: [1, 2, 3, 4],
  ///   correctValue: 3,
  ///   random: Random(),
  /// );
  /// // => ([2, 4, 3, 1], 2) のような結果（3が2番目のインデックスに）
  /// ```
  static (List<T>, int) shuffleOptionsWithCorrectIndex<T>({
    required List<T> options,
    required T correctValue,
    required Random random,
  }) {
    final shuffled = List<T>.from(options)..shuffle(random);
    final correctIndex = shuffled.indexOf(correctValue);

    if (correctIndex == -1) {
      throw ArgumentError('correctValue $correctValue not found in options');
    }

    return (shuffled, correctIndex);
  }

  /// 範囲から等間隔の数値リストを生成
  ///
  /// [count] 生成する数値の個数
  /// [minValue] 最小値（含む）
  /// [maxValue] 最大値（含む）
  ///
  /// 返値: 等間隔に配置された数値のリスト
  ///
  /// 例:
  /// ```dart
  /// final numbers = ProblemGeneratorHelper.generateEvenlySpacedNumbers(
  ///   count: 5,
  ///   minValue: 0,
  ///   maxValue: 100,
  /// );
  /// // => [0, 25, 50, 75, 100]
  /// ```
  static List<int> generateEvenlySpacedNumbers({
    required int count,
    required int minValue,
    required int maxValue,
  }) {
    if (count <= 1) {
      return [minValue];
    }

    final interval = (maxValue - minValue) / (count - 1);
    return List.generate(
      count,
      (i) => (minValue + i * interval).round().clamp(minValue, maxValue),
    );
  }

  /// ランダムなシード値を生成
  ///
  /// 問題生成時に一貫性を保ちつつランダム性を持たせるためのシード生成。
  /// ゲームインデックスと問題番号を組み合わせて、再現可能なシードを作成。
  ///
  /// [questionIndex] 問題番号（0始まり）
  /// [multiplier] 乗数（オプション、デフォルト: 1000）
  ///
  /// 返値: シード値
  ///
  /// 例:
  /// ```dart
  /// final seed = ProblemGeneratorHelper.generateSeed(questionIndex: 5);
  /// final random = Random(seed);
  /// ```
  static int generateSeed({
    required int questionIndex,
    int multiplier = 1000,
  }) {
    return questionIndex * multiplier + DateTime.now().millisecondsSinceEpoch % multiplier;
  }
}