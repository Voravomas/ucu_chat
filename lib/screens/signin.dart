import 'package:flutter/material.dart';
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

Padding getInputPage(text) {
  const customBorderRadius = BorderRadius.all(Radius.circular(27.0));
  return Padding(
    padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
    child: TextField(
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
    )),
  );
}

Container getLogPass() {
  return Container(
    child: Column(
      children: [
        getInputPage("Enter your email"),
        getInputPage("Enter your password")
      ],
    ),
  );
}

Container authAndRedirect(context, login, password, text, url) {
  // add authentication
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

Container getGoSignUp() {
  return Container(
    padding: EdgeInsets.only(top: 40.0),
    child: Text(
      "Don’t have an account? Sign up",
      style: AppTextStyles.robotoBlack16Reg,
    ),
  );
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
            getLogPass(),
            authAndRedirect(context, "aaa", "aaa", "Sign In", "/selectChat"),
            getGoSignUp()
          ],
        ));
  }
}
