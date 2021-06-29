import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ucuchat/models/user_model.dart';

Future<bool> addUser(UserSignUp user) async {
  print("in Add user");
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  print("Created users");
  print(user.chatsList);
  try {
    var value = await users.doc(getCurrentUserId()).set({
      'name': user.name,
      'imgUrl': user.imageUrl,
      'email': user.email,
      'password': user.password,
      'phone': user.phone,
      'occupation': user.occupation,
      'chatsList': user.chatsList,
      'personalChats': user.personalChats,
    });

    print("User Added: ${user.name}");
    // Just for debug
    // addNewChat(getCurrentUserId(), "8f0MzWxhUjM9bo5yqrPFI5j6LWO2", user.name,
    //     'Serj Miskiv', []);
    return true;
  } catch (error) {
    print("Failed to add user ${user.name}: $error");
    return false;
  }
}

Future<DocumentSnapshot> getDataFromFirestore() async {
  DocumentSnapshot data = await FirebaseFirestore.instance
      .collection('users')
      .doc(getCurrentUserId())
      .get();
  return data;
}

String getCurrentUserId() {
  return FirebaseAuth.instance.currentUser!.uid;
}

addChatToUsers(String yourId, String notYourId, String chatId) {
  FirebaseFirestore.instance.collection('users').doc(yourId).update(
    {
      'personalChats': FieldValue.arrayUnion([
        {'userId': notYourId, 'chatId': chatId}
      ])
    },
  );

  FirebaseFirestore.instance.collection('users').doc(notYourId).update(
    {
      'personalChats': FieldValue.arrayUnion([
        {'userId': yourId, 'chatId': chatId}
      ])
    },
  );
}

Future<String> addNewChat(String creatorID, String receiverID,
    String creatorName, String receiverName, List allChats) async {
  bool exists = false;
  String existingId = '';
  for (var chat in allChats) {
    if (chat['userId'] == receiverID) {
      exists = true;
      existingId = chat['chatId'];
    }
  }
  if (exists) {
    return existingId;
  } else {
    final String chatName = '$creatorName and $receiverName';
    DocumentReference ref =
        await FirebaseFirestore.instance.collection('messages').add({
      'chatName': chatName,
    });
    addChatToUsers(creatorID, receiverID, ref.id);
    // Creating full path for message, maybe need to delete this
    FirebaseFirestore.instance
        .collection('messages')
        .doc(ref.id)
        .collection('messages')
        .add({});
    return ref.id;
  }
}

addMessage(String chatId, String content, String userName, String userId) {
  FirebaseFirestore.instance
      .collection('messages')
      .doc(chatId)
      .collection('messages')
      .add({
    'content': content,
    'senderName': userName,
    'senderId': userId,
    'time': FieldValue.serverTimestamp()
  });
}
