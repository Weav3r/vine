import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/schema/object/object_schema.dart';

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

abstract interface class VineEnumerable<T> {
  T get value;
}

abstract interface class BasicSchema<T extends VineSchema> {
  T requiredIfExist(List<String> values);

  T requiredIfAnyExist(List<String> values);

  T requiredIfMissing(List<String> values);

  T requiredIfAnyMissing(List<String> values);

  T transform(Function(VineValidationContext ctx, FieldContext field) fn);

  T nullable();

  T optional();
}

abstract interface class VineString implements VineSchema, BasicSchema<VineString> {
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
}

abstract interface class VineNumber implements VineSchema, BasicSchema<VineNumber> {
  VineNumber range(List<num> values, {String? message});

  VineNumber min(num value, {String? message});

  VineNumber max(num value, {String? message});

  VineNumber negative({String? message});

  VineNumber positive({String? message});

  VineNumber double({String? message});

  VineNumber integer({String? message});
}

abstract interface class VineBoolean implements VineSchema, BasicSchema<VineBoolean> {}

abstract interface class VineAny implements VineSchema, BasicSchema<VineAny> {}


abstract interface class VineEnum implements VineSchema, BasicSchema<VineEnum> {
}

abstract interface class VineObject implements VineSchema, BasicSchema<VineObject> {
  Map<String, VineSchema> get properties;

  VineObject merge(VineObjectSchema schema);
}

abstract interface class VineGroup implements VineSchema {
  VineGroup when(bool Function(Map<String, dynamic> data) fn, Map<String, VineSchema> object);
  VineGroup otherwise(Function(VineValidationContext, FieldContext) fn);
}

abstract interface class VineArray implements VineSchema, BasicSchema<VineArray> {
  VineArray minLength(int value, {String? message});

  VineArray maxLength(int value, {String? message});

  VineArray fixedLength(int value, {String? message});
}


abstract interface class VineUnion implements VineSchema, BasicSchema<VineUnion> {}

abstract interface class VineDate implements VineSchema, BasicSchema<VineDate> {
  VineDate before(DateTime value, {String? message});

  VineDate after(DateTime value, {String? message});

  VineDate between(DateTime min, DateTime max, {String? message});

  VineDate beforeField(String value, {String? message});

  VineDate afterField(String value, {String? message});

  VineDate betweenFields(String start, String end, {String? message});
}
