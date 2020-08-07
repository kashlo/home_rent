import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hellohome/core/helpers/constants.dart';
import 'package:hellohome/core/models/chat.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/core/models/message.dart';
import 'package:hellohome/core/models/user.dart';
//import 'package:socket_io/socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class ChatScreen extends StatefulWidget {
//  final Property home;
//  final int userId;
//  final  List<Message> messages;
  final Chat chat;

  @override
  _ChatScreenState createState() => _ChatScreenState();

  ChatScreen({this.chat});
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  List<Message> messages = [];
  FirebaseUser user;

  @override
  void initState() {
    if (widget.chat.messages != null) {
      widget.chat.messages.forEach((message) {  messages.add(message) ; });
      setState(() {

      });
    }

    socketStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = User(id: 1);

    return Scaffold(
      appBar: AppBar(
        title: Text("Чат: ${widget.chat.property.address}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
//              crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisAlignment: MainAxisAlignment.start,
              children: messages.map((m) => Row(
                mainAxisAlignment: m.fromUserId == user.id ?  MainAxisAlignment.start : MainAxisAlignment.end,
                children: <Widget>[
                  Container(

//                    alignment: m.fromUserId == user.uid ? Alignment.centerRight : Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: m.fromUserId == user.id ? Colors.grey.withOpacity(0.3) : Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(m.body),
                  ),
                ],
              )).toList(),
            ),
            Form(
              key: formKey,
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Сообщение не может быть пустым';
                  }
                  return null;
                },
                controller: messageController,
                decoration: InputDecoration(labelText: 'Сообщение'),
              ),
            ),
//            StreamBuilder(
//              stream: channel.stream,
//              builder: (context, snapshot) {
////                snapshot.data
//                return Padding(
//                  padding: const EdgeInsets.symmetric(vertical: 24.0),
//                  child: Text(snapshot.hasData ? '${snapshot.data.}' : ''),
//                );
//              },
//            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  socketStart() async {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>socketStart");

    Constants.socket.on('error', (error) {
      print('error');
      print(error);
    });

    Constants.socket.on('connect_error', (error) {
      print('connect_error');
      print(error);
    });

    Constants.socket.on('connect_timeout', (_) {
      print('connect_timeout');
    });

    Constants.socket.on('connect', (_) {

        print('connect');
        Constants.socket.on('hhmsg', (msg) {
          print('message received>>');
          print(msg);
          Map<String, dynamic> json = jsonDecode(msg);
          Message message = Message(body: json["msg"], fromUserId: json["userId"]);
          messages.add(message);
          setState(() {});
          //        socket.emit('msg', 'connect');
        });
//        socket.emit('msg', 'connect');
      });

    Constants.socket.on('event', (data) => print(data));
    Constants.socket.on('disconnect', (_) => print('disconnect'));
    Constants.socket.on('fromServer', (_) => print(_));
    Constants.socket.connect();
//print(socket.connected);

  }

  void _sendMessage() async {
    if (formKey.currentState.validate()) {
      print("message send>>");

//      DocumentReference chat;
//
//      QuerySnapshot querySnapshot = await Firestore.instance.collection("chats")
//          .where('userId', isEqualTo: widget.userId != null ? widget.userId : user.uid )
//          .where('homeId', isEqualTo: widget.home.id).getDocuments();
//
//      if (querySnapshot.documents.length > 0) {
//        chat = querySnapshot.documents.first.reference;
//      } else {
//        chat = await Firestore.instance.collection("chats").add({'userId': user.uid, 'homeId': widget.home.id}, );
//      }
//      chat.collection("messages").add({"message": messageController.text, "userId": user.uid});

      String chatCreator;

//      if (widget.userId != null) {
//        chatCreator = widget.userId;
//      } else {
//        chatCreator = user.uid;
//      }

//      String msgEncoded = json.encode({
//        'homeId': widget.home.id,
//        'msg': messageController.text,
//        'userId': user.uid,
//        'roomCreator': widget.userId
//      }
//        );
//      Constants.socket.emit("hhmsg", msgEncoded);
//      messageController.clear();
    }

//    if (_controller.text.isNotEmpty) {
//      channel.sink.add(_controller.text);
//    }
  }
//
  @override
  void dispose() {
    print(">>>>>>>>>>>>>>>>>close");
    Constants.socket.disconnect();
    Constants.socket.close();
    Constants.socket.destroy();
    Constants.socket.clearListeners();
//    socket = null;
//    channel.sink.close();
    super.dispose();
  }
}