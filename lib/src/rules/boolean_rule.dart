import 'package:vine/src/contracts/vine.dart';

void booleanRuleHandler(FieldContext field, String? message) {
  final content = switch(field.value) {
    String value when value == '1' => true,
    String value when value == '0' => false,
    String value => bool.tryParse(value),
    int value when value == 1 => true,
    int value when value == 0 => false,
    bool value => value,
    _ => null,
  };

  if (content == null) {
    final error = field.errorReporter.format('boolean', field, message, {});
    field.errorReporter.report('boolean', field.name, error);
  } else {
    field.mutate(content);
  }

  field.next();
}
