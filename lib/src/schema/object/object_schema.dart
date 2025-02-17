import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/rule_parser.dart';
import 'package:vine/src/rules/basic_rule.dart';

final class VineObjectSchema extends RuleParser implements VineObject {
  final Map<String, VineSchema> _properties;

  VineObjectSchema(this._properties, super._rules);

  @override
  Map<String, VineSchema> get properties => {..._properties};

  @override
  VineObject merge(VineObjectSchema schema) {
    _properties.addAll(schema.properties);
    return this;
  }

  @override
  VineObject requiredIfExist(List<String> values) {
    super.addRule((ctx, field) => requiredIfExistsRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineObject requiredIfAnyExist(List<String> values) {
    super.addRule((ctx, field) => requiredIfAnyExistsRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineObject requiredIfMissing(List<String> values) {
    super.addRule((ctx, field) => requiredIfMissingRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineObject requiredIfAnyMissing(List<String> values) {
    super.addRule((ctx, field) => requiredIfAnyMissingRuleHandler(ctx, field, values), positioned: true);
    return this;
  }

  @override
  VineObject transform(Function(VineValidationContext, FieldContext) fn) {
    super.addRule((ctx, field) => transformRuleHandler(ctx, field, fn));
    return this;
  }

  @override
  VineObject nullable() {
    super.isNullable = true;
    return this;
  }

  @override
  VineObject optional() {
    super.isOptional = true;
    return this;
  }

  @override
  VineObject clone() {
    return VineObjectSchema({..._properties}, Queue.of(rules));
  }
}
