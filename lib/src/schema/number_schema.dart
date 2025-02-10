import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/basic_rule.dart';
import 'package:vine/src/rules/number_rule.dart';

final class VineNumberSchema extends RuleParser implements VineNumber {
  VineNumberSchema(super._rules);

  @override
  VineNumber range(List<int> values, {String? message}) {
    super.addRule((field) => rangeRuleHandler(field, values, message));
    return this;
  }

  @override
  VineNumber nullable() {
    super.addRule(nullableRuleHandler, position: 0);
    return this;
  }

  @override
  VineNumber optional() {
    super.addRule(optionalRuleHandler, position: 0);
    return this;
  }
}
