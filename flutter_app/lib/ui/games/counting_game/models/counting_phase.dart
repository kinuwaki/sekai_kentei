/// 数かぞえゲームの状態フェーズ
/// 
/// フラグ地獄を解決するための単一状態管理enum
enum CountingPhase {
  /// 初期化直後（設定選択画面）
  ready,
  
  /// ドット表示中（問題生成後の初期表示）
  displaying,
  
  /// 質問待ち（選択肢を選べる状態）
  questioning,
  
  /// 回答処理中（ボタン押下後の判定中）
  processing,
  
  /// 正解演出中（入力ロック）
  feedbackOk,
  
  /// 不正解演出中（再挑戦可能）
  feedbackNg,
  
  /// 次問題へ遷移中（入力ロック）
  transitioning,
  
  /// 全問完了（入力ロック）
  completed,
}