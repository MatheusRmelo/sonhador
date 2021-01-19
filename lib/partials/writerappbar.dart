import 'package:flutter/material.dart';

Widget WriterAppBar(
    {@required BuildContext pageContext,
    String title = 'Sem título',
    Function onChangeTitle}) {
  void backAction() {
    Navigator.pop(pageContext);
  }

  return AppBar(
    elevation: 0,
    backgroundColor: Color(0xFF9B9987),
    leading: IconButton(
      color: Colors.black,
      icon: Icon(Icons.close),
      onPressed: backAction,
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.edit),
        color: Colors.black,
        onPressed: () {
          onChangeTitle();
        },
      )
    ],
    title: Text(title,
        style: TextStyle(
            color: Colors.black, fontFamily: 'Fredoka One', fontSize: 16)),
    centerTitle: true,
  );
}
