import 'package:string_validator/string_validator.dart';
import 'package:vine/src/contracts/schema.dart';
import 'package:vine/src/contracts/vine.dart';
import 'package:vine/src/helper.dart';

final regex = RegExp(r'^\+?[0-9]{1,4}[-.\s]?[0-9]{1,4}[-.\s]?[0-9]{4,10}$');

void stringRuleHandler(VineValidationContext ctx, FieldContext field, String? message) {
  if (field.value is! String) {
    final error = ctx.errorReporter.format('string', field, message, {});
    ctx.errorReporter.report('string', [...field.customKeys, field.name], error);
  }
}

void minLengthRuleHandler(VineValidationContext ctx, FieldContext field, int minValue, String? message) {
  if ((field.value as String).length < minValue) {
    final error = ctx.errorReporter.format('minLength', field, message, {
      'min': minValue,
    });

    ctx.errorReporter.report('minLength', [...field.customKeys, field.name], error);
  }
}

void maxLengthRuleHandler(VineValidationContext ctx, FieldContext field, int maxValue, String? message) {
  if ((field.value as String).length > maxValue) {
    final error = ctx.errorReporter.format('maxLength', field, message, {
      'max': maxValue,
    });

    ctx.errorReporter.report('maxLength', [...field.customKeys, field.name], error);
  }
}

void fixedLengthRuleHandler(VineValidationContext ctx, FieldContext field, int count, String? message) {
  if ((field.value as String).length != count) {
    final error = ctx.errorReporter.format('fixedLength', field, message, {
      'length': count,
    });
    ctx.errorReporter.report('fixedLength', [...field.customKeys, field.name], error);
  }
}

void emailRuleHandler(VineValidationContext ctx, FieldContext field, String? message) {
  if (!isEmailSimd(field.value as String)) {
    final error = ctx.errorReporter.format('email', field, message, {});
    ctx.errorReporter.report('email', [...field.customKeys, field.name], error);
  }
}

void phoneRuleHandler(VineValidationContext ctx, FieldContext field, String? message) {
  if (!regex.hasMatch(field.value)) {
    final error = ctx.errorReporter.format('phone', field, message, {});
    ctx.errorReporter.report('phone', [...field.customKeys, field.name], error);
  }
}

void ipAddressRuleHandler(VineValidationContext ctx, FieldContext field, IpAddressVersion? version, String? message) {
  if (!(field.value as String).isIP(version?.value)) {
    final error = ctx.errorReporter.format(
        'ipAddress', field, message, {'version': version ?? IpAddressVersion.values.toList()});
    ctx.errorReporter.report('ipAddress', [...field.customKeys, field.name], error);
  }
}

void regexRuleHandler(VineValidationContext ctx, FieldContext field, RegExp regex, String? message) {
  if (!regex.hasMatch(field.value)) {
    final error = ctx.errorReporter.format('regex', field, message, {
      'pattern': regex.pattern,
    });

    ctx.errorReporter.report('regex', [...field.customKeys, field.name], error);
  }
}

void hexColorRuleHandler(VineValidationContext ctx, FieldContext field, String? message) {
  if (!(field.value as String).isHexColor) {
    final error = ctx.errorReporter.format('hexColor', field, message, {});
    ctx.errorReporter.report('hexColor', [...field.customKeys, field.name], error);
  }
}

void urlRuleHandler(VineValidationContext ctx, FieldContext field, List<String> protocols, bool requireTld,
    bool requireProtocol, bool allowUnderscores, String? message) {
  if (!(field.value as String).isURL({
    'protocols': protocols,
    'requireTld': requireTld,
    'requireProtocol': requireProtocol,
    'allowUnderscores': allowUnderscores,
  })) {
    final error = ctx.errorReporter.format('url', field, message, {});
    ctx.errorReporter.report('url', [...field.customKeys, field.name], error);
  }
}

void alphaRuleHandler(VineValidationContext ctx, FieldContext field, String? message) {
  if (!(field.value as String).isAlpha) {
    final error = ctx.errorReporter.format('alpha', field, message, {});
    ctx.errorReporter.report('alpha', [...field.customKeys, field.name], error);
  }
}

void alphaNumericRuleHandler(VineValidationContext ctx, FieldContext field, String? message) {
  if (!(field.value as String).isAlphanumeric) {
    final error = ctx.errorReporter.format('alphaNumeric', field, message, {});
    ctx.errorReporter.report('alphaNumeric', [...field.customKeys, field.name], error);
  }
}

void startWithRuleHandler(VineValidationContext ctx, FieldContext field, String attemptedValue, String? message) {
  if (!(field.value as String).startsWith(attemptedValue)) {
    final error =
        ctx.errorReporter.format('startWith', field, message, {'value': attemptedValue});
    ctx.errorReporter.report('startWith', [...field.customKeys, field.name], error);
  }
}

void endWithRuleHandler(VineValidationContext ctx, FieldContext field, String attemptedValue, String? message) {
  if (!(field.value as String).endsWith(attemptedValue)) {
    final error = ctx.errorReporter.format('endWith', field, message, {'value': attemptedValue});
    ctx.errorReporter.report('endWith', [...field.customKeys, field.name], error);
  }
}

void confirmedRuleHandler(VineValidationContext ctx, FieldContext field, String? targetField, bool include, String? message) {
  final confirmedKey = targetField ?? '${field.name}_confirmation';
  final hasKey = ctx.data.containsKey(confirmedKey);

  if (!hasKey) {
    final error =
        ctx.errorReporter.format('missingProperty', field, message, {'field': confirmedKey});
    ctx.errorReporter.report('missingProperty', [...field.customKeys, field.name], error);
  }

  final currentValue = ctx.data[confirmedKey];
  if ((field.value as String) != currentValue) {
    final error =
        ctx.errorReporter.format('confirmed', field, message, {'attemptedName': confirmedKey});
    ctx.errorReporter.report('confirmed', [...field.customKeys, field.name], error);
  }

  if (!include) {
    ctx.data.remove(confirmedKey);
  }
}

void trimRuleHandler(VineValidationContext ctx, FieldContext field) {
  field.mutate((field.value as String).trim());
}

void normalizeEmailRuleHandler(VineValidationContext ctx, FieldContext field, bool lowerCase) {
  if (field.value case String value) {
    field.mutate(value.normalizeEmail({
      'lowercase': lowerCase,
    }));
  }
}

void toUpperCaseRuleHandler(VineValidationContext ctx, FieldContext field) {
  if (field.value case String value) {
    field.mutate(value.toUpperCase());
  }
}

void toLowerCaseRuleHandler(VineValidationContext ctx, FieldContext field) {
  if (field.value case String value) {
    field.mutate(value.toLowerCase());
  }
}

void toCamelCaseRuleHandler(VineValidationContext ctx, FieldContext field) {
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

void uuidRuleHandler(VineValidationContext ctx, FieldContext field, UuidVersion? version, String? message) {
  if (!(field.value as String).isUUID()) {
    final error = ctx.errorReporter.format('uuid', field, message, {
      'version': version ?? UuidVersion.values.toList(),
    });

    ctx.errorReporter.report('uuid', [...field.customKeys, field.name], error);
  }
}

void isCreditCodeRuleHandler(VineValidationContext ctx, FieldContext field, String? message) {
  if (!(field.value as String).isCreditCard) {
    final error = ctx.errorReporter.format('creditCard', field, message, {});

    ctx.errorReporter.report('creditCard', [...field.customKeys, field.name], error);
  }
}
