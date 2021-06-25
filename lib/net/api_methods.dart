import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ucuchat/models/user_model.dart';

Future<bool> addUser(UserSignUp user) async {
  print("in Add user");
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  print("Created users");
  try {
    var value = await users.add({
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
