import 'package:flutter/foundation.dart';
import 'storage_interface.dart';
import 'web_storage.dart' if (dart.library.io) 'web_storage_stub.dart';
import 'mobile_storage.dart';

/// シンプルなストレージファクトリー
class SimpleStorageFactory {
  static StorageInterface? _instance;

  static StorageInterface getInstance() {
    _instance ??= _createInstance();
    return _instance!;
  }

  static StorageInterface _createInstance() {
    if (kIsWeb) {
      return WebStorageService();
    } else {
      return MobileStorageService();
    }
  }

  static void resetInstance() {
    _instance = null;
  }
}