import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  final String text;
  final Function onClick;
  ColoredButton(this.text, this.onClick);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onClick,
      child: Text(text),
      color: Colors.green,
      textColor: Colors.white,
    );
  }
}
