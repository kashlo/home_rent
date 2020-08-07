import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/property.dart';

@immutable
abstract class MyHomeDeleteState {}

class MyHomeDeleteInitial extends MyHomeDeleteState {
//  final List<MyHomesItem> bookingItems;

//  MyHomesInitial(this.bookingItems);
//  @override
//  List<Object> get props => ["MyHomessInitial"];
}

class MyHomeDeleteSuccess extends MyHomeDeleteState {
//  final List<Home> homes;
//
//  MyHomeDeleteFetched({@required this.homes});

  @override
  String toString() => 'MyHomeDeleted';
//
//  @override
//  List<Object> get props => ["Fetched"];
}

class MyHomeDeleteLoading extends MyHomeDeleteState {
//  final List<MyHomesItem> bookingItems;
//
//  MyHomesLoading(this.bookingItems);
  @override
  String toString() => 'MyHomeDeleteLoading Loading';
//
//  @override
//  List<Object> get props => ["Error"];
}


class MyHomeDeleteError extends MyHomeDeleteState {
//  final List<MyHomesItem> bookingItems;
//
//  MyHomesError(this.bookingItems);

  @override
  String toString() => 'MyHomesDeleteError';
//
//  @override
//  List<Object> get props => ["Error"];
}
