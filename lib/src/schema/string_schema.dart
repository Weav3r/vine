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
  VineString alpha(
      {String? message}) {
    super.addRule(
        (field) => alphaRuleHandler(field, message),
        position: 0);
    return this;
  }

  @override
  VineString alphanumeric(
      {String? message}) {
    super.addRule(
            (field) => alphanumericRuleHandler(field, message),
        position: 0);
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
