import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ucuchat/constants.dart';
import 'package:ucuchat/net/api_methods.dart';
import 'package:ucuchat/utils.dart';
import 'package:ucuchat/validation.dart';

TextFormField getInputText(label, icon, controller) {
  return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        icon: icon,
      )
  );
}

changeSettingsPopUp(context, Function refresh) async {
  DocumentSnapshot data = await getDataFromFirestore();
  TextEditingController _updateNameController = TextEditingController(text: data['name']);
  TextEditingController _updateEmailController = TextEditingController(text: data['email']);
  TextEditingController _updatePhoneController = TextEditingController(text: data['phone']);

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Change User Data'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: <Widget> [
                  getInputText('Name', Icon(Icons.account_box), _updateNameController),
                  getInputText('Email', Icon(Icons.email), _updateEmailController),
                  getInputText('Phone', Icon(Icons.phone), _updatePhoneController),
                ],
              ),
            ),
          ),
          actions: [
            Row (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 80,
                  child: ElevatedButton(
                      child: Text("Cancel"),
                      style: ElevatedButton.styleFrom( primary: Colors.grey,),
                      onPressed: () { Navigator.pop(context); }
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: primaryColor,),
                      child: Text("Save"),
                      onPressed: () async {
                        bool shouldNavigate = await validateAndUpdateDB(
                            context,
                            _updateNameController,
                            _updateEmailController,
                            _updatePhoneController);
                        updateUserData(refresh,
                            _updateNameController.text,
                            _updateEmailController.text,
                            _updatePhoneController.text);
                        if (shouldNavigate) {
                          Navigator.pop(context);
                        }
                      }
                  ),
                )
              ]),
          ],);
      });
}

Future<bool> validateAndUpdateDB(context, name, email, phone) async {
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

  // udate data in firestore
  // updateUserData(name.text, email.text, phone.text, refresh);
  return true;
}

Future<bool> updateUserData(Function refresh, name, email, phone) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  try {
    await users.doc(getCurrentUserId()).update({
      'name': name,
      'email': email,
      'phone': phone,
    }).then((_) => refresh());
    return true;
  } catch (error) {
    print("Failed to update user data : $error");
    return false;
  }
}

// change password and login

changeLoginAndPasswordPopUp(context) async {
  DocumentSnapshot data = await getDataFromFirestore();
  TextEditingController _updateLoginController = TextEditingController(text: data['email']);
  TextEditingController _updatePasswordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();


  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Change Login and Password'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: <Widget> [
                  getInputText('Login', Icon(Icons.account_box), _updateLoginController),
                  getInputText('Enter New Password', Icon(Icons.vpn_key_outlined), _updatePasswordController),
                  getInputText('Repeat New Password', Icon(Icons.vpn_key_outlined), _repeatPasswordController),
                ],
              ),
            ),
          ),
          actions: [
            Row (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                        child: Text("Cancel"),
                        style: ElevatedButton.styleFrom( primary: Colors.grey,),
                        onPressed: () { Navigator.pop(context); }
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: primaryColor,),
                        child: Text("Save"),
                        onPressed: () async {
                          bool shouldNavigate = await validateLoginAndPassword(
                            context,
                            _updateLoginController,
                            _updatePasswordController,
                            _repeatPasswordController
                          );
                          if (shouldNavigate) { Navigator.pop(context); }
                        }
                    ),
                  )
                ]),
          ],);
      });
}

Future<bool> validateLoginAndPassword(context, login, newPassword, repeatedPassword) async {
  if(newPassword != repeatedPassword) {
    showAlertDialog(context, "You didn't repeat password correct. "
        "Please try one more time.");
  }
  if (validateEmail(login.text) == false) {
    showAlertDialog(context, "You have entered invalid email");
    login.clear();
    return false;
  }
  if (validatePassword(newPassword.text) == false) {
    showAlertDialog(context, "You have entered invalid password");
    newPassword.clear();
    return false;
  }
  changeLoginAndPassword(context, newPassword.text, login.text);
  return true;
}

void changeLoginAndPassword(context, String newPassword, String login) async {
  User? user = FirebaseAuth.instance.currentUser;

  user!.updatePassword(newPassword).then((_){
    print("Successfully changed password");
  }).catchError((error){
    print("Password can't be changed" + error.toString());
    showAlertDialog(context, "Password and Login wasn't changed. "
        "Try to re-authenticate.");
  });
  user.updateEmail(login).then((_){
    print("Successfully changed login");
  }).catchError((error){
    print("Login can't be changed" + error.toString());
    showAlertDialog(context, "Password and Login wasn't changed. "
        "Try to re-authenticate.");
  });
}
