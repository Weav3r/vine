import 'dart:collection';

import 'package:vine/vine.dart';

class FieldPool {
  static final _pool = Queue<Field>();
  static final int _maxSize = 1000;

  static Field acquire(String name, dynamic value) {
    if (_pool.isEmpty) return Field(name, value);
    return _pool.removeFirst()
      ..name = name
      ..value = value
      ..canBeContinue = true
      ..customKeys.clear();
  }

  static void release(Field field) {
    if (_pool.length < _maxSize) {
      _pool.add(field);
    }
  }
}
