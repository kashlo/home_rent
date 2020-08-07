import 'package:flutter/foundation.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/core/models/report.dart';

@immutable
abstract class ReportAddEvent {
  const ReportAddEvent();
}

class ReportCreatePressed extends ReportAddEvent {

  final Report report;

  @override
  String toString() => 'ReportAddPressed';

  ReportCreatePressed(this.report);
}


