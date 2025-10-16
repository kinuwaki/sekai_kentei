/// ひらがな文字データの管理システム
/// 
/// このファイルは段階的リファクタリングのステップ1として作成されています。
/// 新しい文字の追加を簡単にするための統合データ管理システムです。
library;

import 'hiragana_data_registry.dart';

/// 単一のひらがな文字の完全なデータセット
class HiraganaCharacterData {
  /// 文字（例：'あ'）
  final String character;
  
  /// ストロークパス（ユーザーが描く線の軌跡）
  final List<String> strokePaths;
  
  /// 輪郭パス（完成した文字の形状）
  final List<String> outlinePaths;
  
  /// ストローク→輪郭のマッピング
  /// キー: ストロークインデックス
  /// 値: 対応する輪郭パスのインデックスリスト
  final Map<int, List<int>> strokeToOutlineMapping;
  
  /// セグメント比率（複数輪郭がある場合の分割比率）
  final Map<int, List<double>> segmentRatios;
  
  const HiraganaCharacterData({
    required this.character,
    required this.strokePaths,
    required this.outlinePaths,
    required this.strokeToOutlineMapping,
    required this.segmentRatios,
  });
  
  /// ストローク数を取得
  int get strokeCount => strokePaths.length;
  
  /// 輪郭数を取得
  int get outlineCount => outlinePaths.length;
  
  /// データの整合性をチェック
  bool validate() {
    // すべてのストロークにマッピングが存在するか
    for (int i = 0; i < strokeCount; i++) {
      if (!strokeToOutlineMapping.containsKey(i)) {
        print('警告: ストローク$i のマッピングが存在しません');
        return false;
      }
      if (!segmentRatios.containsKey(i)) {
        print('警告: ストローク$i のセグメント比率が存在しません');
        return false;
      }
      
      // マッピングされた輪郭インデックスが範囲内か
      final outlineIndices = strokeToOutlineMapping[i]!;
      for (int idx in outlineIndices) {
        if (idx >= outlineCount) {
          print('警告: 輪郭インデックス$idx が範囲外です（最大: ${outlineCount - 1}）');
          return false;
        }
      }
      
      // セグメント比率の数が輪郭インデックスの数と一致するか
      if (segmentRatios[i]!.length != outlineIndices.length) {
        print('警告: セグメント比率の数が輪郭インデックスの数と一致しません');
        return false;
      }
    }
    
    return true;
  }
}

/// ひらがな文字データの管理クラス
class HiraganaDataManager {
  /// シングルトンインスタンス
  static final HiraganaDataManager _instance = HiraganaDataManager._internal();
  
  /// ファクトリコンストラクタ
  factory HiraganaDataManager() => _instance;
  
  /// プライベートコンストラクタ
  HiraganaDataManager._internal();
  
  /// 文字データの内部ストレージ
  final Map<String, HiraganaCharacterData> _characters = {};
  
  /// 初期化済みフラグ
  bool _initialized = false;
  
  /// システムを初期化
  void initialize() {
    if (_initialized) return;
    
    // すべての文字データを登録
    HiraganaDataRegistry.registerAllCharacters();
    
    _initialized = true;
  }
  
  /// 文字データを登録
  void registerCharacter(HiraganaCharacterData data) {
    if (!data.validate()) {
      throw ArgumentError('文字データの検証に失敗しました: ${data.character}');
    }
    _characters[data.character] = data;
    // print('文字データを登録しました: ${data.character}');
  }
  
  /// 登録済みの文字一覧を取得
  List<String> getSupportedCharacters() {
    return _characters.keys.toList();
  }
  
  /// 特定の文字がサポートされているかチェック
  bool isSupported(String character) {
    return _characters.containsKey(character);
  }
  
  /// 文字データを取得
  HiraganaCharacterData? getCharacterData(String character) {
    return _characters[character];
  }
  
  /// ストロークパスを取得
  List<String> getStrokePaths(String character) {
    return _characters[character]?.strokePaths ?? [];
  }
  
  /// 輪郭パスを取得
  List<String> getOutlinePaths(String character) {
    return _characters[character]?.outlinePaths ?? [];
  }
  
  /// ストローク→輪郭マッピングを取得
  Map<int, List<int>> getStrokeToOutlineMapping(String character) {
    return _characters[character]?.strokeToOutlineMapping ?? {};
  }
  
  /// セグメント比率を取得
  Map<int, List<double>> getSegmentRatios(String character) {
    return _characters[character]?.segmentRatios ?? {};
  }
  
  /// ストローク数を取得
  int getStrokeCount(String character) {
    return _characters[character]?.strokeCount ?? 0;
  }
  
  /// デバッグ情報を出力
  void printDebugInfo() {
    print('=== HiraganaDataManager デバッグ情報 ===');
    print('登録済み文字数: ${_characters.length}');
    print('登録済み文字: ${getSupportedCharacters().join(", ")}');
    
    for (var entry in _characters.entries) {
      final char = entry.key;
      final data = entry.value;
      print('---');
      print('文字: $char');
      print('  ストローク数: ${data.strokeCount}');
      print('  輪郭数: ${data.outlineCount}');
      print('  データ検証: ${data.validate() ? "OK" : "NG"}');
    }
    print('========================================');
  }
}