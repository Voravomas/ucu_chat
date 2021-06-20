import 'package:flutter/material.dart';
import 'package:ucuchat/constants.dart';

ElevatedButton getSomebutton(context, text, url) {
  return ElevatedButton(
      child: Text(text),
      onPressed: () {
        Navigator.pushNamed(context, url);
      },
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
      ));
}

ElevatedButton getMockedbutton(context, text) {
  return ElevatedButton(
      child: Text(text),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
      ));
}

Container getBigRedBox() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.red,
    ),
    height: 200,
    width: 200,
  );
}

Container getText(text) {
  return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: Text(text),
      ));
}
