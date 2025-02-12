import 'package:vine/src/contracts/vine.dart';

void handleNumberConversionError (FieldContext field, String? message) {
  final error = field.errorReporter.format('number', field, message, {});
  field.errorReporter.report('number', [...field.customKeys, field.name], error);
}

void numberRuleHandler(FieldContext field, String? message) {
  final value = field.value;
  if (value is num) {
    return;
  }

  if (value is String) {
    final parsed = num.tryParse(value);
    if (parsed == null) {
      handleNumberConversionError(field, message);
      return;
    }
    field.mutate(parsed);
    return;
  }

  handleNumberConversionError(field, message);
}

void minRuleHandler(FieldContext field, num minValue, String? message) {
  if (field.value case num value when value.isNegative || value < minValue) {
    final error = field.errorReporter.format('min', field, message, {
      'min': minValue,
    });

    field.errorReporter.report('min', [...field.customKeys, field.name], error);
  }
}

void maxRuleHandler(FieldContext field, num maxValue, String? message) {
  if (field.value case num value when value.isNegative || value > maxValue) {
    final error = field.errorReporter.format('max', field, message, {
      'max': maxValue,
    });

    field.errorReporter.report('max', [...field.customKeys, field.name], error);
  }
}

void rangeRuleHandler(FieldContext field, List<num> values, String? message) {
  if (!values.contains((field.value as num))) {
    final error = field.errorReporter.format('range', field, message, {
      'values': values,
    });

    field.errorReporter.report('range', [...field.customKeys, field.name], error);
  }
}

void negativeRuleHandler(FieldContext field, String? message) {
  if (field.value case num value when !value.isNegative) {
    final error = field.errorReporter.format('negative', field, message, {});
    field.errorReporter.report('negative', [...field.customKeys, field.name], error);
  }
}

void positiveRuleHandler(FieldContext field, String? message) {
  if (field.value case num value when value.isNegative) {
    final error = field.errorReporter.format('positive', field, message, {});
    field.errorReporter.report('positive', [...field.customKeys, field.name], error);
  }
}

void doubleRuleHandler(FieldContext field, String? message) {

  if (field.value case num value when value is! double) {
    final error = field.errorReporter.format('double', field, message, {});
    field.errorReporter.report('double', [...field.customKeys, field.name], error);
  }
}

void integerRuleHandler(FieldContext field, String? message) {
  if (field.value case num value when value is! int) {
    final error = field.errorReporter.format('integer', field, message, {});
    field.errorReporter.report('integer', [...field.customKeys, field.name], error);
  }
}
