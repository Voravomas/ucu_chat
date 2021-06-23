import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, String>> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return {"ok": "true", "msg": ""};
  } catch (e) {
    print(e);
    return {"ok": "false", "msg": e.toString()};
  }
}

Future<Map<String, String>> register(
    String name, String email, String phone, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return {"ok": "true", "msg": ""};
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return {"ok": "false", "msg": e.code};
  } catch (e) {
    print(e.toString());
    return {"ok": "false", "msg": e.toString()};
  }
}
