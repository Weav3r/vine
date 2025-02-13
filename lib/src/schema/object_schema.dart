import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/rule_parser.dart';

final class VineObjectSchema extends RuleParser implements VineObject {
  final Map<String, VineSchema> _properties;

  VineObjectSchema(this._properties, super._rules);

  @override
  Map<String, VineSchema> get properties => {..._properties};

  @override
  VineObjectSchema merge(VineObjectSchema schema) {
    _properties.addAll(schema.properties);
    return this;
  }

  @override
  VineObjectSchema clone() {
    return VineObjectSchema(_properties, rules);
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
}
