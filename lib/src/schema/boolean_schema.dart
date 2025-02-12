import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';

final class VineBooleanSchema extends RuleParser implements VineBoolean {
  VineBooleanSchema(super._rules);

  @override
  VineBoolean nullable() {
    super.isNullable = true;
    return this;
  }

  @override
  VineBoolean optional() {
    super.isOptional = true;
    return this;
  }
}
