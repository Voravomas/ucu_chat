import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ucuchat/net/api_methods.dart';
import 'package:ucuchat/net/flutterfire.dart';
import 'package:ucuchat/utils.dart';
import 'package:ucuchat/screens/signin.dart';
import 'package:ucuchat/constants.dart';
import 'package:ucuchat/validation.dart';
import 'package:ucuchat/models/user_model.dart';

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

enum UserOccupation { student, teacher }

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key, required this.characterSetter})
      : super(key: key);
  final void Function(UserOccupation) characterSetter;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  UserOccupation? _character = UserOccupation.student;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('I am Student'),
          leading: Radio<UserOccupation>(
            value: UserOccupation.student,
            groupValue: _character,
            onChanged: (UserOccupation? value) {
              setState(() {
                _character = value;
                if (value != null) {
                  widget.characterSetter(value);
                }
              });
            },
          ),
        ),
        ListTile(
          title: const Text('I am Teacher'),
          leading: Radio<UserOccupation>(
            value: UserOccupation.teacher,
            groupValue: _character,
            onChanged: (UserOccupation? value) {
              setState(() {
                _character = value;
                if (value != null) {
                  widget.characterSetter(value);
                }
              });
            },
          ),
        ),
      ],
    );
  }
}

class RegisterPassField extends StatefulWidget {
  @override
  RegisterPassFieldState createState() => RegisterPassFieldState();
}

Future<bool> validateAndRegister(
    context, occupation, name, email, phone, password) async {
  if (validateName(name.text) == false) {
    showAlertDialog(context, "You have entered invalid name");
    name.clear();
    return false;
  }
  if (validateEmail(email.text) == false) {
    showAlertDialog(context, "You have entered invalid email");
    email.clear();
    return false;
  }
  if (validatePhone(phone.text) == false) {
    showAlertDialog(context, "You have entered invalid phone");
    phone.clear();
    return false;
  }
  if (validatePassword(password.text) == false) {
    showAlertDialog(context, "You have entered invalid password");
    password.clear();
    return false;
  }
  Map<String, String> resFromApi =
      await register(name.text, email.text, phone.text, password.text);
  if (resFromApi["ok"] == "false") {
    showAlertDialog(context, resFromApi["msg"]);
    return false;
  }

  String occupationString;
  if (occupation == UserOccupation.teacher) {
    occupationString = "Teacher";
  } else {
    occupationString = "Student";
  }

  UserSignUp user = UserSignUp(
      name: name.text,
      imageUrl: defaultImg,
      email: email.text,
      password: password.text,
      phone: phone.text,
      occupation: occupationString);
  addUser(user);
  return true;
}

class RegisterPassFieldState extends State<RegisterPassField> {
  TextEditingController _registerEmailController = TextEditingController();
  TextEditingController _registerPasswordController = TextEditingController();
  TextEditingController _registerNameController = TextEditingController();
  TextEditingController _registerPhoneController = TextEditingController();
  UserOccupation occupation = UserOccupation.student;
  MyStatefulWidget radioButton = MyStatefulWidget(characterSetter: (value) {});

  @override
  void initState() {
    super.initState();
    radioButton = MyStatefulWidget(
      characterSetter: (value) => occupation = value,
    );
  }

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
            child: getInputPage("Enter your phone number (+380)",
                _registerPhoneController, false),
            padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0)),
        Padding(
            child: getInputPage(
                "Enter your password", _registerPasswordController, true),
            padding: EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0)),
        radioButton,
        Container(
            padding: EdgeInsets.only(top: 70.0),
            child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 250, height: 60),
                child: ElevatedButton(
                    child:
                        Text('Sign Up', style: AppTextStyles.robotoWhite18Bold),
                    onPressed: () async {
                      bool shouldNavigate = await validateAndRegister(
                          context,
                          // TODO: get response from radio button
                          // now it is hardcoded
                          occupation,
                          _registerNameController,
                          _registerEmailController,
                          _registerPhoneController,
                          _registerPasswordController);
                      if (shouldNavigate) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home', (route) => false);
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
