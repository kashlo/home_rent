import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hellohome/core/api/users.dart';
import 'package:hellohome/core/helpers/constants.dart';
import 'package:hellohome/core/helpers/secure_storage.dart';
import 'package:hellohome/core/models/user.dart';
import 'package:http/http.dart' as http;

class UsersRepository {

  static Future<User> get() async {
    String token = await SecureStorageHelper.get(Constants.authToken);

    http.Response response = await UsersApi.get(token);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      return User.fromJson(responseBody["data"]);
    } else {
      throw PlatformException(
        code: 'USER_FETCH_ERROR',
        message: 'User fetch error',
      );
    }
  }


  static Future<User> update(User user) async {
    String token = await SecureStorageHelper.get(Constants.authToken);

    http.Response response = await UsersApi.update(user, token);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
//      return User.fromJson(responseBody["data"]);

    } else {
      throw PlatformException(
        code: 'HOME_UPDATE_ERROR',
        message: 'Homes update error',
      );
    }
  }

}