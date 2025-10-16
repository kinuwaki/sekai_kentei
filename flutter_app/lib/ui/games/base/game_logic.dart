import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 共通ゲームロジックインターフェース
/// 全てのゲームロジックはこのインターフェースを実装する
abstract class GameLogic<T> extends StateNotifier<T> {
  GameLogic(super.initialState);

  /// 現在の問題文（nullの場合はスピーカーボタン非表示）
  String? get questionText;
  
  /// ゲーム進行度（0.0〜1.0）
  double get progress;
  
  /// 入力がロックされているかどうか
  bool get isBusy;
  
  /// ゲームタイトル
  String get gameTitle;
  
  /// サブタイトル
  String get subtitle;
  
  /// 数字入力API（数字を扱うゲーム用）
  Future<void> submitNumber(int number) async {
    // デフォルト実装：何もしない
    debugPrint('GameLogic: submitNumber($number) - not implemented');
  }
  
  /// テキスト入力API（文字を扱うゲーム用）
  Future<void> submitText(String text) async {
    // デフォルト実装：何もしない
    debugPrint('GameLogic: submitText($text) - not implemented');
  }
  
  /// 選択肢入力API（選択ゲーム用）
  Future<void> submitChoice(int index) async {
    // デフォルト実装：何もしない
    debugPrint('GameLogic: submitChoice($index) - not implemented');
  }
  
  /// ゲームリセット
  void resetGame();
  
  /// リソース解放
  @override
  void dispose() {
    super.dispose();
  }
}

/// 現在のゲームロジックプロバイダー
/// 各画面で適切なGameLogicを提供するようにオーバーライドする
final currentGameLogicProvider = Provider<GameLogic<dynamic>>((ref) {
  throw UnimplementedError('currentGameLogicProviderをオーバーライドしてください');
});