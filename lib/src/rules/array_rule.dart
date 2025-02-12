import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/rule_parser.dart';

void arrayRuleHandler(FieldContext field, VineSchema schema) {
  final copy = field.customKeys;
  if (field.value case List values) {
    final List validatedValues = [];
    final copyRules = Queue.of((schema as RuleParser).rules);

    for (int i = 0; i < values.length; i++) {
      (schema as RuleParser).rules.clear();
      (schema as RuleParser).rules.addAll(copyRules);

      field.customKeys.add(i.toString());
      final ctx = schema.parse(field.errorReporter, field..value = values[i]);

      field.customKeys
        ..clear()
        ..addAll(copy);

      validatedValues.add(ctx.value);
    }

    field.mutate(validatedValues);
    return;
  }

  final error = field.errorReporter.format('array', field, null, {});
  field.errorReporter.report('array', [...field.customKeys, field.name], error);
}
