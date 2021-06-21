import 'package:flutter/material.dart';
import 'package:ucuchat/utils.dart';
import 'package:ucuchat/constants.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // isLogedIn will prevent users from authenticating twice
    String nextPath;
    if (isLogedIn == false) {
      //set isLogedIn to context
      nextPath = '/signIn';
    } else {
      nextPath = '/selectChat';
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('UCU Chat'),
        ),
        body: Column(
          children: [
            getText("Wellcome to UCU Chat!"),
            Center(child: getSomebutton(context, 'Get Started!', nextPath)),
          ],
        ));
  }
}
