import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hellohome/core/models/property.dart';
import 'package:hellohome/theme.dart';

import 'image.dart';

class PropertyGalleryScreen extends StatefulWidget {
  final Property home;

  PropertyGalleryScreen(this.home);

  @override
  _PropertyGalleryScreenState createState() => _PropertyGalleryScreenState();
}

class _PropertyGalleryScreenState extends State<PropertyGalleryScreen> {

  List<String> images = [
    "assets/images/home1.jpg",
    "assets/images/home6.jpg",
    "assets/images/home2.jpg",
    "assets/images/home7.jpg",
    "assets/images/home3.jpg",
    "assets/images/home4.jpg",
    "assets/images/home8.jpg",
    "assets/images/home0.jpg",
    "assets/images/home6.jpg",
    "assets/images/home5.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: buildGallery(),
    );
  }

  buildGallery() {
    return StaggeredGridView.countBuilder(

      crossAxisCount: 4,
      itemCount: images.length,
//      padding: EdgeInsets.all(5),
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      itemBuilder: (BuildContext context, int index) => InkWell(
        onTap: () => openImageScreen(index),
        child: Container(
            color: ThemeProvider.primaryAccent,
            child: Image.asset(images[index], fit: BoxFit.cover),
        ),
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 2 : 1),
    );
  }

  void openImageScreen(int index) {
    Navigator.push (
      context,
      MaterialPageRoute(builder: (context) => ImageScreen(images, index)),
    );

  }
}
