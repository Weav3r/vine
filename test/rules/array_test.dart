import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:vine/vine.dart';

void main() {
  group('VineArray', () {
    test('is valid when value is string', () {
      final validator = vine.compile({
        'value': vine.array(vine.string().minLength(2))
      });

      expect(() => vine.validate({'value': ['foo']}, validator), returnsNormally);
    });

    test('is valid when value is number', () {
      final validator = vine.compile({
        'value': vine.array(vine.number())
      });

      expect(() => vine.validate({'value': [1, 1.1]}, validator), returnsNormally);
    });

    test('is valid when value is double', () {
      final validator = vine.compile({
        'value': vine.array(vine.number().double())
      });

      expect(() => vine.validate({'value': [1.1, 1.2]}, validator), returnsNormally);
    });

    test('is valid when value is integer', () {
      final validator = vine.compile({
        'value': vine.array(vine.number().integer())
      });

      expect(() => vine.validate({'value': [1, 2]}, validator), returnsNormally);
    });

    test('is valid when value is boolean', () {
      final validator = vine.compile({
        'value': vine.array(vine.boolean())
      });

      expect(() => vine.validate({'value': [true, false]}, validator), returnsNormally);
    });

    test('is valid when value is dynamic', () {
      final validator = vine.compile({
        'value': vine.array(vine.any())
      });

      expect(() => vine.validate({'value': ['str', 1, true]}, validator), returnsNormally);
    });

    test('is invalid when value is many type', () {
      final validator = vine.compile({
        'value': vine.array(vine.string())
      });

      expect(() => vine.validate({'value': ['foo', 1]}, validator), throwsA(isA<ValidationException>()));
    });

    test('is invalid when value is not array', () {
      final validator = vine.compile({
        'value': vine.array(vine.string())
      });

      expect(() => vine.validate({'value': 'foo'}, validator), throwsA(isA<ValidationException>()));
    });
  });
}
