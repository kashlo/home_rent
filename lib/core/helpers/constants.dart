import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Constants {
//  static final baseUrl = "http://138.68.251.193:3000";
  static final String authToken = "authToken";
  static final String oauthProviderFacebook = "facebook";

  static final String userIsAnonymous = "anonymousUser";

  static final kievCenter = LatLng(50.450963, 30.522573);

  static IO.Socket socket = IO.io('http://192.168.31.11:3000', <String, dynamic>{
  'transports': ['websocket'],
//  'query': {'homeId': widget.home.id},
//      'extraHeaders': {'homeId': widget.home.id, 'userId': user.uid} // optional
  });


}
