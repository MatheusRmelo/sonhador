import 'package:flutter/material.dart';

Widget CustomAppBar({BuildContext pageContext, String title = ''}) {
  return AppBar(
    brightness: Brightness.dark,
    backgroundColor: Color(0xFF9B9987),
    elevation: 0,
    centerTitle: false,
    title: Text(
      title,
      style: TextStyle(
          color: Colors.black, fontSize: 16, fontFamily: 'Fredoka One'),
    ),
    leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 30,
        ),
        onPressed: () {
          Navigator.pop(pageContext);
        }),
  );
}
