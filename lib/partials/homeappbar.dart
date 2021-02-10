import 'package:flutter/material.dart';

Widget HomeAppBar(
    {@required BuildContext pageContext,
    String title = 'Sem título',
    Function onChangeTitle}) {
  void backAction() {
    Navigator.pop(pageContext);
  }

  return AppBar(
    elevation: 0,
    backgroundColor: Color(0xFF483D3F),
    leading: Container(),
    actions: [
      Center(
        child: Container(
          margin: EdgeInsets.only(right: 18),
          child: Text('1/1',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Fredoka One',
                  fontSize: 12)),
        ),
      )
    ],
    title: Text(title,
        style: TextStyle(
            color: Colors.white, fontFamily: 'Fredoka One', fontSize: 16)),
    centerTitle: true,
  );
}
