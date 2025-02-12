import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';

final class VineEnumSchema extends RuleParser implements VineEnum {
  VineEnumSchema(super._rules);

  @override
  VineEnum nullable() {
    super.isNullable = true;
    return this;
  }

  @override
  VineEnum optional() {
    super.isOptional = true;
    return this;
  }
}
