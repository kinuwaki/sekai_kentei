import 'package:flutter/foundation.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
}

class DebugLogger {
  static const bool _enableDebugLogs = kDebugMode;
  static const bool _enableInfoLogs = kDebugMode;
  static const bool _enableWarningLogs = true; // Always enabled
  static const bool _enableErrorLogs = true; // Always enabled
  
  // Log level colors for console output
  static const String _resetColor = '\x1B[0m';
  static const String _debugColor = '\x1B[36m'; // Cyan
  static const String _infoColor = '\x1B[32m'; // Green
  static const String _warningColor = '\x1B[33m'; // Yellow
  static const String _errorColor = '\x1B[31m'; // Red
  
  /// Debug level logs - only in debug builds
  static void debug(String message, {String? tag}) {
    if (_enableDebugLogs) {
      _log(LogLevel.debug, message, tag);
    }
  }
  
  /// Info level logs - only in debug builds
  static void info(String message, {String? tag}) {
    if (_enableInfoLogs) {
      _log(LogLevel.info, message, tag);
    }
  }
  
  /// Warning level logs - always enabled
  static void warning(String message, {String? tag}) {
    if (_enableWarningLogs) {
      _log(LogLevel.warning, message, tag);
    }
  }
  
  /// Error level logs - always enabled
  static void error(String message, {String? tag}) {
    if (_enableErrorLogs) {
      _log(LogLevel.error, message, tag);
    }
  }
  
  static void _log(LogLevel level, String message, String? tag) {
    final timeFormatted = DateTime.now().toString().substring(11, 23); // HH:mm:ss.mmm
    
    String levelPrefix;
    String color;
    
    switch (level) {
      case LogLevel.debug:
        levelPrefix = 'DEBUG';
        color = _debugColor;
        break;
      case LogLevel.info:
        levelPrefix = 'INFO';
        color = _infoColor;
        break;
      case LogLevel.warning:
        levelPrefix = 'WARN';
        color = _warningColor;
        break;
      case LogLevel.error:
        levelPrefix = 'ERROR';
        color = _errorColor;
        break;
    }
    
    final tagStr = tag != null ? '[$tag] ' : '';
    final output = '$color$timeFormatted $levelPrefix: $tagStr$message$_resetColor';
    
    // Use debugPrint for better performance in debug builds
    if (kDebugMode) {
      debugPrint(output);
    } else {
      print(output);
    }
  }
}

// Convenience aliases for commonly used log levels
class Log {
  /// Debug logs - verbose development info
  static void d(String message, {String? tag}) => DebugLogger.debug(message, tag: tag);
  
  /// Info logs - general information
  static void i(String message, {String? tag}) => DebugLogger.info(message, tag: tag);
  
  /// Warning logs - potential issues
  static void w(String message, {String? tag}) => DebugLogger.warning(message, tag: tag);
  
  /// Error logs - errors and exceptions
  static void e(String message, {String? tag}) => DebugLogger.error(message, tag: tag);
}