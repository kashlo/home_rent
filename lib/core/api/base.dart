import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

class ApiBase {

  static final String _baseDevUrl = "http://192.168.31.11:3000/api/";
//  static final String _baseDevUrl = "https://hello-home-282809.ey.r.appspot.com/api/";


  static Future<http.Response> post({String uri, Map<String, dynamic> body, String token}) async {
    print(">>>>>>>>>>>>POST request");

    String url = '$_baseDevUrl$uri';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers.putIfAbsent("Authorization", ()=> "Bearer $token");
    }

    print("Request URL: $url");
    print("Request headers: $headers");
    print("Request body: $body");

    http.Response response = await http.post(url, headers: headers, body: jsonEncode(body));

    print("Response code: ${response.statusCode}");
    print("Response body: ${response.body}");

    return response;
  }

  static Future<http.Response> put({String uri, Map<String, dynamic> body, String token}) async {
    print(">>>>>>>>>>>>PUT request");

    String url = '$_baseDevUrl$uri';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers.putIfAbsent("Authorization", ()=> "Bearer $token");
    }
    http.Response response = await http.put(url, headers: headers, body: jsonEncode(body));
    print("Request URL: $url");
    print("Request headers: $headers");
    print("Request body: $body");
    print("Response code: ${response.statusCode}");
    print("Response body: ${response.body}");

    return response;
  }

  static Future<http.Response> get({String relativeUrl, String token}) async {
    print(">>>>>>>>>>>>GET request");

    String url = '$_baseDevUrl$relativeUrl';

//    Map<String, String> headers = {};
    Map<String, String> headers = {
//      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers.putIfAbsent("Authorization", ()=> "Bearer $token");
    }

    print("Request URL: $url");
    print("Request headers: $headers");

    http.Response response = await http.get(url, headers: headers);

    print("Response code: ${response.statusCode}");
    print("Response body: ${response.body}");
    return response;
  }

  static Future<http.Response> delete({String uri, String token}) async {
    print(">>>>>>>>>>>>DELETE request");

    String url = '$_baseDevUrl$uri';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers.putIfAbsent("Authorization", ()=> "Bearer $token");
    }
    http.Response response = await http.delete(url, headers: headers);

    print("Request URL: $url");
    print("Response code: ${response.statusCode}");
    print("Response body: ${response.body}");

    return response;
  }

  static Future<StreamedResponse> postMultipart({String uri, Map<String, dynamic> body, List<File> images, String token}) async {
    print(">>>>>>>>>>>>POST MULTIPART request");

    var url = Uri.parse('$_baseDevUrl$uri');

    Map<String, String> headers = {
      'Authorization': "Bearer $token",
      'Content-Type': 'multipart/form-data',
    };

    var request = http.MultipartRequest("POST", url);

    body.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    for (var file in images) {
      String fileName = file.path.split("/").last;
      ByteStream stream = http.ByteStream(DelegatingStream.typed(file.openRead()));

      int length = await file.length(); //imageFile is your image file

      // multipart that takes file
      MultipartFile multipartFileSign = http.MultipartFile('images', stream, length, filename: fileName);

      request.files.add(multipartFileSign);
    }

    request.headers.addAll(headers);
//    var file = await http.MultipartFile.fromPath(
//        'avatar',
//        image.path,
//        contentType: MediaType('image', 'png')
////    );
//    print(file);
//    request.files.add(file);
//
    //StreamedResponse streamedResponse = await request.send();
//    http.Response response = await http.Response.fromStream(streamedResponse);

    // send
    StreamedResponse response = await request.send();

    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });


    print("Request URL: $url");
    print("Request BODY: ${request.fields}");
    print("Request FILES: ${request.files}");

    print("Response code: ${response.statusCode}");
    print("Response body: ${response.stream}");
    return response;

  }
}