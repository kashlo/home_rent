import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:hellohome/core/blocs/facilities/list/bloc.dart';
import 'package:hellohome/core/blocs/facilities/list/state.dart';
import 'package:hellohome/core/blocs/properties/list/bloc.dart';
import 'package:hellohome/core/blocs/properties/list/event.dart';
import 'package:hellohome/core/blocs/properties_search_filter/bloc.dart';
import 'package:hellohome/core/blocs/properties_search_filter/event.dart';
import 'package:hellohome/core/blocs/properties_search_filter/state.dart';
import 'package:hellohome/core/models/facility.dart';
import 'package:hellohome/core/models/filter.dart';
import 'package:hellohome/core/models/property.dart';

import '../../theme.dart';

class FiltersScreen extends StatefulWidget {

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Map<Facility, bool> facilitiesValues = {};
  RangeValues priceRangeValues;
  RangeValues roomsRangeValues;

  bool animalsAllowed;
  bool childrenAllowed;
  PropertyType homeTypeSelected;
  bool notFirstFloor;
  bool notLastFloor;

  PropertyType defaultHomeType = PropertyType.apartment;
  double defaultMaxPrice = 25000;
  double defaultMinPrice = 0;
  bool defaultAnimalsAllowed = false;
  bool defaultChildrenAllowed = false;
  bool defaultNotFirstFloor = false;
  bool defaultNotLastFloor = false;

