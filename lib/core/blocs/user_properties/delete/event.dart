import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/property.dart';

@immutable
abstract class MyHomeDeleteEvent {
  const MyHomeDeleteEvent();
}

class MyHomeDeletePressed extends MyHomeDeleteEvent {
  final Property home;

  @override
  String toString() => 'MyHomesDeletePressed';

  MyHomeDeletePressed(this.home);
}


