enum TsumikiCountingPhase {
  ready,         // 初期設定画面
  displaying,    // 問題表示中
  questioning,   // ユーザー操作可能
  processing,    // 回答処理中
  feedbackOk,    // 正解フィードバック
  feedbackNg,    // 不正解フィードバック（再試行可能）
  transitioning, // 次の問題への遷移
  completed,     // 全問題完了
}