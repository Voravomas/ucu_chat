import 'package:flutter/material.dart';
import 'package:ucuchat/utils.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('UCU Chat'),
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