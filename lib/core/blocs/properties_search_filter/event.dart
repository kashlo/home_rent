import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/filter.dart';

@immutable
abstract class SearchFilterEvent {
  const SearchFilterEvent();
}

class SearchFilterApplyPressed extends SearchFilterEvent {
  final SearchFilter searchFilter;

  @override
  String toString() => 'HomesFetchRequested';

  SearchFilterApplyPressed({this.searchFilter});
}

class SearchFilterClearPressed extends SearchFilterEvent {

  @override
  String toString() => 'HomesFetchRequested';

}

class SearchFilterRequested extends SearchFilterEvent {

  @override
  String toString() => 'SearchFilterRequested';

}

