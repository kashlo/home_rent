import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/property.dart';

@immutable
abstract class MyHomeUpdateState {}

class MyHomeUpdateInitial extends MyHomeUpdateState {
//  final List<MyHomesItem> bookingItems;

//  MyHomesInitial(this.bookingItems);
//  @override
//  List<Object> get props => ["MyHomessInitial"];
}

class MyHomeUpdateSuccess extends MyHomeUpdateState {
//  final List<Home> homes;
//
//  MyHomeUpdateFetched({@required this.homes});

  @override
  String toString() => 'MyHomeUpdated';
//
//  @override
//  List<Object> get props => ["Fetched"];
}

class MyHomeUpdateLoading extends MyHomeUpdateState {
//  final List<MyHomesItem> bookingItems;
//
//  MyHomesLoading(this.bookingItems);
  @override
  String toString() => 'MyHomeUpdateLoading Loading';
//
//  @override
//  List<Object> get props => ["Error"];
}


class MyHomeUpdateError extends MyHomeUpdateState {
//  final List<MyHomesItem> bookingItems;
//
//  MyHomesError(this.bookingItems);

  @override
  String toString() => 'MyHomesUpdateError';
//
//  @override
//  List<Object> get props => ["Error"];
}
