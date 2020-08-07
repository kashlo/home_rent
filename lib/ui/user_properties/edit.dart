import 'dart:io';

import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hellohome/core/blocs/facilities/list/bloc.dart';
import 'package:hellohome/core/blocs/facilities/list/event.dart';
import 'package:hellohome/core/blocs/facilities/list/state.dart';
import 'package:hellohome/core/blocs/user_properties/delete/bloc.dart';
import 'package:hellohome/core/blocs/user_properties/delete/event.dart';
import 'package:hellohome/core/blocs/user_properties/delete/state.dart';
import 'package:hellohome/core/blocs/user_properties/update/bloc.dart';
import 'package:hellohome/core/blocs/user_properties/update/event.dart';
import 'package:hellohome/core/blocs/user_properties/update/state.dart';
import 'package:hellohome/core/blocs/user_properties/list/bloc.dart';
import 'package:hellohome/core/blocs/user_properties/list/event.dart';
import 'package:hellohome/core/helpers/validator.dart';
import 'package:hellohome/core/models/facility.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/ui/components/loading_overlay.dart';
import 'package:hellohome/ui/components/snack_bar.dart';
import 'package:hellohome/theme.dart';
import 'package:image_picker/image_picker.dart';

class UserPropertyEditScreen extends StatefulWidget {

  final Property home;

  @override
  _UserPropertyEditScreenState createState() => _UserPropertyEditScreenState();

  UserPropertyEditScreen(this.home);
}

class _UserPropertyEditScreenState extends State<UserPropertyEditScreen> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  bool isActive;
  Marker marker;
  Map<Facility, bool> facilitiesValues = {};
  final picker = ImagePicker();
  List<File> images = [];
  final GlobalKey<State> loadingOverlayKey = GlobalKey<State>();

  @override
  void initState() {
    context.bloc<FacilitiesListBloc>().add(FacilitiesListRequested());

    addressController.text = widget.home.address;
    descriptionController.text = widget.home.description;
    priceController.text = widget.home.price.toString();
    isActive = widget.home.isActive;
    if (widget.home.lat != null && widget.home.lng != null) {
      marker = Marker(
//      markerId: MarkerId(widget.home.id),
          position: LatLng(widget.home.lat, widget.home.lng)
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: showDeleteHomeDialog,
          ),
          IconButton(
            icon: Icon(Icons.check_circle, color: ThemeProvider.primaryAccent,),
            onPressed: updateHome,
          )
        ],
      ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<MyHomeDeleteBloc, MyHomeDeleteState>(
              listener: (context, state) {
                if (state is MyHomeDeleteSuccess) {
                  context.bloc<MyHomesListBloc>().add(MyHomesFetchRequested());
                  Navigator.pop(context);
                  HelloHomeSnackBar(context).show("Обьявление удалено", SnackBarType.info);
                }
              },
            ),
            BlocListener<MyHomeUpdateBloc, MyHomeUpdateState>(
              listener: (context, state) {
                if (state is MyHomeUpdateLoading) {
                  LoadingOverlay.show(context, loadingOverlayKey);
                }
                if (state is MyHomeUpdateError) {
                  Navigator.of(loadingOverlayKey.currentContext,rootNavigator: true).pop();
                  HelloHomeSnackBar(context).show(FlutterI18n.translate(context, "property_edit.errors.updateError"), SnackBarType.error);
                }
                if (state is MyHomeUpdateSuccess) {
                  Navigator.of(loadingOverlayKey.currentContext,rootNavigator: true).pop();
                  Navigator.pop(context);
                  HelloHomeSnackBar(context).show(FlutterI18n.translate(context, "property_edit.info.updateSuccess"), SnackBarType.error);
                  context.bloc<MyHomesListBloc>().add(MyHomesFetchRequested());
                }
              },
            ),
          ],
          child: buildBody(),
        )
