class DatabaseErrorException implements Exception {
  String message;
  Exception? exception;

  DatabaseErrorException({
    required this.message,
    this.exception,
  });
}
