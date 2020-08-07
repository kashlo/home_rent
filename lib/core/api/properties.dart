import 'package:http/http.dart' as http;

import 'base.dart';

class PropertiesApi {

  static Future<http.Response> list({Map<String, dynamic> searchFilter}) async {
    String queryParams = '';
    if (searchFilter != null) {
      queryParams = queryParams + "?";
      searchFilter.forEach((key, value) {
        queryParams = queryParams + '&$key=$value';
      });
    }

    String uri = 'properties' + queryParams;
    http.Response response = await ApiBase.get(relativeUrl: uri);
    return response;
  }

  static Future get(String id) async {
//    DocumentSnapshot documentSnapshot = await firestore.collection("homes").document(id).get();
//    return documentSnapshot;
////    print(querySnapshot.documents);
////    return querySnapshot.documents;
  }


}