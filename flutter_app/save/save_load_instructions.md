# 保存・読み込み指示書

## 保存・読み込みを指示する際の参考資料

### 1. 基本的な指示パターン

#### ユーザーデータの保存
```
ユーザー名を "太郎" に設定して保存してください
→ await userManager.updateUserName("太郎");

初期設定を完了状態にして保存してください
→ await userManager.completeInitialSetup();

設定で音声をOFFにして保存してください
→ await userManager.updateSettings((s) => s.copyWith(soundEnabled: false));
```

#### ゲームデータの保存
```
WritingGameの結果を保存してください（スコア85点、完了）
→ GameData作成してsaveGameData()呼び出し

ゲームプレイ回数を増やして保存してください
→ await userManager.recordGamePlay("writing_game");
```

#### 設定の読み込み
```
現在の設定を確認してください
→ final settings = await storage.loadSettings();

ユーザー名を取得してください
→ final userName = userManager.currentUser?.userName;
```

### 2. 保存されるデータの場所

#### Web版 (Chrome)
- ブラウザのLocalStorageに保存
- 開発者ツール → Application → Local Storage で確認可能
- キー: `app_settings`, `app_conversations`, `app_gamedata`

#### モバイル版
- アプリのDocumentsディレクトリ内のsaveフォルダ
- ファイル: `settings.json`, `conversations.json`, `gamedata.json`
- SharedPreferencesにもバックアップ保存

### 3. よくある指示のパターンと実装方法

#### 「初回起動時のデータを作成」
```dart
// 自動で実行される（UserDataManager.initialize()内）
await _createNewUser();
```

#### 「設定をリセット」
```dart
await userManager.resetAllData();
```

#### 「ゲーム結果を記録」
```dart
final gameData = GameData(
  id: uuid.v4(),
  gameType: 'writing_game',
  playedAt: DateTime.now(),
  score: 85,
  completed: true,
  timeSpent: 120000,
);
await storage.saveGameData(gameData);
```

#### 「全データをエクスポート」
```dart
final exportData = await userManager.exportAllData();
// ファイルに保存やクリップボードにコピーなど
```

#### 「データをインポート」
```dart
await userManager.importAllData(importedData);
```

### 4. エラーが起きやすいパターン

#### ❌ 間違った指示例
```
「assetsディレクトリにセーブデータを保存して」
→ assetsは読み取り専用なので不可能

「SharedPreferencesに直接GameDataを保存して」
→ GameDataはJSONファイルとして保存するべき

「LocalStorageにファイルを作成して」
→ LocalStorageはキー・バリューストア、ファイルは作れない
```

#### ✅ 正しい指示例
```
「ゲームデータを保存して」
→ storage.saveGameData()を使用

「設定を永続化して」
→ userManager.updateSettings()を使用

「モバイル版でsaveディレクトリにJSONファイルを作成して」
→ 自動で作成される（MobileStorageService内）
```

### 5. デバッグ時の確認方法

#### 保存されたデータの確認
```dart
// 設定確認
final settings = await storage.loadSettings();
print('Settings: $settings');

// ゲームデータ確認
final gameData = await storage.loadGameData();
print('Game data count: ${gameData.length}');

// ストレージサイズ確認
final size = await storage.getStorageSize();
print('Storage size: $size bytes');
```

#### データの存在確認
```dart
// ユーザーデータの存在確認
if (userManager.currentUser != null) {
  print('User exists: ${userManager.currentUser!.userId}');
}

// 初期設定完了確認
if (userManager.isInitialSetupCompleted) {
  print('Initial setup completed');
}
```

### 6. 特殊な操作

#### データの完全削除
```dart
await storage.clearAll();  // 全ストレージ削除
await storage.clearCache(); // キャッシュのみ削除
```

#### プラットフォーム固有の操作
```dart
// Web版のみ
if (kIsWeb) {
  // LocalStorageの直接操作
  html.window.localStorage.clear();
}

// モバイル版のみ
if (!kIsWeb) {
  // ファイルシステムの直接操作
  final saveDir = await _getSaveDirectory();
  if (await saveDir.exists()) {
    await saveDir.delete(recursive: true);
  }
}
```

### 7. パフォーマンス考慮事項

#### 頻繁な保存は避ける
```dart
// ❌ 悪い例：毎回設定を保存
for (int i = 0; i < 100; i++) {
  await userManager.updateSettings(...);
}

// ✅ 良い例：まとめて保存
await userManager.updateSettings((settings) {
  // 複数の設定をまとめて変更
  return settings.copyWith(
    soundEnabled: false,
    difficulty: 2,
    language: 'en',
  );
});
```

#### 大量データの処理
```dart
// ゲームデータが多い場合は分割処理を検討
final allGameData = await storage.loadGameData();
if (allGameData.length > 1000) {
  // 古いデータの削除やアーカイブを検討
}
```