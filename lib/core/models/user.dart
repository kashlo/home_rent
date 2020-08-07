import 'package:flutter/foundation.dart';

class User {
  int id;
  String firstName;
  String lastName;
  String email;
  String pictureUrl;
  String bio;
  String provider;
  String providerId;

  User({
    this.id,
    @required this.firstName,
    @required this.lastName,
    this.email,
    this.pictureUrl,
    this.bio,
    this.provider,
    this.providerId
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      pictureUrl: json['pictureUrl'],
      bio: json['bio'],
      providerId: json['providerId'],
      provider: json['provider'],
    );
  }

  Map<String, dynamic> toJson() {
    return       {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'pictureUrl': pictureUrl,
      'bio': bio,
      'providerId': providerId,
      'provider': provider
    };
  }
}