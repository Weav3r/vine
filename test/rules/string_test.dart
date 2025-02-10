import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/exceptions/validation_exception.dart';
import 'package:vine/src/vine.dart';

void main() {
  group('String validation', () {
    test('valid minLength', () {
      const payload = {'username': 'john'};
      final validator = vine.compile({
        'username': vine.string().minLength(3),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid minLength', () {
      const payload = {'username': 'john'};
      final validator = vine.compile({
        'username': vine.string().minLength(5),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid maxLength', () {
      const payload = {'username': 'john'};
      final validator = vine.compile({
        'username': vine.string().maxLength(10),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid maxLength', () {
      const payload = {'username': 'john'};
      final validator = vine.compile({
        'username': vine.string().maxLength(3),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid fixedLength', () {
      const payload = {'username': 'john'};
      final validator = vine.compile({
        'username': vine.string().fixedLength(4),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid fixedLength', () {
      const payload = {'username': 'john'};
      final validator = vine.compile({
        'username': vine.string().fixedLength(5),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid email', () {
      const payload = {'email': 'john.doe@example.com'};
      final validator = vine.compile({
        'email': vine.string().email(),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid email', () {
      const payload = {'email': 'john.doe'};
      final validator = vine.compile({
        'email': vine.string().email(),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid phone', () {
      const payload = {'phone': '1234567890'};
      final validator = vine.compile({
        'phone': vine.string().phone(),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid phone', () {
      const payload = {'phone': '123'};
      final validator = vine.compile({
        'phone': vine.string().phone(),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid ipAddress IPv4', () {
      const payload = {'ip': '192.168.1.1'};
      final validator = vine.compile({
        'ip': vine.string().ipAddress(version: IpAddressVersion.v4),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid ipAddress IPv4', () {
      const payload = {'ip': '192.168.1.256'};
      final validator = vine.compile({
        'ip': vine.string().ipAddress(version: IpAddressVersion.v4),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid url', () {
      const payload = {'url': 'https://example.com'};
      final validator = vine.compile({
        'url': vine.string().url(),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid url', () {
      const payload = {'url': 'example'};
      final validator = vine.compile({
        'url': vine.string().url(),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid alpha', () {
      const payload = {'name': 'JohnDoe'};
      final validator = vine.compile({
        'name': vine.string().alpha(),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid alpha', () {
      const payload = {'name': 'John123'};
      final validator = vine.compile({
        'name': vine.string().alpha(),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid alphaNumeric', () {
      const payload = {'username': 'John123'};
      final validator = vine.compile({
        'username': vine.string().alphaNumeric(),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid alphaNumeric', () {
      const payload = {'username': 'John@123'};
      final validator = vine.compile({
        'username': vine.string().alphaNumeric(),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid startWith', () {
      const payload = {'code': 'ABC123'};
      final validator = vine.compile({
        'code': vine.string().startWith('ABC'),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid startWith', () {
      final validator = vine.compile({
        'code': vine.string().startWith('ABC'),
      });

      const payload = {
        'code': '123ABC',
      };

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid endWith', () {
      final validator = vine.compile({
        'code': vine.string().endWith('XYZ'),
      });

      const payload = {
        'code': '123XYZ',
      };

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid endWith', () {
      const payload = {'code': 'XYZ123'};
      final validator = vine.compile({
        'code': vine.string().endWith('XYZ'),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    group('confirmed', () {
      test('is valid when confirmation is the same as original property', () {
        const payload = {
          'password': 'password123',
          'password_confirmation': 'password123',
        };

        final validator = vine.compile({
          'password': vine.string().confirmed(property: 'password_confirmation'),
        });

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('cannot be valid when confirmation is not the same as original property', () {
        const payload = {
          'password': 'password123',
          'password_confirmation': 'password456',
        };

        final validator = vine.compile({
          'password': vine.string().confirmed(property: 'password_confirmation'),
        });

        expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
      });
    });

    test('mutate value with trim', () {
      const payload = {'name': '  John Doe  '};
      final validator = vine.compile({
        'name': vine.string().trim(),
      });

      final data = vine.validate(payload, validator);
      expect(data['name'], 'John Doe');
    });

    test('mutate value with normalizeEmail', () {
      const payload = {'email': 'John.Doe@Example.COM'};
      final validator = vine.compile({
        'email': vine.string().normalizeEmail(lowercase: true),
      });

      final data = vine.validate(payload, validator);
      expect(data['email'], 'john.doe@example.com');
    });

    test('mutate value to upperCase', () {
      const payload = {'name': 'John Doe'};
      final validator = vine.compile({
        'name': vine.string().toUpperCase(),
      });

      final data = vine.validate(payload, validator);
      expect(data['name'], 'JOHN DOE');
    });

    test('mutate value to lowerCase', () {
      const payload = {'name': 'John Doe'};
      final validator = vine.compile({
        'name': vine.string().toLowerCase(),
      });

      final data = vine.validate(payload, validator);
      expect(data['name'], 'john doe');
    });

    test('mutate value to camelCase', () {
      const payload = {'name': 'john doe'};
      final validator = vine.compile({
        'name': vine.string().toCamelCase(),
      });

      final data = vine.validate(payload, validator);
      expect(data['name'], 'johnDoe');
    });

    group('uuid', () {
      test('is valid in v3 version', () {
        const payload = {'uuid': '123e4567-e89b-12d3-a456-426614174000'};
        final validator = vine.compile({
          'uuid': vine.string().uuid(version: UuidVersion.v3),
        });

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('is valid in v4 version', () {
        const payload = {'uuid': '123e4567-e89b-12d3-a456-426614174000'};
        final validator = vine.compile({
          'uuid': vine.string().uuid(version: UuidVersion.v4),
        });

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('is valid in v5 version', () {
        const payload = {'uuid': '123e4567-e89b-12d3-a456-426614174000'};
        final validator = vine.compile({
          'uuid': vine.string().uuid(version: UuidVersion.v5),
        });

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('cannot be invalid with a bad format', () {
        const payload = {'uuid': '123e4567-e89b-12d3-a456-42661417400'};
        final validator = vine.compile({
          'uuid': vine.string().uuid(version: UuidVersion.v4),
        });

        expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
      });
    });

    group('credit card', () {
      test('is valid when using good format', () {
        const payload = {'card': '4111111111111111'};
        final validator = vine.compile({
          'card': vine.string().isCreditCard(),
        });

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('cannot be invalid with a bad format', () {
        const payload = {'card': '1234567890123456'};
        final validator = vine.compile({
          'card': vine.string().isCreditCard(),
        });

        expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
      });
    });

    test('can be nullable', () {
      const payload = {'name': null};
      final validator = vine.compile({
        'name': vine.string().nullable(),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('cannot be nullable', () {
      const payload = {'name': null};
      final validator = vine.compile({
        'name': vine.string(),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('can be optional', () {
      const payload = <String, dynamic>{};
      final validator = vine.compile({
        'name': vine.string().optional(),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('cannot be optional', () {
      const payload = <String, dynamic>{};
      final validator = vine.compile({
        'name': vine.string(),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });
  });

  group('VineString Validator with Chained Rules', () {
    test('can be valid with [email, minLength, maxLength] rules', () {
      const payload = {'email': 'john.doe@example.com'};
      final validator = vine.compile({
        'email': vine.string().email().minLength(10).maxLength(50),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('cannot be too short with [email, minLength, maxLength] rules', () {
      const payload = {'email': 'john@doe.com'};
      final validator = vine.compile({
        'email': vine.string().email().minLength(20).maxLength(50),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('cannot be too long with [email, minLength, maxLength] rules', () {
      const payload = {'email': 'john.doe.very.long.email@example.com'};
      final validator = vine.compile({
        'email': vine.string().email().minLength(10).maxLength(20),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    group('alphaNumeric', () {
      test('can be valid with [alphaNumeric, startWith, endWith] rules', () {
        const payload = {'code': 'ABC123XYZ'};
        final validator = vine.compile({
          'code': vine.string().alphaNumeric().startWith('ABC').endWith('XYZ'),
        });

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('cannot have a wrong start with [alphaNumeric, startWith, endWith] rules', () {
        const payload = {'code': '123ABCXYZ'};
        final validator = vine.compile({
          'code': vine.string().alphaNumeric().startWith('ABC').endWith('XYZ'),
        });

        expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
      });

      test('cannot have a wrong end with [alphaNumeric, startWith, endWith] rules', () {
        const payload = {'code': 'ABC123123'};
        final validator = vine.compile({
          'code': vine.string().alphaNumeric().startWith('ABC').endWith('XYZ'),
        });

        expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
      });
    });

    group('url', () {
      test('can be present [url, optional, nullable] rules', () {
        const payload = {'website': 'https://example.com'};
        final validator = vine.compile({
          'website': vine.string().url().optional().nullable(),
        });

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('can be null with [url, optional, nullable] rules', () {
        const payload = {'website': null};
        final validator = vine.compile({
          'website': vine.string().url().optional().nullable(),
        });

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('can be absent with [url, optional, nullable] rules', () {
        final validator = vine.compile({
          'website': vine.string().url().optional().nullable(),
        });

        const payload = <String, dynamic>{};

        expect(() => vine.validate(payload, validator), returnsNormally);
      });
    });

    test('can be valid with [trim, toLowerCase, minLength] rules', () {
      const payload = {'username': '  JohnDoe  '};
      final validator = vine.compile({
        'username': vine.string().trim().toLowerCase().minLength(5),
      });

      final data = vine.validate(payload, validator);
      expect(data['username'], 'johndoe');
    });

    test('is too short after trim with [trim, toLowerCase, minlength] rules', () {
      const payload = {'username': '  John  '};
      final validator = vine.compile({
        'username': vine.string().trim().toLowerCase().minLength(10),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    group('uuid', () {
      test('can be valid with [uuid, fixedLength, nullable] rules', () {
        const payload = {'uuid': '123e4567-e89b-12d3-a456-426614174000'};
        final validator = vine.compile({
          'uuid': vine.string().uuid(version: UuidVersion.v4).fixedLength(36).nullable(),
        });

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('cannot have a wrong length with [uuid, fixedLength, nullable] rules', () {
        const payload = {'uuid': '123e4567-e89b-12d3-a456-42661417400'};
        final validator = vine.compile({
          'uuid': vine.string().uuid(version: UuidVersion.v4).fixedLength(36).nullable(),
        });

        expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
      });
    });

    group('credit card', () {
      test('can be valid with [isCreditCard, optional, trim] rules', () {
        const payload = {'card': ' 4111111111111111 '};
        final validator = vine.compile({
          'card': vine.string().isCreditCard().optional().trim(),
        });

        final data = vine.validate(payload, validator);
        expect(data['card'], '4111111111111111');
      });

      test('cannot be invalid card with [trim, isCreditCard, optional] rules', () {
        const payload = {'card': ' 1234567890123456 '};
        final validator = vine.compile({
          'card': vine.string().trim().isCreditCard().optional(),
        });

        expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
      });
    });

    group('confirmed', () {
      test('can be valid with [trim, toLowerCase, confirmed] rules', () {
        const payload = {
          'password': '  Password123  ',
          'password_confirmation': 'password123',
        };

        final validator = vine.compile({
          'password':
              vine.string().trim().toLowerCase().confirmed(property: 'password_confirmation'),
        });

        final data = vine.validate(payload, validator);
        expect(data['password'], 'password123');
      });
    });
  });
}
