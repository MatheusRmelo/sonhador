import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sonhador/app/utils/colors.dart';

class ProfileBox extends StatelessWidget {
  ProfileBox({this.photoURL, this.file, this.color = Colors.white});

  final String photoURL;
  final File file;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(40)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: (photoURL == null && file == null)
              ? Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                )
              : file != null
                  ? Image.file(
                      file,
                      width: 80,
                      height: 80,
                    )
                  : Image.network(
                      photoURL,
                      width: 80,
                      height: 80,
                    ),
        ));
  }
}
