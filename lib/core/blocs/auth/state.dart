import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticateInitial extends AuthenticationState {
}


class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';

}

class Anonymous extends AuthenticationState {
  @override
  String toString() => 'Anonymous';

}

class Authenticated extends AuthenticationState {
//  final String token;
////
//  Authenticated({this.token});

  @override
  String toString() => 'Authenticated';

}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';

}

class PhoneVerificationPending extends AuthenticationState {
  final String phoneNumber;
  final String countryCode;

  PhoneVerificationPending({this.phoneNumber, this.countryCode});

  @override
  String toString() => 'PhoneVerificationPending';

}
