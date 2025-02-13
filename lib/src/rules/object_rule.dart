import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/field.dart';
import 'package:vine/src/rule_parser.dart';

void objectRuleHandler(VineValidationContext ctx, FieldContext field,
    Map<String, VineSchema> payload, String? message) {
  if (field.value is! Map) {
    final error = ctx.errorReporter.format('object', field, message, {});
    return ctx.errorReporter.report('object', field.customKeys, error);
  }

  final currentField = Field('', null);
  for (final property in payload.entries) {
    final copyRules = Queue.of((property.value as RuleParser).rules);

    if (property.value is VineArray) {
      field.customKeys.add(property.key);
    }

    if (property.value is VineObject) {
      if (field.value case Map values when !values.containsKey(property.key)) {
        final error = ctx.errorReporter.format('object', field, message, {});
        ctx.errorReporter.report('object', field.customKeys, error);
      }

      currentField.customKeys.add(property.key);
    }

    currentField
      ..name = property.key
      ..value = (field.value as Map).containsKey(property.key)
          ? field.value[property.key]
          : MissingValue();

    property.value.parse(ctx, currentField);

    (property.value as RuleParser).rules.addAll(copyRules);

    field.mutate({
      ...field.value as Map<String, dynamic>,
      currentField.name: currentField.value
    });

    if (!currentField.canBeContinue) break;
    if (ctx.errorReporter.hasError) break;
  }

  final copy = {...field.value as Map<String, dynamic>};
  for (final value in (field.value as Map<String, dynamic>).entries) {
    if (payload.containsKey(value.key)) {
      field.mutate({
        ...field.value as Map<String, dynamic>,
        value.key: copy[value.key]
      });
    }
  }
}
