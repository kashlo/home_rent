import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/property.dart';

@immutable
abstract class PropertyCreateState {}

class PropertyAddInitial extends PropertyCreateState {
//  final List<HomesItem> bookingItems;

//  HomesInitial(this.bookingItems);
//  @override
//  List<Object> get props => ["HomessInitial"];
}

class PropertyCreateSuccess extends PropertyCreateState {
//  final List<Home> homes;
//
//  HomeAddSuccess({@required this.homes});

  @override
  String toString() => 'HomeAddSuccess';
//
//  @override
//  List<Object> get props => ["Fetched"];
}

class PropertyCreateLoading extends PropertyCreateState {
//  final List<HomesItem> bookingItems;
//
//  HomesLoading(this.bookingItems);
  @override
  String toString() => 'HomesAddLoading';
//
//  @override
//  List<Object> get props => ["Error"];
}


class PropertyCreateError extends PropertyCreateState {
//  final List<HomesItem> bookingItems;
//
//  HomesError(this.bookingItems);

  @override
  String toString() => 'HomesAddError';
//
//  @override
//  List<Object> get props => ["Error"];
}
