import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/core/repositories/my_properties.dart';

import 'state.dart';
import 'event.dart';

class MyHomeDeleteBloc extends Bloc<MyHomeDeleteEvent, MyHomeDeleteState> {
  MyHomeDeleteBloc() : super(MyHomeDeleteInitial());

  @override
  Stream<MyHomeDeleteState> mapEventToState(MyHomeDeleteEvent event) async* {
    if (event is MyHomeDeletePressed) {
      yield* _mapMyHomeDeletePressedToState(event.home);
    }
  }

  Stream<MyHomeDeleteState> _mapMyHomeDeletePressedToState(Property property) async*{
    yield MyHomeDeleteLoading();
    try {

      await MyPropertiesRepository.delete(property.id);
      yield MyHomeDeleteSuccess();
    } catch(e) {
      print(e);
      yield MyHomeDeleteError();
    }
  }

}

