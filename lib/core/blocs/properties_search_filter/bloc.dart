import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/blocs/properties_search_filter/state.dart';
import 'package:hellohome/core/models/filter.dart';

import 'event.dart';

class SearchFilterBloc extends Bloc<SearchFilterEvent, SearchFilterState> {
  SearchFilterBloc() : super(SearchFilterInitial());

  SearchFilter _searchFilter;

  @override
  Stream<SearchFilterState> mapEventToState(SearchFilterEvent event) async* {
    if (event is SearchFilterApplyPressed) {
      yield* _mapSearchFilterAppliedToState(searchFilter: event.searchFilter);
    } else if (event is SearchFilterClearPressed) {
      yield* _mapSearchFilterClearedToState();
    } else if (event is SearchFilterRequested) {
      yield* _mapSearchFilterRequestedToState();

    }
  }

  Stream<SearchFilterState> _mapSearchFilterAppliedToState({SearchFilter searchFilter}) async* {
    _searchFilter = searchFilter;
//    yield SearchFilterLoading();
      yield SearchFilterApplied(searchFilter: _searchFilter);
      yield SearchFilterFetched(searchFilter: _searchFilter);

  }

  Stream<SearchFilterState> _mapSearchFilterClearedToState() async* {
    _searchFilter = null;

//    yield SearchFilterLoading();
    yield SearchFilterCleared();

//    yield SearchFilterCleared();
  }

  Stream<SearchFilterState> _mapSearchFilterRequestedToState() async* {
//    yield SearchFilterLoading();
    yield SearchFilterFetched(searchFilter: _searchFilter);

//    yield SearchFilterCleared();
  }


}

