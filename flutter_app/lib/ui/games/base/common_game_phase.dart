/// 全ゲーム共通の状態フェーズ定義
///
/// 11個の学習ゲーム全体で統一されたフェーズ管理を提供します。
/// フラグ地獄を解決し、一貫した状態遷移を実現します。

import 'base_game_screen.dart' show GameUiPhase;

enum CommonGamePhase {
  /// 初期化直後（設定選択画面）
  /// - ゲーム設定の選択可能
  /// - まだ問題は生成されていない
  ready,

  /// 問題表示中（問題生成後の初期表示）
  /// - 問題内容の表示完了
  /// - ユーザー操作はまだ受け付けない
  /// - アニメーション等の演出が進行中
  displaying,

  /// 質問待ち（選択肢を選べる状態）
  /// - ユーザーが回答可能な状態
  /// - すべての選択肢が操作可能
  /// - メインのゲームプレイフェーズ
  questioning,

  /// 回答処理中（ボタン押下後の判定中）
  /// - 回答判定処理実行中
  /// - 入力ロック状態
  /// - 短時間の処理フェーズ
  processing,

  /// 正解演出中（入力ロック）
  /// - 正解のフィードバック表示
  /// - 効果音・アニメーション実行
  /// - 次問題への自動遷移待ち
  feedbackOk,

  /// 不正解演出中（再挑戦可能/次問題遷移）
  /// - 不正解のフィードバック表示
  /// - ゲームによって再試行 or 次問題進行
  /// - エラー音・アニメーション実行
  feedbackNg,

  /// 次問題へ遷移中（入力ロック）
  /// - 問題間の遷移処理実行中
  /// - 新しい問題の生成・表示準備
  /// - 短時間の遷移フェーズ
  transitioning,

  /// 全問完了（入力ロック）
  /// - すべての問題が終了
  /// - 結果画面表示
  /// - リトライ・メニュー戻り可能
  completed,
}

/// CommonGamePhaseの拡張メソッド
extension CommonGamePhaseExtension on CommonGamePhase {
  /// ユーザー入力を受け付ける状態かどうか
  bool get canAcceptInput {
    switch (this) {
      case CommonGamePhase.questioning:
        return true;
      case CommonGamePhase.ready:
      case CommonGamePhase.displaying:
      case CommonGamePhase.processing:
      case CommonGamePhase.feedbackOk:
      case CommonGamePhase.feedbackNg:
      case CommonGamePhase.transitioning:
      case CommonGamePhase.completed:
        return false;
    }
  }

  /// フィードバック中かどうか
  bool get isInFeedback {
    return this == CommonGamePhase.feedbackOk || this == CommonGamePhase.feedbackNg;
  }

  /// ゲーム進行中かどうか（設定・完了以外）
  bool get isInProgress {
    switch (this) {
      case CommonGamePhase.displaying:
      case CommonGamePhase.questioning:
      case CommonGamePhase.processing:
      case CommonGamePhase.feedbackOk:
      case CommonGamePhase.feedbackNg:
      case CommonGamePhase.transitioning:
        return true;
      case CommonGamePhase.ready:
      case CommonGamePhase.completed:
        return false;
    }
  }

  /// BaseGameScreenのGameUiPhaseへの写像
  /// BaseGameScreen との互換性のため
  GameUiPhase get toGameUiPhase {
    switch (this) {
      case CommonGamePhase.ready:
        return GameUiPhase.settings;
      case CommonGamePhase.completed:
        return GameUiPhase.result;
      case CommonGamePhase.displaying:
      case CommonGamePhase.questioning:
      case CommonGamePhase.processing:
      case CommonGamePhase.feedbackOk:
      case CommonGamePhase.feedbackNg:
      case CommonGamePhase.transitioning:
        return GameUiPhase.playing;
    }
  }

  /// 日本語表示名（デバッグ用）
  String get displayName {
    switch (this) {
      case CommonGamePhase.ready:
        return '設定画面';
      case CommonGamePhase.displaying:
        return '問題表示中';
      case CommonGamePhase.questioning:
        return '回答待ち';
      case CommonGamePhase.processing:
        return '処理中';
      case CommonGamePhase.feedbackOk:
        return '正解演出';
      case CommonGamePhase.feedbackNg:
        return '不正解演出';
      case CommonGamePhase.transitioning:
        return '遷移中';
      case CommonGamePhase.completed:
        return '完了';
    }
  }
}