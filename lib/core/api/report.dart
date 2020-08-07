import 'package:hellohome/core/models/report.dart';
import 'package:http/http.dart' as http;

import 'base.dart';

class ReportApi {
  static Future<http.Response> create(Report report) async {
    String uri = 'complaints';
    http.Response response = await ApiBase.post(uri: uri, body: report.toJson());
    return response;
  }
}