import 'package:flutter/foundation.dart';

@immutable
abstract class UserUpdateState {}

class UserUpdateInitial extends UserUpdateState {
}

class UserUpdateSuccess extends UserUpdateState {
//  final List<Home> homes;
//
//  UserUpdateFetched({@required this.homes});

  @override
  String toString() => 'UserUpdated';
}

class UserUpdateLoading extends UserUpdateState {
  @override
  String toString() => 'UserUpdateLoading Loading';
}


class UserUpdateError extends UserUpdateState {
  @override
  String toString() => 'UsersUpdateError';

}
