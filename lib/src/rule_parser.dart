import 'dart:collection';

import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/rules/basic_rule.dart';
import 'package:vine/vine.dart';

abstract interface class RuleParserContract {
  Queue<VineRule> get rules;
  void addRule(VineRule rule, {bool positioned = false});
}

class RuleParser implements RuleParserContract {
  @override
  Queue<VineRule> rules;

  bool isNullable = false;
  bool isOptional = false;

  RuleParser(this.rules);

  @override
  void addRule(VineRule rule, {bool positioned = false}) {
    if (positioned) {
      rules.addFirst(rule);
      return;
    }

    rules.add(rule);
  }

  FieldContext parse(VineValidationContext ctx, FieldContext field) {
    if (isNullable) {
      addRule(VineNullableRule(), positioned: true);
    }

    if (isOptional) {
      addRule(VineOptionalRule(), positioned: true);
    }

    while(rules.isNotEmpty) {
      final rule = rules.removeFirst();
      rule.handle(ctx, field);

      if (!field.canBeContinue) break;
      if (ctx.errorReporter.hasErrorForField(field.name)) break;
    }

    return field;
  }
}
