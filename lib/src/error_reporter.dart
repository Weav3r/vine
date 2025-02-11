import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/exceptions/validation_exception.dart';
import 'package:vine/src/mapped_errors.dart';

class SimpleErrorReporter implements ErrorReporter {
  final Map<String, String> _errorMessages;

  @override
  final Map<String, Map<String, Object>> errors = {};

  SimpleErrorReporter(this._errorMessages);

  @override
  bool hasError = false;

  @override
  String format(String rule, FieldContext field, String? message, Map<String, dynamic> options) {
    String content = message ?? _errorMessages[field.name] ?? mappedErrors[rule]!;

    for (final element in options.entries) {
      content = content.replaceAll('{${element.key}}', element.value.toString());
    }

    return content.replaceAll('{name}', field.name).replaceAll('{value}', field.value.toString());
  }

  @override
  void report(String rule, String field, String message) {
    hasError = true;
    errors.putIfAbsent(field, () => {
      'key': field,
      'rule': rule,
      'message': message
    });
  }

  @override
  Exception createError(Object message) {
    return ValidationException(message.toString());
  }
}
