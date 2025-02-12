import 'package:vine/src/vine.dart';

void main() {
  final validator = vine.compile(vine.object({
    'username': vine.string(),
    'password': vine.string(),
    'contact': vine.object({
      'name': vine.string(),
      'address': vine.string().optional(),
    }),
  }));

  final payload = {
    'username': 'John Doe',
    'password': 'secret',
    'contact': {
      'name': 'John Doe',
      'address': '123 Main St',
    },
  };

  final duration = Duration(seconds: 1);
  int iterationCount = 0;
  final stopwatch = Stopwatch()..start();

  while (stopwatch.elapsed < duration) {
    vine.validate(payload, validator);
    iterationCount++;
  }

  print('Nested Object : Processed $iterationCount iterations in ${duration.inSeconds} seconds');
}
