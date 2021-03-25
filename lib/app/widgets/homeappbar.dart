import 'package:flutter/material.dart';

Widget HomeAppBar({
  @required BuildContext pageContext,
  String title = 'Sem título',
  int pagesLength = 1,
  int currentPage = 1,
  bool showBack = false,
}) {
  void backAction() {
    Navigator.pop(pageContext);
  }

  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: showBack
        ? IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: backAction)
        : IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Colors.black,
            ),
            onPressed: () {}),
    actions: [
      Center(
        child: Container(
          margin: EdgeInsets.only(right: 18),
          child: Text('$currentPage/$pagesLength',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Fredoka One',
                  fontSize: 12)),
        ),
      )
    ],
    title: Text(title,
        style: TextStyle(
            color: Colors.black, fontFamily: 'Fredoka One', fontSize: 16)),
    centerTitle: true,
  );
}
