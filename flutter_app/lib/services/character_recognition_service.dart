// 条件付きインポート
export 'character_recognition_service_interface.dart';

// プラットフォーム別の実装をインポート
export 'character_recognition_service_stub.dart'
  if (dart.library.html) 'character_recognition_service_web.dart'
  if (dart.library.io) 'character_recognition_service_native.dart';