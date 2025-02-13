import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:vine/vine.dart';

void main() {
  group('Union validation', () {
    test('is valid when value is string', () {
      final payload = {'value': 'foo'};
      final validator = vine.compile(vine.object({
        'value': vine.union([
          vine.string(),
          vine.number(),
        ]),
      }));

      expect(() => vine.validate(payload, validator), returnsNormally);
    });
  });

  test('is valid when value is number', () {
    final payload = {'value': 10};
    final validator = vine.compile(vine.object({
      'value': vine.union([
        vine.string(),
        vine.number(),
      ]),
    }));

    expect(() => vine.validate(payload, validator), returnsNormally);
  });

  test('is valid when value is boolean', () {
    final payload = {'value': true};
    final validator = vine.compile(vine.object({
      'union': vine.union([
        vine.string(),
        vine.number(),
      ]),
    }));

    expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
  });
}
