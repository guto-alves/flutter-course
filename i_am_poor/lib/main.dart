import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('I Am Poor'),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Image(
            image: AssetImage("images/homeless_help.png"),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
