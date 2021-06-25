import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String imageUrl;
  final String occupation;
  final String email;
  final String phone;
  User(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.occupation,
      required this.email,
      required this.phone});
}

class UserSignUp {
  final String name;
  final String imageUrl;
  final String email;
  final String password;
  final String phone;
  final String occupation;

  UserSignUp({
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.password,
    required this.phone,
    required this.occupation,
  });
}