//      body: BlocListener<MyHomeDeleteBloc, MyHomeDeleteState>(
//        listener: (ctx, state) {
//          //          if (state is HomesAddLoading) {
//          //            return Center(child: CircularProgressIndicator());
//          //          }
//          if (state is MyHomeDeleteSuccess) {
//              Navigator.pop(context);
//              HelloHomeSnackBar.show(context, "Обьект удален", SnackBarType.info);
//          }
//        },
//        child: buildBody(),
//
//      ),
    );
  }

  buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 20,),
          Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: addressController,
                  validator: (value) => Validator.validatePresence(value),
                  decoration: InputDecoration(
                    labelText: "Адрес"
                  ),
                ),
                TextFormField(
                  controller: descriptionController,
                  validator: (value) => Validator.validatePresence(value),
                  decoration: InputDecoration(
                    labelText: "Описание"
                  ),
                ),
                TextFormField(
                  controller: priceController,
                  validator: (value) => Validator.validatePresence(value),
                  decoration: InputDecoration(
                      labelText: "Цена"
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: (){

    setState(() {
                    isActive = !isActive;
                  });
                },

                child: CustomSwitchButton(
                  backgroundColor: Colors.grey,
                  unCheckedColor: Colors.white,
                  animationDuration: Duration(milliseconds: 400),
                  checkedColor: ThemeProvider.primaryAccent,
                  checked: isActive,
                  buttonHeight: 30,
                  buttonWidth: 50,
                  indicatorBorderRadius: 15,
                  backgroundBorderRadius: 15,
                  indicatorWidth: 50,
                ),
              )
//              Switch(
//                value: isActive,
//                onChanged: (bool value){
//                  setState(() {
//                    isActive = value;
//                  });
//                },
//              ),
            ],
          ),
          SizedBox(height: 20,),
          buildImages(),
          SizedBox(height: 20,),
          buildFacilities(),
          SizedBox(height: 20,),
          widget.home.lat != null && widget.home.lng != null ? buildMap() : Container(),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  buildMap() {
    LatLng cameraPosition = LatLng(widget.home.lat, widget.home.lng);

    return Container(
      height: 400,
      child: GoogleMap(
        mapType: MapType.terrain,
        myLocationButtonEnabled: true,
        onTap: (LatLng pos) {
          setState(() {
            marker = Marker(
                markerId: MarkerId("marker_1"),
                position: pos
            );
          });
        },
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: true,
        markers: createMarker(),
//        markers: _createMarker(),
        initialCameraPosition: CameraPosition(target: cameraPosition, zoom: 14.4746),
//        onMapCreated: (GoogleMapController controller) {
//          _controller.complete(controller);
//        },
      ),
    );
  }

  Set<Marker> createMarker() {
    return <Marker>[
      marker,
    ].toSet();
  }

  void showDeleteHomeDialog() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text("Удалить"),
        content: Text("Вы уверены что хотите удалить это обьявление?"),
        actions: <Widget>[
          FlatButton(
            child: Text("Отменить"),
            onPressed: () { Navigator.of(context).pop(); },
          ),
          FlatButton(
            child: Text("Удалить"),
            onPressed: deleteHome,
          )
        ],
      )
    );
  }

  List<Facility> getFacilities() {
    facilitiesValues.removeWhere((key, value) => value == false);
    return facilitiesValues.keys.toList();
  }

  Widget buildFacilities() {
    return BlocBuilder<FacilitiesListBloc, FacilitiesListState>(
      builder: (context, state) {
        if (state is FacilitiesListLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is FacilitiesListFetched) {
          return Column(
            children: state.facilities.map<Widget>((facility) {
              facilitiesValues.putIfAbsent(facility, () => getFacility(facility));
              return buildFacility(facility);
            }).toList()
          );
        }
        return Container();
      }
    );
  }

  bool getFacility(Facility facility){
    if (widget.home.facilities.map((facility) => facility.id).toList().contains(facility.id)) {
      return true;
    }
    return false;
  }

  buildFacility(Facility facility) {
    return CheckboxListTile(
      title: Text(facility.name),
      value: facilitiesValues[facility],
      onChanged: (bool value) {
        setState(() {
          facilitiesValues[facility] = value;
        });
      },
      secondary: Icon(Icons.local_laundry_service),
    );
  }


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

//    setState(() {
    setState(() {
      images.add(File(pickedFile.path));
    });
//    return Image.file(
//      snapshot.data,
//      width: 300,
//      height: 300,
//    );
//    });
  }

  Widget buildImages() {
    List<Widget> children = [];
    children.add(
      InkWell(
      onTap: getImage,
      child: Container(
        color: ThemeProvider.primaryAccent,
//            width: 100,
//            height: 100,
        child: Icon(Icons.add, size: 30,)
      )
    ));
    images.forEach((File image) {
      children.add(
          Container(
            decoration: BoxDecoration(
              color: ThemeProvider.primaryAccent,
              image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(image)
//                image: Image.file(image)
              )
            ),
//              width: 100,
//              height: 100,
//              child: Image.file(image)
          )
      );
    });
//    return Row(
//      children: children,
//    );

    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 3,
      shrinkWrap: true,
//      primary: false,
      physics: NeverScrollableScrollPhysics(),
//      padding: EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      // Generate 100 widgets that display their index in the List.
      children: children,
    );
  }


  void deleteHome() {
    Navigator.of(context).pop();
    context.bloc<MyHomeDeleteBloc>().add(MyHomeDeletePressed(widget.home));
  }

  void updateHome() {
    if (formKey.currentState.validate()) {
      Property home = widget.home;
      home.address = addressController.text;
      home.price = int.parse(priceController.text);
      home.description = descriptionController.text;

      home.isActive = isActive;
//      home.lat = marker.position.latitude;
//      home.lng = marker.position.longitude;
      home.facilities = getFacilities();

      context.bloc<MyHomeUpdateBloc>().add(MyHomeUpdatePressed(home));
    }

  }
}
