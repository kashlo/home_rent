import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/user.dart';

@immutable
abstract class UserFetchState {}

class UserFetchInitial extends UserFetchState {
}

class UserFetchSuccess extends UserFetchState {
  final User user;

  UserFetchSuccess(this.user);

  @override
  String toString() => 'UserFetchSuccess';
}

class UserFetchLoading extends UserFetchState {
  @override
  String toString() => 'UserFetchLoading';
}


class UserFetchError extends UserFetchState {
  @override
  String toString() => 'UserFetchError';
}
