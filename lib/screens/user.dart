import 'package:flutter/material.dart';
import 'package:ucuchat/utils.dart';

const const_name = "Abraham Lincoln";
const const_email = "lincoln@ucu.edu.ua";
const const_phone = "+380123456789";

Container getTopText(text) {
  return Container(
    margin: const EdgeInsets.only(top: 80.0, bottom: 120.0),
    child: Text(
      text,
      style: AppTextStyles.robotoPurple21Bold,
    ),
  );
}

Container getPairText(key, value) {
  return Container(
    child: Column(
      children: [
        Text(key, style: AppTextStyles.robotoPurple18Bold),
        Text(value, style: AppTextStyles.robotoBlack18Reg),
      ],
    ),
    margin: EdgeInsets.only(top: 20.0),
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

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: getAppBarText('UCU Chat'),
        ),
        body: Column(
          children: [
            getTopText("User Page"),
            getUserInfoText(const_name, const_email, const_phone),
            Center(
                child: Container(
              child: getRedbutton(context, 'Back to chats', 'pop'),
              padding: EdgeInsets.only(top: 150.0),
            )),
          ],
        ));
  }
}
