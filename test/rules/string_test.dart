import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:vine/vine.dart';

void main() {
  group('String validation', () {
    test('valid minLength', () {
      final payload = {'username': 'john'};
      final validator = vine.compile(vine.object({
        'username': vine.string().minLength(3),
      }));

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid minLength', () {
      final payload = {'username': 'john'};
      final validator = vine.compile(vine.object({
        'username': vine.string().minLength(5),
      }));

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid maxLength', () {
      final payload = {'username': 'john'};
      final validator = vine.compile(vine.object({
        'username': vine.string().maxLength(10),
      }));

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid maxLength', () {
      final payload = {'username': 'john'};
      final validator = vine.compile(vine.object({
        'username': vine.string().maxLength(3),
      }));

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid fixedLength', () {
      final payload = {'username': 'john'};
      final validator = vine.compile(vine.object({
        'username': vine.string().fixedLength(4),
      }));

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid fixedLength', () {
      final payload = {'username': 'john'};
      final validator = vine.compile(vine.object({
        'username': vine.string().fixedLength(5),
      }));

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid email', () {
      final payload = {'email': 'john.doe@example.com'};
      final validator = vine.compile(vine.object({
        'email': vine.string().email(),
      }));

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid email', () {
      final payload = {'email': 'john.doe'};
      final validator = vine.compile(vine.object({
        'email': vine.string().email(),
      }));

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid phone', () {
      final payload = {'phone': '1234567890'};
      final validator = vine.compile(vine.object({
        'phone': vine.string().phone(),
      }));

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid phone', () {
      final payload = {'phone': '123'};
      final validator = vine.compile(vine.object({
        'phone': vine.string().phone(),
      }));

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid ipAddress IPv4', () {
      final payload = {'ip': '192.168.1.1'};
      final validator = vine.compile(vine.object({
        'ip': vine.string().ipAddress(version: IpAddressVersion.v4),
      }));

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid ipAddress IPv4', () {
      final payload = {'ip': '192.168.1.256'};
      final validator = vine.compile(vine.object({
        'ip': vine.string().ipAddress(version: IpAddressVersion.v4),
      }));

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid url', () {
      final payload = {'url': 'https://example.com'};
      final validator = vine.compile(vine.object({
        'url': vine.string().url(),
      }));

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid url', () {
      final payload = {'url': 'example'};
      final validator = vine.compile(vine.object({
        'url': vine.string().url(),
      }));

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid alpha', () {
      final payload = {'name': 'JohnDoe'};
      final validator = vine.compile(vine.object({
        'name': vine.string().alpha(),
      }));

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid alpha', () {
      final payload = {'name': 'John123'};
      final validator = vine.compile(vine.object({
        'name': vine.string().alpha(),
      }));

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid alphaNumeric', () {
      final payload = {'username': 'John123'};
      final validator = vine.compile(vine.object({
        'username': vine.string().alphaNumeric(),
      }));

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid alphaNumeric', () {
      final payload = {'username': 'John@123'};
      final validator = vine.compile(vine.object({
        'username': vine.string().alphaNumeric(),
      }));

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid startsWith', () {
      final payload = {'code': 'ABC123'};
      final validator = vine.compile(vine.object({
        'code': vine.string().startsWith('ABC'),
      }));

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid startsWith', () {
      final validator = vine.compile(vine.object({
        'code': vine.string().startsWith('ABC'),
      }));

      final payload = {
        'code': '123ABC',
      };

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('valid endsWith', () {
      final validator = vine.compile(vine.object({
        'code': vine.string().endsWith('XYZ'),
      }));

      final payload = {
        'code': '123XYZ',
      };

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('invalid endsWith', () {
      final payload = {'code': 'XYZ123'};
      final validator = vine.compile(vine.object({
        'code': vine.string().endsWith('XYZ'),
      }));

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    group('confirmed', () {
      test('is valid when confirmation is the same as original property', () {
        final payload = {
          'password': 'password123',
          'password_confirmation': 'password123',
        };

        final validator = vine.compile(vine.object({
          'password': vine.string().confirmed(property: 'password_confirmation'),
        }));

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('cannot be valid when confirmation is not the same as original property', () {
        final payload = {
          'password': 'password123',
          'password_confirmation': 'password456',
        };

        final validator = vine.compile(vine.object({
          'password': vine.string().confirmed(property: 'password_confirmation'),
        }));

        expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
      });
    });

    test('mutate value with trim', () {
      final payload = {'name': '  John Doe  '};
      final validator = vine.compile(vine.object({
        'name': vine.string().trim(),
      }));

      final data = vine.validate(payload, validator);
      expect(data['name'], 'John Doe');
    });

    test('mutate value with normalizeEmail', () {
      final payload = {'email': 'John.Doe@Example.COM'};
      final validator = vine.compile(vine.object({
        'email': vine.string().normalizeEmail(lowercase: true),
      }));

      final data = vine.validate(payload, validator);
      expect(data['email'], 'john.doe@example.com');
    });

    test('mutate value to upperCase', () {
      final payload = {'name': 'John Doe'};
      final validator = vine.compile(vine.object({
        'name': vine.string().toUpperCase(),
      }));

      final data = vine.validate(payload, validator);
      expect(data['name'], 'JOHN DOE');
    });

    test('mutate value to lowerCase', () {
      final payload = {'name': 'John Doe'};
      final validator = vine.compile(vine.object({
        'name': vine.string().toLowerCase(),
      }));

      final data = vine.validate(payload, validator);
      expect(data['name'], 'john doe');
    });

    test('mutate value to camelCase', () {
      final payload = {'name': 'john doe'};
      final validator = vine.compile(vine.object({
        'name': vine.string().toCamelCase(),
      }));

      final data = vine.validate(payload, validator);
      expect(data['name'], 'johnDoe');
    });

    group('uuid', () {
      test('is valid in v3 version', () {
        final payload = {'uuid': '123e4567-e89b-12d3-a456-426614174000'};
        final validator = vine.compile(vine.object({
          'uuid': vine.string().uuid(version: UuidVersion.v3),
        }));

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('is valid in v4 version', () {
        final payload = {'uuid': '123e4567-e89b-12d3-a456-426614174000'};
        final validator = vine.compile(vine.object({
          'uuid': vine.string().uuid(version: UuidVersion.v4),
        }));

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('is valid in v5 version', () {
        final payload = {'uuid': '123e4567-e89b-12d3-a456-426614174000'};
        final validator = vine.compile(vine.object({
          'uuid': vine.string().uuid(version: UuidVersion.v5),
        }));

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('cannot be invalid with a bad format', () {
        final payload = {'uuid': '123e4567-e89b-12d3-a456-42661417400'};
        final validator = vine.compile(vine.object({
          'uuid': vine.string().uuid(version: UuidVersion.v4),
        }));

        expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
      });
    });

    group('credit card', () {
      test('is valid when using good format', () {
        final payload = {'card': '4111111111111111'};
        final validator = vine.compile(vine.object({
          'card': vine.string().isCreditCard(),
        }));

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('cannot be invalid with a bad format', () {
        final payload = {'card': '1234567890123456'};
        final validator = vine.compile(vine.object({
          'card': vine.string().isCreditCard(),
        }));

        expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
      });
    });

    test('can be nullable', () {
      final payload = {'name': null};
      final validator = vine.compile(vine.object({
        'name': vine.string().nullable(),
      }));

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('cannot be nullable', () {
      final payload = {'name': null};
      final validator = vine.compile(vine.object({
        'name': vine.string(),
      }));

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('can be optional', () {
      final payload = <String, dynamic>{};
      final validator = vine.compile(vine.object({
        'name': vine.string().optional(),
      }));

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('cannot be optional', () {
      final payload = <String, dynamic>{};
      final validator = vine.compile(vine.object({
        'name': vine.string(),
      }));

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });
  });

  group('VineString Validator with Chained Rules', () {
    test('can be valid with [email, minLength, maxLength] rules', () {
      final payload = {'email': 'john.doe@example.com'};
      final validator = vine.compile(vine.object({
        'email': vine.string().email().minLength(10).maxLength(50),
      }));

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('cannot be too short with [email, minLength, maxLength] rules', () {
      final payload = {'email': 'john@doe.com'};
      final validator = vine.compile(vine.object({
        'email': vine.string().email().minLength(20).maxLength(50),
      }));

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    test('cannot be too long with [email, minLength, maxLength] rules', () {
      final payload = {'email': 'john.doe.very.long.email@example.com'};
      final validator = vine.compile(vine.object({
        'email': vine.string().email().minLength(10).maxLength(20),
      }));

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    group('alphaNumeric', () {
      test('can be valid with [alphaNumeric, startsWith, endsWith] rules', () {
        final payload = {'code': 'ABC123XYZ'};
        final validator = vine.compile(vine.object({
          'code': vine.string().alphaNumeric().startsWith('ABC').endsWith('XYZ'),
        }));

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('cannot have a wrong start with [alphaNumeric, startsWith, endsWith] rules', () {
        final payload = {'code': '123ABCXYZ'};
        final validator = vine.compile(vine.object({
          'code': vine.string().alphaNumeric().startsWith('ABC').endsWith('XYZ'),
        }));

        expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
      });

      test('cannot have a wrong end with [alphaNumeric, startsWith, endsWith] rules', () {
        final payload = {'code': 'ABC123123'};
        final validator = vine.compile(vine.object({
          'code': vine.string().alphaNumeric().startsWith('ABC').endsWith('XYZ'),
        }));

        expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
      });
    });

    group('url', () {
      test('can be present [url, optional, nullable] rules', () {
        final payload = {'website': 'https://example.com'};
        final validator = vine.compile(vine.object({
          'website': vine.string().url().optional().nullable(),
        }));

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('can be null with [url, optional, nullable] rules', () {
        final payload = {'website': null};
        final validator = vine.compile(vine.object({
          'website': vine.string().url().optional().nullable(),
        }));

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('can be absent with [url, optional, nullable] rules', () {
        final validator = vine.compile(vine.object({
          'website': vine.string().url().optional().nullable(),
        }));

        final payload = <String, dynamic>{};

        expect(() => vine.validate(payload, validator), returnsNormally);
      });
    });

    test('can be valid with [trim, toLowerCase, minLength] rules', () {
      final payload = {'username': '  JohnDoe  '};
      final validator = vine.compile(vine.object({
        'username': vine.string().trim().toLowerCase().minLength(5),
      }));

      final data = vine.validate(payload, validator);
      expect(data['username'], 'johndoe');
    });

    test('is too short after trim with [trim, toLowerCase, minlength] rules', () {
      final payload = {'username': '  John  '};
      final validator = vine.compile(vine.object({
        'username': vine.string().trim().toLowerCase().minLength(10),
      }));

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });

    group('uuid', () {
      test('can be valid with [uuid, fixedLength, nullable] rules', () {
        final payload = {'uuid': '123e4567-e89b-12d3-a456-426614174000'};
        final validator = vine.compile(vine.object({
          'uuid': vine.string().uuid(version: UuidVersion.v4).fixedLength(36).nullable(),
        }));

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('cannot have a wrong length with [uuid, fixedLength, nullable] rules', () {
        final payload = {'uuid': '123e4567-e89b-12d3-a456-42661417400'};
        final validator = vine.compile(vine.object({
          'uuid': vine.string().uuid(version: UuidVersion.v4).fixedLength(36).nullable(),
        }));

        expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
      });
    });

    group('credit card', () {
      test('can be valid with [isCreditCard, optional, trim] rules', () {
        final payload = {'card': ' 4111111111111111 '};
        final validator = vine.compile(vine.object({
          'card': vine.string().isCreditCard().optional().trim(),
        }));

        final data = vine.validate(payload, validator);
        expect(data['card'], '4111111111111111');
      });

      test('cannot be invalid card with [trim, isCreditCard, optional] rules', () {
        final payload = {'card': ' 1234567890123456 '};
        final validator = vine.compile(vine.object({
          'card': vine.string().trim().isCreditCard().optional(),
        }));

        expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
      });
    });

    group('confirmed', () {
      test('can be valid with [trim, toLowerCase, confirmed] rules', () {
        final payload = {
          'password': '  Password123  ',
          'password_confirmation': 'password123',
        };

        final validator = vine.compile(vine.object({
          'password':
              vine.string().trim().toLowerCase().confirmed(property: 'password_confirmation'),
        }));

        final data = vine.validate(payload, validator);
        expect(data['password'], 'password123');
      });
    });

    group('sameAs', () {
      test('can be valid', () {
        final payload = {
          'first_field': 'foo',
          'second_field': 'foo',
        };

        final validator = vine.compile(vine.object({
          'first_field': vine.string(),
          'second_field': vine.string().sameAs('first_field'),
        }));

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('should be valid in nested object when values are identiques', () {
        final payload = {
          'obj': {
            'first_field': 'foo',
            'second_field': 'foo',
          },
        };

        final validator = vine.compile(vine.object({
          'obj': vine.object({
            'first_field': vine.string(),
            'second_field': vine.string().sameAs('first_field'),
          }),
        }));

        expect(() => vine.validate(payload, validator), returnsNormally);
      });

      test('cannot be valid in nested object when values are different', () {
        final payload = {
          'obj': {
            'first_field': 'foo',
            'second_field': 'bar',
          },
        };

        final validator = vine.compile(vine.object({
          'obj': vine.object({
            'first_field': vine.string(),
            'second_field': vine.string().sameAs('first_field'),
          }),
        }));

        expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
      });
    });
  });
}
