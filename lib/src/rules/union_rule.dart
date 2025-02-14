import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/field.dart';
import 'package:vine/src/field_pool.dart';

void unionRuleHandler(VineValidationContext ctx, FieldContext field, Queue<ParseHandler> rules,
    List<VineSchema> schemas) {
  final List errors = [];
  field.customKeys.add(field.name);
  final currentField = FieldPool.acquire(field.name, field.value);

  currentField.isUnion = true;
  for (final schema in schemas) {
    try {
      schema.parse(ctx, currentField);
    } catch (e) {
      errors.add(e);
    }
  }
  currentField.isUnion = false;
  FieldPool.release(currentField);

  if (errors.length == schemas.length) {
    final error = ctx.errorReporter.format('union', field, null, {
      'types': schemas
          .map((schema) => schema.runtimeType.toString().replaceFirst('Schema', ''))
          .join(', ')
    });

    ctx.errorReporter.report('union', field.customKeys, error);
    throw ctx.errorReporter.createError({'errors': ctx.errorReporter.errors});
  }
}
