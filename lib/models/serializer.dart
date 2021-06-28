import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import 'package:ucuchat/models/user_model.dart';
import 'package:ucuchat/models/message_model.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _usersJson async {
  final path = await _localPath;
  return File('$path/users.json');
}

Future<File> get _messagesJson async {
  final path = await _localPath;
  return File('$path/messages.json');
}

Future<bool> checkIfUsersJsonExists() async {
  final file = await _usersJson;
  return file.exists();
}

void writeMessagesToJson(List<Message> msgList) async {
  final file = await _messagesJson;

  Map<String, dynamic> jsonMap = Map<String, dynamic>();

  for (int i = 0; i < msgList.length; ++i) {
    jsonMap[i.toString()] = msgList[i].toJson();
    // print(msgList[i].sender.name);
  }

  // print(jsonMap);
  // Write the file
  file.writeAsString(jsonEncode(jsonMap));
}

void writeUsersToJson(List<User> userList) async {
  // Map<String, dynamic> json
  final file = await _usersJson;

  Map<String, dynamic> jsonMap = Map<String, dynamic>();

  for (int i = 0; i < userList.length; ++i) {
    jsonMap[userList[i].id] = userList[i].toJson();
  }

  // Write the file
  file.writeAsString(jsonEncode(jsonMap));
}

Future<List<User>> loadUsersFromJson() async {
  try {
    final file = await _usersJson;
    // Read the file
    final contents = await file.readAsString();

    final Map<String, dynamic> json = jsonDecode(contents);

    List<User> users = <User>[]..length = json.length;

    json.forEach((key, value) {
      users.add(User.fromJson(value));
    });

    return users;
  } catch (e) {
    // If encountering an error, return 0
    return <User>[];
  }
}

Future<List<Message>> loadMessagesFromJson() async {
  try {
    final file = await _messagesJson;
    // Read the file
    final contents = await file.readAsString();

    final Map<String, dynamic> json = jsonDecode(contents);

    List<Message> msgs = <Message>[];
    json.forEach((key, value) {
      msgs.add(Message.fromJson(value));
    });

    return msgs;
  } catch (e) {
    print("caught ex");
    print(e);
    // If encountering an error, return 0
    return <Message>[];
  }
}
