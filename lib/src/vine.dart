import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/error_reporter.dart';
import 'package:vine/src/rules/boolean_rule.dart';
import 'package:vine/src/rules/number_rule.dart';
import 'package:vine/src/rules/string_rule.dart';
import 'package:vine/src/schema/boolean_schema.dart';
import 'package:vine/src/schema/number_schema.dart';
import 'package:vine/src/schema/string_schema.dart';

final class Vine {
  ErrorReporter Function(Map<String, String> errors) errorReporter = SimpleErrorReporter.new;

  VineString string({String? message}) {
    final List<ParseHandler> rules = [];

    rules.add((metadata) => stringRuleHandler(metadata, message));
    return VineStringSchema(rules);
  }

  VineNumber number({String? message}) {
    final List<ParseHandler> rules = [];

    rules.add((metadata) => numberRuleHandler(metadata, message));
    return VineNumberSchema(rules);
  }

  VineBoolean boolean({String? message}) {
    final List<ParseHandler> rules = [];

    rules.add((metadata) => booleanRuleHandler(metadata, message));
    return VineBooleanSchema(rules);
  }

  Validator compile(Map<String, VineSchema> properties, {Map<String, String> errors = const {}}) {
    return Validator(this, properties, errors);
  }

  Map<String, dynamic> validate(Map<String, dynamic> data, Validator validator) {
    final reporter = errorReporter(validator.errors);

    validator.data.clear();
    validator.data.addAll(data);

    for (final property in validator._properties.entries) {
      final value = data.containsKey(property.key) ? data[property.key] : MissingValue();
      final schema = property.value;

      final FieldContext field = schema.parse(reporter, validator, property.key, value);
      validator.data[property.key] = field.value;
    }

    if (reporter.hasError) {
      throw reporter.createError({'errors': reporter.errors});
    }

    return validator.data.entries.fold({}, (acc, field) {
      if (field.value is! MissingValue) {
        acc[field.key] = field.value;
      }
      return acc;
    });
  }
}

final class Validator implements ValidatorContract {
  final Vine _vine;

  final Map<String, VineSchema> _properties;
  final Map<String, String> errors;

  @override
  final Map<String, dynamic> data = {};

  Validator(this._vine, this._properties, this.errors);

  @override
  void validate(Map<String, dynamic> data) {
    _vine.validate(data, this);
  }
}

final vine = Vine();
