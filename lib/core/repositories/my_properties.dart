import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hellohome/core/api/user_properties.dart';
import 'package:hellohome/core/helpers/constants.dart';
import 'package:hellohome/core/helpers/secure_storage.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:http/http.dart' as http;

class MyPropertiesRepository {

  static Future<List<Property>> list() async {
    String token = await SecureStorageHelper.get(Constants.authToken);

    http.Response response = await UserPropertyApi.list(token);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      List<Property> homes = responseBody["data"].map<Property>((item) {
        return Property.fromJson(item);
      }).toList();
      return homes;
    } else {
      throw PlatformException(
        code: 'HOME_FETCH_ERROR',
        message: 'Homes fetch error',
      );
    }
  }

  static Future<Property> create({Property property, List<File> images}) async {
    String token = await SecureStorageHelper.get(Constants.authToken);

    http.Response response = await UserPropertyApi.create(property, images, token);
//    if (response.statusCode == 200) {
//      Map<String, dynamic> responseBody = jsonDecode(response.body);
//      return Property.fromJson(responseBody["data"]);
//    } else {
//      throw PlatformException(
//        code: 'HOME_CREATE_ERROR',
//        message: 'Homes create error',
//      );
//    }
  }

  static Future<void> delete(int propertyId) async {
    String token = await SecureStorageHelper.get(Constants.authToken);

    http.Response response = await UserPropertyApi.delete(propertyId, token);
    if (response.statusCode != 200) {
      throw PlatformException(
        code: 'HOME_DELETE_ERROR',
        message: 'Homes update error',
      );
    }
  }

  static Future<void> update(Property home) async {
    String token = await SecureStorageHelper.get(Constants.authToken);

    http.Response response = await UserPropertyApi.update(home, token);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      return;
//      return Property.fromJson(responseBody["data"]);
    } else {
      throw PlatformException(
        code: 'HOME_UPDATE_ERROR',
        message: 'Homes update error',
      );
    }
  }

}