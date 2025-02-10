import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/field.dart';

class RuleParser {
  final List<ParseHandler> _rules;

  RuleParser(this._rules);

  void addRule(ParseHandler rule, {int? position}) {
    if (position != null) {
      addRuleAt(position, rule);
      return;
    }

    _rules.add(rule);
  }

  void addRuleAt(int index, ParseHandler rule) {
    _rules.insert(index, rule);
  }

  FieldContext parse(ErrorReporter errorReporter, ValidatorContract validator, String key, dynamic value) {
    final context = Field(key, value, errorReporter, validator);
    void next(int index) {
      if (index < _rules.length) {
        context.next = () => next(index + 1);
        _rules[index](context);
      }
    }

    next(0);

    return context;
  }
}
