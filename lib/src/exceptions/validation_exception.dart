class ValidationException implements Exception {
  String code = 'E_VALIDATION_ERROR';
  final statusCode = 422;

  final String message;
  ValidationException(this.message);


  @override
  String toString() => '[$code]: $message';
}
