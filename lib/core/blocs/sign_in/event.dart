import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/property.dart';

@immutable
abstract class SignInEvent {
  const SignInEvent();
}

class FacebookSignInPressed extends SignInEvent {

//  final Home home;

  @override
  String toString() => 'SignInPressed';

//  HomesAddPressed(this.home);
}

class GoogleSignInPressed extends SignInEvent {

//  final Home home;

  @override
  String toString() => 'GoogleSignInPressed';

//  HomesAddPressed(this.home);
}

class SignInSkippedPressed extends SignInEvent {


  @override
  String toString() => 'SignInSkippedPressed';
}


