import 'package:flutter/foundation.dart';

@immutable
abstract class FacilitiesListEvent {
  const FacilitiesListEvent();
}

class FacilitiesListRequested extends FacilitiesListEvent {
  @override
  String toString() => 'FavoritesListFetchRequested';
}


