import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/field_pool.dart';
import 'package:vine/src/rule_parser.dart';

void arrayRuleHandler(VineValidationContext ctx, FieldContext field, VineSchema schema) {
  final copy = field.customKeys;

  if (field.value case List values) {
    final currentSchema = schema as RuleParser;
    final copyRules = currentSchema.rules.toList();

    for (int i = 0; i < values.length; i++) {
      final currentField = FieldPool.acquire(field.name, values[i]);

      currentSchema.rules.clear();
      currentSchema.rules.addAll(copyRules);

      currentField.customKeys.add(i.toString());
      schema.parse(ctx, currentField);

      currentField.customKeys
        ..clear()
        ..addAll(copy);

      currentField.mutate([...field.value, currentField.value]);
      FieldPool.release(currentField);
    }

    return;
  }

  final error = ctx.errorReporter.format('array', field, null, {});
  ctx.errorReporter.report('array', [...field.customKeys, field.name], error);
}

void arrayMinLengthRuleHandler(VineValidationContext ctx, FieldContext field, int minValue, String? message) {
  if ((field.value as String).length < minValue) {
    final error = ctx.errorReporter.format('array.minLength', field, message, {
      'min': minValue,
    });

    ctx.errorReporter.report('array.minLength', [...field.customKeys, field.name], error);
  }
}

void arrayMaxLengthRuleHandler(VineValidationContext ctx, FieldContext field, int maxValue, String? message) {
  if ((field.value as String).length > maxValue) {
    final error = ctx.errorReporter.format('array.maxLength', field, message, {
      'max': maxValue,
    });

    ctx.errorReporter.report('array.maxLength', [...field.customKeys, field.name], error);
  }
}

void arrayFixedLengthRuleHandler(VineValidationContext ctx, FieldContext field, int count, String? message) {
  if ((field.value as String).length != count) {
    final error = ctx.errorReporter.format('array.fixedLength', field, message, {
      'length': count,
    });
    ctx.errorReporter.report('array.fixedLength', [...field.customKeys, field.name], error);
  }
}
