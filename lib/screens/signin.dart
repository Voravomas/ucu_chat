import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ucuchat/net/flutterfire.dart';
import 'package:ucuchat/utils.dart';
import 'package:ucuchat/constants.dart';

Container getTopText(text) {
  return Container(
    margin: const EdgeInsets.only(top: 80.0, bottom: 15.0),
    child: Text(
      text,
      style: AppTextStyles.robotoRed21Bold,
    ),
  );
}

class LoginPassField extends StatefulWidget {
  @override
  LoginPassFieldState createState() => LoginPassFieldState();
}

class LoginPassFieldState extends State<LoginPassField> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            child: getInputPage("Enter your email", _emailController, false),
            padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0)),
        Padding(
            child:
                getInputPage("Enter your password", _passwordController, true),
            padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0)),
        Container(
            padding: EdgeInsets.only(top: 70.0),
            child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 250, height: 60),
                child: ElevatedButton(
                    child:
                        Text('Sign In', style: AppTextStyles.robotoWhite18Bold),
                    onPressed: () async {
                      bool shouldNavigate = await signIn(
                          _emailController.text, _passwordController.text);
                      if (shouldNavigate) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/selectChat', (route) => false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                    )))),
      ],
    );
  }
}

TextField getInputPage(text, controller, obscure) {
  const customBorderRadius = BorderRadius.all(Radius.circular(27.0));
  return TextField(
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: AppTextStyles.robotoBlack16Reg,
        fillColor: greyColor,
        // when field is not selected
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: greyColor),
            borderRadius: customBorderRadius),
        // when field is selected
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: customBorderRadius),
        filled: true,
        contentPadding:
            EdgeInsets.only(top: 21.0, bottom: 21.0, left: 20.0, right: 20.0),
      ));
}

// Container authAndRedirect(context, login, password, text, url) {
//   // add authentication
//   return Container(
//       padding: EdgeInsets.only(top: 70.0),
//       child: ConstrainedBox(
//           constraints: BoxConstraints.tightFor(width: 250, height: 60),
//           child: ElevatedButton(
//               child: Text(text, style: AppTextStyles.robotoWhite18Bold),
//               onPressed: () {
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

Container getGoSignUp(context) {
  return Container(
      padding: EdgeInsets.only(top: 40.0),
      child: new RichText(
          text: new TextSpan(
              text: 'Don’t have an account? ',
              style: AppTextStyles.robotoBlack18Reg,
              children: [
            new TextSpan(
              text: 'Sign up',
              style: AppTextStyles.robotoRed18Bold,
              recognizer: new TapGestureRecognizer()
                ..onTap = () => Navigator.pushNamed(context, "/signUp"),
            )
          ])));
}

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
            getTopText("Sign in"),
            LoginPassField(),
            // authAndRedirect(context, "aaa", "aaa", "Sign In", "/selectChat"),
            getGoSignUp(context)
          ],
        ));
  }
}
