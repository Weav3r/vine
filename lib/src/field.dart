import 'package:vine/src/contracts/vine.dart';

final class Field<T extends ErrorReporter> implements FieldContext<T> {
  @override
  String name;

  @override
  dynamic value;

  @override
  final List<String> customKeys = [];

  @override
  final T errorReporter;

  @override
  final Map<String, dynamic> data;

  @override
  bool canBeContinue = true;

  Field(this.name, this.value, this.errorReporter, this.data);

  @override
  void mutate(dynamic value) {
    data[name] = value;
    this.value = value;
  }
}
