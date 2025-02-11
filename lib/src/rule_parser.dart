import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/field.dart';

abstract interface class RuleParserContract {
  void addRule(ParseHandler rule, {int? position});
}

class RuleParser implements RuleParserContract {
  final List<ParseHandler> rules;

  RuleParser(this.rules);

  @override
  void addRule(ParseHandler rule, {int? position}) {
    if (position != null) {
      rules.insert(position, rule);
      return;
    }

    rules.add(rule);
  }

  FieldContext parse(ErrorReporter errorReporter, ValidatorContract validator, String key, dynamic value) {
    final context = Field(key, value, errorReporter, validator);
    void next(int index) {
      if (index < rules.length) {
        context.next = () => next(index + 1);
        rules[index](context);
      }
    }

    next(0);

    return context;
  }
}
