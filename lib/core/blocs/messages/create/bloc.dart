import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/blocs/messages/create/state.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/core/repositories/messages.dart';
import 'package:hellohome/core/repositories/my_properties.dart';

import 'event.dart';

class MessageCreateBloc extends Bloc<MessageCreateEvent, MessageCreateState> {
  MessageCreateBloc() : super(MessageCreateInitial());

  @override
  Stream<MessageCreateState> mapEventToState(MessageCreateEvent event) async* {
    if (event is MessageCreatePressed) {
      yield* _mapMessageCreatePressedToState(event.home, event.message);
    }
  }

  Stream<MessageCreateState> _mapMessageCreatePressedToState(Property home, String message) async*{
    yield MessageCreateLoading();
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final FirebaseUser currentUser = await _auth.currentUser();
      print(">>>>>>>>>>>>>>>>>>~~~~~~~~~~~");
      print(home.userId);

      await MessagesRepository.add(
          fromUserId: currentUser.uid,
//          toUserId: home.userId,
//          homeId: home.id,
          message: message);
      yield MessageCreateSuccess();
    } catch(e) {
      print(e);
      yield MessageCreateError();
    }
  }

}

