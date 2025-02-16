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

  VineSchema requiredIfAnyExist(List<String> values);

  VineSchema requiredIfMissing(List<String> values);

  VineSchema requiredIfAnyMissing(List<String> values);

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

  VineNumber requiredIfExist(List<String> values);

  VineNumber requiredIfAnyExist(List<String> values);

  VineNumber requiredIfMissing(List<String> values);

  VineNumber requiredIfAnyMissing(List<String> values);

  VineNumber nullable();

  VineNumber optional();
}

abstract interface class VineBoolean implements VineSchema {
  VineBoolean requiredIfExist(List<String> values);

  VineBoolean requiredIfAnyExist(List<String> values);

  VineBoolean requiredIfMissing(List<String> values);

  VineBoolean requiredIfAnyMissing(List<String> values);

  VineBoolean nullable();

  VineBoolean optional();
}

abstract interface class VineAny implements VineSchema {
  VineAny requiredIfExist(List<String> values);

  VineAny requiredIfAnyExist(List<String> values);

  VineAny requiredIfMissing(List<String> values);

  VineAny requiredIfAnyMissing(List<String> values);

  VineAny nullable();

  VineAny optional();
}

abstract interface class VineEnumerable<T> {
  T get value;
}

abstract interface class VineEnum implements VineSchema {
  VineEnum requiredIfExist(List<String> values);

  VineEnum requiredIfAnyExist(List<String> values);

  VineEnum requiredIfMissing(List<String> values);

  VineEnum requiredIfAnyMissing(List<String> values);

  VineEnum nullable();

  VineEnum optional();
}

abstract interface class VineObject implements VineSchema {
  Map<String, VineSchema> get properties;

  VineObjectSchema merge(VineObjectSchema schema);

  VineObject requiredIfExist(List<String> values);

  VineObject requiredIfAnyExist(List<String> values);

  VineObject requiredIfMissing(List<String> values);

  VineObject requiredIfAnyMissing(List<String> values);

  VineObject nullable();

  VineObject optional();
}

abstract interface class VineArray implements VineSchema {
  VineArray requiredIfExist(List<String> values);

  VineArray requiredIfAnyExist(List<String> values);

  VineArray requiredIfMissing(List<String> values);

  VineArray requiredIfAnyMissing(List<String> values);

  VineArray nullable();

  VineArray optional();
}


abstract interface class VineUnion implements VineSchema {
  VineUnion requiredIfExist(List<String> values);

  VineUnion requiredIfAnyExist(List<String> values);

  VineUnion requiredIfMissing(List<String> values);

  VineUnion requiredIfAnyMissing(List<String> values);

  VineUnion nullable();

  VineUnion optional();
}
