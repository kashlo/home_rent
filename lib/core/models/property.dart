import 'dart:math';

import 'package:flutter/foundation.dart';

import 'facility.dart';

class Property {
  int id;
  PropertyType type = PropertyType.apartment;
  int roomCount;
  int square;
  String address;
  String description;
  double lat;
  double lng;
  List<Facility> facilities;
  int userId;
  bool isActive;
  int price;
  PriceCurrency priceCurrency = PriceCurrency.uah;
  int floor;
  bool animalsAllowed;
  bool childrenAllowed;
  String image;

  Property({
    this.id,
    @required this.address,
    this.type,
    this.description,
    this.roomCount,
    this.square,
    this.lat,
    this.lng,
    this.facilities,
    this.userId,
    this.isActive = true,
    this.price,
    this.priceCurrency,
    this.floor,
    this.animalsAllowed,
    this.childrenAllowed
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    Random random = Random();
    int randomNumber = random.nextInt(5);
    Property property = Property(
      id: json['id'],
      address: json['address'],
      description: json['description'],
      userId: json['userId'],
      isActive: json['isActive'],
      price: json['price'],
      priceCurrency: currencyFromJson(json['priceCurrency']),
      roomCount: json['rooms'],
      square: json['square'],
//      lat: json['position'].latitude,
//      lng: json['position'].longitude,
      type: typeFromJson(json['type']),
      floor: json['floor'],
      facilities: json['Facilities'] != null ? json['Facilities'].map<Facility>((item) => Facility.fromJson(item)).toList() : null,
      animalsAllowed: json['animalsAllowed'],
      childrenAllowed: json['childrenAllowed'],
    );
    property.image = "assets/images/home$randomNumber.jpg";
    return property;
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'description': description,
      'userId': userId,
      'isActive': isActive,
      'type': typeToJson(type),
//      'position': GeoPoint(lat, lng),
      'price': price,
      'priceCurrency': currencyToJson(priceCurrency),
      'square': square,
      'roomCount': roomCount,
      'floor': floor,
      'animalsAllowed': animalsAllowed,
      'facilities': facilities.map((facility) => facility.id).toList()
    };
  }

  static PropertyType typeFromJson(String type) {
    if (type == "FLAT") {
      return PropertyType.apartment;
    } else if (type == "ROOM") {
      return PropertyType.room;
    } else if (type == "HOUSE") {
      return PropertyType.house;
    }
  }

  static String typeToJson(PropertyType type) {
    if (type == PropertyType.apartment) {
      return "FLAT";
    } else if (type == PropertyType.room) {
      return "ROOM";
    } else if (type == PropertyType.house) {
      return "HOUSE";
    }
  }

  static PriceCurrency currencyFromJson(String currency) {
    if (currency == "UAH") {
      return PriceCurrency.uah;
    } else if (currency == "USD") {
      return PriceCurrency.usd;
    }
  }

  static String currencyToJson(PriceCurrency currency) {
    if (currency == PriceCurrency.uah) {
      return "UAH";
    } else if (currency == PriceCurrency.usd) {
      return "USD";
    }
  }

//  get image {
//    Random random = Random();
//    int randomNumber = random.nextInt(5);
//    return "assets/images/home$randomNumber.jpg";
//  }

  List<String> get images {
     return [
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
  }

  get priceFrmt {
    return price.toString() + "₴";
  }

}

enum PropertyType {
  apartment,
  room,
  house,
}

enum PriceCurrency {
  uah,
  usd,
}