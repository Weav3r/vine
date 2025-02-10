import 'package:vine/src/vine.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    final validator = vine.compile({
      'firstname': vine.string().minLength(3).minLength(4),
      'lastname': vine.string().maxLength(10).nullable(),
      'age': vine.number().range([18, 20, 21]),
      'email': vine.string().email(),
      'phone': vine.string().phone(),
      'ip': vine.string().ipAddress(),
      'url': vine.string().url().optional(),
    });

    const payload = {
      'firstname': 'John',
      'lastname': null,
      'age': 20,
      'email': 'john.doe@foo.bar',
      'phone': '0000000000',
      'ip': '127.0.0.1',
    };

    final data = vine.validate(payload, validator);

    expect(data, {...payload, 'age': 20});
  });

  test('confirmed rule', () {
    final validator = vine.compile({
      'password': vine.string().minLength(3).maxLength(255).confirmed(),
    });

    const payload = {
      'password': '123456789',
    };

    final data = vine.validate({
      ...payload,
      'password_confirmation': '123456789',
    }, validator);

    expect(data, payload);
  });
}
