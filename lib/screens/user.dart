import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ucuchat/constants.dart';
import 'package:ucuchat/net/api_methods.dart';
import 'package:ucuchat/screens/profile_settings.dart';
import 'package:ucuchat/utils.dart';

Container getPairText(key, value) {
  return Container(
    child: Column(
      children: [
        Text(key, style: AppTextStyles.robotoRed18Bold),
        SizedBox(
          height: 3,
        ),
        Text(value, style: AppTextStyles.robotoBlack18Reg),
        Divider(
          thickness: 1,
        ),
      ],
    ),
    margin: EdgeInsets.only(
      top: 10.0,
    ),
  );
}

Container getUserInfoText(name, email, phone) {
  return Container(
    child: Column(
      children: [
        getPairText("Name", name),
        getPairText("Email", email),
        getPairText("Phone", phone)
      ],
    ),
  );
}

class Avatar extends StatelessWidget {
  final String? imgUrl;
  const Avatar({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imgUrl == null) {
      return CircleAvatar(backgroundImage: AssetImage(default_user_logo));
    }
    return CircleAvatar(backgroundImage: NetworkImage(imgUrl!));
  }
}

class UserData extends StatelessWidget {
  final DocumentSnapshot? textFromDB;
  const UserData({Key? key, required this.textFromDB}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (textFromDB == null) {
      return Container(
          child: Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: CircularProgressIndicator(
                color: primaryColor,
              )));
    }
    return Container(
        child: getUserInfoText(
            textFromDB!['name'], textFromDB!['email'], textFromDB!['phone']));
  }
}

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final ImagePicker _picker = ImagePicker();

  String? _imgUrl;
  DocumentSnapshot? _textFromDB;

  @override
  void initState() {
    super.initState();
    avatarState();
    userDataState();
  }

  avatarState() {
    getDataFromFirestore().then((val) => setState(() {
          _imgUrl = val['imgUrl'];
        }));
  }

  userDataState() {
    getDataFromFirestore().then((val) => setState(() {
          _textFromDB = val;
        }));
  }

  _uploadImageToDB(image, uid) {
    final FirebaseStorage storage = FirebaseStorage.instance;

    Reference ref = storage.ref().child('user_profile/${uid}');
    UploadTask uploadTask = ref.putFile(File(image!.path));

    uploadTask.whenComplete(() async {
      var userLogoUrl = await ref.getDownloadURL();

      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({"imgUrl": userLogoUrl}).then((_) => avatarState());
    }).catchError((onError) {
      print(onError);
    });
  }

  _editAvatarButton() {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextButton(
          child: Icon(
            Icons.edit_rounded,
            color: Colors.white,
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: Colors.white, width: 2.0))),
          ),
          onPressed: () async {
            PickedFile? image =
                await _picker.getImage(source: ImageSource.gallery);
            _uploadImageToDB(image, getCurrentUserId());
          }),
    );
  }

  _footerButtons() {
    return Container(
        color: Color(0xfff0e9df),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: () {
                  changeLoginAndPasswordPopUp(context);
                },
                child: Row(children: [
                  Text(
                    'Change Login & Password',
                    style: TextStyle(color: primaryColor, fontSize: 15.0),
                  ),
                  SizedBox(
                    width: 3.0,
                  ),
                  Icon(
                    Icons.vpn_key,
                    color: primaryColor,
                  )
                ])),
            TextButton(
                onPressed: () {
                  changeSettingsPopUp(context, userDataState);
                },
                child: Row(
                  children: [
                    Text(
                      'Edit Profile',
                      style: TextStyle(color: primaryColor, fontSize: 15.0),
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    Icon(
                      Icons.settings,
                      color: primaryColor,
                    )
                  ],
                )),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 200,
            width: 200,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                Avatar(
                  imgUrl: _imgUrl,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: _editAvatarButton(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          UserData(
            textFromDB: _textFromDB,
          ),
          SizedBox(
            height: 10,
          ),
          getRedbutton(context, 'Sign-out', 'sign-out'),
        ],
      )),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(0.0),
        child: _footerButtons(),
      ),
    );
  }
}
