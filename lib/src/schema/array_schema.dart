import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';

final class VineArraySchema extends RuleParser implements VineArray {
  VineArraySchema(super._rules);

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
