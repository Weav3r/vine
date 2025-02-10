import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/basic_rule.dart';

final class VineBooleanSchema extends RuleParser implements VineBoolean {
  VineBooleanSchema(super._rules);

  @override
  VineBoolean nullable() {
    super.addRule(nullableRuleHandler, position: 0);
    return this;
  }

  @override
  VineBoolean optional() {
    super.addRule(optionalRuleHandler, position: 0);
    return this;
  }
}
