import 'package:flutter/foundation.dart';

class Logger {
  static void write(String text, {bool isError = false}) {
    debugPrint('** $text [$isError]');
  }
}
