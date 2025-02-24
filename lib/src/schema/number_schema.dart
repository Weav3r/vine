import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/basic_rule.dart';
import 'package:vine/src/rules/number_rule.dart';

final class VineNumberSchema extends RuleParser implements VineNumber {
  VineNumberSchema(super._rules);

  @override
  VineNumber range(List<num> values, {String? message}) {
    super.addRule(VineRangeRule(values, message));
    return this;
  }

  @override
  VineNumber min(num value, {String? message}) {
    super.addRule(VineMinRule(value, message));
    return this;
  }

  @override
  VineNumber max(num value, {String? message}) {
    super.addRule(VineMaxRule(value, message));
    return this;
  }

  @override
  VineNumber negative({String? message}) {
    super.addRule(VineNegativeRule(message));
    return this;
  }

  @override
  VineNumber positive({String? message}) {
    super.addRule(VinePositiveRule(message));
    return this;
  }

  @override
  VineNumber double({String? message}) {
    super.addRule(VineDoubleRule(message));
    return this;
  }

  @override
  VineNumber integer({String? message}) {
    super.addRule(VineIntegerRule(message));
    return this;
  }

  @override
  VineNumber requiredIfExist(List<String> values) {
    super.addRule(VineRequiredIfExistRule(values), positioned: true);
    return this;
  }

  @override
  VineNumber requiredIfAnyExist(List<String> values) {
    super.addRule(VineRequiredIfAnyExistRule(values), positioned: true);
    return this;
  }

  @override
  VineNumber requiredIfMissing(List<String> values) {
    super.addRule(VineRequiredIfMissingRule(values), positioned: true);
    return this;
  }

  @override
  VineNumber requiredIfAnyMissing(List<String> values) {
    super.addRule(VineRequiredIfAnyMissingRule(values), positioned: true);
    return this;
  }

  @override
  VineNumber transform(Function(VineValidationContext, FieldContext) fn) {
    super.addRule(VineTransformRule(fn));
    return this;
  }

  @override
  VineNumber nullable() {
    super.isNullable = true;
    return this;
  }

  @override
  VineNumber optional() {
    super.isOptional = true;
    return this;
  }

  @override
  VineNumber clone() {
    return VineNumberSchema(Queue.of(rules));
  }
}
