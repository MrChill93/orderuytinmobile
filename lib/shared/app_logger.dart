// ignore_for_file: depend_on_referenced_packages

import 'package:logger/logger.dart';

class AppLogger {
  final Logger logger = Logger();
  final String now = DateTime.now().toString().substring(11);

  /// Singleton
  AppLogger._internal();
  static AppLogger? _instance;

  static AppLogger get shared {
    _instance ??= AppLogger._internal();

    return _instance!;
  }

  void logErr(String label, dynamic error, [StackTrace? stackTrace]) {
    logger.e("ERROR $label $now - $error\n$stackTrace");
    return;
  }

  void logInfo(String label, dynamic message) {
    logger.i("LOG $now - $message");
    return;
  }

  void logException(String label, dynamic exception, [StackTrace? stackTrace]) {
    logger.i("EXCEPTION $label $now - $exception\n$stackTrace");
    return;
  }
}
