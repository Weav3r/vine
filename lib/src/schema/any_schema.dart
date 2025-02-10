import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/basic_rule.dart';

final class VineAnySchema extends RuleParser implements VineAny {
  VineAnySchema(super._rules);

  @override
  VineAny nullable() {
    super.addRule(nullableRuleHandler, position: 0);
    return this;
  }

  @override
  VineAny optional() {
    super.addRule(optionalRuleHandler, position: 0);
    return this;
  }
}
