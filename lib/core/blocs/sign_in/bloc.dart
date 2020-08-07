import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/api/auth.dart';
import 'package:hellohome/core/blocs/auth/bloc.dart';
import 'package:hellohome/core/blocs/auth/event.dart';
import 'package:hellohome/core/blocs/sign_in/event.dart';
import 'package:hellohome/core/blocs/sign_in/state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hellohome/core/helpers/constants.dart';
import 'package:hellohome/core/helpers/secure_storage.dart';
import 'package:hellohome/core/repositories/auth.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {

  AuthenticationBloc authBloc;

  SignInBloc(this.authBloc) : super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is FacebookSignInPressed) {
      yield* _mapFacebookSignInPressedToState();
    } else if (event is GoogleSignInPressed) {
      yield* _mapGoogleSignInPressedToState();

    } else if (event is SignInSkippedPressed) {
      yield* _mapSignInSkippedPressedToState();

    }
  }

  Stream<SignInState> _mapFacebookSignInPressedToState() async* {
    print(">>>");
    yield SignInLoading();
    try {
      Map<String, dynamic> data = await AuthRepository.facebookSignIn();
      authBloc.add(SignedIn(token: data["token"]));
      yield SignInSuccess();
    } catch(e) {
      print(e);
      yield SignInError();
    }
  }

  Stream<SignInState> _mapGoogleSignInPressedToState() async*{
    yield SignInLoading();
    try {
      await AuthApi.signInWithGoogle();
      authBloc.add(SignedIn());
//      await HomesRepository.add(home);
//      yield SignInSuccess();
    } catch(e) {
      print(e);
      yield SignInError();
    }
  }


  Stream<SignInState> _mapSignInSkippedPressedToState() async* {
    print(">>>>>>skipped");
    yield SignInLoading();
    try {
//      await HomesRepository.add(home);
      yield SignInSuccess();
    } catch(e) {
      print(e);
      yield SignInError();
    }
  }

}

