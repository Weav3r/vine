import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';

final class VineUnionSchema extends RuleParser implements VineUnion {
  VineUnionSchema(super._rules);

  @override
  VineUnion nullable() {
    super.isNullable = true;
    return this;
  }

  @override
  VineUnion optional() {
    super.isOptional = true;
    return this;
  }
}
