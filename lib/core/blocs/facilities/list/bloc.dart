import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/models/facility.dart';
import 'package:hellohome/core/repositories/facilities.dart';

import 'state.dart';
import 'event.dart';

class FacilitiesListBloc extends Bloc<FacilitiesListEvent, FacilitiesListState> {
  FacilitiesListBloc() : super(FacilitiesListInitial());

  @override
  Stream<FacilitiesListState> mapEventToState(FacilitiesListEvent event) async* {
    if (event is FacilitiesListRequested) {
      yield* _mapFavoritesFetchRequestedToState();
    }
  }

  Stream<FacilitiesListState> _mapFavoritesFetchRequestedToState() async*{
    yield FacilitiesListLoading();
    try {
      List<Facility> facilities = await FacilitiesRepository.list();
      yield FacilitiesListFetched(facilities: facilities);
    } catch(e) {
      print(e);
      yield FacilitiesListFetchError();
    }
  }

}

