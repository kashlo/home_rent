import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/user.dart';

@immutable
abstract class UserUpdateEvent {
  const UserUpdateEvent();
}

class UserUpdatePressed extends UserUpdateEvent {
  final User user;

  @override
  String toString() => 'UsersUpdatePressed';

  UserUpdatePressed(this.user);
}


