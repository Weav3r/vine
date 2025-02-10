import 'package:vine/src/contracts/vine.dart';

abstract interface class VineSchema<T extends ErrorReporter> {
  FieldContext parse(T errorReporter, ValidatorContract validator, String key, dynamic value);
}

enum IpAddressVersion { all, v4, v6 }

abstract interface class StringSchemaContract implements VineSchema {
  StringSchemaContract minLength(int value, {String? message});

  StringSchemaContract maxLength(int value, {String? message});

  StringSchemaContract email({String? message});

  StringSchemaContract phone({String? message});

  StringSchemaContract ipAddress(
      {IpAddressVersion version = IpAddressVersion.all, String? message});

  StringSchemaContract url({String? message});

  StringSchemaContract alpha(
      {bool allowSpaces = false,
        bool allowDashes = false,
        bool allowUnderscores = false,
        String? message});

  StringSchemaContract nullable();

  StringSchemaContract optional();
}

abstract interface class NumberSchemaContract implements VineSchema {
  NumberSchemaContract range(List<int> values, {String? message});
}
