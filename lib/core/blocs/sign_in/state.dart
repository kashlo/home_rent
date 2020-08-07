import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/property.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {
//  final List<HomesItem> bookingItems;

//  HomesInitial(this.bookingItems);
//  @override
//  List<Object> get props => ["HomessInitial"];
}

class SignInSuccess extends SignInState {
//  final List<Home> homes;
//
//  SignInSuccess({@required this.homes});

  @override
  String toString() => 'SignInSuccess';
//
//  @override
//  List<Object> get props => ["Fetched"];
}

class SignInLoading extends SignInState {
//  final List<HomesItem> bookingItems;
//
//  HomesLoading(this.bookingItems);
  @override
  String toString() => 'Homes List Loading';
//
//  @override
//  List<Object> get props => ["Error"];
}


class SignInError extends SignInState {
//  final List<HomesItem> bookingItems;
//
//  HomesError(this.bookingItems);

  @override
  String toString() => 'HomesFetchError';
//
//  @override
//  List<Object> get props => ["Error"];
}
