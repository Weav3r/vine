import 'package:vine/src/contracts/vine.dart';

void nullableRuleHandler(VineValidationContext ctx, FieldContext field) {
  if (field.value == null) {
    field.canBeContinue = false;
  }
}

void optionalRuleHandler(VineValidationContext ctx, FieldContext field) {
  if (field.value is MissingValue) {
    field.canBeContinue = false;
    ctx.data.remove(field.name);
  }
}
