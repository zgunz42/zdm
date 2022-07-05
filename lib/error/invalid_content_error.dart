class InvalidContentError extends Error {
  InvalidContentError(this.message) : super();
  final String message;

  @override
  String toString() {
    return 'InvalidContent: $message';
  }
}
