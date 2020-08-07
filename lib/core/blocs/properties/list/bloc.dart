import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/models/filter.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/core/repositories/properties.dart';

import 'state.dart';
import 'event.dart';

class PropertiesListBloc extends Bloc<HomesListEvent, PropertiesListState> {
  PropertiesListBloc() : super(HomesListInitial());

  @override
  Stream<PropertiesListState> mapEventToState(HomesListEvent event) async* {
    if (event is HomesListRequested) {
      yield* _mapHomesFetchedToState(searchFilter: event.searchFilter);
    }
  }

  Stream<PropertiesListState> _mapHomesFetchedToState({SearchFilter searchFilter}) async*{
    yield PropertiesListLoading();
    try {
      List<Property> homes = await PropertiesRepository.list(searchFilter: searchFilter);
      yield PropertiesListFetched(properties: homes, );
    } catch(e) {
      print(e);
      yield PropertiesFetchError();
    }
  }

}

