import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/blocs/properties/list/state.dart';
import 'package:hellohome/core/blocs/chats/list/state.dart';
import 'package:hellohome/core/models/chat.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/core/models/message.dart';
import 'package:hellohome/core/repositories/chats.dart';
import 'package:hellohome/core/repositories/properties.dart';
import 'package:hellohome/core/repositories/messages.dart';

import 'event.dart';

class ChatsListBloc extends Bloc<ChatsListEvent, ChatsListState> {
  ChatsListBloc() : super(ChatsListInitial());

  @override
  Stream<ChatsListState> mapEventToState(ChatsListEvent event) async* {
    if (event is ChatsListRequested) {
      yield* _mapChatsListRequestedToState();
    }
  }

  Stream<ChatsListState> _mapChatsListRequestedToState() async*{
    yield ChatsListLoading();
//    try {

      List<Chat> chats = await ChatsRepository.list();
//      print(homes);
//      Map<Home, List<Message>> homeMessages = {};

//      homes.forEach((homeSnapshot) { homeMessages.putIfAbsent(Home.fromSnapshot(homeSnapshot), () => []); });
      yield ChatsListFetched(chats: chats);
//    } catch(e) {
//      print(e);
//      yield MessagesFetchError();
//    }
  }

}

