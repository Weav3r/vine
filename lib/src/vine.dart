import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/error_reporter.dart';
import 'package:vine/src/field.dart';
import 'package:vine/src/rules/any_rule.dart';
import 'package:vine/src/rules/array_rule.dart';
import 'package:vine/src/rules/boolean_rule.dart';
import 'package:vine/src/rules/enum_rule.dart';
import 'package:vine/src/rules/number_rule.dart';
import 'package:vine/src/rules/object_rule.dart';
import 'package:vine/src/rules/string_rule.dart';
import 'package:vine/src/rules/union_rule.dart';
import 'package:vine/src/schema/any_schema.dart';
import 'package:vine/src/schema/array_schema.dart';
import 'package:vine/src/schema/boolean_schema.dart';
import 'package:vine/src/schema/enum_schema.dart';
import 'package:vine/src/schema/number_schema.dart';
import 'package:vine/src/schema/object_schema.dart';
import 'package:vine/src/schema/string_schema.dart';
import 'package:vine/src/schema/union_schema.dart';

final class Vine {
  ErrorReporter Function(Map<String, String> errors) errorReporter = SimpleErrorReporter.new;

  VineObject object(Map<String, VineSchema> payload, {String? message}) {
    final Queue<ParseHandler> rules = Queue();
    rules.add((ctx, field) => objectRuleHandler(ctx, field, payload, message));
    return VineObjectSchema(payload, rules);
  }

  VineString string({String? message}) {
    final Queue<ParseHandler> rules = Queue();
    rules.add((ctx, field) => stringRuleHandler(ctx, field, message));
    return VineStringSchema(rules);
  }

  VineNumber number({String? message}) {
    final Queue<ParseHandler> rules = Queue();

    rules.add((ctx, field) => numberRuleHandler(ctx, field, message));
    return VineNumberSchema(rules);
  }

  VineBoolean boolean({bool includeLiteral = false, String? message}) {
    final Queue<ParseHandler> rules = Queue();

    rules.add((ctx, field) => booleanRuleHandler(ctx, field, includeLiteral, message));
    return VineBooleanSchema(rules);
  }

  VineAny any() {
    final Queue<ParseHandler> rules = Queue();

    rules.add(anyRuleHandler);
    return VineAnySchema(rules);
  }

  VineEnum enumerate<T extends VineEnumerable>(List<T> source) {
    final Queue<ParseHandler> rules = Queue();

    rules.add((ctx, field) => enumRuleHandler<T>(ctx, field, source));
    return VineEnumSchema(rules);
  }

  VineArray array(VineSchema schema) {
    final Queue<ParseHandler> rules = Queue();

    rules.add((ctx, field) => arrayRuleHandler(ctx, field, schema));
    return VineArraySchema(rules);
  }

  VineUnion union(List<VineSchema> schemas) {
    final Queue<ParseHandler> rules = Queue();

    rules.add((ctx, field) => unionRuleHandler(ctx, field, rules, schemas));
    return VineUnionSchema(rules);
  }

  Validator compile(VineSchema schema, {Map<String, String> errors = const {}}) {
    return Validator(schema.clone(), errors);
  }


  Map<String, dynamic> validate(Map<String, dynamic> data, VineSchema schema) {
    final reporter = errorReporter({});

    final validatorContext = ValidatorContext(reporter, data);
    final field = Field('', data);
    schema.parse(validatorContext, field);

    if (reporter.hasError) {
      throw reporter.createError({'errors': reporter.errors});
    }

    return field.value;
  }
}

final class Validator implements ValidatorContract {
  final VineSchema _schema;
  final Map<String, String> errors;
  final reporter = vine.errorReporter({});

  Validator(this._schema, this.errors);

  Map<String, dynamic> validate(Map<String, dynamic> data) {
    final validatorContext = ValidatorContext(reporter, data);
    final field = Field('', data);
    _schema.parse(validatorContext, field);

    if (reporter.hasError) {
      throw reporter.createError({'errors': reporter.errors});
    }

    reporter.clear();
    return field.value;
  }
}

final vine = Vine();
