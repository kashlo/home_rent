import 'package:http/http.dart' as http;

import 'base.dart';

class FavoriteApi {
  static Future<http.Response> list(String token) async {
    String uri = 'users/me/favorites';
    http.Response response = await ApiBase.get(relativeUrl: uri, token: token);
    return response;
  }

  static Future<http.Response> create({int propertyId, String token}) async {
    String uri = 'users/me/favorites';
    http.Response response = await ApiBase.post(uri: uri, body: {"id": propertyId}, token: token);
    return response;
  }

  static Future<http.Response> delete({int propertyId, String token}) async {
    String uri = 'users/me/favorites/$propertyId';
    http.Response response = await ApiBase.delete(uri: uri, token: token);
    return response;
  }
}