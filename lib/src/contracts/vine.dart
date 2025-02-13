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

abstract interface class VineValidationContext<T extends ErrorReporter> {
  T get errorReporter;

  Map get data;
}

abstract interface class FieldContext {
  List<String> get customKeys;

  abstract String name;
  abstract bool canBeContinue;

  dynamic value;

  void mutate(dynamic value);
}

typedef ParseHandler = void Function(VineValidationContext, FieldContext);

final class MissingValue {}
