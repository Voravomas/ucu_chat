import 'package:flutter/material.dart';
import 'package:ucuchat/utils.dart';
import 'package:ucuchat/constants.dart';

// TODO: set isLogedIn to context

String getNextPath(isLogedIn) {
  if (isLogedIn == false) {
    return '/signIn';
  } else {
    return '/selectChat';
  }
}

Container getWelcomeText(text) {
  return Container(
      margin: const EdgeInsets.only(top: 100.0, bottom: 50.0),
      child: Center(
        child: Text(text, style: AppTextStyles.robotoPurple21Bold),
      ));
}

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // isLogedIn will prevent users from authenticating twice
    String nextPath = getNextPath(isLogedIn);
    return Scaffold(
        appBar: AppBar(
          title: getAppBarText('UCU Chat'),
        ),
        body: Column(
          children: [
            getWelcomeText("Welcome to UCU Chat!"),
            Image.asset('assets/images/ucu_logo.png', scale: 0.8),
            Center(
                child: Container(
              child: getRedbutton(context, 'Get Started!', nextPath),
              padding: EdgeInsets.only(top: 50.0),
            )),
          ],
        ));
  }
}
