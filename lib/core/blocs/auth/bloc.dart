import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hellohome/core/blocs/auth/state.dart';
import 'package:hellohome/core/helpers/constants.dart';
import 'package:hellohome/core/helpers/secure_storage.dart';
import 'package:hellohome/core/helpers/shared_prefs.dart';
import 'package:meta/meta.dart';

import 'event.dart';


class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  AuthenticationBloc() : super(Uninitialized());

//  final UserRepository _userRepository;
//  final UserProfileBloc _userBloc;
//
//  AuthenticationBloc({
////    @required UserRepository userRepository,
//    @required UserProfileBloc userBloc
//  }) : _userBloc = userBloc;

  Timer timer;

//
//  @override
//  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
    ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is SignedIn) {
      yield* _mapSignedInToState(event.token);
    } else if (event is AuthenticationSkipped) {
      yield* _mapAuthenticationSkippedToState();
    } else if (event is SignedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapSignedInToState(String token) async* {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>_mapSignedInToState");
    await SecureStorageHelper.set(name: Constants.authToken, value: token);

    yield Authenticated();

  }

  Stream<AuthenticationState> _mapAuthenticationSkippedToState() async* {
    await SharedPrefsHelper.setBool(Constants.userIsAnonymous, true);
    yield Anonymous();
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>app started");
//      final token = await SecureStorageHelper.get(Constants.authToken);
      bool anonymous = await SharedPrefsHelper.getBool(Constants.userIsAnonymous);

//      final refreshToken = await SecureStorageHelper.get(Constants.refreshToken);
//      String email = await SecureStorageHelper.get(Constants.email);
      print(anonymous);
      if (anonymous) {
        print(">>>>>>>>>>>>>anonymous");
        yield Anonymous();
      } else {
        String token = await SecureStorageHelper.get(Constants.authToken);
        print(">>>>>>>>>>>>>>>>>>>>>token");
        print(token);
        if (token != null) {
//        scheduleTokenRevalidation();

//        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>signed in");
//
////        await UserRepository.getUser();
////        _userBloc.add(UserReloaded());
////          await SharedPrefsHelper.setBoolValue(Constants.userIsAnonymous, false);

          yield Authenticated();
        } else {
//////        await UserRepository.signOut();
          yield Unauthenticated();
        }
      }


    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    await SecureStorageHelper.delete(Constants.authToken);
//    await SecureStorageHelper.delete(Constants.email);
//    await SecureStorageHelper.delete(Constants.refreshToken);

    yield Unauthenticated();
  }

}
