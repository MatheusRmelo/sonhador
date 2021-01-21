import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  Loading({@required this.status});

  final String status;

  TextStyle smallText =
      TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Fredoka One');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          Text(
            status,
            style: smallText,
          )
        ],
      ),
    );
  }
}
