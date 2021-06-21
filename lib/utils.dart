import 'package:flutter/material.dart';
import 'package:ucuchat/constants.dart';

class AppTextStyles {
  static const TextStyle robotoPurple21Bold = TextStyle(
      color: primaryColor,
      fontWeight: FontWeight.w700,
      fontFamily: "Roboto",
      fontSize: 21);

  static const TextStyle robotoWhite21Bold = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontFamily: "Roboto",
      fontSize: 21);

  static const TextStyle robotoWhite18Bold = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontFamily: "Roboto",
      fontSize: 18);
}

ElevatedButton getSomebutton(context, text, url) {
  return ElevatedButton(
      child: Text(text),
      onPressed: () {
        if (url == 'pop') {
          Navigator.pop(context);
        } else {
          Navigator.pushNamed(context, url);
        }
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
        child: Text(text, style: AppTextStyles.robotoPurple21Bold),
      ));
}

Text getAppBarText(text) {
  return Text(text, style: AppTextStyles.robotoWhite21Bold);
}

ConstrainedBox getRedbutton(context, text, url) {
  return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 250, height: 60),
      child: ElevatedButton(
          child: Text(text, style: AppTextStyles.robotoWhite18Bold),
          onPressed: () {
            if (url == 'pop') {
              Navigator.pop(context);
            } else {
              Navigator.pushNamed(context, url);
            }
          },
          style: ElevatedButton.styleFrom(
            primary: primaryColor,
          )));
}
