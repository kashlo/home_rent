import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hellohome/core/api/report.dart';
import 'package:hellohome/core/models/report.dart';
import 'package:http/http.dart' as http;

class ReportsRepository {

  static create(Report report) async{
    http.Response response = await ReportApi.create(report);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
//      return Property.fromJson(responseBody["data"]);
    } else {
      throw PlatformException(
        code: 'REPORT_CREATE_ERROR',
        message: 'Report create error',
      );
    }
  }
}