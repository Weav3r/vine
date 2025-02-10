import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/basic_rule.dart';

final class VineEnumSchema extends RuleParser implements VineEnum {
  VineEnumSchema(super._rules);

  @override
  VineEnum nullable() {
    super.addRule(nullableRuleHandler, position: 0);
    return this;
  }

  @override
  VineEnum optional() {
    super.addRule(optionalRuleHandler, position: 0);
    return this;
  }
}
