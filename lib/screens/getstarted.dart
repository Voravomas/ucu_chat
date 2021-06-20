import 'package:flutter/material.dart';
import 'package:ucuchat/utils.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('UCU Chat'),
        ),
        body: Column(
          children: [
            getText("Wellcome to UCU Chat!"),
            Center(child: getSomebutton(context, 'Get Started!', '/signIn')),
          ],
        ));
  }
}
