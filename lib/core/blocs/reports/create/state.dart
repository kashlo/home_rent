import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/property.dart';

@immutable
abstract class ReportCreateState {}

class ReportAddInitial extends ReportCreateState {
//  final List<ReportItem> bookingItems;

//  ReportInitial(this.bookingItems);
//  @override
//  List<Object> get props => ["ReportsInitial"];
}

class ReportCreateSuccess extends ReportCreateState {
//  final List<Home> homes;
//
//  HomeAddSuccess({@required this.homes});

  @override
  String toString() => 'HomeAddSuccess';
//
//  @override
//  List<Object> get props => ["Fetched"];
}

class ReportCreateLoading extends ReportCreateState {
//  final List<ReportItem> bookingItems;
//
//  ReportLoading(this.bookingItems);
  @override
  String toString() => 'ReportAddLoading';
//
//  @override
//  List<Object> get props => ["Error"];
}


class ReportCreateError extends ReportCreateState {
//  final List<ReportItem> bookingItems;
//
//  ReportError(this.bookingItems);

  @override
  String toString() => 'ReportAddError';
//
//  @override
//  List<Object> get props => ["Error"];
}
