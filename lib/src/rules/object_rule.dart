import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/rule_parser.dart';

void objectRuleHandler(FieldContext field, Map<String, VineSchema> payload, String? message) {
  for (final property in payload.entries) {
    final copy = field.value;
    final copyRules = Queue.of((property.value as RuleParser).rules);

    if (property.value is VineArray) {
      field.customKeys.add(property.key);
    }

    if (property.value is VineObject) {
      field.customKeys.add(property.key);
    }

    field.value =
        (field.value as Map).containsKey(property.key) ? field.value[property.key] : MissingValue();

    field.name = property.key;
    final ctx = property.value.parse(field.errorReporter, field);

    if (ctx case List<FieldContext> values) {
      field.mutate(values.map((ctx) => ctx.value).toList());
    }

    (property.value as RuleParser).rules.addAll(copyRules);
    field.value = copy;
    field.customKeys.clear();

    if (!field.canBeContinue) break;
    if (field.errorReporter.hasError) break;
  }
}
