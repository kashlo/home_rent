import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hellohome/core/api/favorites.dart';
import 'package:hellohome/core/helpers/constants.dart';
import 'package:hellohome/core/helpers/secure_storage.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:http/http.dart' as http;

class FavoritesRepository {
  static Future<List<Property>> list() async {
    String token = await SecureStorageHelper.get(Constants.authToken);

    http.Response response = await FavoriteApi.list(token);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      List<Property> properties = responseBody["data"].map<Property>((item) {
        return Property.fromJson(item);
      }).toList();
      return properties;
    } else {
      throw PlatformException(
        code: 'FAVS_FETCH_ERROR',
        message: 'Favorites fetch error',
      );
    }
  }

  static add({int propertyId}) async {
    String token = await SecureStorageHelper.get(Constants.authToken);

    http.Response response = await FavoriteApi.create(propertyId: propertyId, token: token);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      return Property.fromJson(responseBody["data"]);
    } else {
      throw PlatformException(
        code: 'FAVS_ADD_ERROR',
        message: 'Favorites add error',
      );
    }
  }

  static delete({int propertyId}) async {
    String token = await SecureStorageHelper.get(Constants.authToken);

    http.Response response = await FavoriteApi.delete(propertyId: propertyId, token: token);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);

    } else {
      throw PlatformException(
        code: 'FAVS_DELETE_ERROR',
        message: 'Favorites delete error',
      );
    }
  }

}