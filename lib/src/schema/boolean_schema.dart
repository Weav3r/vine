import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/basic_rule.dart';

final class VineBooleanSchema extends RuleParser implements VineBoolean {
  VineBooleanSchema(super._rules);

  @override
  VineBoolean requiredIfExist(List<String> values) {
    super.addRule((ctx, field) => requiredIfExistsRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineBoolean requiredIfAnyExist(List<String> values) {
    super.addRule((ctx, field) => requiredIfAnyExistsRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineBoolean requiredIfMissing(List<String> values) {
    super.addRule((ctx, field) => requiredIfMissingRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineBoolean requiredIfAnyMissing(List<String> values) {
    super.addRule((ctx, field) => requiredIfAnyMissingRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineBoolean transform(Function(VineValidationContext, FieldContext) fn) {
    super.addRule((ctx, field) => transformRuleHandler(ctx, field, fn));
    return this;
  }

  @override
  VineBoolean nullable() {
    super.isNullable = true;
    return this;
  }

  @override
  VineBoolean optional() {
    super.isOptional = true;
    return this;
  }

  @override
  VineBoolean clone() {
    return VineBooleanSchema(Queue.of(rules));
  }
}
