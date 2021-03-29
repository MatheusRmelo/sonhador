import 'package:flutter/material.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/utils/fonts.dart';

Widget HomeContentAppBar({
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
    title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(right: 16),
        child: Text(
          'Seguindo',
          style: TextStyle(
              fontFamily: 'Fredoka One', fontSize: 16, color: Colors.grey[400]),
        ),
      ),
      Text('Descubra',
          style: TextStyle(
              fontFamily: 'Fredoka One', fontSize: 16, color: primary_color))
    ]),
    centerTitle: true,
  );
}
