import 'package:string_validator/string_validator.dart';
import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/helper.dart';

final regex = RegExp(r'^\+?[0-9]{1,4}[-.\s]?[0-9]{1,4}[-.\s]?[0-9]{4,10}$');

void stringRuleHandler(FieldContext field, String? message) {
  if (field.value is! String) {
    final error = field.errorReporter.format('string', field, message, {});
    field.errorReporter.report('string', [...field.customKeys, field.name], error);
  }
}

void minLengthRuleHandler(FieldContext field, int minValue, String? message) {
  if ((field.value as String).length < minValue) {
    final error = field.errorReporter.format('minLength', field, message, {
      'min': minValue,
    });

    field.errorReporter.report('minLength', [...field.customKeys, field.name], error);
  }
}

void maxLengthRuleHandler(FieldContext field, int maxValue, String? message) {
  if ((field.value as String).length > maxValue) {
    final error = field.errorReporter.format('maxLength', field, message, {
      'max': maxValue,
    });

    field.errorReporter.report('maxLength', [...field.customKeys, field.name], error);
  }
}

void fixedLengthRuleHandler(FieldContext field, int count, String? message) {
  if ((field.value as String).length != count) {
    final error = field.errorReporter.format('fixedLength', field, message, {
      'length': count,
    });
    field.errorReporter.report('fixedLength', [...field.customKeys, field.name], error);
  }
}

void emailRuleHandler(FieldContext field, String? message) {
  if (!isEmailSimd(field.value as String)) {
    final error = field.errorReporter.format('email', field, message, {});
    field.errorReporter.report('email', [...field.customKeys, field.name], error);
  }
}

void phoneRuleHandler(FieldContext field, String? message) {
  if (!regex.hasMatch(field.value)) {
    final error = field.errorReporter.format('phone', field, message, {});
    field.errorReporter.report('phone', [...field.customKeys, field.name], error);
  }
}

void ipAddressRuleHandler(FieldContext field, IpAddressVersion? version, String? message) {
  if (!(field.value as String).isIP(version?.value)) {
    final error = field.errorReporter.format(
        'ipAddress', field, message, {'version': version ?? IpAddressVersion.values.toList()});
    field.errorReporter.report('ipAddress', [...field.customKeys, field.name], error);
  }
}

void regexRuleHandler(FieldContext field, RegExp regex, String? message) {
  if (!regex.hasMatch(field.value)) {
    final error = field.errorReporter.format('regex', field, message, {
      'pattern': regex.pattern,
    });

    field.errorReporter.report('regex', [...field.customKeys, field.name], error);
  }
}

void hexColorRuleHandler(FieldContext field, String? message) {
  if (!(field.value as String).isHexColor) {
    final error = field.errorReporter.format('hexColor', field, message, {});
    field.errorReporter.report('hexColor', [...field.customKeys, field.name], error);
  }
}

void urlRuleHandler(FieldContext field, List<String> protocols, bool requireTld,
    bool requireProtocol, bool allowUnderscores, String? message) {
  if (!(field.value as String).isURL({
    'protocols': protocols,
    'requireTld': requireTld,
    'requireProtocol': requireProtocol,
    'allowUnderscores': allowUnderscores,
  })) {
    final error = field.errorReporter.format('url', field, message, {});
    field.errorReporter.report('url', [...field.customKeys, field.name], error);
  }
}

void alphaRuleHandler(FieldContext field, String? message) {
  if (!(field.value as String).isAlpha) {
    final error = field.errorReporter.format('alpha', field, message, {});
    field.errorReporter.report('alpha', [...field.customKeys, field.name], error);
  }
}

void alphaNumericRuleHandler(FieldContext field, String? message) {
  if (!(field.value as String).isAlphanumeric) {
    final error = field.errorReporter.format('alphaNumeric', field, message, {});
    field.errorReporter.report('alphaNumeric', [...field.customKeys, field.name], error);
  }
}

void startWithRuleHandler(FieldContext field, String attemptedValue, String? message) {
  if (!(field.value as String).startsWith(attemptedValue)) {
    final error =
        field.errorReporter.format('startWith', field, message, {'value': attemptedValue});
    field.errorReporter.report('startWith', [...field.customKeys, field.name], error);
  }
}

void endWithRuleHandler(FieldContext field, String attemptedValue, String? message) {
  if (!(field.value as String).endsWith(attemptedValue)) {
    final error = field.errorReporter.format('endWith', field, message, {'value': attemptedValue});
    field.errorReporter.report('endWith', [...field.customKeys, field.name], error);
  }
}

void confirmedRuleHandler(FieldContext field, String? targetField, bool include, String? message) {
  final confirmedKey = targetField ?? '${field.name}_confirmation';
  final hasKey = field.data.containsKey(confirmedKey);

  if (!hasKey) {
    final error =
        field.errorReporter.format('missingProperty', field, message, {'field': confirmedKey});
    field.errorReporter.report('missingProperty', [...field.customKeys, field.name], error);
  }

  final currentValue = field.data[confirmedKey];
  if ((field.value as String) != currentValue) {
    final error =
        field.errorReporter.format('confirmed', field, message, {'attemptedName': confirmedKey});
    field.errorReporter.report('confirmed', [...field.customKeys, field.name], error);
  }

  if (!include) {
    field.data.remove(confirmedKey);
  }
}

void trimRuleHandler(FieldContext field) {
  field.mutate((field.value as String).trim());
}

void normalizeEmailRuleHandler(FieldContext field, bool lowerCase) {
  if (field.value case String value) {
    field.mutate(value.normalizeEmail({
      'lowercase': lowerCase,
    }));
  }
}

void toUpperCaseRuleHandler(FieldContext field) {
  if (field.value case String value) {
    field.mutate(value.toUpperCase());
  }
}

void toLowerCaseRuleHandler(FieldContext field) {
  if (field.value case String value) {
    field.mutate(value.toLowerCase());
  }
}

void toCamelCaseRuleHandler(FieldContext field) {
  if (field.value case String value) {
    final buffer = StringBuffer();
    final parts = value.split(RegExp(r'[_\s-]'));

    buffer.write(parts.first.toLowerCase());

    for (final part in parts.skip(1)) {
      buffer.write(part[0].toUpperCase());
      buffer.write(part.substring(1).toLowerCase());
    }

    field.mutate(buffer.toString());
  }
}

void uuidRuleHandler(FieldContext field, UuidVersion? version, String? message) {
  if (!(field.value as String).isUUID()) {
    final error = field.errorReporter.format('uuid', field, message, {
      'version': version ?? UuidVersion.values.toList(),
    });

    field.errorReporter.report('uuid', [...field.customKeys, field.name], error);
  }
}

void isCreditCodeRuleHandler(FieldContext field, String? message) {
  if (!(field.value as String).isCreditCard) {
    final error = field.errorReporter.format('creditCard', field, message, {});

    field.errorReporter.report('creditCard', [...field.customKeys, field.name], error);
  }
}
