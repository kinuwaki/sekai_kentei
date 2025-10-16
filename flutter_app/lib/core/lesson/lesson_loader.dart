import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';
import 'lesson_models.dart';

/// レッスンデータの読み込みサービス
class LessonLoader {
  static Course4yo? _cachedCourse;
  
  /// 4歳コースを読み込み
  static Future<Course4yo> loadCourse4yo() async {
    if (_cachedCourse != null) {
      return _cachedCourse!;
    }
    
    try {
      final yamlString = await rootBundle.loadString('assets/lessons/course_4yo.yml');
      final yamlMap = loadYaml(yamlString);
      
      // YamlMapをMap<String, dynamic>に変換
      final Map<String, dynamic> data = _convertYamlToMap(yamlMap);
      
      _cachedCourse = Course4yo.fromMap(data);
      return _cachedCourse!;
    } catch (e) {
      throw Exception('Failed to load course_4yo.yml: $e');
    }
  }
  
  /// YamlMapを通常のMapに変換（再帰的）
  static dynamic _convertYamlToMap(dynamic yaml) {
    if (yaml is YamlMap) {
      final Map<String, dynamic> map = {};
      yaml.forEach((key, value) {
        map[key.toString()] = _convertYamlToMap(value);
      });
      return map;
    } else if (yaml is YamlList) {
      return yaml.map((item) => _convertYamlToMap(item)).toList();
    } else {
      return yaml;
    }
  }
  
  /// キャッシュクリア（テスト用）
  static void clearCache() {
    _cachedCourse = null;
  }
}