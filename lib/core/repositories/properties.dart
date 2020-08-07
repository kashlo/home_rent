import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

import 'package:hellohome/core/api/properties.dart';
import 'package:hellohome/core/models/filter.dart';
import 'package:hellohome/core/models/property.dart';

class PropertiesRepository {

  static Future<List<Property>> list({SearchFilter searchFilter}) async {
    http.Response response = await PropertiesApi.list(searchFilter: searchFilter != null ? searchFilter.toJson() : null);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      List<Property> homes = responseBody["data"].map<Property>((item) {
        return Property.fromJson(item);
      }).toList();
      return homes;
    } else {
      throw PlatformException(
        code: 'HOME_FETCH_ERROR',
        message: 'Home fetch error',
      );
    }
  }

}