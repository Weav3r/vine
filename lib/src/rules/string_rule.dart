import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:string_validator/string_validator.dart';

void stringRuleHandler(FieldContext field, String? message) {
  if (field.value is! String) {
    final error = field.errorReporter.format('string', field, message, {});
    field.errorReporter.report('string', field.name, error);
  }

  field.next();
}

void minLengthRuleHandler(FieldContext field, int minValue, String? message) {
  if (field.value case String(:final length) when length < minValue) {
    final error = field.errorReporter.format('minLength', field, message, {
      'min': minValue,
    });

    field.errorReporter.report('minLength', field.name, error);
  }

  field.next();
}

void maxLengthRuleHandler(FieldContext field, int maxValue, String? message) {
  if (field.value case String(:final length) when length > maxValue) {
    final error = field.errorReporter.format('maxLength', field, message, {
      'max': maxValue,
    });

    field.errorReporter.report('maxLength', field.name, error);
  }

  field.next();
}

void emailRuleHandler(FieldContext field, String? message) {
  if (field.value case String value when !value.isEmail) {
    final error = field.errorReporter.format('email', field, message, {});
    field.errorReporter.report('email', field.name, error);
  }

  field.next();
}

void phoneRuleHandler(FieldContext field, String? message) {
  final regex = RegExp(r'^\+?[0-9]{1,4}[-.\s]?[0-9]{1,4}[-.\s]?[0-9]{4,10}$');

  if (field.value case String value when !regex.hasMatch(value)) {
    final error = field.errorReporter.format('phone', field, message, {});
    field.errorReporter.report('phone', field.name, error);
  }

  field.next();
}

void ipAddressRuleHandler(FieldContext field, IpAddressVersion? version, String? message) {
  if (field.value case String value when !value.isIP(version?.value)) {
    final error = field.errorReporter.format(
        'ipAddress', field, message, {'version': version ?? IpAddressVersion.values.toList()});
    field.errorReporter.report('ipAddress', field.name, error);
  }

  field.next();
}

void regexRuleHandler(FieldContext field, RegExp regex, String? message) {
  if (field.value case String value when !regex.hasMatch(value)) {
    final error = field.errorReporter.format('regex', field, message, {
      'pattern': regex.pattern,
    });

    field.errorReporter.report('regex', field.name, error);
  }

  field.next();
}

void hexColorRuleHandler(FieldContext field, String? message) {
  if (field.value case String value when !value.isHexColor) {
    final error = field.errorReporter.format('hexColor', field, message, {});
    field.errorReporter.report('hexColor', field.name, error);
  }

  field.next();
}

void urlRuleHandler(FieldContext field, List<String> protocols, bool requireTld,
    bool requireProtocol, bool allowUnderscores, String? message) {
  if (field.value case String value
      when !value.isURL({
        'protocols': protocols,
        'requireTld': requireTld,
        'requireProtocol': requireProtocol,
        'allowUnderscores': allowUnderscores,
      })) {
    final error = field.errorReporter.format('url', field, message, {});
    field.errorReporter.report('url', field.name, error);
  }

  field.next();
}

void alphaRuleHandler(FieldContext field, String? message) {
  if (field.value case String value when !value.isAlpha) {
    final error = field.errorReporter.format('alpha', field, message, {});
    field.errorReporter.report('alpha', field.name, error);
  }

  field.next();
}

void alphanumericRuleHandler(FieldContext field, String? message) {
  if (field.value case String value when !value.isAlphanumeric) {
    final error = field.errorReporter.format('alphaNumeric', field, message, {});
    field.errorReporter.report('alphaNumeric', field.name, error);
  }

  field.next();
}
