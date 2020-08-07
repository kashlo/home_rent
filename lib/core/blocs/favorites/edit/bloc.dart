//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:hellohome/core/blocs/favorites_edit/state.dart';
//import 'package:hellohome/core/blocs/favorites/list/bloc.dart';
//import 'package:hellohome/core/blocs/favorites/list/event.dart';
//import 'package:hellohome/core/models/property.dart';
//import 'package:hellohome/core/repositories/favourites.dart';
//
//import 'event.dart';
//
//class FavoritesHomeEditBloc extends Bloc<FavoritesCreateEvent, FavoritesEditState> {
//  final FavoritesHomeListBloc favoritesHomeListBloc;
//  FavoritesHomeEditBloc(this.favoritesHomeListBloc) : super(FavoritesCreateInitial());
//
//  @override
//  Stream<FavoritesEditState> mapEventToState(FavoritesCreateEvent event) async* {
//    if (event is FavoritesAddPressed) {
//      yield* _mapFavoritesAddPressedToState(event.home);
//    } else if (event is FavoritesDeletePressed) {
//      yield* _mapFavoritesDeletePressedToState(event.home);
//    }
//  }
//
//  Stream<FavoritesEditState> _mapFavoritesAddPressedToState(Home home) async*{
////    yield FavoritesAddLoading();
//    try {
//      final FirebaseAuth _auth = FirebaseAuth.instance;
//      final FirebaseUser currentUser = await _auth.currentUser();
//
//      await FavoritesRepository.add(homeId: home.id, userId: currentUser.uid);
//      yield FavoritesEditSuccess();
//      favoritesHomeListBloc.add(FavoritesHomeListRequested());
//    } catch(e) {
//      print(e);
//      yield FavoritesAddError();
//    }
//  }
//
//  Stream<FavoritesEditState> _mapFavoritesDeletePressedToState(Home home) async*{
////    yield FavoritesAddLoading();
//    try {
//      final FirebaseAuth _auth = FirebaseAuth.instance;
//      final FirebaseUser currentUser = await _auth.currentUser();
//
//      await FavoritesRepository.delete(homeId: home.id, userId: currentUser.uid);
//      yield FavoritesEditSuccess();
//      favoritesHomeListBloc.add(FavoritesHomeListRequested());
//    } catch(e) {
//      print(e);
//      yield FavoritesAddError();
//    }
//  }
//
//}
//
