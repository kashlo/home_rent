import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hellohome/core/api/facilities.dart';
import 'package:hellohome/core/models/facility.dart';
import 'package:http/http.dart' as http;

class FacilitiesRepository {
  static Future<List<Facility>> list() async{
    http.Response response = await FacilitiesApi.list();
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      List<Facility> facilities = responseBody["data"].map<Facility>((item) {
        return Facility.fromJson(item);
      }).toList();
      return facilities;
    } else {
      throw PlatformException(
        code: 'FETCH_ERROR',
        message: 'Facilities fetch error',
      );
    }
  }
}