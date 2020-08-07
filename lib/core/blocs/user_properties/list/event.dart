import 'package:flutter/foundation.dart';

@immutable
abstract class MyHomesListEvent {
  const MyHomesListEvent();
}

class MyHomesFetchRequested extends MyHomesListEvent {
  @override
  String toString() => 'MyHomesFetchRequested';
}


