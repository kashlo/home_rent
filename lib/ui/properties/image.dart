import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  final int startWithIndex;
  final List<String> images;

  ImageScreen(this.images, this.startWithIndex);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.startWithIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.close), onPressed: ()=> Navigator.of(context).pop(),),
        actions: <Widget>[
          FlatButton(
              child: Text("${currentIndex + 1}/${widget.images.length}",
                style: TextStyle(fontSize: 16, color:Colors.black),)
          )
        ],
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    PageController pageViewController = PageController(
//    viewportFraction: 0.8,
      initialPage: widget.startWithIndex,
    );

    return Center(
      child: PageView(
        onPageChanged: (int pageIdx) {
          setState(() {
            currentIndex = pageIdx;
          });
        },
        controller: pageViewController,
        children: widget.images.asMap().entries.map<Widget>((item) => buildChild(item.value, item.key)).toList(),
      ),
    );
  }

  buildChild(String image, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(image),
      ],
    );
  }
}
