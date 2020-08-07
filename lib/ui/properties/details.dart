import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hellohome/core/helpers/marker_icon.dart';
import 'package:hellohome/core/models/facility.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/ui/chats/chat.dart';
import 'package:hellohome/ui/components/report_dialog.dart';

import 'gallery.dart';

class PropertyDetailsScreen extends StatefulWidget {

  final Property home;

  @override
  _PropertyDetailsScreenState createState() => _PropertyDetailsScreenState();

  PropertyDetailsScreen(this.home);
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {

  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor markerIcon;
  FirebaseUser user;
  int currentPhotoIndex = 1;

  @override
  void initState() {
    getUser();
    getMarkerIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildChatButton(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 220.0,
            floating: false,
            pinned: true,
            stretch: true,
            elevation: 50,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    PageView(
                      onPageChanged: (int pageIdx) {
                        setState(() {
                          currentPhotoIndex = pageIdx;
                        });
                      },
                      children: widget.home.images.map<Widget>((image) => Image.asset(
                        image,
                        fit: BoxFit.cover,
                      )).toList(),
                    ),
                    buildReportButton(),
                    Positioned(
                      bottom: 20,
                      right: 0,
                      left: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "$currentPhotoIndex/${widget.home.images.length}",
                            style: TextStyle(color: Colors.white),
                          ),
                          RawMaterialButton(
                              fillColor: Colors.white,
                              shape: CircleBorder(),
                              onPressed: openGallery,
                              child: Icon(Icons.image, size: 20, color: Colors.deepOrangeAccent
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ),
           SliverList(
            delegate:  SliverChildListDelegate([buildBody()])
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(widget.home.address, style: TextStyle(fontSize: 22),),
              Text("${widget.home.price.toString()}₴", style: TextStyle(fontSize: 20)),
            ],
          ),
          SizedBox(height: 20,),
          Text(widget.home.description, style: TextStyle(fontSize: 14)),
          SizedBox(height: 20,),
          Text("Этаж ${widget.home.floor}", style: TextStyle(fontSize: 14)),
          Text("Площадь ${widget.home.square}м\u00B2", style: TextStyle(fontSize: 14)),
          Divider(),
          Text("Техника", style: TextStyle(fontSize: 20),),
          SizedBox(height: 10,),
          widget.home.facilities != null ? Column(
            children: widget.home.facilities.map<Widget>((facility) {
              return buildFacility(facility);
            }).toList()
          ) : Container(),
          SizedBox(height: 20,),
          buildRules(),
          buildMap()
        ],
      ),
    );
  }

  buildFacility(Facility facility){
    return Row(
      children: <Widget>[
        Image.asset("assets/icons/${facility.name}.png", width: 20,),
        Text(FlutterI18n.translate(context, "general.facilities.${facility.name}")),
      ],
    );
  }

   openChatScreen() {
//     Navigator.push (
//       context,
//       MaterialPageRoute(builder: (context) => ChatScreen(home: widget.home)),
//     );
  }

  buildMap() {
    if (widget.home.lat != null && widget.home.lng != null) {
      LatLng cameraPosition = LatLng(widget.home.lat, widget.home.lng);

      return Container(
        height: 200,
        child: GoogleMap(
          mapType: MapType.terrain,
          myLocationButtonEnabled: true,
          zoomGesturesEnabled: true,
          tiltGesturesEnabled: true,
          markers: createMarker(),
          initialCameraPosition: CameraPosition(target: cameraPosition, zoom: 14.4746),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      );
    }
    return Container();
  }

  Set<Marker> createMarker() {
    LatLng cameraPosition = LatLng(widget.home.lat, widget.home.lng);

    return <Marker>[
      Marker(
        markerId: MarkerId("marker_1"),
        position: cameraPosition,
        icon: markerIcon,
      ),
    ].toSet();
  }


  void showReportDialog(){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ReportDialog(widget.home);
      }
    );
  }

  getMarkerIcon() async {
    markerIcon = BitmapDescriptor.fromBytes(await Helper.selectedMarkerIcon());
    setState(() {});
  }

  void openGallery() {
    Navigator.push (
      context,
      MaterialPageRoute(builder: (context) => PropertyGalleryScreen(widget.home)),
    );
  }

  buildChatButton() {
    if (user!= null && widget.home.userId != user.uid) {
      return FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: openChatScreen,
      );
    }
    return Container();

  }

  void getUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    user = await _auth.currentUser();
    setState(() {

    });
  }

  Widget buildRules() {
    return Column(
      children: <Widget>[
        Text("Правила", style: TextStyle(fontSize: 20),),
        widget.home.animalsAllowed ? Text("Можно с животными", ) : Container(),
        widget.home.childrenAllowed ? Text("Можно с детьми", ) : Container()

      ],
    );
  }

  Widget buildReportButton() {
    return Positioned(
      top: 20,
      right: 0,
      child: SafeArea(
        child: RawMaterialButton(
          fillColor: Colors.white,
          shape: CircleBorder(),
          onPressed: showReportDialog,
          child: Icon(Icons.report, size: 20, color: Colors.deepOrangeAccent)
        ),
      ),
    );
  }

}
