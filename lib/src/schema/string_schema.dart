import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/string_rule.dart';

final class VineStringSchema extends RuleParser implements VineString {
  VineStringSchema(super._rules);

  @override
  VineString minLength(int value, {String? message}) {
    super.addRule((ctx, field) => minLengthRuleHandler(ctx, field, value, message));
    return this;
  }

  @override
  VineString maxLength(int value, {String? message}) {
    super.addRule((ctx, field) => maxLengthRuleHandler(ctx, field, value, message));
    return this;
  }

  @override
  VineString fixedLength(int value, {String? message}) {
    super.addRule((ctx, field) => fixedLengthRuleHandler(ctx, field, value, message));
    return this;
  }

  @override
  VineString email({String? message}) {
    super.addRule((ctx, field) => emailRuleHandler(ctx, field, message));
    return this;
  }

  @override
  VineString phone({String? message}) {
    super.addRule((ctx, field) => phoneRuleHandler(ctx, field, message));
    return this;
  }

  @override
  VineString ipAddress({IpAddressVersion? version, String? message}) {
    super.addRule((ctx, field) => ipAddressRuleHandler(ctx, field, version, message));
    return this;
  }

  @override
  VineString url(
      {List<String> protocols = const ['http', 'https', 'ftp'],
      bool requireTld = true,
      bool requireProtocol = false,
      bool allowUnderscores = false,
      String? message}) {
    super.addRule((ctx, field) =>
        urlRuleHandler(ctx, field, protocols, requireTld, requireProtocol, allowUnderscores, message));
    return this;
  }

  @override
  VineString alpha({String? message}) {
    super.addRule((ctx, field) => alphaRuleHandler(ctx, field, message));
    return this;
  }

  @override
  VineString alphaNumeric({String? message}) {
    super.addRule((ctx, field) => alphaNumericRuleHandler(ctx, field, message));
    return this;
  }

  @override
  VineString startsWith(String value, {String? message}) {
    super.addRule((ctx, field) => startWithRuleHandler(ctx, field, value, message));
    return this;
  }

  @override
  VineString endsWith(String value, {String? message}) {
    super.addRule((ctx, field) => endWithRuleHandler(ctx, field, value, message));
    return this;
  }

  @override
  VineString confirmed({String? property, bool include = false, String? message}) {
    super.addRule((ctx, field) => confirmedRuleHandler(ctx, field, property, include, message));
    return this;
  }

  @override
  VineString trim() {
    super.addRule(trimRuleHandler);
    return this;
  }

  @override
  VineString normalizeEmail({bool lowercase = true}) {
    super.addRule((ctx, field) => normalizeEmailRuleHandler(ctx, field, lowercase));
    return this;
  }

  @override
  VineString toUpperCase() {
    super.addRule(toUpperCaseRuleHandler);
    return this;
  }

  @override
  VineString toLowerCase() {
    super.addRule(toLowerCaseRuleHandler);
    return this;
  }

  @override
  VineString toCamelCase() {
    super.addRule(toCamelCaseRuleHandler);
    return this;
  }

  @override
  VineString uuid({UuidVersion? version, String? message}) {
    super.addRule((ctx, field) => uuidRuleHandler(ctx, field, version, message));
    return this;
  }

  @override
  VineString isCreditCard({String? message}) {
    super.addRule((ctx, field) => isCreditCodeRuleHandler(ctx, field, message));
    return this;
  }

  @override
  VineString sameAs(String value, {String? message}) {
    super.addRule((ctx, field) => sameAsRuleHandler(ctx, field, value, message));
    return this;
  }

  @override
  VineString notSameAs(String value, {String? message}) {

    return this;
  }

  @override
  VineString inList(List<String> values, {String? message}) {
    super.addRule((ctx, field) => inListRuleHandler(ctx, field, values, message));
    return this;
  }

  @override
  VineString notInList(List<String> values, {String? message}) {
    super.addRule((ctx, field) => notInListRuleHandler(ctx, field, values, message));
    return this;
  }

  @override
  VineString nullable() {
    super.isNullable = true;
    return this;
  }

  @override
  VineString optional() {
    super.isOptional = true;
    return this;
  }
}
