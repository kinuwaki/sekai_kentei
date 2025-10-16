import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/instant_feedback_service.dart';
import '../../../core/debug_logger.dart';

/// 回答処理の共通パターンを提供するMixin
///
/// 正解/不正解処理のロジックを統一し、各ゲームでの重複を削減
/// 全11ゲームで約500行のコード削減を実現
mixin AnswerHandlerMixin<T> on StateNotifier<T> {
  /// ゲームタイトル（ログ用）
  String get gameTitle => 'Game';

  /// エポックチェック: 競合状態を防ぐために現在のエポックを検証
  ///
  /// [epoch] チェック対象のエポック値
  /// 返値: 現在のエポックと一致すればtrue
  bool checkEpoch(int epoch);

  /// 次の問題または完了画面へ進む
  Future<void> proceedToNext();

  /// 質問フェーズへ戻る（再挑戦用）
  void returnToQuestioning();

  /// 共通の正解処理
  ///
  /// [epoch] エポック値（競合ガード用）
  /// [updateState] 状態更新のコールバック
  /// [feedbackDuration] フィードバック表示時間
  /// [customFeedback] カスタムフィードバック処理（オプション）
  ///
  /// 処理の流れ:
  /// 1. エポックチェック
  /// 2. 状態更新（正解としてマーク）
  /// 3. フィードバック音再生
  /// 4. 演出待機
  /// 5. 次問題へ進む
  Future<void> handleCorrectAnswer({
    required int epoch,
    required VoidCallback updateState,
    Duration feedbackDuration = const Duration(milliseconds: 1500),
    Future<void> Function()? customFeedback,
  }) async {
    if (!checkEpoch(epoch)) {
      Log.d('Epoch mismatch in handleCorrectAnswer, skipping', tag: gameTitle);
      return;
    }

    Log.d('Correct answer - updating state', tag: gameTitle);
    updateState();

    // フィードバック処理
    if (customFeedback != null) {
      await customFeedback();
    } else {
      await InstantFeedbackService().playCorrectAnswerFeedback();
    }

    // 演出待機
    await Future.delayed(feedbackDuration);

    // エポック再チェック
    if (!checkEpoch(epoch)) {
      Log.d('Epoch changed during feedback, skipping proceed', tag: gameTitle);
      return;
    }

    Log.d('Proceeding to next question', tag: gameTitle);
    await proceedToNext();
  }

  /// 共通の不正解処理
  ///
  /// [epoch] エポック値（競合ガード用）
  /// [updateState] 状態更新のコールバック
  /// [allowRetry] 再挑戦を許可するか（true: 再挑戦, false: 次問題へ）
  /// [feedbackDuration] フィードバック表示時間
  /// [customFeedback] カスタムフィードバック処理（オプション）
  ///
  /// 処理の流れ:
  /// 1. エポックチェック
  /// 2. 状態更新（不正解としてマーク）
  /// 3. フィードバック音再生
  /// 4. 演出待機
  /// 5a. allowRetry=true: 質問フェーズへ戻る（再挑戦）
  /// 5b. allowRetry=false: 次問題へ進む
  Future<void> handleWrongAnswer({
    required int epoch,
    required VoidCallback updateState,
    required bool allowRetry,
    Duration feedbackDuration = const Duration(milliseconds: 1000),
    Future<void> Function()? customFeedback,
  }) async {
    if (!checkEpoch(epoch)) {
      Log.d('Epoch mismatch in handleWrongAnswer, skipping', tag: gameTitle);
      return;
    }

    Log.d('Wrong answer - updating state, allowRetry=$allowRetry', tag: gameTitle);
    updateState();

    // フィードバック処理
    if (customFeedback != null) {
      await customFeedback();
    } else {
      await InstantFeedbackService().playWrongAnswerFeedback();
    }

    // 演出待機（不正解は短め）
    await Future.delayed(feedbackDuration);

    // エポック再チェック
    if (!checkEpoch(epoch)) {
      Log.d('Epoch changed during feedback, skipping next step', tag: gameTitle);
      return;
    }

    if (allowRetry) {
      Log.d('Returning to questioning for retry', tag: gameTitle);
      returnToQuestioning();
    } else {
      Log.d('Proceeding to next question without retry', tag: gameTitle);
      await proceedToNext();
    }
  }

  /// 遷移待機: 次問題への遷移前の短いディレイ
  ///
  /// [duration] 遷移時間
  ///
  /// 視覚的な遷移をスムーズにするための待機時間
  Future<void> waitForTransition({
    Duration duration = const Duration(milliseconds: 350),
  }) async {
    await Future.delayed(duration);
  }
}