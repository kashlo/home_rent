import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/user.dart';

@immutable
abstract class UserFetchEvent {
  const UserFetchEvent();
}

class UserFetchPressed extends UserFetchEvent {

  @override
  String toString() => 'UsersUpdatePressed';

  UserFetchPressed();
}


