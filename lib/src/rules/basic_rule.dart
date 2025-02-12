import 'package:vine/src/contracts/vine.dart';

void nullableRuleHandler(FieldContext field) {
  if (field.value == null) {
    field.canBeContinue = false;
  }
}

void optionalRuleHandler(FieldContext field) {
  if (field.value is MissingValue) {
    field.canBeContinue = false;
    field.data.remove(field.name);
  }
}
