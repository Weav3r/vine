import 'package:vine/src/contracts/vine.dart';

void booleanRuleHandler(
    VineValidationContext ctx, FieldContext field, bool literal, String? message) {
  final bool? content = !literal
      ? switch (field.value) {
          String() => bool.tryParse(field.value.toString()),
          bool() => field.value,
          _ => null
        }
      : switch (field.value) {
          '1' => true,
          '0' => false,
          String() => bool.tryParse(field.value),
          1 => true,
          0 => false,
          bool() => field.value,
          _ => null,
        };

  if (content == null) {
    if (field.isUnion) {
      throw Exception('Union type is not supported for boolean type');
    }

    final error = ctx.errorReporter.format('boolean', field, message, {});
    ctx.errorReporter.report('boolean', [...field.customKeys, field.name], error);
  } else {
    field.mutate(content);
  }
}
