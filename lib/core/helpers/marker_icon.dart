import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Helper {
  static Future<Uint8List> markerIcon() async {
    ByteData data = await rootBundle.load('assets/icons/marker.png');
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 120);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  static Future<Uint8List> selectedMarkerIcon() async {
    ByteData data = await rootBundle.load('assets/icons/marker_selected.png');
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: 120);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  static Future<BitmapDescriptor> createCustomMarkerBitmap(String title, bool selected) async {
    TextSpan span = TextSpan(
      style: TextStyle(
        color: selected ? Colors.white : Colors.black,
        fontSize: 45.0,
        fontWeight: FontWeight.bold,
//        fontFamily: "RobotoMono"
      ),
      text: title,
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
//    Paint paint = Paint()
//      ..color = Color(0xFFFFFFFF);
////      ..style = PaintingStyle.stroke
////      ..strokeWidth = 2;
//
//    canvas.drawRect(
//      Rect.fromLTRB(
//          150.0, 100.0, 0.0, 0.0
//      ),
////      Paint()..color = Color(0xFFFFFFFF)
//      paint,
//    );
    //up

    double gap = 3;
    int smallMarkWidth = 2;

    RRect rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, 120, 50,),
        Radius.elliptical(10, 10));

//    Rect rect2 = Rect.fromLTRB(0, 0, 100, 100);
//    paintBorder(
//        canvas, rect2
//        , top: BorderSide(color: Colors.deepOrangeAccent, width: 2))
//    ;

//    int size = 100;

//    canvas.drawPath(getOuterPath(rect), paint);

//    canvas.drawRRect(
//        RRect.fromRectAndRadius(
//            Rect.fromLTWH(100, 150, 100, 50,),
//            Radius.circular(15.0)
//        ),
//        Paint()..color = Color(0xFFFFFFFF)
//    );

    tp.layout();
    int offset = 20;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, tp.size.width + offset, tp.size.height + offset),
          Radius.circular(30),

        ),
        Paint()..color = selected ? Colors.deepOrangeAccent : Colors.white
    );
    tp.paint(canvas, Offset(offset/ 2, offset/2));

//    tp.;

    /* Do your painting of the custom icon here, including drawing text, shapes, etc. */

    Picture p = recorder.endRecording();
    ByteData pngBytes = await (await p.toImage(tp.width.toInt() + 40, tp.height.toInt() + 20))
        .toByteData(format: ImageByteFormat.png);

    Uint8List data = Uint8List.view(pngBytes.buffer);

    return BitmapDescriptor.fromBytes(data);
  }
}