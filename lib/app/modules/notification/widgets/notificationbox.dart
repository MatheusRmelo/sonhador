import 'package:flutter/material.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/utils/fonts.dart';
import 'package:sonhador/app/widgets/profilebox.dart';

class NotificationBox extends StatelessWidget {
  NotificationBox(
      {@required this.index, @required this.message, @required this.photoUrl});

  final int index;
  final String message;
  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: primary_color, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          ProfileBox(
            size: 32,
            color: secondary_color,
            photoURL: photoUrl,
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 8),
            child: Text(
              message,
              style: smallStyleLight,
            ),
          ),
          // Container(
          //   height: 32,
          //   child: RaisedButton(
          //     onPressed: () {},
          //     child: Text(
          //       'Teste',
          //       style: smallStyleLight,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
