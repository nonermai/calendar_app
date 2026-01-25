//
// Copyright (c) 2026 Renon Sumii. All rights reserved.
//
import 'package:logger/logger.dart' as l;

class Logger {
  static final l.Logger _logger = l.Logger(
    printer: l.SimplePrinter(),
  );

  static void d(dynamic message) => _logger.d(message);
  static void i(dynamic message) => _logger.i(message);
  static void w(dynamic message) => _logger.w(message);
  static void e(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) => _logger.e(message, error: error, stackTrace: stackTrace);
}
