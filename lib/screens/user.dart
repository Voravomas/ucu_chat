import 'package:flutter/material.dart';
import 'package:ucuchat/utils.dart';

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: getAppBarText('UCU Chat'),
        ),
        body: Column(
          children: [
            getText("Name\nAbraham Lincoln\nEmail\n" +
                "lincoln@ucu.edu.ua\nPhone number\n+380123456789"),
            Center(child: getSomebutton(context, 'Back to chats', 'pop')),
          ],
        ));
  }
}
