import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/property.dart';

@immutable
abstract class PropertiesListState {}

class HomesListInitial extends PropertiesListState {
//  final List<HomesItem> bookingItems;

//  HomesInitial(this.bookingItems);
//  @override
//  List<Object> get props => ["HomessInitial"];
}

class PropertiesListFetched extends PropertiesListState {
  final List<Property> properties;

  PropertiesListFetched({@required this.properties});

  @override
  String toString() => 'Homes List Fetched';
//
//  @override
//  List<Object> get props => ["Fetched"];
}

class PropertiesListLoading extends PropertiesListState {
//  final List<HomesItem> bookingItems;
//
//  HomesLoading(this.bookingItems);
  @override
  String toString() => 'Homes List Loading';
//
//  @override
//  List<Object> get props => ["Error"];
}


class PropertiesFetchError extends PropertiesListState {
//  final List<HomesItem> bookingItems;
//
//  HomesError(this.bookingItems);

  @override
  String toString() => 'HomesFetchError';
//
//  @override
//  List<Object> get props => ["Error"];
}
