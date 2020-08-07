import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/property.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {
//  final <HomesItem> bookingItems;

//  HomesInitial(this.bookingItems);
//  @override
//  <Object> get props => ["HomessInitial"];
}

class FavoritesFetched extends FavoritesState {
  final List<Property> properties;
//
  FavoritesFetched({@required this.properties});
//
//  @override
//  String toString() => 'Favorites Fetched';
////
////  @override
////  <Object> get props => ["Fetched"];
}
//class FavoritesHomesFetched extends FavoritesState {
//  final <String> bookingItems;
//
//  FavoritesHomesFetched(this.bookingItems);
//  @override
//  String toString() => 'FavoritesHomesFetched';
////
////  @override
////  <Object> get props => ["Error"];
//}

class FavoritesLoading extends FavoritesState {
//  final <HomesItem> bookingItems;
//
//  HomesLoading(this.bookingItems);
  @override
  String toString() => 'Favorites Loading';
//
//  @override
//  <Object> get props => ["Error"];
}


class FavoritesFetchError extends FavoritesState {
//  final <HomesItem> bookingItems;
//
//  HomesError(this.bookingItems);

  @override
  String toString() => 'FavoritesFetchError';
//
//  @override
//  <Object> get props => ["Error"];
}

class FavoritesEditSuccess extends FavoritesState {
  final List<Property> properties;
//
  FavoritesEditSuccess({@required this.properties});

  @override
  String toString() => 'FavoritesEditSuccess';
//
//  @override
//  List<Object> get props => ["Fetched"];
}
class FavoritesEditError extends FavoritesState {
//  final List<Favorites> homes;
//
//  FavoritesAddSuccess({@required this.homes});

  @override
  String toString() => 'FavoritesEditError';
//
//  @override
//  List<Object> get props => ["Fetched"];
}
