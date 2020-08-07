import 'package:http/http.dart' as http;

import 'base.dart';

class ChatsApi {
  static Future<http.Response> list() async {
    String uri = 'users/me/chats';
    http.Response response = await ApiBase.get(relativeUrl: uri);
    return response;
  }
}