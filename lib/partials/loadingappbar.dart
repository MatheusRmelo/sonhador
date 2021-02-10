import 'package:flutter/material.dart';

Widget LoadingAppBar(
    {@required BuildContext pageContext, @required Color color}) {
  return AppBar(
    elevation: 0,
    leading: Container(),
    backgroundColor: color,
    title: Container(),
    centerTitle: true,
  );
}
