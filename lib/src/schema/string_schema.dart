import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/basic_rule.dart';
import 'package:vine/src/rules/string_rule.dart';

final class VineStringSchema extends RuleParser implements VineString {
  VineStringSchema(super._rules);

  @override
  VineString minLength(int value, {String? message}) {
    super.addRule((field) => minLengthRuleHandler(field, value, message));
    return this;
  }

  @override
  VineString maxLength(int value, {String? message}) {
    super.addRule((field) => maxLengthRuleHandler(field, value, message));
    return this;
  }

  @override
  VineString fixedLength(int value, {String? message}) {
    super.addRule((field) => fixedLengthRuleHandler(field, value, message));
    return this;
  }

  @override
  VineString email({String? message}) {
    super.addRule((field) => emailRuleHandler(field, message));
    return this;
  }

  @override
  VineString phone({String? message}) {
    super.addRule((field) => phoneRuleHandler(field, message));
    return this;
  }

  @override
  VineString ipAddress({IpAddressVersion? version, String? message}) {
    super.addRule((field) => ipAddressRuleHandler(field, version, message));
    return this;
  }

  @override
  VineString url(
      {List<String> protocols = const ['http', 'https', 'ftp'],
      bool requireTld = true,
      bool requireProtocol = false,
      bool allowUnderscores = false,
      String? message}) {
    super.addRule((field) =>
        urlRuleHandler(field, protocols, requireTld, requireProtocol, allowUnderscores, message));
    return this;
  }

  @override
  VineString alpha({String? message}) {
    super.addRule((field) => alphaRuleHandler(field, message), position: 0);
    return this;
  }

  @override
  VineString alphaNumeric({String? message}) {
    super.addRule((field) => alphaNumericRuleHandler(field, message), position: 0);
    return this;
  }

  @override
  VineString startWith(String value, {String? message}) {
    super.addRule((field) => startWithRuleHandler(field, value, message));
    return this;
  }

  @override
  VineString endWith(String value, {String? message}) {
    super.addRule((field) => endWithRuleHandler(field, value, message));
    return this;
  }

  @override
  VineString confirmed({String? property, bool include = false, String? message}) {
    super.addRule((field) => confirmedRuleHandler(field, property, include, message));
    return this;
  }

  @override
  VineString trim() {
    super.addRule(trimRuleHandler);
    return this;
  }

  @override
  VineString normalizeEmail({bool lowercase = true}) {
    super.addRule((field) => normalizeEmailRuleHandler(field, lowercase));
    return this;
  }

  @override
  VineString toUpperCase() {
    super.addRule(toUpperCaseRuleHandler);
    return this;
  }

  @override
  VineString toLowerCase() {
    super.addRule(toUpperCaseRuleHandler);
    return this;
  }

  @override
  VineString toCamelCase() {
    super.addRule(toCamelCaseRuleHandler);
    return this;
  }

  @override
  VineString uuid({UuidVersion? version, String? message}) {
    super.addRule((field) => uuidRuleHandler(field, version, message));
    return this;
  }

  @override
  VineString isCreditCard({String? message}) {
    super.addRule((field) => isCreditCodeRuleHandler(field, message));
    return this;
  }

  @override
  VineString nullable() {
    super.addRule(nullableRuleHandler, position: 0);
    return this;
  }

  @override
  VineString optional() {
    super.addRule(optionalRuleHandler, position: 0);
    return this;
  }
}
