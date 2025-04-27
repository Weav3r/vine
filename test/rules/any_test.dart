import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:vine/vine.dart';

void main() {
  group('VineAny', () {
    test('is support any validation on top level', () {
      final validator = vine.compile(vine.any());
      expect(() => validator.validate('foo'), returnsNormally);
    });

    test('is valid when value is boolean', () {
      final validator = vine.compile(vine.object({'value': vine.boolean()}));

      expect(() => validator.validate({'value': true}), returnsNormally);
    });

    test('is valid when value is number', () {
      final validator = vine.compile(vine.object({'value': vine.number()}));

      expect(() => validator.validate({'value': 1}), returnsNormally);
    });

    test('is valid when value is string', () {
      final validator = vine.compile(vine.object({'value': vine.string()}));

      expect(() => validator.validate({'value': 'foo'}), returnsNormally);
    });
  });
}
