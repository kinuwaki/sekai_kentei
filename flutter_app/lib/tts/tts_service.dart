import 'dart:async';
import 'package:flutter/material.dart';

/// TTS サービスの抽象インターフェース
abstract class TtsService {
  /// 発話状態の変更を通知するStream
  Stream<bool> get speakingChanges;
  
  /// 現在発話中かどうか
  bool get isSpeaking;
  
  /// 基本音声再生
  Future<void> speak(String text, {Function? onComplete});
  
  /// コンテキスト付き音声再生（エラー表示あり）
  Future<void> playTTS(BuildContext context, String text, {Function? onComplete});
  
  /// 音声停止
  Future<void> stop();
  
  /// 数値音声再生
  Future<void> speakNumber(int number, {Function? onComplete});
  
  /// 比較問題用音声再生
  Future<void> speakComparison(String text, {Function? onComplete});
  
  /// 書字指示音声再生
  Future<void> speakWritingInstruction(String character, {Function? onComplete});
  
  /// 連続音声再生
  Future<void> speakSequence(List<String> texts, {Function? onComplete});
  
  /// プリロード機能
  Future<void> preloadText(String text, {int speaker = 0});
  Future<void> preloadTexts(List<String> texts, {int speaker = 0});
  
  /// 状態取得
  Set<String> getMissingFiles();
  String generateMissingFilesReport();
  
  /// リソース解放
  Future<void> dispose();
}