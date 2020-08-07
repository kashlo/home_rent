import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:hellohome/core/blocs/chats/list/bloc.dart';
import 'package:hellohome/core/blocs/chats/list/event.dart';
import 'package:hellohome/core/blocs/chats/list/state.dart';
import 'package:hellohome/core/models/chat.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/core/models/message.dart';
import 'package:hellohome/core/repositories/properties.dart';
import 'package:hellohome/core/repositories/my_properties.dart';
import 'package:hellohome/ui/chats/chat.dart';
import 'package:hellohome/ui/components/snack_bar.dart';

import '../../theme.dart';
import '../components/drawer.dart';
import 'details.dart';

class MessagesScreen extends StatefulWidget {

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  List<Chat> chats = [];

  @override
  void initState() {
    context.bloc<ChatsListBloc>().add(ChatsListRequested());
    getChats();
    super.initState();
  }

  getChats() async{
//    final FirebaseAuth _auth = FirebaseAuth.instance;
//    FirebaseUser user = await _auth.currentUser();
//
//    List<Property> homes = await MyPropertiesRepository.list();
//    await Future.forEach(homes, (Property home) async {
//
//      QuerySnapshot querySnapshot = await Firestore.instance.collection("chats").where('homeId', isEqualTo: home.id).getDocuments();
//      List<DocumentSnapshot> chatsSnapshots = querySnapshot.documents;
//      await Future.forEach(chatsSnapshots, (DocumentSnapshot ds) async {
//        QuerySnapshot querySnapshotChats = await Firestore.instance.collection("chats").document(ds.documentID).collection("messages").getDocuments();
//        List<Message> messages = querySnapshotChats.documents.map((doc) => Message.fromSnapshot(doc)).toList();
//        print(">>>>>>>>>>>>>messages21");
//        print(messages);
//        messages.forEach((element) { print(element.fromUserId); });
//
////        Home home = await HomesRepository.findByIds(ds["homeId"]);
//        Chat chat = Chat(propertyId: ds["homeId"], fromUserId: ds["userId"], home: home, messages: messages);
//        chats.add(chat);
//      } );
//    });
//
//
//      QuerySnapshot querySnapshot = await Firestore.instance.collection("chats").where('userId', isEqualTo: user.uid).getDocuments();
//      List<DocumentSnapshot> chatsSnapshots = querySnapshot.documents;
//      await Future.forEach(chatsSnapshots, (DocumentSnapshot ds) async {
//        QuerySnapshot querySnapshotChats = await Firestore.instance.collection("chats").document(ds.documentID).collection("messages").getDocuments();
//        List<Message> messages = querySnapshotChats.documents.map((doc) => Message.fromSnapshot(doc)).toList();
//        print(">>>>>>>>>>>>>messages!");
//        print(messages);
//        messages.forEach((element) { print(element.fromUserId); });
//        List<Property> home = await PropertiesRepository.findByIds([ds["homeId"]]);
//        Chat chat = Chat(propertyId: ds["homeId"], fromUserId: ds["userId"], home: home.first, messages: messages);
//        chats.add(chat);
//      } );
//
//    
//    setState(() {
//      
//    });
//

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Сообщения"),),
      drawer: HelloHomeDrawer(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return BlocConsumer<ChatsListBloc, ChatsListState>(
        listener: (context, state) {
          if (state is ChatsFetchError) {
            HelloHomeSnackBar(context).show(FlutterI18n.translate(context, "property_list.errors.fetchError"), SnackBarType.error);
          }
        },
        builder: (context, state) {
          if (state is ChatsListLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ChatsListFetched) {

            return ListView(
                children: state.chats.map<Widget>((chat) => buildChat(chat)).toList()
            );
          }

          return Container();
        }
    );

    
//    return BlocBuilder<MessagesListBloc, MessagesListState>(
//        builder: (context, state) {
//          if (state is MessagesListLoading) {
//            return Center(child: CircularProgressIndicator());
//          }
//          if (state is MessagesListFetched) {
////            List<Widget> widgets = [];
////            state.chats.forEach((key, value)  {
////              widgets.add(buildHomeMessages(key, value));
////            });
//
//            return ListView(
//                children: state.chats.map<Widget>((chat) => buildHomeMessages(chat)).toList()
//            );
//          }
//          return Container();
//        }
//    );
  }

  Widget buildChat(Chat chat) {
    return InkWell(
      onTap: () => openChatScreen(chat: chat),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            width: 100,
            height: 100,
            color: ThemeProvider.lightGrey,
            child: Center(
              child: Image.asset(
                chat.property.image,
//                width: 50, height: 50,
                fit: BoxFit.contain,
//                color: Colors.white.withOpacity(0.5)
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(chat.property.address, style: TextStyle(fontSize: 18),),
              Text(chat.fromUserId.toString(), style: TextStyle(fontSize: 16),),
              Text(chat.messages.last.body, style: TextStyle(fontSize: 18),),

            ],
          )
        ],
      ),
    );
  }

  openChatScreen({Chat chat}) {
    Navigator.push (
      context,
      MaterialPageRoute(builder: (context) => ChatScreen(chat: chat,)),
    );
//    return showDialog(
//        context: context,
//        barrierDismissible: true,
//        builder: (BuildContext context) {
//          return RequestDialog(widget.home);
//        }
//    );
  }

//  openChatDetails(Chat chat) {
//    Navigator.push (
//      context,
//      MaterialPageRoute(builder: (context) => ChatDetailsScreen(chat)),
//    );
//  }
}
