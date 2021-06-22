import 'package:flutter/material.dart';
import 'package:ucuchat/utils.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('UCU Chat'),
        // ),
        body: Column(
      children: [
        getText("Mykyta [20:23]: Hello World!"),
        Center(child: getMockedbutton(context, 'Send')),
      ],
    ));
  }
}
