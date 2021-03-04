import 'dart:io';

import 'package:flutter/material.dart';

class ProfileBox extends StatelessWidget {
  ProfileBox(
      {this.photoURL, this.file, this.color = Colors.white, this.size = 80});

  final String photoURL;
  final File file;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(40)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: (photoURL == null && file == null) || photoURL == ''
              ? Icon(
                  Icons.person,
                  size: size * 0.75,
                  color: Colors.white,
                )
              : file != null
                  ? Image.file(
                      file,
                      width: size,
                      height: size,
                    )
                  : Image.network(
                      photoURL,
                      width: size,
                      height: size,
                    ),
        ));
  }
}
