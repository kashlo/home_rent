import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/core/repositories/my_properties.dart';

import 'state.dart';
import 'event.dart';

class MyHomesListBloc extends Bloc<MyHomesListEvent, MyHomesListState> {
  MyHomesListBloc() : super(MyHomesListInitial());

  @override
  Stream<MyHomesListState> mapEventToState(MyHomesListEvent event) async* {
    if (event is MyHomesFetchRequested) {
      yield* _mapMyHomesFetchRequestedToState();
    }
  }

  Stream<MyHomesListState> _mapMyHomesFetchRequestedToState() async*{
    yield MyHomesListLoading();
    try {
      List<Property> homes = await MyPropertiesRepository.list();
      yield MyHomesListFetched(homes: homes);
    } catch(e) {
      print(e);
      yield MyHomesFetchError();
    }
  }

}

