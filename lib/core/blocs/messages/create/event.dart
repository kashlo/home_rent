import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/property.dart';

@immutable
abstract class MessageCreateEvent {
  const MessageCreateEvent();
}

class MessageCreatePressed extends MessageCreateEvent {

  final Property home;
  final String message;

  @override
  String toString() => 'HomesFetchRequested';

  MessageCreatePressed(this.home, this.message);
}


