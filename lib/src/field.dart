import 'package:vine/src/contracts/vine.dart';

final class Field<T extends ErrorReporter> implements FieldContext<T> {
  @override
  final String name;

  @override
  dynamic value;

  @override
  final T errorReporter;

  @override
  final ValidatorContract validator;

  @override
  late Function next;

  Field(this.name, this.value, this.errorReporter, this.validator);

  @override
  void mutate(dynamic value) {
    this.value = value;
  }
}
