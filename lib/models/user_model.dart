import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_model.g.dart';

@immutable
@JsonSerializable()
class User {
  // @JsonKey()
  final String id;
  final String name;
  final String imageUrl;
  final String occupation;
  final String email;
  final String phone;
  final List<dynamic> chatsList;
  final List<dynamic> personalChats;
  User({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.occupation,
    required this.email,
    required this.phone,
    required this.chatsList,
    required this.personalChats,
  });

  @override
  bool operator ==(other) =>
      other is User && other.id == id && other.name == name;

  @override
  int get hashCode => hashValues(id, name);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromDocument(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    // print(map);
    map["id"] = doc.id;

    return User.fromJson(map as Map<String, dynamic>);
  }
}

class UserSignUp {
  final String name;
  final String imageUrl;
  final String email;
  final String password;
  final String phone;
  final String occupation;
  final List chatsList;
  final List personalChats;

  UserSignUp({
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.password,
    required this.phone,
    required this.occupation,
    required this.chatsList,
    required this.personalChats,
  });
}
