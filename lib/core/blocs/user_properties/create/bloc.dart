import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/core/repositories/my_properties.dart';

import 'state.dart';
import 'event.dart';

class PropertyCreateBloc extends Bloc<PropertyCreateEvent, PropertyCreateState> {
  PropertyCreateBloc() : super(PropertyAddInitial());

  @override
  Stream<PropertyCreateState> mapEventToState(PropertyCreateEvent event) async* {
    if (event is PropertyCreatePressed) {
      yield* _mapPropertyCreatePressedToState(property: event.property, images: event.images);
    }
  }

  Stream<PropertyCreateState> _mapPropertyCreatePressedToState({Property property, List<File> images}) async*{
    yield PropertyCreateLoading();
//    try {
      await MyPropertiesRepository.create(property: property, images: images);
//      yield PropertyCreateSuccess();
//    } catch(e) {
//      print(e);
//      yield PropertyCreateError();
//    }
  }

}

