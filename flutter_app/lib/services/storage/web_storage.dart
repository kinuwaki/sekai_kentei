import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'storage_interface.dart';

/// Web用LocalStorageストレージサービス
class WebStorageService implements StorageInterface {
  static const String _settingsKey = 'app_settings';
  static const String _conversationsKey = 'app_conversations';
  static const String _gameDataKey = 'app_gamedata';

  @override
  Future<void> saveSettings(Map<String, dynamic> settings) async {
    try {
      html.window.localStorage[_settingsKey] = jsonEncode(settings);
    } catch (e) {
      debugPrint('Failed to save settings: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> loadSettings() async {
    try {
      final data = html.window.localStorage[_settingsKey];
      if (data != null) {
        return Map<String, dynamic>.from(jsonDecode(data));
      }
      return {};
    } catch (e) {
      debugPrint('Failed to load settings: $e');
      return {};
    }
  }

  @override
  Future<void> saveConversation(ConversationData data) async {
    try {
      final conversations = await loadConversations();
      conversations.removeWhere((c) => c.id == data.id);
      conversations.add(data);
      html.window.localStorage[_conversationsKey] = jsonEncode(
        conversations.map((c) => c.toJson()).toList()
      );
    } catch (e) {
      debugPrint('Failed to save conversation: $e');
    }
  }

  @override
  Future<List<ConversationData>> loadConversations() async {
    try {
      final data = html.window.localStorage[_conversationsKey];
      if (data != null) {
        final list = jsonDecode(data) as List;
        return list.map((item) => ConversationData.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Failed to load conversations: $e');
      return [];
    }
  }

  @override
  Future<ConversationData?> loadConversation(String id) async {
    final conversations = await loadConversations();
    try {
      return conversations.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteConversation(String id) async {
    try {
      final conversations = await loadConversations();
      conversations.removeWhere((c) => c.id == id);
      html.window.localStorage[_conversationsKey] = jsonEncode(
        conversations.map((c) => c.toJson()).toList()
      );
    } catch (e) {
      debugPrint('Failed to delete conversation: $e');
    }
  }

  @override
  Future<void> saveGameData(GameData data) async {
    try {
      final gameData = await loadGameData();
      gameData.add(data);
      html.window.localStorage[_gameDataKey] = jsonEncode(
        gameData.map((g) => g.toJson()).toList()
      );
    } catch (e) {
      debugPrint('Failed to save game data: $e');
    }
  }

  @override
  Future<List<GameData>> loadGameData() async {
    try {
      final data = html.window.localStorage[_gameDataKey];
      if (data != null) {
        final list = jsonDecode(data) as List;
        return list.map((item) => GameData.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Failed to load game data: $e');
      return [];
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      html.window.localStorage.removeWhere((key, value) =>
        key.startsWith('app_'));
    } catch (e) {
      debugPrint('Failed to clear all data: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      html.window.sessionStorage.clear();
    } catch (e) {
      debugPrint('Failed to clear cache: $e');
    }
  }

  @override
  Future<int> getStorageSize() async {
    int size = 0;
    try {
      for (final key in html.window.localStorage.keys) {
        if (key.startsWith('app_')) {
          final value = html.window.localStorage[key];
          if (value != null) {
            size += key.length + value.length;
          }
        }
      }
    } catch (e) {
      debugPrint('Failed to calculate storage size: $e');
    }
    return size * 2; // UTF-16として概算
  }

  @override
  Future<Map<String, dynamic>> exportData() async {
    final settings = await loadSettings();
    final conversations = await loadConversations();
    final gameData = await loadGameData();

    return {
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'settings': settings,
      'conversations': conversations.map((c) => c.toJson()).toList(),
      'gameData': gameData.map((g) => g.toJson()).toList(),
    };
  }

  @override
  Future<void> importData(Map<String, dynamic> data) async {
    try {
      if (data.containsKey('settings')) {
        await saveSettings(Map<String, dynamic>.from(data['settings']));
      }

      if (data.containsKey('conversations')) {
        final conversations = data['conversations'] as List;
        for (final conv in conversations) {
          await saveConversation(ConversationData.fromJson(conv));
        }
      }

      if (data.containsKey('gameData')) {
        final gameDataList = data['gameData'] as List;
        for (final game in gameDataList) {
          await saveGameData(GameData.fromJson(game));
        }
      }
    } catch (e) {
      debugPrint('Failed to import data: $e');
    }
  }
}