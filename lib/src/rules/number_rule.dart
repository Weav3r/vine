import 'package:vine/src/contracts/vine.dart';

void handleNumberConversionError (VineValidationContext ctx, FieldContext field, String? message) {
  final error = ctx.errorReporter.format('number', field, message, {});
  ctx.errorReporter.report('number', [...field.customKeys, field.name], error);
}

void numberRuleHandler(VineValidationContext ctx, FieldContext field, String? message) {
  final value = field.value;
  if (value is num) {
    return;
  }

  if (value is String) {
    final parsed = num.tryParse(value);
    if (parsed == null) {
      handleNumberConversionError(ctx, field, message);
      return;
    }
    field.mutate(parsed);
    return;
  }

  handleNumberConversionError(ctx, field, message);
}

void minRuleHandler(VineValidationContext ctx, FieldContext field, num minValue, String? message) {
  if (field.value case num value when value.isNegative || value < minValue) {
    final error = ctx.errorReporter.format('min', field, message, {
      'min': minValue,
    });

    ctx.errorReporter.report('min', [...field.customKeys, field.name], error);
  }
}

void maxRuleHandler(VineValidationContext ctx, FieldContext field, num maxValue, String? message) {
  if (field.value case num value when value.isNegative || value > maxValue) {
    final error = ctx.errorReporter.format('max', field, message, {
      'max': maxValue,
    });

    ctx.errorReporter.report('max', [...field.customKeys, field.name], error);
  }
}

void rangeRuleHandler(VineValidationContext ctx, FieldContext field, List<num> values, String? message) {
  if (!values.contains((field.value as num))) {
    final error = ctx.errorReporter.format('range', field, message, {
      'values': values,
    });

    ctx.errorReporter.report('range', [...field.customKeys, field.name], error);
  }
}

void negativeRuleHandler(VineValidationContext ctx, FieldContext field, String? message) {
  if (field.value case num value when !value.isNegative) {
    final error = ctx.errorReporter.format('negative', field, message, {});
    ctx.errorReporter.report('negative', [...field.customKeys, field.name], error);
  }
}

void positiveRuleHandler(VineValidationContext ctx, FieldContext field, String? message) {
  if (field.value case num value when value.isNegative) {
    final error = ctx.errorReporter.format('positive', field, message, {});
    ctx.errorReporter.report('positive', [...field.customKeys, field.name], error);
  }
}

void doubleRuleHandler(VineValidationContext ctx, FieldContext field, String? message) {

  if (field.value case num value when value is! double) {
    final error = ctx.errorReporter.format('double', field, message, {});
    ctx.errorReporter.report('double', [...field.customKeys, field.name], error);
  }
}

void integerRuleHandler(VineValidationContext ctx, FieldContext field, String? message) {
  if (field.value case num value when value is! int) {
    final error = ctx.errorReporter.format('integer', field, message, {});
    ctx.errorReporter.report('integer', [...field.customKeys, field.name], error);
  }
}
