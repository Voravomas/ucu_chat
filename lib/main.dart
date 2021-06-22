import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

//importing constants
import 'constants.dart';

// importing all screens
import 'screens/getstarted.dart';
import 'screens/signin.dart';
import 'screens/signup.dart';
import 'screens/selectchat.dart';
import 'screens/chat.dart';
import 'screens/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: primaryColor,
    ),
    initialRoute:
        FirebaseAuth.instance.currentUser == null ? '/' : '/selectChat',
    routes: {
      '/': (context) => GetStarted(),
      '/signIn': (context) => SignIn(),
      '/signUp': (context) => SignUp(),
      '/user': (context) => UserPage(),
      '/selectChat': (context) => SelectChat(),
      '/selectChat/chat': (context) => Chat(),
    },
  ));
}
