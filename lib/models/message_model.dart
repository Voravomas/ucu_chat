// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'message_model.g.dart';

@immutable
@JsonSerializable()
class Message {
  final String senderName;
  final String senderId;
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String content;

  Message({
    required this.senderName,
    required this.senderId,
    required this.time,
    required this.content,
  });

  @override
  bool operator ==(other) =>
      other is Message && other.senderName == senderName && other.time == time;

  @override
  int get hashCode => hashValues(senderName, time);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  factory Message.fromDocument(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    // print(map);
    map["id"] = doc.id;

    return Message.fromJson(map as Map<String, dynamic>);
  }
}
