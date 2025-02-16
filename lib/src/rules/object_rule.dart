import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/field_pool.dart';

void objectRuleHandler(VineValidationContext ctx, FieldContext field,
    Map<String, VineSchema> payload, String? message) {
  if (field.value is! Map) {
    final error = ctx.errorReporter.format('object', field, message, {});
    return ctx.errorReporter.report('object', field.customKeys, error);
  }

  for (final MapEntry(:key, :value) in payload.entries) {
    final currentField = FieldPool.acquire(
        key, (field.value as Map).containsKey(key) ? field.value[key] : MissingValue())
      ..customKeys.addAll(field.customKeys);

    if (value is VineArray) {
      field.customKeys.add(key);
    }

    if (value is VineObject) {
      if (field.value case Map values when !values.containsKey(key)) {
        final error = ctx.errorReporter.format('object', field, message, {});
        ctx.errorReporter.report('object', field.customKeys, error);
      }

      currentField.customKeys.add(key);
      field.customKeys.add(key);
    }

    value.parse(ctx, currentField);

    field.mutate({...field.value as Map<String, dynamic>, currentField.name: currentField.value});
    FieldPool.release(currentField);

    if (!currentField.canBeContinue) break;
    if (ctx.errorReporter.hasError) break;
  }

  final copy = {...field.value as Map<String, dynamic>};
  for (final value in (field.value as Map<String, dynamic>).entries) {
    if (!payload.containsKey(value.key)) {
      copy.remove(value.key);
    }
  }
  field.mutate(copy);
}
