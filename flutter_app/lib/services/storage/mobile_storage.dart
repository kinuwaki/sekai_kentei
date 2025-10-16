import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'storage_interface.dart';

/// モバイル用ファイルベースストレージサービス
class MobileStorageService implements StorageInterface {
  static const String _saveDirectory = 'save';
  static const String _settingsFile = 'settings.json';
  static const String _conversationsFile = 'conversations.json';
  static const String _gameDataFile = 'gamedata.json';

  /// save ディレクトリのパスを取得
  Future<Directory> _getSaveDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final saveDir = Directory('${appDir.path}/$_saveDirectory');

    if (!await saveDir.exists()) {
      await saveDir.create(recursive: true);
    }

    return saveDir;
  }

  @override
  Future<void> saveSettings(Map<String, dynamic> settings) async {
    try {
      final saveDir = await _getSaveDirectory();
      final file = File('${saveDir.path}/$_settingsFile');
      await file.writeAsString(jsonEncode(settings));

      // SharedPreferencesにもバックアップ
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('backup_settings', jsonEncode(settings));

    } catch (e) {
      debugPrint('Failed to save settings: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> loadSettings() async {
    try {
      final saveDir = await _getSaveDirectory();
      final file = File('${saveDir.path}/$_settingsFile');

      if (await file.exists()) {
        final content = await file.readAsString();
        return Map<String, dynamic>.from(jsonDecode(content));
      }

      // ファイルがない場合はSharedPreferencesから読み込み
      final prefs = await SharedPreferences.getInstance();
      final backup = prefs.getString('backup_settings');
      if (backup != null) {
        return Map<String, dynamic>.from(jsonDecode(backup));
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

      final saveDir = await _getSaveDirectory();
      final file = File('${saveDir.path}/$_conversationsFile');
      await file.writeAsString(jsonEncode(
        conversations.map((c) => c.toJson()).toList()
      ));
    } catch (e) {
      debugPrint('Failed to save conversation: $e');
    }
  }

  @override
  Future<List<ConversationData>> loadConversations() async {
    try {
      final saveDir = await _getSaveDirectory();
      final file = File('${saveDir.path}/$_conversationsFile');

      if (await file.exists()) {
        final content = await file.readAsString();
        final list = jsonDecode(content) as List;
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

      final saveDir = await _getSaveDirectory();
      final file = File('${saveDir.path}/$_conversationsFile');
      await file.writeAsString(jsonEncode(
        conversations.map((c) => c.toJson()).toList()
      ));
    } catch (e) {
      debugPrint('Failed to delete conversation: $e');
    }
  }

  @override
  Future<void> saveGameData(GameData data) async {
    try {
      final gameData = await loadGameData();
      gameData.add(data);

      final saveDir = await _getSaveDirectory();
      final file = File('${saveDir.path}/$_gameDataFile');
      await file.writeAsString(jsonEncode(
        gameData.map((g) => g.toJson()).toList()
      ));
    } catch (e) {
      debugPrint('Failed to save game data: $e');
    }
  }

  @override
  Future<List<GameData>> loadGameData() async {
    try {
      final saveDir = await _getSaveDirectory();
      final file = File('${saveDir.path}/$_gameDataFile');

      if (await file.exists()) {
        final content = await file.readAsString();
        final list = jsonDecode(content) as List;
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
      // saveディレクトリ内を全削除
      final saveDir = await _getSaveDirectory();
      if (await saveDir.exists()) {
        await saveDir.delete(recursive: true);
      }

      // SharedPreferencesのバックアップも削除
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('backup_settings');

    } catch (e) {
      debugPrint('Failed to clear all data: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final cacheDir = await getTemporaryDirectory();
      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
        await cacheDir.create();
      }
    } catch (e) {
      debugPrint('Failed to clear cache: $e');
    }
  }

  @override
  Future<int> getStorageSize() async {
    int totalSize = 0;

    try {
      final saveDir = await _getSaveDirectory();
      if (await saveDir.exists()) {
        await for (final entity in saveDir.list(recursive: true)) {
          if (entity is File) {
            totalSize += await entity.length();
          }
        }
      }
    } catch (e) {
      debugPrint('Failed to calculate storage size: $e');
    }

    return totalSize;
  }

  @override
  Future<Map<String, dynamic>> exportData() async {
    final settings = await loadSettings();
    final conversations = await loadConversations();
    final gameData = await loadGameData();

    return {
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'platform': Platform.operatingSystem,
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