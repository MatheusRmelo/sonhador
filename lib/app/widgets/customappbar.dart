import 'package:flutter/material.dart';

Widget CustomAppBar(
    {BuildContext pageContext,
    String title = '',
    Color color,
    Color itemsColor,
    bool backButton = true}) {
  return AppBar(
    brightness: Brightness.dark,
    backgroundColor: color == null ? Color(0xFF9B9987) : color,
    elevation: 0,
    centerTitle: false,
    title: Text(
      title,
      style: TextStyle(
          color: itemsColor == null ? Colors.black : itemsColor,
          fontSize: 16,
          fontFamily: 'Fredoka One'),
    ),
    leading: backButton
        ? IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: itemsColor == null ? Colors.black : itemsColor,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(pageContext);
            })
        : Container(),
  );
}
