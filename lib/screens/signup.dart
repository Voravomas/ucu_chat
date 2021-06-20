import 'package:flutter/material.dart';
import 'package:ucuchat/utils.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('UCU Chat'),
        ),
        body: Column(
          children: [
            getText("Enter your\nLogin\nEmail\nPhone\nPassword"),
            Center(child: getSomebutton(context, 'Register', '/')),
          ],
        ));
  }
}
