import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';

void arrayRuleHandler(FieldContext field, List<ParseHandler> rules, VineSchema schema) {
  if (field.value case List values) {
    final List<FieldContext> contexts = [];

    for (final value in values) {
      final index = values.indexOf(value);
      final ctx = schema.parse(field.errorReporter, field.validator, '${field.name}[$index]', value);
      contexts.add(ctx);
    }

    field.mutate(contexts);
  } else {
    final error = field.errorReporter.format('array', field, null, {});
    field.errorReporter.report('array', field.name, error);
  }

  field.next();
}
