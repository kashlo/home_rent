
import 'package:flutter/material.dart';
//import 'package:overlay_support/overlay_support.dart';
//import 'package:ozerly/theme.dart';
import 'package:flushbar/flushbar.dart';

import '../../theme.dart';

enum SnackBarType {
  info,
  error
}

class HelloHomeSnackBar {

  final BuildContext context;

  HelloHomeSnackBar(this.context);

  void show(String text, SnackBarType type) {
    Flushbar(
      message: text,
      backgroundColor: type == SnackBarType.error ? ThemeProvider.primaryAccent : Colors.grey,
      icon: type == SnackBarType.error ? Icon(Icons.error, color: Colors.white) : Icon(Icons.info, color: Colors.white),
      shouldIconPulse: false,
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
