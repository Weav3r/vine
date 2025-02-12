abstract interface class ErrorReporter {
  List<Map<String, Object>> get errors;

  bool get hasError;

  bool hasErrorForField(String fieldName);

  String format(String rule, FieldContext field, String? message, Map<String, dynamic> options);

  void report(String rule, List<String> keys, String message);

  Exception createError(Object message);
}

abstract interface class ValidatorContract {
  void validate(Map<String, dynamic> data);
}

abstract interface class FieldContext<T extends ErrorReporter> {
  abstract String name;

  dynamic value;

  final List<String> customKeys = [];

  T get errorReporter;

  Map<String, dynamic> get data;

  abstract bool canBeContinue;

  void mutate(dynamic value);
}

typedef ParseHandler = void Function(FieldContext);

final class MissingValue {}
