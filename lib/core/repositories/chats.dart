import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hellohome/core/api/chats.dart';
import 'package:hellohome/core/api/user_properties.dart';
import 'package:hellohome/core/models/chat.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:http/http.dart' as http;

class ChatsRepository {

  static Future<List<Chat>> list() async{
    http.Response response = await ChatsApi.list();
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      List<Chat> chats = responseBody["data"].map<Chat>((item) {
        return Chat.fromJson(item);
      }).toList();
      return chats;
    } else {
      throw PlatformException(
        code: 'CHATS_FETCH_ERROR',
        message: 'Chats fetch error',
      );
    }
  }

}