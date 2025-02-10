import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:vine/vine.dart';

void main() {
  group('VineBoolean', () {
    test('is valid when value is "true"', () {
      final validator = vine.compile({
        'value': vine.boolean()
      });

      expect(() => vine.validate({'value': 'true'}, validator), returnsNormally);
    });

    test('is valid when value is "false"', () {
      final validator = vine.compile({
        'value': vine.boolean()
      });

      expect(() => vine.validate({'value': 'false'}, validator), returnsNormally);
    });

    test('is valid when value is true', () {
      final validator = vine.compile({
        'value': vine.boolean()
      });

      expect(() => vine.validate({'value': true}, validator), returnsNormally);
    });

    test('is valid when value is false', () {
      final validator = vine.compile({
        'value': vine.boolean()
      });

      expect(() => vine.validate({'value': false}, validator), returnsNormally);
    });

    test('is valid when value is "0"', () {
      final validator = vine.compile({
        'value': vine.boolean()
      });

      expect(() => vine.validate({'value': '0'}, validator), returnsNormally);
    });

    test('is valid when value is "1"', () {
      final validator = vine.compile({
        'value': vine.boolean()
      });

      expect(() => vine.validate({'value': '1'}, validator), returnsNormally);
    });

    test('is invalid when value is not a boolean', () {
      final validator = vine.compile({
        'value': vine.boolean()
      });

      expect(() => vine.validate({'value': 'foo'}, validator), throwsA(isA<ValidationException>()));
    });
  });
}
