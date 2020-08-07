import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/chat.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/core/models/message.dart';

@immutable
abstract class ChatsListState {}

class ChatsListInitial extends ChatsListState {
//  final List<MessagesItem> bookingItems;

//  MessagesInitial(this.bookingItems);
//  @override
//  List<Object> get props => ["MessagessInitial"];
}

class ChatsListFetched extends ChatsListState {
  final List<Chat> chats;

  ChatsListFetched({@required this.chats});

  @override
  String toString() => 'Messages List Fetched';
//
//  @override
//  List<Object> get props => ["Fetched"];
}

class ChatsListLoading extends ChatsListState {
//  final List<MessagesItem> bookingItems;
//
//  MessagesLoading(this.bookingItems);
  @override
  String toString() => 'Chats List Loading';
//
//  @override
//  List<Object> get props => ["Error"];
}


class ChatsFetchError extends ChatsListState {
//  final List<MessagesItem> bookingItems;
//
//  MessagesError(this.bookingItems);

  @override
  String toString() => 'MessagesFetchError';
//
//  @override
//  List<Object> get props => ["Error"];
}
