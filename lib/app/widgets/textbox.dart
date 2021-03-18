import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/widgets/profilebox.dart';

class TextBox extends StatelessWidget {
  TextBox(
      {@required this.textId,
      @required this.title,
      this.onTap,
      this.credit = false,
      this.social,
      this.width = 72,
      this.height = 96,
      this.color,
      this.margin,
      this.points,
      this.imgUrl,
      this.file});

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
  final String imgUrl;
  final File file;
  @override
  Widget build(BuildContext context) {
    TextStyle smallText = TextStyle(
        color: Color(0xFF969191), fontSize: 6, fontFamily: 'Fredoka One');
    TextStyle footerText =
        TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Fredoka One');
    return Container(
      alignment: Alignment.center,
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
                    border: Border.all(width: 0.01, color: secondary_color),
                    borderRadius: BorderRadius.circular(8),
                    color: color == null ? secondary_color : color,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 1,
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset.fromDirection(1, 3),
                          spreadRadius: 0)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: file != null
                      ? Image.file(
                          file,
                        )
                      : (imgUrl == '' || imgUrl == null)
                          ? Container()
                          : Image.network(
                              imgUrl,
                            ),
                )),
            Positioned(
              left: 0,
              right: width * 0.1,
              top: height * 0.15,
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
