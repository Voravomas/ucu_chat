import 'package:flutter/material.dart';
import 'package:ucuchat/utils.dart';

Container getTopText(text) {
  return Container(
    margin: const EdgeInsets.only(top: 80.0, bottom: 20.0),
    child: Text(
      text,
      style: AppTextStyles.robotoRed21Bold,
    ),
  );
}

Container getChatButton(context, text, url) {
  return Container(
    child: getGreybutton(context, text, url),
    margin: const EdgeInsets.only(top: 35.0),
  );
}

Container getChatList(context) {
  return Container(
    child: Column(
      children: [
        getChatButton(context, 'Students-Students', '/selectChat/chat'),
        getChatButton(context, 'Students-Teachers', '/selectChat/chat'),
        getChatButton(context, 'Teachers-Teachers', '/selectChat/chat')
      ],
    ),
  );
}

Container getRedButtonWithPadding(context, text, url) {
  return Container(
    child: getRedbutton(context, text, url),
    margin: const EdgeInsets.only(top: 35.0),
  );
}

Container getBottomButtons(context) {
  return Container(
    child: Column(
      children: [
        getRedButtonWithPadding(context, 'My account', '/user'),
        getRedButtonWithPadding(context, 'Sign out', '/')
      ],
    ),
    margin: const EdgeInsets.only(top: 35.0),
  );
}

class SelectChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: getAppBarText('UCU Chat'),
        ),
        body: Center(
            child: Column(
          children: [
            getTopText("Please choose a chat"),
            getChatList(context),
            getBottomButtons(context)
          ],
        )));
  }
}
