import 'package:hellohome/core/models/user.dart';
import 'package:http/http.dart' as http;

import 'base.dart';

class UsersApi {

  static Future<http.Response> get(String token) async {
    String uri = 'users/me';
    http.Response response = await ApiBase.get(relativeUrl: uri, token: token);
    return response;
  }

  static Future<http.Response> update(User user, String token) async {
    String uri = 'users/me';
    http.Response response = await ApiBase.put(uri: uri, body: user.toJson(), token: token);
    return response;
  }

}