import 'dart:collection';

import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';

final class VineAnySchema extends RuleParser implements VineAny {
  VineAnySchema(super._rules);

  @override
  VineAny nullable() {
    super.isNullable = true;
    return this;
  }

  @override
  VineAny optional() {
    super.isOptional = true;
    return this;
  }

  @override
  VineAny clone() {
    return VineAnySchema(Queue.of(rules));
  }
}
