import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';

final class VineObjectSchema extends RuleParser implements VineObject {
  VineObjectSchema(super._rules);

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
}
