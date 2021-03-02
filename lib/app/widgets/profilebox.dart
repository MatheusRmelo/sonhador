import 'dart:io';

import 'package:flutter/material.dart';

class ProfileBox extends StatelessWidget {
  ProfileBox({@required this.photoURL, this.file});

  final String photoURL;
  final File file;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(40)),
      child: file == null
          ? Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/512px-Circle-icons-profile.svg.png',
              width: 80,
              height: 80,
            )
          : Image.file(file),
    );
  }
}
