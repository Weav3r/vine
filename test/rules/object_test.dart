import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:vine/vine.dart';

void main() {
  group('Object validation', () {
    test('is valid when value is object', () {
      final validator = vine.compile(vine.object({
        'obj': vine.object({}),
      }));

      expect(() => vine.validate({'obj': { 'foo': 'bar'}}, validator), returnsNormally);
    });

    test('can be composable', () {
      final payload = {
        'user': {
          'firstname': 'John',
          'lastname': 'Doe',
          'email': 'john.doe@foo.bar',
          'age': 25,
        },
        'roles': [
          {'name': 'admin role', 'description': 'Administrator'},
          {'name': 'user role', 'description': 'User'},
        ],
      };

      final identitySchema = vine.object({
        'firstname': vine.string().minLength(2).maxLength(255),
        'lastname': vine.string().minLength(2).maxLength(255),
      });

      final userSchema = vine.object({
        ...identitySchema.properties,
        'email': vine.string().email(),
        'age': vine.number().integer().min(18).max(100),
      });

      final roleSchema = vine.object({
        'name': vine.string().minLength(2).maxLength(255),
        'description': vine.string().minLength(2).maxLength(255),
      });

      final validator = vine.compile(vine.object({
        'user': userSchema,
        'roles': vine.array(roleSchema),
      }));

      expect(() => vine.validate(payload, validator), returnsNormally);
    });

    test('cannot be composable with bad data structure', () {
      final payload = {
        'firstname': 'John',
        'lastname': 'Doe',
        'email': 'john.doe@foo.bar',
        'age': 25,
        'roles': [
          {'name': 'admin role', 'description': 'Administrator'},
          {'name': 'user role', 'description': 'User'},
        ],
      };

      final identitySchema = vine.object({
        'firstname': vine.string().minLength(2).maxLength(255),
        'lastname': vine.string().minLength(2).maxLength(255),
      });

      final userSchema = vine.object({
        ...identitySchema.properties,
        'email': vine.string().email(),
        'age': vine.number().integer().min(18).max(100),
      });

      final roleSchema = vine.object({
        'name': vine.string().minLength(2).maxLength(255),
        'description': vine.string().minLength(2).maxLength(255),
      });

      final validator = vine.compile(vine.object({
        'user': userSchema.optional(),
        'roles': vine.array(roleSchema),
      }));

      expect(() => vine.validate(payload, validator), throwsA(isA<ValidationException>()));
    });
  });
}
