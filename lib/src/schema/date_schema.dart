import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/basic_rule.dart';
import 'package:vine/src/rules/date_rule.dart';

final class VineDateSchema extends RuleParser implements VineDate {
  VineDateSchema(super._rules);

  @override
  VineDate before(DateTime value, {String? message}) {
    super.addRule((ctx, field) => beforeDateRuleHandler(ctx, field, value, message));
    return this;
  }

  @override
  VineDate after(DateTime value, {String? message}) {
    super.addRule((ctx, field) => afterDateRuleHandler(ctx, field, value, message));
    return this;
  }

  @override
  VineDate between(DateTime min, DateTime max, {String? message}) {
    super.addRule((ctx, field) => betweenDateRuleHandler(ctx, field, min, max, message));
    return this;
  }

  @override
  VineDate beforeField(String target, {String? message}) {
    super.addRule((ctx, field) => beforeFieldDateRuleHandler(ctx, field, target, message));
    return this;
  }

  @override
  VineDate afterField(String target, {String? message}) {
    super.addRule((ctx, field) => beforeFieldDateRuleHandler(ctx, field, target, message));
    return this;
  }

  @override
  VineDate betweenFields(String start, String end, {String? message}) {
    super.addRule((ctx, field) => betweenFieldDateRuleHandler(ctx, field, start, end, message));
    return this;
  }

  @override
  VineDate transform(Function(VineValidationContext, FieldContext) fn) {
    super.addRule((ctx, field) => transformRuleHandler(ctx, field, fn));
    return this;
  }

  @override
  VineDate requiredIfExist(List<String> values) {
    super.addRule((ctx, field) => requiredIfExistsRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineDate requiredIfAnyExist(List<String> values) {
    super.addRule((ctx, field) => requiredIfAnyExistsRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineDate requiredIfMissing(List<String> values) {
    super.addRule((ctx, field) => requiredIfMissingRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineDate requiredIfAnyMissing(List<String> values) {
    super.addRule((ctx, field) => requiredIfAnyMissingRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineDate nullable() {
    super.isNullable = true;
    return this;
  }

  @override
  VineDate optional() {
    super.isOptional = true;
    return this;
  }

  @override
  VineDate clone() {
    return VineDateSchema(Queue.of(rules));
  }
}
