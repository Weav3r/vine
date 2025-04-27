import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:vine/src/vine.dart';

import 'rules/enum_test.dart';

void main() {
  test('test', () {
    final validator = vine.compile(
        vine.object({'value': vine.enumerate(MyEnum.values).optional()}));

    expect(() => validator.validate({}), returnsNormally);
  });
}
