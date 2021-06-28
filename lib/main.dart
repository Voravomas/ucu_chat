import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/serializer.dart';
import 'models/message_model.dart';
import 'models/user_model.dart';

//importing constants
import 'constants.dart';

// importing all screens
import 'screens/getstarted.dart';
import 'screens/signin.dart';
import 'screens/signup.dart';
import 'screens/home.dart';
import 'screens/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // final file = await _usersJson;

  // dumpUsersTofile();
  // writeMessagesToJson(chats);

  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: primaryColor,
    ),
    initialRoute: FirebaseAuth.instance.currentUser == null ? '/' : '/home',
    routes: {
      '/': (context) => GetStarted(),
      '/signIn': (context) => SignIn(),
      '/signUp': (context) => SignUp(),
      '/user': (context) => UserPage(),
      '/home': (context) => Home(),
      // '/selectChat/chat': (context) => Chat(),
    },
  ));
}
