import 'dart:io';

import 'package:hellohome/core/api/base.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:http/http.dart' as http;

class UserPropertyApi {

  static Future<http.Response> list(String token) async {
    String uri = 'users/me/properties';
    http.Response response = await ApiBase.get(relativeUrl: uri, token: token);
    return response;
  }

  static Future<http.Response> create(Property property, List<File> images, String token) async {
    String uri = 'users/me/properties';
//    http.Response response = await ApiBase.postMultipart(uri: uri, body: property.toJson(), token: token);
    await ApiBase.postMultipart(uri: uri, body: property.toJson(), images: images, token: token);
//    return response;
  }

  static Future<http.Response> delete(int propertyId, String token) async {
    String uri = 'users/me/properties/$propertyId';
    http.Response response = await ApiBase.delete(uri: uri, token: token);
    return response;
  }

  static Future<http.Response> update(Property property, String token) async {
    String uri = 'users/me/properties/${property.id}';
    http.Response response = await ApiBase.put(uri: uri, body: property.toJson(), token: token);
    return response;
  }

}