import 'storage_interface.dart';

/// モバイルプラットフォーム用のWebStorageServiceスタブ
class WebStorageService implements StorageInterface {
  @override
  Future<void> saveSettings(Map<String, dynamic> settings) async {
    throw UnsupportedError('WebStorageService is not available on mobile platforms');
  }

  @override
  Future<Map<String, dynamic>> loadSettings() async {
    throw UnsupportedError('WebStorageService is not available on mobile platforms');
  }

  @override
  Future<void> saveConversation(ConversationData data) async {
    throw UnsupportedError('WebStorageService is not available on mobile platforms');
  }

  @override
  Future<List<ConversationData>> loadConversations() async {
    throw UnsupportedError('WebStorageService is not available on mobile platforms');
  }

  @override
  Future<ConversationData?> loadConversation(String id) async {
    throw UnsupportedError('WebStorageService is not available on mobile platforms');
  }

  @override
  Future<void> deleteConversation(String conversationId) async {
    throw UnsupportedError('WebStorageService is not available on mobile platforms');
  }

  @override
  Future<void> saveGameData(GameData data) async {
    throw UnsupportedError('WebStorageService is not available on mobile platforms');
  }

  @override
  Future<List<GameData>> loadGameData() async {
    throw UnsupportedError('WebStorageService is not available on mobile platforms');
  }

  @override
  Future<void> clearAll() async {
    throw UnsupportedError('WebStorageService is not available on mobile platforms');
  }

  @override
  Future<void> clearCache() async {
    throw UnsupportedError('WebStorageService is not available on mobile platforms');
  }

  @override
  Future<int> getStorageSize() async {
    throw UnsupportedError('WebStorageService is not available on mobile platforms');
  }

  @override
  Future<Map<String, dynamic>> exportData() async {
    throw UnsupportedError('WebStorageService is not available on mobile platforms');
  }

  @override
  Future<void> importData(Map<String, dynamic> data) async {
    throw UnsupportedError('WebStorageService is not available on mobile platforms');
  }
}