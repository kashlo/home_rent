import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/models/user.dart';
import 'package:hellohome/core/repositories/users.dart';
import 'state.dart';
import 'event.dart';

class UserUpdateBloc extends Bloc<UserUpdateEvent, UserUpdateState> {
  UserUpdateBloc() : super(UserUpdateInitial());

  @override
  Stream<UserUpdateState> mapEventToState(UserUpdateEvent event) async* {
    if (event is UserUpdatePressed) {
      yield* _mapUserUpdatePressedToState(event.user);
    }
  }

  Stream<UserUpdateState> _mapUserUpdatePressedToState(User user) async*{
    yield UserUpdateLoading();
    try {

      await UsersRepository.update(user);
      yield UserUpdateSuccess();
    } catch(e) {
      print(e);
      yield UserUpdateError();
    }
  }

}

