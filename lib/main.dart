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
    title: 'Navigation Basics',
    theme: ThemeData(
      primaryColor: primaryColor,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => GetStarted(),
      '/signIn': (context) => SignIn(),
      '/signUp': (context) => SignUp(),
      '/user': (context) => User(),
      '/selectChat': (context) => SelectChat(),
      '/selectChat/chat': (context) => Chat(),
    },
  ));
}
