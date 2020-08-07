import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/property.dart';

@immutable
abstract class MessageCreateState {}

class MessageCreateInitial extends MessageCreateState {
//  final List<HomesItem> bookingItems;

//  HomesInitial(this.bookingItems);
//  @override
//  List<Object> get props => ["HomessInitial"];
}

class MessageCreateSuccess extends MessageCreateState {
//  final List<Home> homes;
//
//  MessageCreateSuccess({@required this.homes});

  @override
  String toString() => 'MessageCreateSuccess';
//
//  @override
//  List<Object> get props => ["Fetched"];
}

class MessageCreateLoading extends MessageCreateState {
//  final List<HomesItem> bookingItems;
//
//  HomesLoading(this.bookingItems);
  @override
  String toString() => 'MessageCreateLoading';
//
//  @override
//  List<Object> get props => ["Error"];
}


class MessageCreateError extends MessageCreateState {
//  final List<HomesItem> bookingItems;
//
//  HomesError(this.bookingItems);

  @override
  String toString() => 'MessageCreateError';
//
//  @override
//  List<Object> get props => ["Error"];
}
