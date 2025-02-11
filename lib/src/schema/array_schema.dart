import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/basic_rule.dart';

final class VineArraySchema extends RuleParser implements VineArray {
  VineArraySchema(super._rules);

  @override
  VineArray nullable() {
    super.addRule(nullableRuleHandler, position: 0);
    return this;
  }

  @override
  VineArray optional() {
    super.addRule(optionalRuleHandler, position: 0);
    return this;
  }
}
