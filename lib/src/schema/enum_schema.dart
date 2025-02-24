import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/basic_rule.dart';
import 'package:vine/vine.dart';

final class VineEnumSchema extends RuleParser implements VineEnum {
  VineEnumSchema(super._rules);

  @override
  VineEnum requiredIfExist(List<String> values) {
    super.addRule(VineRequiredIfExistRule(values), positioned: true);
    return this;
  }

  @override
  VineEnum requiredIfAnyExist(List<String> values) {
    super.addRule(VineRequiredIfAnyExistRule(values), positioned: true);
    return this;
  }

  @override
  VineEnum requiredIfMissing(List<String> values) {
    super.addRule(VineRequiredIfMissingRule(values), positioned: true);
    return this;
  }

  @override
  VineEnum requiredIfAnyMissing(List<String> values) {
    super.addRule(VineRequiredIfAnyMissingRule(values), positioned: true);
    return this;
  }

  @override
  VineEnum transform(Function(VineValidationContext, FieldContext) fn) {
    super.addRule(VineTransformRule(fn));
    return this;
  }

  @override
  VineEnum nullable() {
    super.isNullable = true;
    return this;
  }

  @override
  VineEnum optional() {
    super.isOptional = true;
    return this;
  }

  @override
  VineEnum clone() {
    return VineEnumSchema(Queue.of(rules));
  }
}
