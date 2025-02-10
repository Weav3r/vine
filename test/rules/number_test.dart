import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:vine/src/exceptions/validation_exception.dart';
import 'package:vine/src/vine.dart';

void main() {
  group('VineNumber - range', () {
    test('valid: value within range [10, 20, 30]', () {
      final validator = vine.compile({
        'age': vine.number().range([10, 20, 30])
      });
      expect(() => vine.validate({'age': 20}, validator), returnsNormally);
    });

    test('valid: value equals min range [5, 10, 15]', () {
      final validator = vine.compile({
        'age': vine.number().range([5, 10, 15])
      });
      expect(() => vine.validate({'age': 5}, validator), returnsNormally);
    });

    test('invalid: value below range [10, 20, 30]', () {
      final validator = vine.compile({
        'age': vine.number().range([10, 20, 30])
      });
      expect(() => vine.validate({'age': 5}, validator), throwsA(isA<ValidationException>()));
    });

    test('invalid: value above range [10, 20, 30]', () {
      final validator = vine.compile({
        'age': vine.number().range([10, 20, 30])
      });
      expect(() => vine.validate({'age': 35}, validator), throwsA(isA<ValidationException>()));
    });

    test('invalid: value not in range [10, 20, 30]', () {
      final validator = vine.compile({
        'age': vine.number().range([10, 20, 30])
      });
      expect(() => vine.validate({'age': 25}, validator), throwsA(isA<ValidationException>()));
    });
  });

  group('VineNumber - min', () {
    test('valid: value equals min (10)', () {
      final validator = vine.compile({
        'age': vine.number().min(10)
      });
      expect(() => vine.validate({'age': 10}, validator), returnsNormally);
    });

    test('valid: value above min (10)', () {
      final validator = vine.compile({
        'age': vine.number().min(10)
      });
      expect(() => vine.validate({'age': 15}, validator), returnsNormally);
    });

    test('invalid: value below min (10)', () {
      final validator = vine.compile({
        'age': vine.number().min(10)
      });
      expect(() => vine.validate({'age': 5}, validator), throwsA(isA<ValidationException>()));
    });

    test('invalid: negative value with min (0)', () {
      final validator = vine.compile({
        'age': vine.number().min(0)
      });
      expect(() => vine.validate({'age': -5}, validator), throwsA(isA<ValidationException>()));
    });

    test('invalid: null value with min (10)', () {
      final validator = vine.compile({
        'age': vine.number().min(10)
      });
      expect(() => vine.validate({'age': null}, validator), throwsA(isA<ValidationException>()));
    });
  });

  group('VineNumber - max', () {
    test('valid: value equals max (100)', () {
      final validator = vine.compile({
        'age': vine.number().max(100)
      });
      expect(() => vine.validate({'age': 100}, validator), returnsNormally);
    });

    test('valid: value below max (100)', () {
      final validator = vine.compile({
        'age': vine.number().max(100)
      });
      expect(() => vine.validate({'age': 50}, validator), returnsNormally);
    });

    test('invalid: value above max (100)', () {
      final validator = vine.compile({
        'age': vine.number().max(100)
      });
      expect(() => vine.validate({'age': 150}, validator), throwsA(isA<ValidationException>()));
    });

    test('invalid: null value with max (100)', () {
      final validator = vine.compile({
        'age': vine.number().max(100)
      });
      expect(() => vine.validate({'age': null}, validator), throwsA(isA<ValidationException>()));
    });

    test('invalid: negative value with max (0)', () {
      final validator = vine.compile({
        'age': vine.number().max(0)
      });
      expect(() => vine.validate({'age': -5}, validator), throwsA(isA<ValidationException>()));
    });
  });

  group('VineNumber - negative', () {
    test('valid: negative value (-10)', () {
      final validator = vine.compile({
        'balance': vine.number().negative()
      });
      expect(() => vine.validate({'balance': -10}, validator), returnsNormally);
    });

    test('invalid: zero value (0)', () {
      final validator = vine.compile({
        'balance': vine.number().negative()
      });
      expect(() => vine.validate({'balance': 0}, validator), throwsA(isA<ValidationException>()));
    });

    test('invalid: positive value (10)', () {
      final validator = vine.compile({
        'balance': vine.number().negative()
      });
      expect(() => vine.validate({'balance': 10}, validator), throwsA(isA<ValidationException>()));
    });

    test('invalid: null value', () {
      final validator = vine.compile({
        'balance': vine.number().negative()
      });
      expect(() => vine.validate({'balance': null}, validator), throwsA(isA<ValidationException>()));
    });

    test('invalid: non-numeric value', () {
      final validator = vine.compile({
        'balance': vine.number().negative()
      });
      expect(() => vine.validate({'balance': 'not a number'}, validator), throwsA(isA<ValidationException>()));
    });
  });

  group('VineNumber - positive', () {
    test('valid: positive value (10)', () {
      final validator = vine.compile({
        'balance': vine.number().positive()
      });
      expect(() => vine.validate({'balance': 10}, validator), returnsNormally);
    });

    test('valid: zero value (0)', () {
      final validator = vine.compile({
        'balance': vine.number().positive()
      });
      expect(() => vine.validate({'balance': 0}, validator), returnsNormally);
    });

    test('invalid: negative value (-10)', () {
      final validator = vine.compile({
        'balance': vine.number().positive()
      });
      expect(() => vine.validate({'balance': -10}, validator), throwsA(isA<ValidationException>()));
    });

    test('invalid: null value', () {
      final validator = vine.compile({
        'balance': vine.number().positive()
      });
      expect(() => vine.validate({'balance': null}, validator), throwsA(isA<ValidationException>()));
    });

    test('invalid: non-numeric value', () {
      final validator = vine.compile({
        'balance': vine.number().positive()
      });
      expect(() => vine.validate({'balance': 'not a number'}, validator), throwsA(isA<ValidationException>()));
    });
  });

  group('VineNumber - double', () {
    test('valid: double value (10.5)', () {
      final validator = vine.compile({
        'price': vine.number().double()
      });
      expect(() => vine.validate({'price': 10.5}, validator), returnsNormally);
    });

    test('invalid: integer value (10)', () {
      final validator = vine.compile({
        'price': vine.number().double()
      });
      expect(() => vine.validate({'price': 10}, validator), throwsA(isA<ValidationException>()));
    });

    test('invalid: null value', () {
      final validator = vine.compile({
        'price': vine.number().double()
      });
      expect(() => vine.validate({'price': null}, validator), throwsA(isA<ValidationException>()));
    });

    test('invalid: non-numeric value', () {
      final validator = vine.compile({
        'price': vine.number().double()
      });
      expect(() => vine.validate({'price': 'not a number'}, validator), throwsA(isA<ValidationException>()));
    });

    test('invalid: invalid double format', () {
      final validator = vine.compile({
        'price': vine.number().double()
      });
      expect(() => vine.validate({'price': '10.5.5'}, validator), throwsA(isA<ValidationException>()));
    });
  });

  group('VineNumber - integer', () {
    test('valid: integer value (10)', () {
      final validator = vine.compile({
        'age': vine.number().integer()
      });
      expect(() => vine.validate({'age': 10}, validator), returnsNormally);
    });

    test('valid: zero value (0)', () {
      final validator = vine.compile({
        'age': vine.number().integer()
      });
      expect(() => vine.validate({'age': 0}, validator), returnsNormally);
    });

    test('invalid: double value (10.5)', () {
      final validator = vine.compile({
        'age': vine.number().integer()
      });
      expect(() => vine.validate({'age': 10.5}, validator), throwsA(isA<ValidationException>()));
    });

    test('invalid: null value', () {
      final validator = vine.compile({
        'age': vine.number().integer()
      });
      expect(() => vine.validate({'age': null}, validator), throwsA(isA<ValidationException>()));
    });

    test('invalid: non-numeric value', () {
      final validator = vine.compile({
        'age': vine.number().integer()
      });
      expect(() => vine.validate({'age': 'not a number'}, validator), throwsA(isA<ValidationException>()));
    });
  });

  group('VineNumber - nullable', () {
    test('valid: null value', () {
      final validator = vine.compile({
        'age': vine.number().nullable()
      });
      expect(() => vine.validate({'age': null}, validator), returnsNormally);
    });

    test('valid: non-null value (10)', () {
      final validator = vine.compile({
        'age': vine.number().nullable()
      });
      expect(() => vine.validate({'age': 10}, validator), returnsNormally);
    });

    test('invalid: non-numeric value', () {
      final validator = vine.compile({
        'age': vine.number().nullable()
      });
      expect(() => vine.validate({'age': 'not a number'}, validator), throwsA(isA<ValidationException>()));
    });
  });

  group('VineNumber - optional', () {
    test('valid: absent value', () {
      final validator = vine.compile({
        'age': vine.number().optional()
      });
      expect(() => vine.validate({}, validator), returnsNormally);
    });

    test('valid: present value (10)', () {
      final validator = vine.compile({
        'age': vine.number().optional()
      });
      expect(() => vine.validate({'age': 10}, validator), returnsNormally);
    });

    test('invalid: non-numeric value', () {
      final validator = vine.compile({
        'age': vine.number().optional()
      });
      expect(() => vine.validate({'age': 'not a number'}, validator), throwsA(isA<ValidationException>()));
    });
  });
}
