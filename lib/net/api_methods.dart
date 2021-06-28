import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ucuchat/models/user_model.dart';

Future<bool> addUser(UserSignUp user) async {
  print("in Add user");
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  print("Created users");
  try {
    var value = await users.doc(getCurrentUserId()).set({
      'name': user.name,
      'imgUrl': user.imageUrl,
      'email': user.email,
      'password': user.password,
      'phone': user.phone,
      'occupation': user.occupation
    });

    print("User Added: ${user.name}");
    return true;
  } catch (error) {
    print("Failed to add user ${user.name}: $error");
    return false;
  }
}

// bool haveMessages(String id1, id2) {
//   final messages1 = FirebaseFirestore.instance
//       .collection("messages")
//       .where("sender", isEqualTo: id1)
//       .where("receiver", isEqualTo: id2);
//   final messages2 = FirebaseFirestore.instance
//       .collection("messages")
//       .where("sender", isEqualTo: id2)
//       .where("receiver", isEqualTo: id1);

//   final List<Object> msg_list = messages2.snapshots().toList();
// }

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
