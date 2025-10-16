/// 共通ストレージインターフェース
/// プラットフォーム別の実装を統一するための抽象クラス

abstract class StorageInterface {
  /// 設定データを保存
  Future<void> saveSettings(Map<String, dynamic> settings);

  /// 設定データを読み込み
  Future<Map<String, dynamic>> loadSettings();

  /// 会話データを保存
  Future<void> saveConversation(ConversationData data);

  /// すべての会話データを読み込み
  Future<List<ConversationData>> loadConversations();

  /// 特定の会話データを読み込み
  Future<ConversationData?> loadConversation(String id);

  /// 会話データを削除
  Future<void> deleteConversation(String id);

  /// ゲームデータを保存
  Future<void> saveGameData(GameData data);

  /// ゲームデータを読み込み
  Future<List<GameData>> loadGameData();

  /// すべてのデータをクリア
  Future<void> clearAll();

  /// キャッシュデータのみクリア
  Future<void> clearCache();

  /// ストレージの使用量を取得（バイト単位）
  Future<int> getStorageSize();

  /// データのエクスポート
  Future<Map<String, dynamic>> exportData();

  /// データのインポート
  Future<void> importData(Map<String, dynamic> data);
}

/// 会話データモデル
class ConversationData {
  final String id;
  final DateTime timestamp;
  final String title;
  final List<Message> messages;
  final Map<String, dynamic>? metadata;

  ConversationData({
    required this.id,
    required this.timestamp,
    required this.title,
    required this.messages,
    this.metadata,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'timestamp': timestamp.toIso8601String(),
    'title': title,
    'messages': messages.map((m) => m.toJson()).toList(),
    'metadata': metadata,
  };

  factory ConversationData.fromJson(Map<String, dynamic> json) => ConversationData(
    id: json['id'],
    timestamp: DateTime.parse(json['timestamp']),
    title: json['title'],
    messages: (json['messages'] as List).map((m) => Message.fromJson(m)).toList(),
    metadata: json['metadata'],
  );
}

/// メッセージモデル
class Message {
  final String id;
  final String role;
  final String content;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  Message({
    required this.id,
    required this.role,
    required this.content,
    required this.timestamp,
    this.metadata,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'role': role,
    'content': content,
    'timestamp': timestamp.toIso8601String(),
    'metadata': metadata,
  };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json['id'],
    role: json['role'],
    content: json['content'],
    timestamp: DateTime.parse(json['timestamp']),
    metadata: json['metadata'],
  );
}

/// ゲームデータモデル
class GameData {
  final String gameId;
  final String gameName;
  final DateTime playedAt;
  final int score;
  final int duration;
  final Map<String, dynamic> details;

  GameData({
    required this.gameId,
    required this.gameName,
    required this.playedAt,
    required this.score,
    required this.duration,
    required this.details,
  });

  Map<String, dynamic> toJson() => {
    'gameId': gameId,
    'gameName': gameName,
    'playedAt': playedAt.toIso8601String(),
    'score': score,
    'duration': duration,
    'details': details,
  };

  factory GameData.fromJson(Map<String, dynamic> json) => GameData(
    gameId: json['gameId'],
    gameName: json['gameName'],
    playedAt: DateTime.parse(json['playedAt']),
    score: json['score'],
    duration: json['duration'],
    details: json['details'],
  );
}

/// ストレージ例外
class StorageException implements Exception {
  final String message;
  final dynamic originalError;

  StorageException(this.message, [this.originalError]);

  @override
  String toString() => 'StorageException: $message${originalError != null ? ' ($originalError)' : ''}';
}