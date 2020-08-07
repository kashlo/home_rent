import 'package:hellohome/core/api/properties.dart';
import 'package:hellohome/core/api/messages.dart';
import 'package:hellohome/core/models/chat.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/core/models/message.dart';
import 'package:hellohome/core/models/user.dart';
import 'package:hellohome/core/repositories/users.dart';

class MessagesRepository {
  static Future<List<Chat>> list() async{
//    ChatsApi
//    Map<Home, List<Message>> homeMessages = {};
    List<Chat> chats = [];


//    Chat chat = Chat(
////          home: Home.fromSnapshot(homeSnapshot),
//        fromUserId: snapshot.data['fromUserId'],
//        toUserId: snapshot.data['toUserId'],
//        messages: messagesSnapshots.map((snapshot) => Message.fromSnapshot(snapshot)).toList()
//    );

//    List<DocumentSnapshot> snapshots = await MessagesApi.listByUserId(userId); //find all messages nodes with user id
//    print(">>>list");
//    print(snapshots.length);
//    await Future.forEach(snapshots, (DocumentSnapshot snapshot) async {
//      DocumentSnapshot homeSnapshot = await PropertiesApi.get(snapshot['homeId']);
//
//      List<DocumentSnapshot> messagesSnapshots = await MessagesApi.list(snapshot.documentID);
//
//      Chat chat = Chat(
////          home: Home.fromSnapshot(homeSnapshot),
//          fromUserId: snapshot.data['fromUserId'],
//          toUserId: snapshot.data['toUserId'],
//          messages: messagesSnapshots.map((snapshot) => Message.fromSnapshot(snapshot)).toList()
//      );
//      DocumentSnapshot userSnapshot = await UserRepository.findById(chat.fromUserId);
//      chat.fromUser = User.fromSnapshot(userSnapshot);
//      chats.add(chat);
////      homeMessages.putIfAbsent(Home.fromSnapshot(homeSnapshot), () => messagesSnapshots.map((snapshot) => Message.fromSnapshot(snapshot)).toList());
////          List<DocumentSnapshot> homeSnapshots = await HomeApi.findByIds(snapshots.map<String>((e) => e.data['homeId']).toList());
//
//    });
    

//    print(snapshots.length);
//    List<DocumentSnapshot> homeSnapshots = await HomeApi.findByIds(snapshots.map<String>((e) => e.data['homeId']).toList());
//    print(homeSnapshots.length);
    return chats;
//    return snapshots.map<String>((item) => item.data["homeId"]).toList();
//    return snapshots.map((DocumentSnapshot snapshot) => Home.fromJson(snapshot.data)).toList();
  }

  static add({String fromUserId, String toUserId, String homeId, String message}) async{
//    List<DocumentSnapshot> docs = await MessagesApi.findByUserAndHome(userId: fromUserId, homeId: homeId);
//    if (docs.isNotEmpty) {
//      await MessagesApi.add(fromUserId: fromUserId, toUserId: toUserId, homeId: homeId, message: message, nodeId: docs.first.documentID);
//      docs.first.documentID;
//    } else {
//      await MessagesApi.add(fromUserId: fromUserId, toUserId: toUserId, homeId: homeId, message: message);
//
//    }

//    return snapshots.map((DocumentSnapshot snapshot) => Home.fromJson(snapshot.data)).toList();
  }
}