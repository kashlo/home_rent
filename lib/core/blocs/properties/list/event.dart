import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/filter.dart';

@immutable
abstract class HomesListEvent {
  const HomesListEvent();
}

class HomesListRequested extends HomesListEvent {
  final SearchFilter searchFilter;

  @override
  String toString() => 'HomesFetchRequested';

  HomesListRequested({this.searchFilter});
}


