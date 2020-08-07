import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:hellohome/ui/components/drawer.dart';
import 'package:hellohome/ui/properties/filters.dart';

import 'list.dart';
import 'map.dart';

class HomesListLayout extends StatefulWidget {
  @override
  _HomesListLayoutState createState() => _HomesListLayoutState();
}

class _HomesListLayoutState extends State<HomesListLayout>  with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  buildBody() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: false,
            tabs: [
              Tab(
                text: FlutterI18n.translate(context, "property_list.list"),
//                icon: Icon(Icons.list),
              ),
              Tab(
                text: FlutterI18n.translate(context, "property_list.map"),
//                icon: Icon(Icons.map),
              )
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "HELLO HOME",
                style: TextStyle(
                  fontFamily: "Rubik",
                  fontSize: 20,
                  fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent
                )
              ),
              SizedBox(width: 12),
              Image.asset("assets/launcher.png", height: 20, color: Colors.deepOrangeAccent,)
//              Icon(Icons.store, color: Colors.deepOrangeAccent,),

            ],
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton( icon: Icon(Icons.filter_list), onPressed: showFilterDialog,)
          ],
        ),
        drawer: HelloHomeDrawer(),
//        floatingActionButton: FloatingActionButton(
//          child: Icon(Icons.map),
//          onPressed: showMapView,
//        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            PropertyListScreen(),
            PropertiesMapScreen(),
          ],
        ),
      ),
    );
  }

  showFilterDialog(){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return FiltersScreen();
        }
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(">>>>>>>>>>>>>>>>>${state.toString()}");

    if (state == AppLifecycleState.resumed) {
      print(">>>>>>>>>>>>>>>>>resumed");
//      controller.setMapStyle("[]");
    }
  }
}
