// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ucuchat/models/user_model.dart';
import 'serializer.dart';
part 'message_model.g.dart';

@immutable
@JsonSerializable()
class Message {
  final String senderName;
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String content;
  // final bool isLiked;
  // final bool unread;
  // final String receiver;

  Message({
    required this.senderName,
    // required this.receiver,
    required this.time,
    required this.content,
    // required this.isLiked,
    // required this.unread,
  });

  @override
  bool operator ==(other) =>
      other is Message && other.senderName == senderName && other.time == time;
  // &&
  // other.text == text;

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

// // YOU - current user
// final User currentUser = User(
//   id: '0',
//   name: 'Current User',
//   imageUrl: 'assets/images/greg.jpg',
//   occupation: 'Student',
//   email: 'test@gmail.com',
//   phone: '0671111111',
// );

// // USERS
// final User greg = User(
//   id: '1',
//   name: 'Greg',
//   imageUrl: 'assets/images/greg.jpg',
//   occupation: 'Student',
//   email: 'test@gmail.com',
//   phone: '0671111111',
// );
// final User james = User(
//   id: '2',
//   name: 'James',
//   imageUrl: 'assets/images/james.jpg',
//   occupation: 'Student',
//   email: 'test@gmail.com',
//   phone: '0671111111',
// );
// final User john = User(
//   id: '3',
//   name: 'John',
//   imageUrl: 'assets/images/john.jpg',
//   occupation: 'Student',
//   email: 'test@gmail.com',
//   phone: '0671111111',
// );
// final User olivia = User(
//   id: '4',
//   name: 'Olivia',
//   imageUrl: 'assets/images/olivia.jpg',
//   occupation: 'Student',
//   email: 'test@gmail.com',
//   phone: '0671111111',
// );
// final User sam = User(
//   id: '5',
//   name: 'Sam',
//   imageUrl: 'assets/images/sam.jpg',
//   occupation: 'Student',
//   email: 'test@gmail.com',
//   phone: '0671111111',
// );
// final User sophia = User(
//   id: '6',
//   name: 'Sophia',
//   imageUrl: 'assets/images/sophia.jpg',
//   occupation: 'Student',
//   email: 'test@gmail.com',
//   phone: '0671111111',
// );
// final User steven = User(
//   id: '7',
//   name: 'Steven',
//   imageUrl: 'assets/images/steven.jpg',
//   occupation: 'Student',
//   email: 'test@gmail.com',
//   phone: '0671111111',
// );

// // FAVORITE CONTACTS
// List<User> favorites = [sam, steven, olivia, john, greg];

// // EXAMPLE CHATS ON HOME SCREEN
// // List<Message> chats = [
// //   Message(
// //     sender: james,
// //     time: '5:30 PM',
// //     text: 'Hey, how\'s it going? What did you do today?',
// //     isLiked: false,
// //     unread: true,
// //   ),
// //   Message(
// //     sender: olivia,
// //     time: '4:30 PM',
// //     text: 'Hey, how\'s it going? What did you do today?',
// //     isLiked: false,
// //     unread: true,
// //   ),
// //   Message(
// //     sender: john,
// //     time: '3:30 PM',
// //     text: 'Hey, how\'s it going? What did you do today?',
// //     isLiked: false,
// //     unread: false,
// //   ),
// //   Message(
// //     sender: sophia,
// //     time: '2:30 PM',
// //     text: 'Hey, how\'s it going? What did you do today?',
// //     isLiked: false,
// //     unread: true,
// //   ),
// //   Message(
// //     sender: steven,
// //     time: '1:30 PM',
// //     text: 'Hey, how\'s it going? What did you do today?',
// //     isLiked: false,
// //     unread: false,
// //   ),
// //   Message(
// //     sender: sam,
// //     time: '12:30 PM',
// //     text: 'Hey, how\'s it going? What did you do today?',
// //     isLiked: false,
// //     unread: false,
// //   ),
// //   Message(
// //     sender: greg,
// //     time: '11:30 AM',
// //     text: 'Hey, how\'s it going? What did you do today?',
// //     isLiked: false,
// //     unread: false,
// //   ),
// // ];

// // // EXAMPLE MESSAGES IN CHAT SCREEN
// // List<Message> messages = [
// //   Message(
// //     sender: james,
// //     time: '5:30 PM',
// //     text: 'Hey, how\'s it going? What did you do today?',
// //     isLiked: true,
// //     unread: true,
// //   ),
// //   Message(
// //     sender: currentUser,
// //     time: '4:30 PM',
// //     text: 'Just walked my doge. She was super duper cute. The best pupper!!',
// //     isLiked: false,
// //     unread: true,
// //   ),
// //   Message(
// //     sender: james,
// //     time: '3:45 PM',
// //     text: 'How\'s the doggo?',
// //     isLiked: false,
// //     unread: true,
// //   ),
// //   Message(
// //     sender: james,
// //     time: '3:15 PM',
// //     text: 'All the food',
// //     isLiked: true,
// //     unread: true,
// //   ),
// //   Message(
// //     sender: currentUser,
// //     time: '2:30 PM',
// //     text: 'Nice! What kind of food did you eat?',
// //     isLiked: false,
// //     unread: true,
// //   ),
// //   Message(
// //     sender: james,
// //     time: '2:00 PM',
// //     text: 'I ate so much food today.',
// //     isLiked: false,
// //     unread: true,
// //   ),
// // ];

// void dumpUsersTofile() {
//   final userList = <User>[greg, james, olivia];
//   writeUsersToJson(userList);
// }
