import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/facility.dart';
import 'package:hellohome/core/models/property.dart';

@immutable
abstract class FacilitiesListState {}

class FacilitiesListInitial extends FacilitiesListState {
//  final List<HomesItem> bookingItems;

//  HomesInitial(this.bookingItems);
//  @override
//  List<Object> get props => ["HomessInitial"];
}

class FacilitiesListFetched extends FacilitiesListState {
  final List<Facility> facilities;

  FacilitiesListFetched({@required this.facilities});

  @override
  String toString() => 'FacilitiesList Fetched';
//
//  @override
//  List<Object> get props => ["Fetched"];
}

class FacilitiesListLoading extends FacilitiesListState {
//  final List<HomesItem> bookingItems;
//
//  HomesLoading(this.bookingItems);
  @override
  String toString() => 'FacilitiesList Loading';
//
//  @override
//  List<Object> get props => ["Error"];
}


class FacilitiesListFetchError extends FacilitiesListState {
//  final List<HomesItem> bookingItems;
//
//  HomesError(this.bookingItems);

  @override
  String toString() => 'FacilitiesListFetchError';
//
//  @override
//  List<Object> get props => ["Error"];
}
