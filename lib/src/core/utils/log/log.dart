import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Log {
  static final _logger = Logger();

  static i(String message) {
    if (!kReleaseMode) {
      _logger.i(message);
    }
  }

  static e(String message) {
    if (!kReleaseMode) {
      _logger.e(message);
    }
  }
}
