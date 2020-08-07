import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hellohome/core/api/users.dart';
import 'package:hellohome/core/models/user.dart';
import 'package:http/http.dart' as http;

import 'base.dart';

class AuthApi {

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<http.Response> signInWithGoogle() async {

  }

  static Future<http.Response> signInOauth (User user) async {
    String uri = 'users/login';
    http.Response response = await ApiBase.post(uri: uri, body: user.toJson());
    return response;
  }

//  static Future<dynamic> loginWithFirebase(FacebookAccessToken accessToken) async{
//
//    final FirebaseAuth _auth = FirebaseAuth.instance;
//    final AuthCredential credential = FacebookAuthProvider.getCredential(
//      accessToken: accessToken.token,
//    );
//    final FirebaseUser firebaseUser = (await _auth.signInWithCredential(credential)).user;
//
//    print(">>>>>>>>>>>>>>>>>>>login");
//    print(firebaseUser.email);
//    print(firebaseUser.displayName);
//    print(firebaseUser.photoUrl);
//
//
//    assert(firebaseUser.email != null);
//    assert(firebaseUser.displayName != null);
//    assert(!firebaseUser.isAnonymous);
//    assert(await firebaseUser.getIdToken() != null);
//
//    final FirebaseUser currentUser = await _auth.currentUser();
//    assert(firebaseUser.uid == currentUser.uid);
//
//    DocumentSnapshot doc = await UserApi.getByFacebookId(accessToken.userId);
//    print(">>>>>>>>>>>>>user from firebase");
//    print(doc);
//
//    if (doc != null) {
//      print(doc.data);
//    } else {
//      User user = User(
////          id: firebaseUser.uid,
//          firstName: firebaseUser.displayName,
//          facebookId: accessToken.userId
//      );
//      await UserApi.add(user);
//    }
//
//
////    setState(() {
////    if (user != null) {
////    _message = 'Successfully signed in with Facebook. ' + user.uid;
////    } else {
////    _message = 'Failed to sign in with Facebook. ';
////    }
////    });
//  }
}