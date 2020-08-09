import 'package:flutter/material.dart';

import '../constants.dart';

class BottomButton extends StatelessWidget {
  BottomButton({this.text, this.onTap});

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: kBottomContainerHeight,
        margin: EdgeInsets.only(top: 10.0),
        color: kBottomContainerColor,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
