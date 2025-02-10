import 'package:vine/src/contracts/schema.dart';

abstract interface class ValidatorRule {
  StringSchemaContract string({String? message});
  NumberSchemaContract number({String? message});
}

abstract interface class VineRuleValidator<T extends Object> {
  void handle(T value);
}
