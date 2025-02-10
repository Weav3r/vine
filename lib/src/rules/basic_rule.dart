import 'package:vine/src/contracts/vine.dart';

void nullableRuleHandler(FieldContext field) {
  if (field.value != null) {
    field.next();
  }
}

void optionalRuleHandler(FieldContext field) {
  if (field.value == null && field.value is! MissingValue) {
    field.next();
  }
}
