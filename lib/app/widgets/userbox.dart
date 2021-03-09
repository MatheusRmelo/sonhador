import 'package:flutter/material.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/widgets/profilebox.dart';

class UserBox extends StatelessWidget {
  UserBox(
      {@required this.textId,
      @required this.title,
      this.onTap,
      this.credit = false,
      this.social,
      this.width = 80,
      this.height = 80,
      this.color,
      this.margin,
      this.points,
      this.photo});

  final String textId;
  final String title;
  final Function onTap;
  final bool credit;
  final String social;
  final double width;
  final double height;
  final Color color;
  final EdgeInsets margin;
  final String points;
  final String photo;

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
          onTap(textId);
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
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset.fromDirection(1, 10),
                        spreadRadius: 0)
                  ]),
              child: ProfileBox(
                photoURL: photo,
                color: primary_color,
              ),
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 32,
              child: credit
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.face,
                              size: 16,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text(
                                social,
                                style: smallText,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.face, size: 16),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text(
                                social,
                                style: smallText,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  : Text(points == null ? '' : points + ' pontos',
                      style: footerText),
            )
          ],
        ),
      ),
    );
  }
}
