import 'package:flutter/material.dart';
import 'package:sonhador/app/utils/colors.dart';

Widget TabsAppBar(
    {BuildContext pageContext,
    String title = '',
    Color color,
    Color itemsColor,
    bool backButton = true,
    List<Widget> tabs}) {
  // if (tabs == null) {
  //   tabs.add(Container());
  // }
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
              FocusScope.of(pageContext).unfocus();
              Navigator.pop(pageContext);
            })
        : Container(),
    bottom: TabBar(
      tabs: tabs,
      indicatorColor: secondary_color,
    ),
  );
}
