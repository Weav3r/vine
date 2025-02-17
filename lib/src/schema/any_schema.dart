import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/basic_rule.dart';

final class VineAnySchema extends RuleParser implements VineAny {
  VineAnySchema(super._rules);

  @override
  VineAny requiredIfExist(List<String> values) {
    super.addRule((ctx, field) => requiredIfExistsRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineAny requiredIfAnyExist(List<String> values) {
    super.addRule((ctx, field) => requiredIfAnyExistsRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineAny requiredIfMissing(List<String> values) {
    super.addRule((ctx, field) => requiredIfMissingRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineAny requiredIfAnyMissing(List<String> values) {
    super.addRule((ctx, field) => requiredIfAnyMissingRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineAny transform(Function(VineValidationContext, FieldContext) fn) {
    super.addRule((ctx, field) => transformRuleHandler(ctx, field, fn));
    return this;
  }

  @override
  VineAny nullable() {
    super.isNullable = true;
    return this;
  }

  @override
  VineAny optional() {
    super.isOptional = true;
    return this;
  }

  @override
  VineAny clone() {
    return VineAnySchema(Queue.of(rules));
  }
}
