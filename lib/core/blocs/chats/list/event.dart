import 'package:flutter/foundation.dart';

@immutable
abstract class ChatsListEvent {
  const ChatsListEvent();
}

class ChatsListRequested extends ChatsListEvent {
  @override
  String toString() => 'MessagesFetchRequested';
}


