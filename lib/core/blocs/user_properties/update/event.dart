import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/property.dart';

@immutable
abstract class MyHomeUpdateEvent {
  const MyHomeUpdateEvent();
}

class MyHomeUpdatePressed extends MyHomeUpdateEvent {
  final Property home;

  @override
  String toString() => 'MyHomesUpdatePressed';

  MyHomeUpdatePressed(this.home);
}


