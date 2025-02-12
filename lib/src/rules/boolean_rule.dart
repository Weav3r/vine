import 'package:vine/src/contracts/vine.dart';

void booleanRuleHandler(FieldContext field, String? message) {
  final bool? content = switch (field.value) {
    '1' => true,
    '0' => false,
    String() => bool.tryParse(field.value),
    1 => true,
    0 => false,
    bool() => field.value,
    _ => null,
  };

  if (content == null) {
    final error = field.errorReporter.format('boolean', field, message, {});
    field.errorReporter.report('boolean', [...field.customKeys, field.name], error);
  } else {
    field.mutate(content);
  }
}
