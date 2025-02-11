abstract interface class ErrorReporter {
  Map<String, Map<String, Object>> get errors;

  bool get hasError;

  String format(String rule, FieldContext field, String? message, Map<String, dynamic> options);

  void report(String rule, String field, String message);

  Exception createError(Object message);
}

abstract interface class ValidatorContract {
  Map<String, dynamic> get data;

  void validate(Map<String, dynamic> data);
}

abstract interface class FieldContext<T extends ErrorReporter> {
  String get name;

  dynamic get value;

  T get errorReporter;

  ValidatorContract get validator;

  Function get next;

  void mutate(dynamic value);
}

typedef ParseHandler = void Function(FieldContext);

final class MissingValue {}
