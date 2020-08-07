
import 'package:flutter/foundation.dart';

class Message {
  int id;
  String body;
  int fromUserId;
  DateTime createdAt;
//  String facebookId;

  Message({
    this.id,
    @required this.body,
    this.fromUserId,
    this.createdAt
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      body: json['body'],
      fromUserId: json['userId'],
      createdAt: DateTime.parse(json['createdAt'])
    );
  }

  Map<String, dynamic> toJson() {
    return       {
      'id': id,
      'message': body,
    };
  }
}