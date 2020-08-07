import 'package:flutter/foundation.dart';

class Report {
  String id;
  String description;
  int userId;
  int propertyId;

  Report({
    this.id,
    @required this.description,
    this.userId,
    this.propertyId
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'propertyId': propertyId,
      'userId': userId
    };
  }
}