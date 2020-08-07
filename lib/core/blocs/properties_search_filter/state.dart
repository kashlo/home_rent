import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/filter.dart';

@immutable
abstract class SearchFilterState {}

class SearchFilterInitial extends SearchFilterState {}

class SearchFilterApplied extends SearchFilterState {
  final SearchFilter searchFilter;

  SearchFilterApplied({@required this.searchFilter});

  @override
  String toString() => 'SearchFilterUpdated';
//
//  @override
//  List<Object> get props => ["Fetched"];
}

class SearchFilterFetched extends SearchFilterState {
  final SearchFilter searchFilter;

  SearchFilterFetched({@required this.searchFilter});

////  final List<HomesItem> bookingItems;
////
////  HomesLoading(this.bookingItems);
//  @override
//  String toString() => 'Homes List Loading';
////
////  @override
////  List<Object> get props => ["Error"];
}

class SearchFilterCleared extends SearchFilterState {
////  final List<HomesItem> bookingItems;
////
////  HomesLoading(this.bookingItems);
//  @override
//  String toString() => 'Homes List Loading';
////
////  @override
////  List<Object> get props => ["Error"];
}

