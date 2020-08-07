import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hellohome/core/blocs/facilities/list/bloc.dart';
import 'package:hellohome/core/blocs/facilities/list/event.dart';
import 'package:hellohome/core/blocs/facilities/list/state.dart';
import 'package:hellohome/core/blocs/user_properties/create/bloc.dart';
import 'package:hellohome/core/blocs/user_properties/create/event.dart';
import 'package:hellohome/core/blocs/user_properties/create/state.dart';
import 'package:hellohome/core/blocs/user_properties/list/bloc.dart';
import 'package:hellohome/core/blocs/user_properties/list/event.dart';
import 'package:hellohome/core/helpers/constants.dart';
import 'package:hellohome/core/helpers/validator.dart';
import 'package:hellohome/core/models/facility.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/ui/components/snack_bar.dart';
import 'package:hellohome/ui/properties/layout.dart';
import 'package:image_picker/image_picker.dart';

import '../../theme.dart';
import '../components/drawer.dart';

class UserPropertyAddScreen extends StatefulWidget {
  @override
  _UserPropertyAddScreenState createState() => _UserPropertyAddScreenState();
}

class _UserPropertyAddScreenState extends State<UserPropertyAddScreen> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController squareController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController roomsController = TextEditingController();

  PriceCurrency selectedCurrency = PriceCurrency.uah;
  PropertyType selectedHomeType = PropertyType.apartment;
  Marker marker;
  bool animalsAllowed = false;
  bool childrenAllowed = false;

  Map<Facility, bool> facilitiesValues = {};
  List<File> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Добавить обьявление", style: TextStyle(fontFamily: "Roboto", fontSize: 14),),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Text("Разместить", style: TextStyle(fontFamily: "Roboto", color: Colors.deepOrangeAccent),),
                Icon(Icons.check_circle, color: Colors.deepOrangeAccent)
              ],
            ),
            onPressed: addHome,
          )
        ],
      ),
//      drawer: HelloHomeDrawer(),
      body: BlocListener<PropertyCreateBloc, PropertyCreateState>(
          listener: (BuildContext context, PropertyCreateState state) {
  //          if (state is HomesAddLoading) {
  //            return Center(child: CircularProgressIndicator());
  //          }
            if (state is PropertyCreateSuccess) {
              context.bloc<MyHomesListBloc>().add(MyHomesFetchRequested());
              Navigator.pop(context);
              HelloHomeSnackBar(context).show("Обьявление добавлено", SnackBarType.info);

            }
          },
        child: buildBody(),

      )
    );
  }

  Widget buildBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20,),
            buildHomeTypeSelect(),
//            Text("Параметры", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

            TextFormField(
              keyboardType: TextInputType.text,
              controller: descriptionController,
              validator: (value) => Validator.validatePresence(value),
              decoration: InputDecoration(
                labelText: FlutterI18n.translate(context, "property_add.description")
              ),
              maxLines: 6,
            ),
            SizedBox(height: 20,),
