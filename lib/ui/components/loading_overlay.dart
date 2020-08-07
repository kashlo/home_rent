import 'package:flutter/material.dart';

class LoadingOverlay {
  static Future<void> show(BuildContext context, GlobalKey key) async {
    return showDialog<void>(
//      useRootNavigator: false,

        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          print(">>>>>>>>>>>>>loading dialog!");
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  children: <Widget>[
                    Center(
                      child: Column(
                          children: [
                            CircularProgressIndicator(),
                          ]
                      ),
                    )
                  ]
              )
          );
        }
    );
  }
}