  @override
  void initState() {
    setDefaultFilters();
    context.bloc<SearchFilterBloc>().add(SearchFilterRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Фильтры",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
          )
        ),
        actions: <Widget>[
          buildClearButton(),
        ],
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.close), onPressed: ()=> Navigator.pop(context),),
      ),
      body: BlocConsumer<SearchFilterBloc, SearchFilterState>(
          listener: (context, state) {
            if (state is SearchFilterFetched) {
              if (state.searchFilter != null) {
                if (state.searchFilter.priceFrom != null || state.searchFilter.priceTo != null) {
                  priceRangeValues = RangeValues(
                    state.searchFilter.priceFrom != null ? state.searchFilter.priceFrom.toDouble() : defaultMinPrice,
                    state.searchFilter.priceTo != null ? state.searchFilter.priceTo.toDouble() : defaultMaxPrice
                  );
                }
              }
            }
            if (state is SearchFilterCleared) {
              setDefaultFilters();
            }
          },
          builder: (context, state) {
            if (state is SearchFilterFetched) {
              return buildBody();
            }
            return buildBody();
          }
      )
    );
  }

  Widget buildBody(){
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20,),
              Form(
                child: Column(
                  children: <Widget>[
                    Text("Тип"),
                    SizedBox(height: 20,),
                    buildHomeTypeSelect(),
                    SizedBox(height: 30,),
                    Text("Цена"),
                    SizedBox(height: 20,),
                    buildPriceSlider(),
                    buildRoomsCount(),
                    SizedBox(height: 30,),
                    Text("Техника"),
                    SizedBox(height: 20,),
                    buildFacilities(),
                    SizedBox(height: 20,),
                    Text("Правила"),
                    buildAnimalsAllowed(),
                    buildChildrenAllowed(),
                    buildFloor(),
                    SizedBox(height: 50,),
//                    Text("Этаж"),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: buildApplyButton(),
        )
      ],
    );
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
      title: Text(FlutterI18n.translate(context, "general.facilities.${facility.name}")),
      value: facilitiesValues[facility],
      onChanged: (bool value) {
        setState(() {
          facilitiesValues[facility] = value;
        });
      },
      secondary: Image.asset("assets/icons/${facility.name}.png", width: 20,),
    );
  }

  setHomeType(PropertyType homeType) {
    setState(() {
      this.homeTypeSelected = homeType;
    });
  }

  buildHomeTypeButton(PropertyType homeType, String name) {
    return FlatButton(
        color: homeTypeSelected == homeType ? ThemeProvider.primaryAccent : Colors.grey,
        child: Text(name, style: TextStyle(color: Colors.white),), onPressed: () => setHomeType(homeType)
    );
  }

  Widget buildRoomCountSlider() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("${roomsRangeValues.start.toInt()}", style: TextStyle(fontSize: 18),),
            Text(" - ", style: TextStyle(fontSize: 18),),
            Text("${roomsRangeValues.end.toInt()}+", style: TextStyle(fontSize: 18),)
          ],
        ),
        RangeSlider(
          activeColor: ThemeProvider.primaryAccent,
          values: roomsRangeValues,
          divisions: 4,
          min: 1,
          max: 5,
          onChanged: (RangeValues values) {
            setState(() {
              roomsRangeValues = values;
            });
          },
        ),
      ],
    );
  }

  Widget buildPriceSlider() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("${priceRangeValues.start.toInt()}₴", style: TextStyle(fontSize: 18),),
            Text(" - ", style: TextStyle(fontSize: 18),),
            Text("${priceRangeValues.end.toInt()}₴", style: TextStyle(fontSize: 18),)
          ],
        ),
        RangeSlider(
          activeColor: ThemeProvider.primaryAccent,
          values: priceRangeValues,
          divisions: 10,
          min: 0,
          max: defaultMaxPrice,
          onChanged: (RangeValues values) {
            setState(() {
              priceRangeValues = values;
            });
          },
        ),
      ],
    );
  }

  Widget buildAnimalsAllowed() {
    return CheckboxListTile(
      title: Text("Можно с животными"),
      value: animalsAllowed,
      onChanged: (bool value) {
        setState(() {
          animalsAllowed = value;
        });
      },
      secondary: Icon(Icons.pets),
    );
  }

  Widget buildChildrenAllowed() {
    return CheckboxListTile(
      title: Text("Можно с детьми"),
      value: childrenAllowed,
      onChanged: (bool value) {
        setState(() {
          childrenAllowed = value;
        });
      },
      secondary: Icon(Icons.child_friendly),
    );
  }

  Widget buildFloor() {
    if (homeTypeSelected != PropertyType.house) {
      return Column(
        children: <Widget>[
          Text("Этаж"),
          CheckboxListTile(
            title: Text("Не первый"),
            value: notFirstFloor,
            onChanged: (bool value) {
              setState(() {
                notFirstFloor = value;
              });
            },
            secondary: Icon(Icons.home),
          ),
          CheckboxListTile(
            title: Text("Не последний"),
            value: notLastFloor,
            onChanged: (bool value) {
              setState(() {
                notLastFloor = value;
              });
            },
            secondary: Icon(Icons.home),
          ),
        ],
      );
    }
    return Container();
  }

  Widget buildApplyButton() {
    return FlatButton(
      color: ThemeProvider.primaryAccent,
      child: Text("Применить"),
      onPressed: applyFilters,
    );
  }

  applyFilters() {
    SearchFilter searchFilter = SearchFilter(
      type: homeTypeSelected,
//        priceFrom: priceRangeValues.start != minPrice ? priceRangeValues.start.toInt() : null,
//        priceTo: priceRangeValues.end != maxPrice ? priceRangeValues.end.toInt() : null,
//        animalsAllowed: animalsAllowed
    );
    final filteredMap = Map.from(facilitiesValues)..removeWhere((key, value) => value == false );
    List<int> values = filteredMap.keys.toList().map<int>((item) => item.id).toList();
    if (filteredMap.keys.isNotEmpty) {
      searchFilter.facilitiesIds = values;
    }
    if (priceRangeValues.start != defaultMinPrice || priceRangeValues.end != defaultMaxPrice) {
      searchFilter.priceFrom = priceRangeValues.start.toInt();
    }
    if (priceRangeValues.end != defaultMaxPrice) {
      searchFilter.priceTo = priceRangeValues.end.toInt();
    }
    if (animalsAllowed != defaultAnimalsAllowed) {
      searchFilter.animalsAllowed = animalsAllowed;
    }
    if (childrenAllowed != defaultChildrenAllowed) {
      searchFilter.childrenAllowed = childrenAllowed;
    }
    if (notFirstFloor != defaultNotFirstFloor) {
      searchFilter.notFirstFloor = notFirstFloor;
    }
    if (notLastFloor != defaultNotLastFloor) {
      searchFilter.notLastFloor = notLastFloor;
    }
    context.bloc<PropertiesListBloc>().add(HomesListRequested(searchFilter: searchFilter));
    context.bloc<SearchFilterBloc>().add(SearchFilterApplyPressed(searchFilter: searchFilter));

//    Navigator.pop(context);
  }

  Widget buildClearButton() {
    return FlatButton(
      child: Text("Очистить"),
      onPressed: (){
        context.bloc<SearchFilterBloc>().add(SearchFilterClearPressed());
      },
    );
  }

  void setDefaultFilters() {
    setState(() {
      notFirstFloor = defaultNotFirstFloor;
      notLastFloor = defaultNotLastFloor;
      animalsAllowed = defaultAnimalsAllowed;
      childrenAllowed = defaultChildrenAllowed;
      priceRangeValues = RangeValues(defaultMinPrice, defaultMaxPrice);
      roomsRangeValues = RangeValues(1, 5);
      homeTypeSelected = defaultHomeType;
      facilitiesValues = facilitiesValues.map((key, value) {
        return MapEntry(key, false);
      });
    });
  }

  Widget buildRoomsCount() {
    if (homeTypeSelected != PropertyType.room) {
      return Column(
        children: <Widget>[
          SizedBox(height: 30,),
          Text("Комнаты"),
          buildRoomCountSlider(),
        ],
      );
    } else {
      return Container();
    }
  }
}
