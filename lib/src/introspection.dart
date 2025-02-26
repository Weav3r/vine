import 'package:vine/src/contracts/schema.dart';

abstract interface class SchemaIntrospection {
  Map<String, dynamic> introspect({String? name});
}

final class OpenApiReporter {
  Map<String, dynamic> report(
      {required Map<String, VineSchema> schemas, String version = '3.1.0'}) {
    final components = <String, dynamic>{};

    for (final entry in schemas.entries) {
      components[entry.key] = entry.value.introspect(name: entry.key);
    }

    return {
      'openapi': version,
      'components': {'schemas': components},
    };
  }
}
