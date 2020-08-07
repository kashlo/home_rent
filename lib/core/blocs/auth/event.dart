import 'package:flutter/widgets.dart';

@immutable
abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class AuthenticationSkipped extends AuthenticationEvent {
  @override
  String toString() => 'AuthenticationSkipped';
}

class SignedIn extends AuthenticationEvent {

  final String token;
//  const SignedIn({@required this.token, @required this.email, @required this.refreshToken});
  const SignedIn({@required this.token});

  @override
  String toString() => 'LoggedIn';
}

class SignedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}



