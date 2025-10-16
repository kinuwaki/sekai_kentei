/// ユーザーデータモデル
class UserData {
  /// ユーザーID（デバイス固有）
  final String userId;

  /// ユーザー名
  final String? userName;

  /// 初期設定完了フラグ
  final bool isInitialSetupCompleted;

  /// アプリ初回起動日時
  final DateTime? firstLaunchDate;

  /// 最終アクセス日時
  final DateTime? lastAccessDate;

  /// 累計プレイ回数
  final int totalGamesPlayed;

  /// ユーザー設定
  final UserSettings settings;

  /// カスタムデータ（拡張用）
  final Map<String, dynamic>? customData;

  UserData({
    required this.userId,
    this.userName,
    this.isInitialSetupCompleted = false,
    this.firstLaunchDate,
    this.lastAccessDate,
    this.totalGamesPlayed = 0,
    this.settings = const UserSettings(),
    this.customData,
  });

  UserData copyWith({
    String? userId,
    String? userName,
    bool? isInitialSetupCompleted,
    DateTime? firstLaunchDate,
    DateTime? lastAccessDate,
    int? totalGamesPlayed,
    UserSettings? settings,
    Map<String, dynamic>? customData,
  }) {
    return UserData(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      isInitialSetupCompleted: isInitialSetupCompleted ?? this.isInitialSetupCompleted,
      firstLaunchDate: firstLaunchDate ?? this.firstLaunchDate,
      lastAccessDate: lastAccessDate ?? this.lastAccessDate,
      totalGamesPlayed: totalGamesPlayed ?? this.totalGamesPlayed,
      settings: settings ?? this.settings,
      customData: customData ?? this.customData,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'userName': userName,
    'isInitialSetupCompleted': isInitialSetupCompleted,
    'firstLaunchDate': firstLaunchDate?.toIso8601String(),
    'lastAccessDate': lastAccessDate?.toIso8601String(),
    'totalGamesPlayed': totalGamesPlayed,
    'settings': settings.toJson(),
    'customData': customData,
  };

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    userId: json['userId'] as String,
    userName: json['userName'] as String?,
    isInitialSetupCompleted: json['isInitialSetupCompleted'] as bool? ?? false,
    firstLaunchDate: json['firstLaunchDate'] != null
        ? DateTime.parse(json['firstLaunchDate'] as String)
        : null,
    lastAccessDate: json['lastAccessDate'] != null
        ? DateTime.parse(json['lastAccessDate'] as String)
        : null,
    totalGamesPlayed: json['totalGamesPlayed'] as int? ?? 0,
    settings: json['settings'] != null
        ? UserSettings.fromJson(json['settings'] as Map<String, dynamic>)
        : const UserSettings(),
    customData: json['customData'] as Map<String, dynamic>?,
  );
}

/// ユーザー設定
class UserSettings {
  /// 音声読み上げ有効
  final bool isTtsEnabled;

  /// 効果音有効
  final bool isSoundEffectEnabled;

  /// BGM有効
  final bool isBgmEnabled;

  /// 音量（0.0-1.0）
  final double volume;

  /// TTS速度（0.5-2.0）
  final double ttsSpeed;

  /// 言語設定
  final String language;

  /// テーマ（light/dark/auto）
  final String theme;

  /// フォントサイズ倍率
  final double fontScale;

  /// アニメーション有効
  final bool isAnimationEnabled;

  /// 振動フィードバック有効
  final bool isHapticEnabled;

  /// 難易度（easy/normal/hard）
  final String difficulty;

  /// 左利きモード
  final bool isLeftHandedMode;

  /// 色覚サポートモード
  final bool isColorBlindMode;

  const UserSettings({
    this.isTtsEnabled = true,
    this.isSoundEffectEnabled = true,
    this.isBgmEnabled = true,
    this.volume = 0.8,
    this.ttsSpeed = 1.0,
    this.language = 'ja',
    this.theme = 'auto',
    this.fontScale = 1.0,
    this.isAnimationEnabled = true,
    this.isHapticEnabled = true,
    this.difficulty = 'normal',
    this.isLeftHandedMode = false,
    this.isColorBlindMode = false,
  });

  UserSettings copyWith({
    bool? isTtsEnabled,
    bool? isSoundEffectEnabled,
    bool? isBgmEnabled,
    double? volume,
    double? ttsSpeed,
    String? language,
    String? theme,
    double? fontScale,
    bool? isAnimationEnabled,
    bool? isHapticEnabled,
    String? difficulty,
    bool? isLeftHandedMode,
    bool? isColorBlindMode,
  }) {
    return UserSettings(
      isTtsEnabled: isTtsEnabled ?? this.isTtsEnabled,
      isSoundEffectEnabled: isSoundEffectEnabled ?? this.isSoundEffectEnabled,
      isBgmEnabled: isBgmEnabled ?? this.isBgmEnabled,
      volume: volume ?? this.volume,
      ttsSpeed: ttsSpeed ?? this.ttsSpeed,
      language: language ?? this.language,
      theme: theme ?? this.theme,
      fontScale: fontScale ?? this.fontScale,
      isAnimationEnabled: isAnimationEnabled ?? this.isAnimationEnabled,
      isHapticEnabled: isHapticEnabled ?? this.isHapticEnabled,
      difficulty: difficulty ?? this.difficulty,
      isLeftHandedMode: isLeftHandedMode ?? this.isLeftHandedMode,
      isColorBlindMode: isColorBlindMode ?? this.isColorBlindMode,
    );
  }

  Map<String, dynamic> toJson() => {
    'isTtsEnabled': isTtsEnabled,
    'isSoundEffectEnabled': isSoundEffectEnabled,
    'isBgmEnabled': isBgmEnabled,
    'volume': volume,
    'ttsSpeed': ttsSpeed,
    'language': language,
    'theme': theme,
    'fontScale': fontScale,
    'isAnimationEnabled': isAnimationEnabled,
    'isHapticEnabled': isHapticEnabled,
    'difficulty': difficulty,
    'isLeftHandedMode': isLeftHandedMode,
    'isColorBlindMode': isColorBlindMode,
  };

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
    isTtsEnabled: json['isTtsEnabled'] as bool? ?? true,
    isSoundEffectEnabled: json['isSoundEffectEnabled'] as bool? ?? true,
    isBgmEnabled: json['isBgmEnabled'] as bool? ?? true,
    volume: (json['volume'] as num?)?.toDouble() ?? 0.8,
    ttsSpeed: (json['ttsSpeed'] as num?)?.toDouble() ?? 1.0,
    language: json['language'] as String? ?? 'ja',
    theme: json['theme'] as String? ?? 'auto',
    fontScale: (json['fontScale'] as num?)?.toDouble() ?? 1.0,
    isAnimationEnabled: json['isAnimationEnabled'] as bool? ?? true,
    isHapticEnabled: json['isHapticEnabled'] as bool? ?? true,
    difficulty: json['difficulty'] as String? ?? 'normal',
    isLeftHandedMode: json['isLeftHandedMode'] as bool? ?? false,
    isColorBlindMode: json['isColorBlindMode'] as bool? ?? false,
  );
}

