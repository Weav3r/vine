import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/basic_rule.dart';
import 'package:vine/src/rules/number_rule.dart';

final class VineNumberSchema extends RuleParser implements VineNumber {
  VineNumberSchema(super._rules);

  @override
  VineNumber range(List<num> values, {String? message}) {
    super.addRule((ctx, field) => rangeRuleHandler(ctx, field, values, message));
    return this;
  }

  @override
  VineNumber min(num value, {String? message}) {
    super.addRule((ctx, field) => minRuleHandler(ctx, field, value, message));
    return this;
  }

  @override
  VineNumber max(num value, {String? message}) {
    super.addRule((ctx, field) => maxRuleHandler(ctx, field, value, message));
    return this;
  }

  @override
  VineNumber negative({String? message}) {
    super.addRule((ctx, field) => negativeRuleHandler(ctx, field, message));
    return this;
  }

  @override
  VineNumber positive({String? message}) {
    super.addRule((ctx, field) => positiveRuleHandler(ctx, field, message));
    return this;
  }

  @override
  VineNumber double({String? message}) {
    super.addRule((ctx, field) => doubleRuleHandler(ctx, field, message));
    return this;
  }

  @override
  VineNumber integer({String? message}) {
    super.addRule((ctx, field) => integerRuleHandler(ctx, field, message));
    return this;
  }

  @override
  VineNumber requiredIfExist(List<String> values) {
    super.addRule((ctx, field) => requiredIfExistsRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineNumber requiredIfAnyExist(List<String> values) {
    super.addRule((ctx, field) => requiredIfAnyExistsRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineNumber requiredIfMissing(List<String> values) {
    super.addRule((ctx, field) => requiredIfMissingRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineNumber requiredIfAnyMissing(List<String> values) {
    super.addRule((ctx, field) => requiredIfAnyMissingRuleHandler(ctx, field, values), positioned: true);
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
