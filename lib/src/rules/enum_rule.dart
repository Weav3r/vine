import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';

void enumRuleHandler<T extends VineEnumerable>(FieldContext field, List<T> source) {
  if (field.value == null) {
    return;
  }

  final values = source.where((element) => element.value == field.value);
  if (values.firstOrNull == null) {
    final error = field.errorReporter.format('enum', field, null, {
      'values': source.map((e) => e.value).toList(),
    });

    field.errorReporter.report('enum', [...field.customKeys, field.name], error);
  }
}