//            Text("Удобства"),
//            SizedBox(height: 20,),
//            Text("Фото"),
//
//            Container(
//              width: 50,
//              height: 50,
//              color: Colors.deepOrangeAccent,
//              child: Icon(Icons.add),
//            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: addressController,
              validator: (value) => Validator.validatePresence(value),
              decoration: InputDecoration(
                  labelText: "Адрес"
              ),
            ),
            //            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
              controller: squareController,
              validator: (value) => Validator.validatePresence(value),
              decoration: InputDecoration(
                labelText: "Площадь"
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: roomsController,
              inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
              validator: (value) => Validator.validatePresence(value),
              decoration: InputDecoration(
                  labelText: "Комнаты"
              ),
            ),
            buildPrice(),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly, ],
              decoration: InputDecoration(
                  labelText: "Этаж"
              ),
              maxLines: 1,
            ),
            SizedBox(height: 30,),
            Text("Удобства", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Divider(),
            buildFacilities(),
            SizedBox(height: 20,),
            Text("Условия проживания", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Divider(),

            Row(
              children: <Widget>[
                Text("Можно с животными"),
                Switch(
                  value: animalsAllowed,
                  onChanged: (bool value){
                    setState(() {
                      animalsAllowed = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Text("Можно с детьми"),
                Switch(
                  value: childrenAllowed,
                  onChanged: (bool value){
                    setState(() {
                      childrenAllowed = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20,),
            buildImages(),
            SizedBox(height: 20,),
            buildMap(),
          ],
        ),
      ),
    );
  }

  buildMap() {
    LatLng cameraPosition = Constants.kievCenter;

    return Container(
      height: 400,
      child: GoogleMap(
        gestureRecognizers: Set()..add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer())),
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

        markers: marker != null ? createMarker() : null,
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

  void addHome() async {
    if (formKey.currentState.validate() ) {
      if(images.length < 2) {
        HelloHomeSnackBar(context).show("Добавьте минимум 2 фото", SnackBarType.error);
        return;
      }
      Property property = Property(
        address: addressController.text,
        description: descriptionController.text,
        type: selectedHomeType,
        lat: marker.position.latitude,
        lng: marker.position.longitude,
        price: int.parse(priceController.text),
        priceCurrency: selectedCurrency,
        animalsAllowed: animalsAllowed,
        square: int.parse(squareController.text),
        roomCount: int.parse(roomsController.text),
//        userId: user.uid,
        facilities: getFacilities()
      );
      context.bloc<PropertyCreateBloc>().add(PropertyCreatePressed(
        property: property,
        images: images
      ));

    }
  }

  List<Facility> getFacilities() {
    facilitiesValues.removeWhere((key, value) => value == false);
    return facilitiesValues.keys.toList();
  }

  Widget buildHomeTypeSelect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        buildHomeTypeButton(PropertyType.apartment, "Квартира"),
        buildHomeTypeButton(PropertyType.room, "Комната"),
        buildHomeTypeButton(PropertyType.house, "Дом"),
      ],
    );
  }

  setHomeType(PropertyType homeType) {
    setState(() {
      selectedHomeType = homeType;
    });
  }

  buildHomeTypeButton(PropertyType homeType, String name) {
    return FlatButton(
      color: selectedHomeType == homeType ? ThemeProvider.primaryAccent : Colors.grey,
      child: Text(name, style: TextStyle(color: Colors.white),), onPressed: () => setHomeType(homeType)
    );
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
              facilitiesValues.putIfAbsent(facility, () => false);
              return buildFacility(facility);
            }).toList()
          );
        }
        return Container();
      }
    );
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

  Widget buildPrice() {
    return Column(
      children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
          controller: priceController,
          validator: (value) => Validator.validatePresence(value),
          decoration: InputDecoration(
              labelText: "Цена"
          ),
        ),
        Row(
          children: <Widget>[
            FlatButton(
              color: selectedCurrency == PriceCurrency.uah ? ThemeProvider.primaryAccent : Colors.grey,
              child: Text("UAH"),
              onPressed: () {
                setState(() {
                  selectedCurrency = PriceCurrency.uah;
                });
              },
            ),
            SizedBox(width: 10,),
            FlatButton(
              color: selectedCurrency == PriceCurrency.usd ? ThemeProvider.primaryAccent : Colors.grey,
              child: Text("USD"),
              onPressed: () {
                setState(() {
                  selectedCurrency = PriceCurrency.usd;
                });
              },
            ),
          ],
        ),
      ],
    );
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
          Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: ThemeProvider.primaryAccent,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(image)
                  )
                ),
//              width: 100,
//              height: 100,
//              child: Image.file(image)
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () => deleteImage(image),
                ),
              )
            ],
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

  deleteImage(File image){
    setState(() {
      images.remove(image);
    });
  }

  Future getImage() async {
    final picker = ImagePicker();
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
}

