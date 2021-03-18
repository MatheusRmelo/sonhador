import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  TextBox(
      {@required this.textId,
      @required this.title,
      this.onTap,
      this.credit = false,
      this.social,
      this.width = 90,
      this.height = 100,
      this.color,
      this.margin,
      this.points});

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
                  borderRadius: BorderRadius.circular(8),
                  color: color == null ? Color(0xFF483D3F) : color,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset.fromDirection(1, 3),
                        spreadRadius: 0)
                  ]),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 10,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: 'Fredoka One'),
              ),
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 16,
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
