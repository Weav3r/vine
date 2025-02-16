abstract interface class ErrorReporter {
  List<Map<String, Object>> get errors;

  abstract bool hasError;

  bool hasErrorForField(String fieldName);

  String format(String rule, FieldContext field, String? message, Map<String, dynamic> options);

  void report(String rule, List<String> keys, String message);

  Exception createError(Object message);

  void clear();
}

abstract interface class ValidatorContract {
}

abstract interface class VineValidationContext<T extends ErrorReporter> {
  T get errorReporter;

  Map get data;

  Map<String, dynamic> getFieldContext(List<String> keys);
}

abstract interface class FieldContext {
  List<String> get customKeys;

  abstract String name;
  abstract bool canBeContinue;
  abstract bool isUnion;

  dynamic value;

  void mutate(dynamic value);
}

typedef ParseHandler = void Function(VineValidationContext, FieldContext);

final class MissingValue {}
