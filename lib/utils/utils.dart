import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

launchScreen(context, String tag, {Object arguments}) {
  if (arguments == null) {
    Navigator.pushNamed(context, tag);
  } else {
    Navigator.pushNamed(context, tag, arguments: arguments);
  }
}

appText(String txt,
        {double size = 18.0,
        Color color = Colors.black,
        bool isBold = false}) =>
    Text(
      txt,
      style: TextStyle(
        fontSize: size,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color,
      ),
    );
