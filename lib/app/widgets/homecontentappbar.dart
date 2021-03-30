import 'package:flutter/material.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/utils/fonts.dart';

Widget HomeContentAppBar(
    {@required BuildContext pageContext,
    String title = 'Sem título',
    int pagesLength = 1,
    int currentPage = 1,
    bool showActive = true,
    @required Function changeActive,
    String active}) {
  TextStyle textNormal = TextStyle(
      fontFamily: 'Fredoka One', fontSize: 16, color: Colors.grey[400]);
  TextStyle textActive =
      TextStyle(fontFamily: 'Fredoka One', fontSize: 16, color: primary_color);
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      showActive
          ? Container(
              margin: EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  changeActive('following');
                },
                child: Text(
                  'Seguindo',
                  style: active == 'following' ? textActive : textNormal,
                ),
              ),
            )
          : Container(),
      Container(
        child: GestureDetector(
          onTap: () {
            changeActive('discovery');
          },
          child: Text('Descubra',
              style: active == 'discovery' ? textActive : textNormal),
        ),
      )
    ]),
    centerTitle: true,
  );
}
