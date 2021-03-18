import 'package:flutter/material.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/widgets/profilebox.dart';

class UserBox extends StatelessWidget {
  UserBox(
      {@required this.userId,
      @required this.userName,
      this.onTap,
      this.width = 80,
      this.height = 80,
      this.color,
      this.margin,
      this.points,
      this.photo,
      this.showName = false});

  final String userId;
  final String userName;
  final Function onTap;
  final double width;
  final double height;
  final Color color;
  final EdgeInsets margin;
  final String points;
  final String photo;
  final bool showName;

  @override
  Widget build(BuildContext context) {
    TextStyle smallText = TextStyle(
        color: Color(0xFF969191), fontSize: 8, fontFamily: 'Fredoka One');
    TextStyle footerText =
        TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Fredoka One');
    return Container(
      margin: margin == null ? EdgeInsets.all(16) : margin,
      child: GestureDetector(
        onTap: () {
          onTap(userId);
        },
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width / 2),
                  color: color == null ? Color(0xFF483D3F) : color,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset.fromDirection(1, 3),
                        spreadRadius: 0)
                  ]),
              child: ProfileBox(
                photoURL: photo,
                color: showName ? secondary_color : primary_color,
              ),
            ),
            showName
                ? Positioned(
                    left: 8,
                    right: 8,
                    bottom: 0,
                    child: Text(userName, style: footerText),
                  )
                : Positioned(
                    left: 8,
                    right: 8,
                    bottom: 32,
                    child: Text(points == null ? '' : points + ' pontos',
                        style: footerText),
                  )
          ],
        ),
      ),
    );
  }
}
