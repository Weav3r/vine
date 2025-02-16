import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/schema/object_schema.dart';

abstract interface class VineSchema<T extends ErrorReporter> {
  void parse(VineValidationContext ctx, FieldContext field);
  VineSchema clone();
}

enum IpAddressVersion {
  v4(4),
  v6(6);

  final int value;

  const IpAddressVersion(this.value);
}

enum UuidVersion {
  v3(3),
  v4(4),
  v5(5);

  final int value;

  const UuidVersion(this.value);
}

abstract interface class VineString implements VineSchema {
  VineString minLength(int value, {String? message});

  VineString maxLength(int value, {String? message});

  VineString fixedLength(int value, {String? message});

  VineString email({String? message});

  VineString phone({String? message});

  VineString ipAddress({IpAddressVersion? version, String? message});

  VineString url({String? message});

  VineString alpha({String? message});

  VineString alphaNumeric({String? message});

  VineString startsWith(String value, {String? message});

  VineString endsWith(String value, {String? message});

  VineString confirmed({String? property, bool include = false, String? message});

  VineString trim();

  VineString normalizeEmail({bool lowercase = true});

  VineString toUpperCase();

  VineString toLowerCase();

  VineString toCamelCase();

  VineString uuid({UuidVersion? version, String? message});

  VineString isCreditCard({String? message});

  VineString sameAs(String value, {String? message});

  VineString notSameAs(String value, {String? message});

  VineString inList(List<String> values, {String? message});

  VineString notInList(List<String> values, {String? message});

  VineSchema requiredIfExist(List<String> values);

  VineString nullable();

  VineString optional();
}

abstract interface class VineNumber implements VineSchema {
  VineNumber range(List<num> values, {String? message});

  VineNumber min(num value, {String? message});

  VineNumber max(num value, {String? message});

  VineNumber negative({String? message});

  VineNumber positive({String? message});

  VineNumber double({String? message});

  VineNumber integer({String? message});

  VineNumber nullable();

  VineNumber optional();
}

abstract interface class VineBoolean implements VineSchema {
  VineBoolean nullable();

  VineBoolean optional();
}

abstract interface class VineAny implements VineSchema {
  VineAny nullable();

  VineAny optional();
}

abstract interface class VineEnumerable<T> {
  T get value;
}

abstract interface class VineEnum implements VineSchema {
  VineEnum nullable();

  VineEnum optional();
}

abstract interface class VineObject implements VineSchema {
  Map<String, VineSchema> get properties;

  VineObjectSchema merge(VineObjectSchema schema);

  VineObject nullable();

  VineObject optional();
}

abstract interface class VineArray implements VineSchema {
  VineArray nullable();

  VineArray optional();
}


abstract interface class VineUnion implements VineSchema {
  VineUnion nullable();

  VineUnion optional();
}
