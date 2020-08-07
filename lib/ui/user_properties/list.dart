import 'package:flutter/material.dart';
import 'package:hellohome/core/blocs/user_properties/list/bloc.dart';
import 'package:hellohome/core/blocs/user_properties/list/event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/blocs/user_properties/list/state.dart';
import 'package:hellohome/core/models/property.dart';

import '../../theme.dart';
import '../components/drawer.dart';
import 'create.dart';
import 'edit.dart';

class UserPropertiesListScreen extends StatefulWidget {

  @override
  _UserPropertiesListScreenState createState() => _UserPropertiesListScreenState();
}

class _UserPropertiesListScreenState extends State<UserPropertiesListScreen> {

  @override
  void initState() {
    context.bloc<MyHomesListBloc>().add(MyHomesFetchRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Мои обьявления"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: openAddHomeScreen,
          )
        ],
      ),
      drawer: HelloHomeDrawer(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return BlocBuilder<MyHomesListBloc, MyHomesListState>(
        builder: (context, state) {
          if (state is MyHomesListLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is MyHomesListFetched) {
            return ListView(
                children: state.homes.map<Widget>((home) => buildPropertyItem(home)).toList()
            );
          }
          return Container();
        }
    );
  }

  Widget buildPropertyItem(Property property) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
      ),
      child: InkWell(
        onTap: () => openHomeDetails(property),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(property.address, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  color: ThemeProvider.lightGrey,
                  child: Image.asset(
                    property.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: property.isActive ? ThemeProvider.primaryAccent : Colors.black26,
                    child: Text(
                      property.isActive ? "Активно" : "Выключено",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  openHomeDetails(home) {
    Navigator.push (
      context,
      MaterialPageRoute(builder: (context) => UserPropertyEditScreen(home)),
    );
  }

  void openAddHomeScreen() {
    Navigator.push (
      context,
      MaterialPageRoute(builder: (context) => UserPropertyAddScreen()),
    );
  }
}
