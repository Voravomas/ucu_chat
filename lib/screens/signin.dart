import 'package:flutter/material.dart';
import 'package:ucuchat/utils.dart';
import 'package:ucuchat/constants.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // redirects back to getStarted
    // if user is already authenticated
    if (isLogedIn == true) {
      Navigator.pop(context);
    }
    return Scaffold(
        appBar: AppBar(
          title: getAppBarText('UCU Chat'),
        ),
        body: Column(
          children: [
            getText("Enter your:\nLogin\nPassword"),
            Center(child: getSomebutton(context, 'Sign in', '/selectChat')),
            getText("Don't have an account?"),
            Center(child: getSomebutton(context, 'Sign up', '/signUp')),
          ],
        ));
  }
}
