import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/property.dart';

@immutable
abstract class MyHomesListState {}

class MyHomesListInitial extends MyHomesListState {
//  final List<MyHomesItem> bookingItems;

//  MyHomesInitial(this.bookingItems);
//  @override
//  List<Object> get props => ["MyHomessInitial"];
}

class MyHomesListFetched extends MyHomesListState {
  final List<Property> homes;

  MyHomesListFetched({@required this.homes});

  @override
  String toString() => 'MyHomes List Fetched';
//
//  @override
//  List<Object> get props => ["Fetched"];
}

class MyHomesListLoading extends MyHomesListState {
//  final List<MyHomesItem> bookingItems;
//
//  MyHomesLoading(this.bookingItems);
  @override
  String toString() => 'MyHomes List Loading';
//
//  @override
//  List<Object> get props => ["Error"];
}


class MyHomesFetchError extends MyHomesListState {
//  final List<MyHomesItem> bookingItems;
//
//  MyHomesError(this.bookingItems);

  @override
  String toString() => 'MyHomesFetchError';
//
//  @override
//  List<Object> get props => ["Error"];
}
