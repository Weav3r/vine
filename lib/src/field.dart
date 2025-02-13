import 'package:vine/src/contracts/vine.dart';

final class ValidatorContext<T extends ErrorReporter> implements VineValidationContext<T> {
  @override
  final T errorReporter;

  @override
  final Map<String, dynamic> data;


  ValidatorContext(this.errorReporter, this.data);
}

final class Field implements FieldContext {
  @override
  final List<String> customKeys = [];

  @override
  String name;

  @override
  dynamic value;

  @override
  bool canBeContinue = true;

  Field(this.name, this.value);

  @override
  void mutate(dynamic value) {
    this.value = value;
  }
}
