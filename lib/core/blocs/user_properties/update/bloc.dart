import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/core/repositories/my_properties.dart';

import 'state.dart';
import 'event.dart';


class MyHomeUpdateBloc extends Bloc<MyHomeUpdateEvent, MyHomeUpdateState> {
  MyHomeUpdateBloc() : super(MyHomeUpdateInitial());

  @override
  Stream<MyHomeUpdateState> mapEventToState(MyHomeUpdateEvent event) async* {
    if (event is MyHomeUpdatePressed) {
      yield* _mapMyHomeUpdatePressedToState(event.home);
    }
  }

  Stream<MyHomeUpdateState> _mapMyHomeUpdatePressedToState(Property home) async*{
    yield MyHomeUpdateLoading();
    try {
      await MyPropertiesRepository.update(home);
      yield MyHomeUpdateSuccess();
    } catch(e) {
      print(e);
      yield MyHomeUpdateError();
    }
  }

}

