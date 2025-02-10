import 'package:vine/src/contracts/vine.dart';

abstract interface class VineSchema<T extends ErrorReporter> {
  FieldContext parse(T errorReporter, ValidatorContract validator, String key, dynamic value);
}

enum IpAddressVersion {
  v4(4),
  v6(6);

  final int value;

  const IpAddressVersion(this.value);
}

abstract interface class VineString implements VineSchema {
  VineString minLength(int value, {String? message});

  VineString maxLength(int value, {String? message});

  VineString email({String? message});

  VineString phone({String? message});

  VineString ipAddress({IpAddressVersion? version, String? message});

  VineString url({String? message});

  VineString alpha({String? message});

  VineString alphanumeric({String? message});

  VineString nullable();

  VineString optional();
}

abstract interface class VineNumber implements VineSchema {
  VineNumber range(List<int> values, {String? message});

  VineNumber nullable();

  VineNumber optional();
}
