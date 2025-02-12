import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/number_rule.dart';

final class VineNumberSchema extends RuleParser implements VineNumber {
  VineNumberSchema(super._rules);

  @override
  VineNumber range(List<num> values, {String? message}) {
    super.addRule((field) => rangeRuleHandler(field, values, message));
    return this;
  }

  @override
  VineNumber min(num value, {String? message}) {
    super.addRule((field) => minRuleHandler(field, value, message));
    return this;
  }

  @override
  VineNumber max(num value, {String? message}) {
    super.addRule((field) => maxRuleHandler(field, value, message));
    return this;
  }

  @override
  VineNumber negative({String? message}) {
    super.addRule((field) => negativeRuleHandler(field, message));
    return this;
  }

  @override
  VineNumber positive({String? message}) {
    super.addRule((field) => positiveRuleHandler(field, message));
    return this;
  }

  @override
  VineNumber double({String? message}) {
    super.addRule((field) => doubleRuleHandler(field, message));
    return this;
  }

  @override
  VineNumber integer({String? message}) {
    super.addRule((field) => integerRuleHandler(field, message));
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
}
