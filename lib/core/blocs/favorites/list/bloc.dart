import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/core/repositories/favourites.dart';

import 'state.dart';
import 'event.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial());

  List<Property> properties;
  
  @override
  Stream<FavoritesState> mapEventToState(FavoritesEvent event) async* {
    if (event is FavoritesListRequested) {
      yield* _mapFavoritesFetchRequestedToState();
    } else if (event is FavoritesAddPressed) {
      yield* _mapFavoritesAddPressedToState(event.property);
    } else if (event is FavoritesDeletePressed) {
      yield* _mapFavoritesDeletePressedToState(event.property);
    }
  }

  Stream<FavoritesState> _mapFavoritesFetchRequestedToState() async*{
    yield FavoritesLoading();
    try {

      properties = await FavoritesRepository.list();
      yield FavoritesFetched(properties: properties);
      
    } catch(e) {
      print(e);
      yield FavoritesFetchError();
    }
  }

  Stream<FavoritesState> _mapFavoritesAddPressedToState(Property property) async*{
//    yield FavoritesAddLoading();
    try {

      await FavoritesRepository.add(propertyId: property.id);
      properties.add(property);
      yield FavoritesEditSuccess(properties: properties);
//      favoritesHomeListBloc.add(FavoritesHomeListRequested());
    } catch(e) {
      print(e);
      yield FavoritesEditError();
    }
  }

  Stream<FavoritesState> _mapFavoritesDeletePressedToState(Property property) async*{
//    yield FavoritesAddLoading();
    try {

      await FavoritesRepository.delete(propertyId: property.id);
      properties.remove(property);
      yield FavoritesEditSuccess(properties: properties);

//      favoritesHomeListBloc.add(FavoritesHomeListRequested());
    } catch(e) {
      print(e);
      yield FavoritesEditError();
    }
  }


}

