import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:vine/vine.dart';

enum MyEnum implements VineEnumerable<String> {
  value1('value1'),
  value2('value2'),
  value3('value3');

  @override
  final String value;
  const MyEnum(this.value);
}

void main() {
  group('VineEnum', () {
    test('is valid when value is includes in enum', () {
      final validator = vine.compile(vine.object({
        'value': vine.enumerate(MyEnum.values)
      }));

      expect(() => vine.validate({'value': MyEnum.value1.value}, validator), returnsNormally);
    });

    test('is invalid when value is not includes in enum', () {
      final validator = vine.compile(vine.object({
        'value': vine.enumerate(MyEnum.values)
      }));

      expect(() => vine.validate({'value': 'value4'}, validator), throwsA(isA<ValidationException>()));
    });

    test('is valid when value is nullable', () {
      final validator = vine.compile(vine.object({
        'value': vine.enumerate(MyEnum.values).nullable()
      }));

      expect(() => vine.validate({'value': null}, validator), returnsNormally);
    });

    test('is valid when value is optional', () {
      final validator = vine.compile(vine.object({
        'value': vine.enumerate(MyEnum.values).optional()
      }));

      expect(() => vine.validate({}, validator), returnsNormally);
    });
  });
}
