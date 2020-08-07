import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  buildBody() {
    return Center(
//        child: FlareActor("assets/images/Penguin.flr",
////            alignment: Alignment.center,
//            isPaused: false,
////            fit: BoxFit.cover,
//            animation: "walk",
////            controller: this
//        )
//      child: FlareActor(
//          "assets/images/test3.flr",
//      isPaused: false,
//
////          alignment:Alignment.center,
////          fit: BoxFit.contain,
//          animation: "test"
//      ),
        child: Image.asset("assets/launcher.png", width: 100, height: 100,)
    );
  }
}
