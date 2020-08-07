import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/property.dart';

@immutable
abstract class FavoritesEvent {
  const FavoritesEvent();
}

class FavoritesListRequested extends FavoritesEvent {
  @override
  String toString() => 'FavoritesListFetchRequested';
}

class FavoritesAddPressed extends FavoritesEvent {

  final Property property;

  @override
  String toString() => 'FavoritesAddPressed';

  FavoritesAddPressed(this.property);
}

class FavoritesDeletePressed extends FavoritesEvent {

  final Property property;

  @override
  String toString() => 'FavoritesDeletePressed';

  FavoritesDeletePressed(this.property);
}


