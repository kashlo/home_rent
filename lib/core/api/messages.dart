//
//class MessagesApi {
//  static Future<List<DocumentSnapshot>> listByUserId(String userId) async {
//    QuerySnapshot querySnapshotFrom = await Firestore.instance.collection("chats")
//        .where('fromUserId', isEqualTo: userId)
//        .getDocuments();
//    QuerySnapshot querySnapshotTo = await Firestore.instance.collection("chats")
//        .where('toUserId', isEqualTo: userId)
//        .getDocuments();
//    return querySnapshotFrom.documents + querySnapshotTo.documents;
//  }
//
//  static Future<List<DocumentSnapshot>> list(String groupId) async {
////    QuerySnapshot querySnapshot = await Firestore.instance.collection("chats").document(groupId).collection("messages").getDocuments();
////    return querySnapshot.documents;
//  }
//
//  static Future<List<DocumentSnapshot>> add({String fromUserId, String toUserId, String homeId, String message, String nodeId}) async {
////    if (nodeId != null) {
////      await Firestore.instance.collection("chats").document(nodeId).collection("messages").add({'message': message});
////    } else {
////      DocumentReference doc = await Firestore.instance.collection("chats").add({"homeId": homeId, 'toUserId': toUserId, 'fromUserId': fromUserId});
////      await Firestore.instance.collection("chats").document(doc.documentID).collection("messages").add({'message': message});
////
////    }
//
////    print(querySnapshot.documents);
////    return querySnapshot.documents;
//  }
//
//  static Future<List<DocumentSnapshot>> findByUserAndHome({String userId, String homeId}) async {
//    print(">>>>>>>");
////    QuerySnapshot querySnapshot =
//    QuerySnapshot querySnapshot = await Firestore.instance.collection("chats")
//        .where('homeId', isEqualTo: homeId)
//        .where('fromUserId', isEqualTo: userId ).getDocuments();
////    querySnapshot.
//    return querySnapshot.documents;
////    print(querySnapshot.documents);
////    return querySnapshot.documents;
//  }
//}