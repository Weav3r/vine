import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/exceptions/validation_exception.dart';
import 'package:vine/src/vine.dart';

void main() {
  group('VineString Validator', () {
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

    test('valid confirmed', () {
      const payload = {
        'password': 'password123',
        'password_confirmation': 'password123',
      };

      final validator = vine.compile({
        'password': vine.string().confirmed(property: 'password_confirmation'),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid confirmed', () {
      const payload = {
        'password': 'password123',
        'password_confirmation': 'password456',
      };

      final validator = vine.compile({
        'password': vine.string().confirmed(property: 'password_confirmation'),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid trim', () {
      const payload = {'name': '  John Doe  '};
      final validator = vine.compile({
        'name': vine.string().trim(),
      });

      final data = vine.validate(payload, validator);
      expect(data['name'], 'John Doe');
    });

    test('valid normalizeEmail', () {
      const payload = {'email': 'John.Doe@Example.COM'};
      final validator = vine.compile({
        'email': vine.string().normalizeEmail(lowercase: true),
      });

      final data = vine.validate(payload, validator);
      expect(data['email'], 'john.doe@example.com');
    });

    test('valid toUpperCase', () {
      const payload = {'name': 'John Doe'};
      final validator = vine.compile({
        'name': vine.string().toUpperCase(),
      });

      final data = vine.validate(payload, validator);
      expect(data['name'], 'JOHN DOE');
    });

    test('valid toLowerCase', () {
      const payload = {'name': 'John Doe'};
      final validator = vine.compile({
        'name': vine.string().toLowerCase(),
      });

      final data = vine.validate(payload, validator);
      expect(data['name'], 'john doe');
    });

    test('valid toCamelCase', () {
      const payload = {'name': 'john doe'};
      final validator = vine.compile({
        'name': vine.string().toCamelCase(),
      });

      final data = vine.validate(payload, validator);
      expect(data['name'], 'johnDoe');
    });

    test('valid uuid', () {
      const payload = {'uuid': '123e4567-e89b-12d3-a456-426614174000'};
      final validator = vine.compile({
        'uuid': vine.string().uuid(version: UuidVersion.v4),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid uuid', () {
      const payload = {'uuid': '123e4567-e89b-12d3-a456-42661417400'};
      final validator = vine.compile({
        'uuid': vine.string().uuid(version: UuidVersion.v4),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid isCreditCard', () {
      const payload = {'card': '4111111111111111'};
      final validator = vine.compile({
        'card': vine.string().isCreditCard(),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid isCreditCard', () {
      const payload = {'card': '1234567890123456'};
      final validator = vine.compile({
        'card': vine.string().isCreditCard(),
      });

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid nullable', () {
      const payload = {'name': null};
      final validator = vine.compile({
        'name': vine.string().nullable(),
      });

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('valid optional', () {
      final validator = vine.compile({
        'name': vine.string().optional(),
      });

      const payload = <String, dynamic>{};

      expect(() => vine.validate(payload, validator), returnsNormally);
    });
  });
}
