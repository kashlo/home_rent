import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/models/user.dart';
import 'package:hellohome/core/repositories/users.dart';
import 'state.dart';
import 'event.dart';

class UserFetchBloc extends Bloc<UserFetchEvent, UserFetchState> {
  UserFetchBloc() : super(UserFetchInitial());

  @override
  Stream<UserFetchState> mapEventToState(UserFetchEvent event) async* {
    if (event is UserFetchPressed) {
      yield* _mapUserFetchPressedToState();
    }
  }

  Stream<UserFetchState> _mapUserFetchPressedToState() async*{
    yield UserFetchLoading();
    try {

      User user = await UsersRepository.get();
      yield UserFetchSuccess(user);
    } catch(e) {
      print(e);
      yield UserFetchError();
    }
  }

}

