import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ucuchat/utils.dart';
import 'package:ucuchat/screens/signin.dart';
import 'package:ucuchat/constants.dart';

Container getGoSignIn(context) {
  return Container(
      padding: EdgeInsets.only(top: 40.0),
      child: new RichText(
          text: new TextSpan(
              text: 'Already have an account? ',
              style: AppTextStyles.robotoBlack18Reg,
              children: [
            new TextSpan(
              text: 'Sign in',
              style: AppTextStyles.robotoRed18Bold,
              recognizer: new TapGestureRecognizer()
                ..onTap = () => Navigator.pushNamed(context, "/signIn"),
            )
          ])));
}

Container registerAndRedirect(context, login, password, text, url) {
  // add registration
  return Container(
      padding: EdgeInsets.only(top: 70.0),
      child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 250, height: 60),
          child: ElevatedButton(
              child: Text(text, style: AppTextStyles.robotoWhite18Bold),
              onPressed: () {
                if (url == 'pop') {
                  Navigator.pop(context);
                } else {
                  Navigator.pushNamed(context, url);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
              ))));
}

class RegisterPassField extends StatefulWidget {
  @override
  RegisterPassFieldState createState() => RegisterPassFieldState();
}

class RegisterPassFieldState extends State<RegisterPassField> {
  final emailField = getInputPage("Enter your email");
  final passwordField = getInputPage("Enter your password");
  final nameField = getInputPage("Enter your name");
  final phoneField = getInputPage("Enter your phone number");
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            child: nameField,
            padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0)),
        Padding(
            child: emailField,
            padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0)),
        Padding(
            child: phoneField,
            padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0)),
        Padding(
            child: passwordField,
            padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0))
      ],
    );
  }
}

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: getAppBarText('UCU Chat'),
        ),
        body: Column(
          children: [
            getTopText("Sign up"),
            RegisterPassField(),
            authAndRedirect(context, "aaa", "aaa", "Sign Up", "/selectChat"),
            getGoSignIn(context),
          ],
        ));
  }
}
