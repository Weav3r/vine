import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/basic_rule.dart';

final class VineArraySchema extends RuleParser implements VineArray {
  VineArraySchema(super._rules);

  @override
  VineArray requiredIfExist(List<String> values) {
    super.addRule((ctx, field) => requiredIfExistsRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineArray requiredIfAnyExist(List<String> values) {
    super.addRule((ctx, field) => requiredIfAnyExistsRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineArray requiredIfMissing(List<String> values) {
    super.addRule((ctx, field) => requiredIfMissingRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineArray requiredIfAnyMissing(List<String> values) {
    super.addRule((ctx, field) => requiredIfAnyMissingRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineArray nullable() {
    super.isNullable = true;
    return this;
  }

  @override
  VineArray optional() {
    super.isOptional = true;
    return this;
  }

  @override
  VineArray clone() {
    return VineArraySchema(Queue.of(rules));
  }
}
