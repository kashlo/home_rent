import 'package:flutter/foundation.dart';

class Facility {
  int id;
  String name;

  Facility({
    @required this.id,
    @required this.name,
  });

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
        id: json["id"],
        name: json['name'],
    );
  }

}