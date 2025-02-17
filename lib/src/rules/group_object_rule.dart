import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/rules/object_rule.dart';

void groupObjectRuleHandler(VineValidationContext ctx, FieldContext field,
    bool Function(Map<String, dynamic> data) fn, Map<String, VineSchema> object) {
  if (fn(ctx.data as Map<String, dynamic>)) {
    field.customKeys.add(field.name);
    objectRuleHandler(ctx, field, object, null);
  }
}
