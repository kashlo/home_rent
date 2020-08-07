import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:hellohome/core/blocs/auth/bloc.dart';
import 'package:hellohome/core/blocs/auth/event.dart';
import 'package:hellohome/core/blocs/sign_in/bloc.dart';
import 'package:hellohome/core/blocs/sign_in/event.dart';
import 'package:hellohome/theme.dart';

class SignInScreen extends StatefulWidget {
  final bool fromDashboard;

  @override
  _SignInScreenState createState() => _SignInScreenState();

  SignInScreen({this.fromDashboard});
}

class _SignInScreenState extends State<SignInScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset("assets/launcher.png", width: 100, height: 100,),
          SizedBox(height: 10,),

          Text(
            "Hello Home",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Rubik",
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: Colors.deepOrangeAccent
            )
          ),
          SizedBox(height: 70,),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 15),
            color: ThemeProvider.facebookBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/icons/facebook.png", width: 20, color: Colors.white,),
                SizedBox(width: 10,),
                Text(FlutterI18n.translate(context, "sign_in.facebook_login"), style: TextStyle(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),),
              ],
            ),
            onPressed: fbLogin,
          ),
          SizedBox(height: 20,),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 15),
            color: ThemeProvider.primaryAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/icons/google.png", width: 20, color: Colors.white,),
                SizedBox(width: 10,),

                Text(FlutterI18n.translate(context, "sign_in.google_login"), style: TextStyle(
                    color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),),
              ],
            ),
            onPressed: googleLogin,
          ),
          FlatButton(
            highlightColor: Colors.transparent,
//            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            child: Text(
              "Пропустить",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey
              )
            ),
            onPressed: skipLogin,
          )
        ],
      ),
    );
  }

  void fbLogin() async {
    context.bloc<SignInBloc>().add(FacebookSignInPressed());
  }

  void googleLogin() async {
    context.bloc<SignInBloc>().add(GoogleSignInPressed());

  }

  void skipLogin() {
    if (widget.fromDashboard) {
      Navigator.pop(context);
    } else {
      context.bloc<AuthenticationBloc>().add(AuthenticationSkipped());
    }
  }
}
