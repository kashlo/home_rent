import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hellohome/core/api/auth.dart';
import 'package:hellohome/core/helpers/constants.dart';
import 'package:hellohome/core/helpers/shared_prefs.dart';
import 'package:hellohome/core/models/user.dart';
import 'package:http/http.dart' as http;

class AuthRepository {

  static Future<Map<String, dynamic>> facebookSignIn() async {
    print(">>>>>>>>>>signInWithFacebook");

    final facebookLogin = FacebookLogin();
//    facebookLogin.logOut();

    final result = await facebookLogin.logIn(['email', 'public_profile', 'user_gender', 'user_link', 'user_photos', 'user_birthday', 'user_location']);
//    , 'picture', 'user_gender', 'user_link', 'user_location'
//    , 'first_name', 'last_name'
    print(">>>>>>>>>>signInWithFacebook result");
    print(result.accessToken.token);
    print(result.accessToken.expires);
    print(result.accessToken.userId);
    print(result.accessToken.permissions);

    print(result.status);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final graphResponse = await http.get(
//            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,location,link,picture&access_token=${result.accessToken.token}'
            'https://graph.facebook.com/v2.12/${result.accessToken.userId}?fields=name,first_name,last_name,email,location,birthday,link,picture,photos,gender&access_token=${result.accessToken.token}'

        );
        final profile = json.decode(graphResponse.body);
        User user = User(
          firstName: profile["first_name"],
          lastName: profile["last_name"],
          email: profile["email"],
          pictureUrl: profile["picture"]["data"]["url"],
          providerId: result.accessToken.userId,
          provider: Constants.oauthProviderFacebook,

        );
        http.Response response = await AuthApi.signInOauth(user);

        if (response.statusCode == 200) {
          Map<String, dynamic> responseBody = jsonDecode(response.body);
          String token = responseBody["data"]["token"];
          User user = User.fromJson(responseBody["data"]["user"]);
          Map<String, dynamic> data = {"token": token, "user": user};
          return data;
//          SharedPrefsHelper.setString(Constants.authToken, token);
        } else {
          throw PlatformException(
            code: 'SIGN_IN_ERROR',
            message: 'Sign in error',
          );
        }
//        await loginWithFirebase(result.accessToken);

//        _sendTokenToServer(result.accessToken.token);
//        _showLoggedInUI();
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("canceled  >>>");
//        return;
//        _showCancelledMessage();
        break;
      case FacebookLoginStatus.error:
        print("error >>>");
        print(result.errorMessage);
        throw PlatformException(
          code: 'SIGN_IN_ERROR',
          message: result.errorMessage,
        );
//        _showErrorOnUI(result.errorMessage);
        break;
    }

//    http.Response response = await ReportApi.create(report);
//
//    if (response.statusCode == 200) {
//      Map<String, dynamic> responseBody = jsonDecode(response.body);
////      return Property.fromJson(responseBody["data"]);
//    } else {
//      throw PlatformException(
//        code: 'REPORT_CREATE_ERROR',
//        message: 'Report create error',
//      );
//    }
  }

  googleSignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
//
//    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
//    print("signed in " + user.displayName);
//    return user;
  }

}