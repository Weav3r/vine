import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/field.dart';
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
