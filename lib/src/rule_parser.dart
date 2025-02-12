import 'dart:collection';

import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/rules/basic_rule.dart';

abstract interface class RuleParserContract {
  Queue<ParseHandler> get rules;
  void addRule(ParseHandler rule, {bool positioned = false});
}

class RuleParser implements RuleParserContract {
  @override
  Queue<ParseHandler> rules;

  bool isNullable = false;
  bool isOptional = false;

  RuleParser(this.rules);

  @override
  void addRule(ParseHandler rule, {bool positioned = false}) {
    if (positioned) {
      rules.addFirst(rule);
      return;
    }

    rules.add(rule);
  }

  FieldContext parse(ErrorReporter errorReporter, FieldContext field) {
    if (isNullable) {
      addRule(nullableRuleHandler, positioned: true);
    }

    if (isOptional) {
      addRule(optionalRuleHandler, positioned: true);
    }

    while(rules.isNotEmpty) {
      final rule = rules.removeFirst();
      rule(field);

      if (!field.canBeContinue) break;
      if (errorReporter.hasErrorForField(field.name)) break;
    }

    return field;
  }
}
