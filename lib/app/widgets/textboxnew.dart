import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/utils/fonts.dart';
import 'package:sonhador/app/widgets/profilebox.dart';

class TextBox extends StatelessWidget {
  TextBox(
      {@required this.textId,
      @required this.title,
      @required this.index,
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
  final int index;
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
    TextStyle smallText =
        TextStyle(color: Colors.white, fontSize: 6, fontFamily: 'Fredoka One');
    TextStyle footerText =
        TextStyle(color: Colors.black, fontSize: 8, fontFamily: 'Fredoka One');
    return Container(
      alignment: Alignment.center,
      margin: margin == null ? EdgeInsets.all(16) : margin,
      child: GestureDetector(
        onTap: () {
          onTap(textId);
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      color: color == null ? secondary_color : color,
                    ),
                    child: ClipRRect(
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
                      : Container(),
                )
              ],
            ),
            Container(
                margin: EdgeInsets.all(8),
                child: index < 3
                    ? Row(
                        children: [
                          Icon(
                            Icons.emoji_events,
                            color: index == 0
                                ? Colors.yellow[800]
                                : index == 1
                                    ? Colors.grey[400]
                                    : Colors.brown[700],
                            size: 16,
                          ),
                          Text(
                            points == null ? '' : points + ' pontos',
                            style: footerText,
                          )
                        ],
                      )
                    : Text(
                        points == null ? '' : points + ' pontos',
                        style: footerText,
                      ))
          ],
        ),
      ),
    );
  }
}
