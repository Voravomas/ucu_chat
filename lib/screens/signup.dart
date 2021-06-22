import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ucuchat/net/flutterfire.dart';
import 'package:ucuchat/screens/selectchat.dart';
import 'package:ucuchat/utils.dart';
import 'package:ucuchat/screens/signin.dart';
import 'package:ucuchat/constants.dart';

Container getTopText(text) {
  return Container(
    margin: const EdgeInsets.only(top: 80.0, bottom: 20.0),
    child: Text(
      text,
      style: AppTextStyles.robotoRed21Bold,
    ),
  );
}

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

// Container registerAndRedirect(context, login, password, text, url) {
//   // add registration
//   return Container(
//       padding: EdgeInsets.only(top: 70.0),
//       child: ConstrainedBox(
//           constraints: BoxConstraints.tightFor(width: 250, height: 60),
//           child: ElevatedButton(
//               child: Text(text, style: AppTextStyles.robotoWhite18Bold),
//               onPressed: () async {
//                 bool shouldNavigate =
//                     await register(, email, phone, password);
//                 if (url == 'pop') {
//                   Navigator.pop(context);
//                 } else {
//                   Navigator.pushNamed(context, url);
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: primaryColor,
//               ))));
// }

class RegisterPassField extends StatefulWidget {
  @override
  RegisterPassFieldState createState() => RegisterPassFieldState();
}

class RegisterPassFieldState extends State<RegisterPassField> {
  TextEditingController _registerEmailController = TextEditingController();
  TextEditingController _registerPasswordController = TextEditingController();
  TextEditingController _registerNameController = TextEditingController();
  TextEditingController _registerPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            child:
                getInputPage("Enter your name", _registerNameController, false),
            padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0)),
        Padding(
            child: getInputPage(
                "Enter your email", _registerEmailController, false),
            padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0)),
        Padding(
            child: getInputPage(
                "Enter your phone number", _registerPhoneController, false),
            padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0)),
        Padding(
            child: getInputPage(
                "Enter your password", _registerPasswordController, true),
            padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0)),
        Container(
            padding: EdgeInsets.only(top: 70.0),
            child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 250, height: 60),
                child: ElevatedButton(
                    child:
                        Text('Sign Up', style: AppTextStyles.robotoWhite18Bold),
                    onPressed: () async {
                      bool shouldNavigate = await register(
                          _registerNameController.text,
                          _registerEmailController.text,
                          _registerPhoneController.text,
                          _registerPasswordController.text);
                      if (shouldNavigate) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/selectChat', (route) => false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                    ))))
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
            // registerAndRedirect(
            //     context, "aaa", "aaa", "Sign Up", "/selectChat"),
            getGoSignIn(context),
          ],
        ));
  }
}
