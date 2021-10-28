class Logger {
  static void write(String text, {bool isError = false}) {
    print('** $text [$isError]');
  }
}