import 'package:vine/src/contracts/schema.dart';

abstract interface class ValidatorRule {
  VineString string({String? message});
  VineNumber number({String? message});
}

abstract interface class VineRuleValidator<T extends Object> {
  void handle(T value);
}
