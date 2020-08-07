import 'package:http/http.dart' as http;

import 'base.dart';

class FacilitiesApi {

  static Future<http.Response> list() async {
    String uri = 'facilities';
    http.Response response = await ApiBase.get(relativeUrl: uri);
    return response;
  }

  static Future findByIds(List<dynamic> ids) async {
//    if (ids.isNotEmpty) {
//      QuerySnapshot querySnapshot = await Firestore.instance.collection("facilities").where(FieldPath.documentId, whereIn: ids).getDocuments();
//      return querySnapshot.documents;
//    }
//    return [];
  }
}