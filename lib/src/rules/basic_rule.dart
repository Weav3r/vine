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

void requiredIfExistsRuleHandler(
    VineValidationContext ctx, FieldContext field, List<String> values) {
  final currentContext = ctx.getFieldContext(field.customKeys);
  List<bool> matchs = [];

  for (final value in values) {
    matchs.add(currentContext.containsKey(value));
  }

  if (!matchs.contains(false) && field.value == null) {
    final error = ctx.errorReporter.format('requiredIfExists', field, null, {});
    ctx.errorReporter.report('requiredIfExists', field.customKeys, error);

    field.canBeContinue = false;
  }
}

void requiredIfAnyExistsRuleHandler(
    VineValidationContext ctx, FieldContext field, List<String> values) {
  final currentContext = ctx.getFieldContext(field.customKeys);
  bool hasMatch = false;

  for (final value in values) {
    if (currentContext.containsKey(value)) {
      hasMatch = true;
      break;
    }
  }

  if (hasMatch && field.value == null) {
    final error = ctx.errorReporter.format('requiredIfExistsAny', field, null, {});
    ctx.errorReporter.report('requiredIfExistsAny', field.customKeys, error);

    field.canBeContinue = false;
  }
}

void requiredIfMissingRuleHandler(
    VineValidationContext ctx, FieldContext field, List<String> values) {
  final currentContext = ctx.getFieldContext(field.customKeys);
  List<bool> matchs = [];

  for (final value in values) {
    matchs.add(currentContext.containsKey(value));
  }

  if (!matchs.contains(true) && field.value == null) {
    final error = ctx.errorReporter.format('requiredIfMissing', field, null, {});
    ctx.errorReporter.report('requiredIfMissing', field.customKeys, error);

    field.canBeContinue = false;
  }
}

void requiredIfAnyMissingRuleHandler(
    VineValidationContext ctx, FieldContext field, List<String> values) {
  final currentContext = ctx.getFieldContext(field.customKeys);
  bool hasMatch = false;

  for (final value in values) {
    if (currentContext.containsKey(value)) {
      hasMatch = true;
      break;
    }
  }

  if (!hasMatch && field.value == null) {
    final error = ctx.errorReporter.format('requiredIfMissingAny', field, null, {});
    ctx.errorReporter.report('requiredIfMissingAny', field.customKeys, error);

    field.canBeContinue = false;
  }
}

void transformRuleHandler(VineValidationContext ctx, FieldContext field,
    Function(VineValidationContext, FieldContext) fn) {
  final result = fn(ctx, field);
  field.mutate(result);
}
