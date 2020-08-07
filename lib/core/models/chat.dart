import 'package:hellohome/core/models/message.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/core/models/user.dart';

class Chat {
  int id;
  Property property;
  List<Message> messages;
  int fromUserId;
  int toUserId;
  int propertyId;
  User fromUser;
  User toUser;

  Chat({
    this.id,
//    this.home,
    this.messages,
    this.fromUserId,
    this.toUserId,
    this.propertyId,
    this.property
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json["id"],
      fromUserId: json['fromUserId'],
      toUserId: json['fromUserId'],
      propertyId: json['propertyId'],
      property: Property.fromJson(json['property']),
      messages: json["messages"].map<Message>((item) => Message.fromJson(item)).toList()
    );
  }
}