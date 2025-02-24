import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/basic_rule.dart';
import 'package:vine/vine.dart';

final class VineUnionSchema extends RuleParser implements VineUnion {
  VineUnionSchema(super._rules);

  @override
  VineUnion requiredIfExist(List<String> values) {
    super.addRule(VineRequiredIfExistRule(values), positioned: true);
    return this;
  }

  @override
  VineUnion requiredIfAnyExist(List<String> values) {
    super.addRule(VineRequiredIfAnyExistRule(values), positioned: true);
    return this;
  }

  @override
  VineUnion requiredIfMissing(List<String> values) {
    super.addRule(VineRequiredIfMissingRule(values), positioned: true);
    return this;
  }

  @override
  VineUnion requiredIfAnyMissing(List<String> values) {
    super.addRule(VineRequiredIfAnyMissingRule(values), positioned: true);
    return this;
  }

  @override
  VineUnion transform(Function(VineValidationContext, FieldContext) fn) {
    super.addRule(VineTransformRule(fn));
    return this;
  }

  @override
  VineUnion nullable() {
    super.isNullable = true;
    return this;
  }

  @override
  VineUnion optional() {
    super.isOptional = true;
    return this;
  }

  @override
  VineUnion clone() {
    return VineUnionSchema(Queue.of(rules));
  }
}
