import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hellohome/core/blocs/favorites/list/bloc.dart';
import 'package:hellohome/core/blocs/favorites/list/event.dart';
import 'package:hellohome/core/blocs/favorites/list/state.dart';
import 'package:hellohome/core/models/property.dart';

import '../theme.dart';
import 'components/drawer.dart';
import 'components/snack_bar.dart';
import 'properties/details.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  List<Property> properties;

  @override
  void initState() {
    context.bloc<FavoritesBloc>().add(FavoritesListRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Избранное"),),
      drawer: HelloHomeDrawer(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return BlocConsumer<FavoritesBloc, FavoritesState>(
        listener: (context, state) {
          if (state is FavoritesEditSuccess) {
            HelloHomeSnackBar(context).show("Избранное обновлено", SnackBarType.info);
          }
        },
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is FavoritesFetched) {
            properties = List.from(state.properties);
            return ListView(
              children: state.properties.map<Widget>((home) => buildPropertyItem(home, state.properties)).toList()
            );
          }

          if (state is FavoritesEditSuccess) {
            return ListView(
                children: properties.map<Widget>((home) => buildPropertyItem(home, state.properties)).toList()
            );
          }
          return Container();
        }
    );
  }

  buildPropertyItem(Property property, List<Property> currentProperties) {
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
                      width: 50, height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: IconButton(
                    onPressed: () => currentProperties.contains(property) ? deleteFromFavs(property) : addToFavs(property),
                    icon: Icon(currentProperties.contains(property) ? Icons.favorite : Icons.favorite_border, size: 30, color: Colors.deepOrangeAccent,)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openHomeDetails(Property property) {
    Navigator.push (
      context,
      MaterialPageRoute(builder: (context) => PropertyDetailsScreen(property)),
    );
  }

  void deleteFromFavs(Property property) {
    context.bloc<FavoritesBloc>().add(FavoritesDeletePressed(property));
  }

  void addToFavs(Property property) {
    context.bloc<FavoritesBloc>().add(FavoritesAddPressed(property));
  }
}
