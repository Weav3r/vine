import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/field.dart';
import 'package:vine/src/rule_parser.dart';

void arrayRuleHandler(VineValidationContext ctx, FieldContext field, VineSchema schema) {
  final copy = field.customKeys;

  final currentField = Field('', null);
  if (field.value case List values) {
    final copyRules = Queue.of((schema as RuleParser).rules);

    for (int i = 0; i < values.length; i++) {
      (schema as RuleParser).rules.clear();
      (schema as RuleParser).rules.addAll(copyRules);

      field.customKeys.add(i.toString());
      schema.parse(ctx, currentField..value = values[i]);

      field.customKeys
        ..clear()
        ..addAll(copy);

      field.mutate([...field.value, currentField.value]);
    }

    return;
  }

  final error = ctx.errorReporter.format('array', field, null, {});
  ctx.errorReporter.report('array', [...field.customKeys, field.name], error);
}
