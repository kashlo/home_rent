
import 'dart:async';
import 'dart:typed_data';
import 'package:location_permissions/location_permissions.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hellohome/core/blocs/properties/list/bloc.dart';
import 'package:hellohome/core/blocs/properties/list/state.dart';
import 'package:hellohome/core/helpers/constants.dart';
import 'package:hellohome/core/helpers/marker_icon.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/ui/properties/filters.dart';
import 'package:hellohome/theme.dart';

import 'details.dart';

class PropertiesMapScreen extends StatefulWidget  {
  @override
  _PropertiesMapScreenState createState() => _PropertiesMapScreenState();
}

class _PropertiesMapScreenState extends State<PropertiesMapScreen>  with WidgetsBindingObserver{
//  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
//  GoogleMapController _controller;
  LatLng cameraPosition = Constants.kievCenter;

  BitmapDescriptor markerIcon;
  BitmapDescriptor selectedMarkerIcon;
  PageController pageViewController = PageController(
    viewportFraction: 0.8,
    initialPage: 0,
  );
  int selectedMarkerIdx = 0;
  List<Property> homes;
  Set<Marker> markers;
   Polygon polygon;

  @override
  void initState() {
//    controller = await _controller.future;
    requestLocation();
    getMarkerIcon();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 3, color: Colors.black26, offset: Offset(0, 1))],
                shape: BoxShape.circle, color: Colors.white
              ),
              child: Icon(Icons.close, size: 20
              )
            ),
          ),
          InkWell(
            onTap: showFilterDialog,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 3, color: Colors.black26, offset: Offset(0, 1))],
                shape: BoxShape.circle, color: Colors.white
              ),
              child: Icon(Icons.filter_list, size: 20
              )
            ),
          ),
          // Your widgets here
        ],
      ),
//        leading: Container(
////          width: 10,
////        height: 10,
//        padding: EdgeInsets.all(10),
//        decoration: BoxDecoration(
//
//            shape: BoxShape.circle, color: Colors.white),
////            onPressed: () => Navigator.pop(context),
//            child: Icon(Icons.close, size: 20,)
//        ),
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return BlocBuilder<PropertiesListBloc, PropertiesListState>(
        builder: (context, state) {
          if (state is PropertiesListLoading) {
            return Stack(
              children: <Widget>[
                buildMap(),
//                AppBar(
//                  backgroundColor: Colors.transparent,
//                  elevation: 0.0,
//                  automaticallyImplyLeading: false,
//                  leading: IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context),),
//                ),
                Center(child: CircularProgressIndicator()),
              ],
            );
          }
          if (state is PropertiesListFetched) {
            homes = state.properties;
            return Stack(
              children: <Widget>[
               buildMap(),
//                SafeArea(
//
//                  child: Positioned(
//                    left: 90,
//                    top: 90,
//                    child: Container(
//                        width: 30,
//                        height: 30,
//                        decoration: BoxDecoration(
//
//                            shape: BoxShape.circle, color: Colors.white),
////            onPressed: () => Navigator.pop(context),
//                        child: Icon(Icons.close, size: 10,)
//                    ),
//                  ),
//                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 150,
//                    color: Colors.deepOrangeAccent,
                    child: Center(
                      child: PageView(
                        onPageChanged: (int pageIdx) {
                          moveCameraToMarker();
                          setState(() {
                            selectedMarkerIdx = pageIdx;
                          });
                        },
//                        scrollDirection: Axis.horizontal,
                        controller: pageViewController,
                        children: homes.map((home) => buildHomeItem(home)).toList(),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return Container();
        }
    );
  }

  buildMap(){
    return GoogleMap(
      markers: createMarkers(homes),
      padding: EdgeInsets.only(bottom: 150, top: 50),
      myLocationEnabled: true,
//      polygons: polygon != null ? [polygon].toSet() : null,
      mapType: MapType.terrain,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: true,
      compassEnabled: false,
      mapToolbarEnabled: false, //hides navigation button on marker select
      zoomGesturesEnabled: true,
      tiltGesturesEnabled: true,
      initialCameraPosition: CameraPosition(target: cameraPosition, zoom: 14.4746),
      onCameraMove: (CameraPosition cameraPosition){},
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
        Future.delayed(Duration(milliseconds: 200), setMapBounds);
      },
    );
  }

  createVisibleRegionPolyline() async {
    final LatLngBounds bounds = await mapController.getVisibleRegion();

    final PolygonId polygonId = PolygonId("1");
    final List<LatLng> points = <LatLng>[];
    points.add(bounds.southwest);
    points.add(LatLng(bounds.northeast.latitude, bounds.southwest.longitude) );
    points.add(bounds.northeast);
    points.add(LatLng(bounds.southwest.latitude, bounds.northeast.longitude) );

    polygon = Polygon(
      polygonId: polygonId,
      consumeTapEvents: true,
      strokeColor: ThemeProvider.primaryAccent,
      strokeWidth: 1,
      fillColor: ThemeProvider.primaryAccent.withOpacity(0.2),
      points: points,
//      onTap: () {
//        _onPolygonTapped(polygonId);
//      },
    );
    setState(() {

    });
  }

  Widget buildHomeItem(Property home){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () => openHomeScreen(home),
            child: Container(
//            width: 200,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(home.image),
                  fit: BoxFit.cover
                ),
              ),
            ),
          ),
          Text(home.address),
          Text(home.priceFrmt, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),

        ],
      ),
    );
  }

  Set<Marker> createMarkers(List<Property> homes) {
    markers = homes.where((item) => item.lat != null && item.lng != null).toList().asMap().entries.map((item) {
      return Marker(
//        markerId: MarkerId(item.value.id),
        position: LatLng(item.value.lat, item.value.lng),
        icon: selectedMarkerIdx == item.key ? selectedMarkerIcon : markerIcon,
          onTap: (){
            setState(() {
              selectedMarkerIdx = item.key;
            });
            pageViewController.jumpToPage(item.key);
        }
      );
    }).toSet();

    return markers;
  }

  getMarkerIcon() async {
    markerIcon = await Helper.createCustomMarkerBitmap("8.5₴", false);
    selectedMarkerIcon = await Helper.createCustomMarkerBitmap("8.5т ₴", true);
//    markerIcon = BitmapDescriptor.fromBytes(await Helper.markerIcon());
//    selectedMarkerIcon = BitmapDescriptor.fromBytes(await Helper.selectedMarkerIcon());
    setState(() {});
  }

  void openHomeScreen(Property home) {
    Navigator.push (
      context,
      MaterialPageRoute(builder: (context) => PropertyDetailsScreen(home)),
    );
  }

  void showFilterDialog(){
    Navigator.push (
      context,
      MaterialPageRoute(builder: (context) => FiltersScreen()),
    );
  }

  // fix map blank on app resume
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      mapController.setMapStyle("[]");
    }
  }

  Future<void> moveCameraToMarker() async {
    final LatLngBounds bounds = await mapController.getVisibleRegion();
    double zoomLevel = await mapController.getZoomLevel();
    Marker currentMarker = markers.elementAt(selectedMarkerIdx);
    bool contains = bounds.contains(currentMarker.position);
    if (!contains) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: currentMarker.position, zoom: zoomLevel),
        ),
      );
    }
  }

   setMapBounds() async {
     await mapController.animateCamera(
       CameraUpdate.newLatLngBounds(boundsFromLatLngList(homes.map((home) => LatLng(home.lat, home.lng)).toList()), 50)
     );
     createVisibleRegionPolyline();
   }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }

  void requestLocation() async {
    PermissionStatus permission = await LocationPermissions().requestPermissions();
  }
}
