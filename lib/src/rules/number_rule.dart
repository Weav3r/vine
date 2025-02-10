import 'package:vine/src/contracts/vine.dart';

void numberRuleHandler(FieldContext field, String? message) {
  final value = switch (field.value) {
    String() => num.tryParse(field.value),
    int() => field.value,
    double() => field.value,
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

void minRuleHandler(FieldContext field, num minValue, String? message) {
  if (field.value case num value when value.isNegative || value < minValue) {
    final error = field.errorReporter.format('min', field, message, {
      'min': minValue,
    });

    field.errorReporter.report('min', field.name, error);
  }

  field.next();
}

void maxRuleHandler(FieldContext field, num maxValue, String? message) {
  if (field.value case num value when value.isNegative || value > maxValue) {
    final error = field.errorReporter.format('max', field, message, {
      'max': maxValue,
    });

    field.errorReporter.report('max', field.name, error);
  }

  field.next();
}

void rangeRuleHandler(FieldContext field, List<num> values, String? message) {
  if (field.value case num value when !values.contains(value)) {
    final error = field.errorReporter.format('range', field, message, {
      'values': values,
    });

    field.errorReporter.report('range', field.name, error);
  }

  field.next();
}

void negativeRuleHandler(FieldContext field, String? message) {
  if (field.value case num value when !value.isNegative) {
    final error = field.errorReporter.format('negative', field, message, {});
    field.errorReporter.report('negative', field.name, error);
  }

  field.next();
}

void positiveRuleHandler(FieldContext field, String? message) {
  if (field.value case num value when value.isNegative) {
    final error = field.errorReporter.format('positive', field, message, {});
    field.errorReporter.report('positive', field.name, error);
  }

  field.next();
}

void doubleRuleHandler(FieldContext field, String? message) {

  if (field.value case num value when value is! double) {
    final error = field.errorReporter.format('double', field, message, {});
    field.errorReporter.report('double', field.name, error);
  }

  field.next();
}

void integerRuleHandler(FieldContext field, String? message) {
  if (field.value case num value when value is! int) {
    final error = field.errorReporter.format('integer', field, message, {});
    field.errorReporter.report('integer', field.name, error);
  }

  field.next();
}
