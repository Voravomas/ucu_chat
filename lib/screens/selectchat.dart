import 'package:flutter/material.dart';
import 'package:ucuchat/utils.dart';

class SelectChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('UCU Chat'),
        ),
        body: Column(
          children: [
            getText("Please choose a chat"),
            Center(
                child: getSomebutton(
                    context, 'Students-Students', '/selectChat/chat')),
            Center(
                child: getSomebutton(
                    context, 'Students-Teachers', '/selectChat/chat')),
            Center(
                child: getSomebutton(
                    context, 'Teachers-Teachers', '/selectChat/chat')),
            getText("      "), // rewrite this
            Center(child: getSomebutton(context, 'My account', '/user')),
            Center(child: getSomebutton(context, 'Sign out', '/')),
          ],
        ));
  }
}
