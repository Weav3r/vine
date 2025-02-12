import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:vine/vine.dart';

void main() {
  group('VineAny', () {
    test('is valid when value is boolean', () {
      final validator = vine.compile(vine.object({
        'value': vine.boolean()
      }));

      expect(() => vine.validate({'value': true}, validator), returnsNormally);
    });

    test('is valid when value is number', () {
      final validator = vine.compile(vine.object({
        'value': vine.number()
      }));

      expect(() => vine.validate({'value': 1}, validator), returnsNormally);
    });

    test('is valid when value is string', () {
      final validator = vine.compile(vine.object({
        'value': vine.string()
      }));

      expect(() => vine.validate({'value': 'foo'}, validator), returnsNormally);
    });
  });
}
