# データフロー図

## 全体アーキテクチャ

```
アプリケーション層
├── UserDataManager (シングルトン)
│   ├── ユーザーデータ管理
│   ├── 設定管理
│   └── ゲームプレイ記録
│
├── StorageInterface (抽象化層)
│   ├── saveSettings()
│   ├── loadSettings()
│   ├── saveGameData()
│   ├── loadGameData()
│   └── その他のメソッド
│
└── SimpleStorageFactory (ファクトリー)
    ├── kIsWeb判定
    ├── WebStorageService (Web版)
    └── MobileStorageService (モバイル版)
```

## データ保存フロー

### 1. ユーザーデータ保存
```
ユーザーアクション
│
├── updateUserName(name)
├── updateSettings(updater)
└── completeInitialSetup()
    │
    ↓
UserDataManager._saveUserData()
    │
    ├── loadSettings() で既存設定取得
    ├── 'userData'キーに新しいデータ設定
    └── saveSettings() で保存
        │
        ↓
StorageInterface実装
    │
    ├── [Web] LocalStorage['app_settings'] = JSON
    └── [Mobile] Documents/save/settings.json = JSON
```

### 2. ゲームデータ保存
```
ゲーム完了
    │
    ↓
recordGamePlay(gameId) または saveGameData(data)
    │
    ↓
StorageInterface.saveGameData()
    │
    ├── loadGameData() で既存データ取得
    ├── 新しいGameDataを追加
    └── 全体を保存
        │
        ↓
実装別保存
    │
    ├── [Web] LocalStorage['app_gamedata'] = JSON配列
    └── [Mobile] Documents/save/gamedata.json = JSON配列
```

## データ読み込みフロー

### 1. 初期化時の読み込み
```
アプリ起動
    │
    ↓
UserDataManager.initialize()
    │
    ├── SimpleStorageFactory.getInstance()
    │   ├── [Web] new WebStorageService()
    │   └── [Mobile] new MobileStorageService()
    │
    └── _loadUserData()
        │
        ├── loadSettings()
        │   ├── [Web] LocalStorage['app_settings']
        │   └── [Mobile] Documents/save/settings.json
        │
        ├── 'userData'キーから取得
        ├── UserData.fromJson()で復元
        └── lastAccessDate更新
```

### 2. データが存在しない場合
```
loadSettings() → 空のMap
    │
    ↓
_createNewUser()
    │
    ├── UUID生成
    ├── 新しいUserData作成
    ├── isInitialSetupCompleted = false
    └── _saveUserData()
```

## プラットフォーム別詳細フロー

### Web版 (LocalStorage)
```
操作要求
    │
    ↓
WebStorageService
    │
    ├── saveSettings()
    │   └── html.window.localStorage['app_settings'] = jsonEncode(data)
    │
    ├── loadSettings()
    │   └── jsonDecode(html.window.localStorage['app_settings'])
    │
    ├── saveGameData()
    │   ├── 既存データ読み込み
    │   ├── 新データ追加
    │   └── localStorage['app_gamedata'] = 更新済み配列
    │
    └── clearAll()
        └── removeWhere((key, value) => key.startsWith('app_'))
```

### モバイル版 (ファイルシステム)
```
操作要求
    │
    ↓
MobileStorageService
    │
    ├── _getSaveDirectory()
    │   ├── getApplicationDocumentsDirectory()
    │   ├── 'save'ディレクトリ作成
    │   └── Directory返却
    │
    ├── saveSettings()
    │   ├── saveDir/settings.json に書き込み
    │   └── SharedPreferencesにバックアップ
    │
    ├── loadSettings()
    │   ├── saveDir/settings.json 読み込み
    │   ├── ファイルがない場合はSharedPreferences
    │   └── どちらもない場合は空のMap
    │
    ├── saveGameData()
    │   ├── 既存のgamedata.json読み込み
    │   ├── 新データ追加
    │   └── saveDir/gamedata.json 書き込み
    │
    └── clearAll()
        ├── saveディレクトリ削除
        └── SharedPreferencesクリア
```

## エラーハンドリングフロー

### 保存エラー
```
保存操作
    │
    ├── [Web] LocalStorage容量不足
    │   ├── debugPrint()でログ
    │   └── 操作無視（アプリ継続）
    │
    └── [Mobile] ファイル書き込み失敗
        ├── debugPrint()でログ
        └── 操作無視（アプリ継続）
```

### 読み込みエラー
```
読み込み操作
    │
    ├── データ破損・形式エラー
    │   ├── debugPrint()でログ
    │   ├── 空のデータ返却
    │   └── [Mobile] SharedPreferencesから復旧試行
    │
    └── ファイル・キーが存在しない
        ├── 正常な状態として処理
        └── 空のデータ返却
```

## ライフサイクル

### アプリ起動時
```
1. main() 実行
2. UserDataManager.initialize() 呼び出し
3. ストレージファクトリー初期化
4. ユーザーデータ読み込み
5. UI表示開始
```

### アプリ使用中
```
1. ユーザーアクション発生
2. UserDataManagerメソッド呼び出し
3. データ変更
4. 即座に保存（_saveUserData()）
5. notifyListeners() でUI更新
```

### アプリ終了時
```
1. UserDataManager.dispose() 呼び出し
2. 最終保存実行
3. リソース解放
```

## データ整合性

### ユニークID管理
```
- UserData.userId: UUID v4
- GameData.id: UUID v4
- ConversationData.id: UUID v4

重複チェック不要（UUIDの衝突確率は無視できるレベル）
```

### 時刻管理
```
- firstLaunchDate: 初回作成時の時刻（変更なし）
- lastAccessDate: アクセス毎に更新
- playedAt: ゲーム実行時の時刻
- createdAt/updatedAt: 作成・更新時刻
```

### データバリデーション
```
- JSON形式チェック：fromJson()メソッドでエラーハンドリング
- 必須フィールド：Dartのnull safetyで保証
- データ型：静的型チェックで保証
```