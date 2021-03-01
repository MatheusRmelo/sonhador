import 'package:flutter/material.dart';

class ProfileBox extends StatelessWidget {
  ProfileBox({
    @required this.photoURL,
  });

  final String photoURL;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(40)),
      child: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/512px-Circle-icons-profile.svg.png'),
    );
  }
}
