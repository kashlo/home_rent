import 'package:flutter/material.dart';
import 'package:hellohome/core/models/chat.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/core/models/message.dart';

class ChatDetailsScreen extends StatefulWidget {
  final Chat chat;
  @override
  _ChatDetailsScreenState createState() => _ChatDetailsScreenState();

  ChatDetailsScreen(this.chat);
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.chat.property.address),),
      body: Column(
        children: <Widget>[
Text(widget.chat.fromUser.firstName),
        Expanded(child: ListView(
            shrinkWrap: true,
            children: widget.chat.messages.map<Widget>((message) => buildMessage(message)).toList(),
          ),
        ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      labelText: "message"
                  ),
                ),
              ),
              FlatButton(child: Icon(Icons.send, color: Colors.deepOrangeAccent,),)
            ],
          )
//          Positioned(
//            bottom: 0,
//            left: 0,
//            right: 0,
//            child: Row(
//              children: <Widget>[
//                TextFormField(
//                  decoration: InputDecoration(
//                      labelText: "message"
//                  ),
//                ),
//                FlatButton(child: Icon(Icons.send, color: Colors.deepOrangeAccent,),)
//              ],
//            ),
//          )
        ],
      ),
    );
  }

  buildMessage(Message message) {
    return Text(message.body);
  }
}
