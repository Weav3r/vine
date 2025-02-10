import 'package:vine/src/contracts/vine.dart';

void numberRuleHandler(FieldContext field, String? message) {
  final value = switch (field.value) {
    String() => int.tryParse(field.value),
    int() => field.value,
    _ => null,
  };

  if (value == null) {
    final error = field.errorReporter.format('number', field, message, {});
    field.errorReporter.report('number', field.name, error);
  } else {
    field.mutate(value);
  }

  field.next();
}

void rangeRuleHandler(FieldContext field, List<int> values, String? message) {
  if (!values.contains(field.value)) {
    final error = field.errorReporter.format('range', field, message, {
      'values': values,
    });

    field.errorReporter.report('range', field.name, error);
  }

  field.next();
}
