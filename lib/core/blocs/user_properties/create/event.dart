import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/property.dart';

@immutable
abstract class PropertyCreateEvent {
  const PropertyCreateEvent();
}

class PropertyCreatePressed extends PropertyCreateEvent {

  final Property property;
  final List<File> images;

  @override
  String toString() => 'HomesFetchRequested';

  PropertyCreatePressed({this.property, this.images});
}


