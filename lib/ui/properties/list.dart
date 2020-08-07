import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:hellohome/core/blocs/favorites/list/bloc.dart';
import 'package:hellohome/core/blocs/favorites/list/event.dart';
import 'package:hellohome/core/blocs/favorites/list/state.dart';
import 'package:hellohome/core/blocs/properties/list/bloc.dart';
import 'package:hellohome/core/blocs/properties/list/event.dart';
import 'package:hellohome/core/blocs/properties/list/state.dart';
import 'package:hellohome/core/blocs/properties_search_filter/bloc.dart';
import 'package:hellohome/core/blocs/properties_search_filter/state.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/ui/components/drawer.dart';
import 'package:hellohome/theme.dart';
import 'package:hellohome/ui/components/snack_bar.dart';

import 'filters.dart';
import 'details.dart';
import 'map.dart';

class PropertyListScreen extends StatefulWidget {
  @override
  _PropertyListScreenState createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {

  @override
  void initState() {
    context.bloc<PropertiesListBloc>().add(HomesListRequested());
    context.bloc<FavoritesBloc>().add(FavoritesListRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HelloHomeDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "HELLO HOME",
              style: TextStyle(
                fontFamily: "Rubik",
                fontSize: 20,
                fontWeight: FontWeight.bold, color: ThemeProvider.primaryAccent
              )
            ),
            SizedBox(width: 12),
            Image.asset("assets/launcher.png", height: 20, color: ThemeProvider.primaryAccent,)
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
          buildFilterButton()
        ],
      ),
      body: buildBody(),
    );
  }

  Widget buildFilterButton(){
    return BlocBuilder<SearchFilterBloc, SearchFilterState>(
      builder: (context, state) {
        if (state is SearchFilterApplied) {
          return Stack(
            children: <Widget>[

              IconButton(icon: Icon(Icons.filter_list), onPressed: showFilterDialog,),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 15,
                  height: 15,
//                  child: Text("1", style: TextStyle(color: Colors.white),),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ThemeProvider.primaryAccent
                  ),
                ),
              ),
            ],
          );
        }
        return IconButton(icon: Icon(Icons.filter_list), onPressed: showFilterDialog,);
      }
    );
  }

  buildBody() {
    return BlocConsumer<PropertiesListBloc, PropertiesListState>(
      listener: (context, state) {
        if (state is PropertiesFetchError) {
          HelloHomeSnackBar(context).show(FlutterI18n.translate(context, "property_list.errors.fetchError"), SnackBarType.error);
        }
      },
      builder: (context, state) {
        if (state is PropertiesListLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is PropertiesListFetched) {
          List<Property> properties = state.properties;
//          buildPropertyList(state.properties);

//        TODO add auth user check
//          if (user != null) {
//
//          } else {
//
//          }
          return BlocConsumer<FavoritesBloc, FavoritesState>(
              listener: (context, state) {
                if (state is FavoritesFetchError) {
                  HelloHomeSnackBar(context).show(FlutterI18n.translate(context, "property_list.errors.favoritesFetchError"), SnackBarType.error);
                }
              },
              builder: (context, state) {
                if (state is FavoritesFetched) {
                  return buildPropertyList(properties: properties, favorites: state.properties);
                }
                if (state is FavoritesFetchError) {
                  return buildPropertyList(properties: properties);
                }
                return buildPropertyList(properties: properties);
              }
          );

        }
        if (state is PropertiesFetchError) {
          return Center(child: Image.asset("assets/icons/loading_error.png", height: 100, color: Colors.grey.withOpacity(0.2),),);
        }
        return Container();
      }
    );
  }

  Widget buildPropertyList({List<Property> properties, List<Property> favorites}) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        ListView(
          children: properties.map<Widget>((Property property) => buildHomeItem(property, favorites)).toList()
        ),
        buildMapButton()
      ],
    );
  }

  Widget buildMapButton(){
    return Positioned(
      bottom: 30,
      child: RaisedButton(
        onPressed: openMapScreen,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        color: Colors.deepOrangeAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Карта", style: TextStyle(color: Colors.white),),
            SizedBox(width: 5),
            Icon(Icons.map, color: Colors.white),
          ],
        )
      ),
    );
  }

  buildHomeItem(Property property, List<Property> favorites) {
    return Container(
       padding: EdgeInsets.symmetric(
         horizontal: 20,
         vertical: 20
       ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () => openHomeDetails(property),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  color: ThemeProvider.lightGrey,
                  child: Image.asset(
                    property.image,
                    fit: BoxFit.cover,
//                      width: 50, height: 50,
//                      color: Colors.white.withOpacity(0.5)
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 10,
                child: buildFavButton(property, favorites),
//                child: ,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(property.address, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
//                  Text(describeEnum(home.type), style: TextStyle(fontSize: 14)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                      property.priceFrmt,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                  Text(
                    " / в месяц",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 12, color: Colors.grey),)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  buildFavButton(Property property, List<Property> favorites){
    bool contains = false;
    if (favorites != null) {
      if (favorites.map((property) => property.id).contains(property.id)) {
        contains = true;
      }
      return RawMaterialButton(
          fillColor: Colors.white,
          shape: CircleBorder(),
          onPressed: () => contains ? removeFromFavs(property) : addToFavs(property),
          child: contains
              ? Icon(Icons.favorite, size: 20, color: Colors.deepOrangeAccent,)
              : Icon(Icons.favorite_border, size: 20, color: Colors.deepOrangeAccent,)
      );
    }
    return Container();

  }

  void openHomeDetails(Property home) {
    Navigator.push (
      context,
      MaterialPageRoute(builder: (context) => PropertyDetailsScreen(home)),
    );
  }

  showFilterDialog(){
    Navigator.push (
      context,
      MaterialPageRoute(builder: (context) => FiltersScreen()),
    );
  }

  void showMapView() {

  }

  void addToFavs(Property home) {
    print(">>Add");
    context.bloc<FavoritesBloc>().add(FavoritesAddPressed(home));
  }

  void removeFromFavs(Property home) {
    context.bloc<FavoritesBloc>().add(FavoritesDeletePressed(home));
  }

  void openMapScreen() {
    Navigator.push (
      context,
      MaterialPageRoute(builder: (context) => PropertiesMapScreen()),
    );
  }
}
