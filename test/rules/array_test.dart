import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:vine/vine.dart';

void main() {
  group('VineArray', () {
    test('is valid when value is string', () {
      final validator = vine.compile(vine.object({
        'value': vine.array(vine.string().minLength(2))
      }));

      expect(() => validator.validate({'value': ['foo']}), returnsNormally);
    });

    test('is valid when value is number', () {
      final validator = vine.compile(vine.object({
        'value': vine.array(vine.number())
      }));

      expect(() => validator.validate({'value': [1, 1.1]}), returnsNormally);
    });

    test('is valid when value is double', () {
      final validator = vine.compile(vine.object({
        'value': vine.array(vine.number().double())
      }));

      expect(() => validator.validate({'value': [1.1, 1.2]}), returnsNormally);
    });

    test('is valid when value is integer', () {
      final validator = vine.compile(vine.object({
        'value': vine.array(vine.number().integer())
      }));

      expect(() => validator.validate({'value': [1, 2]}), returnsNormally);
    });

    test('is valid when value is boolean', () {
      final validator = vine.compile(vine.object({
        'value': vine.array(vine.boolean())
      }));

      expect(() => validator.validate({'value': [true, false]}), returnsNormally);
    });

    test('is valid when value is dynamic', () {
      final validator = vine.compile(vine.object({
        'value': vine.array(vine.any())
      }));

      expect(() => validator.validate({'value': ['str', 1, true]}), returnsNormally);
    });

    test('is invalid when value is many type', () {
      final validator = vine.compile(vine.object({
        'value': vine.array(vine.string())
      }));

      expect(() => validator.validate({'value': ['foo', 1, true]}), throwsA(isA<ValidationException>()));
    });

    test('is invalid when value is not array', () {
      final validator = vine.compile(vine.object({
        'value': vine.array(vine.string())
      }));

      expect(() => validator.validate({'value': 'foo'}), throwsA(isA<ValidationException>()));
    });
  });
}
