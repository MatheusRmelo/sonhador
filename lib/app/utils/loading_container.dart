import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  LoadingContainer(
      {@required this.status,
      this.width,
      this.height,
      @required this.expanded});

  final String status;
  final double width;
  final double height;
  final bool expanded;

  TextStyle smallText =
      TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Fredoka One');

  @override
  Widget build(BuildContext context) {
    if (expanded) {
      return Expanded(
        child: Center(
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
        ),
      );
    }
    return Container(
      color: Color(0xFF9B9987),
      width: width,
      height: height,
      child: Center(
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
      ),
    );
  }
}
