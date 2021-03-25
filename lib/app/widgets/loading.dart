import 'package:flutter/material.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'loadingappbar.dart';

class Loading extends StatelessWidget {
  Loading({@required this.status, this.color});

  final String status;
  Color color;

  TextStyle smallText =
      TextStyle(color: primary_color, fontSize: 16, fontFamily: 'Fredoka One');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoadingAppBar(
        pageContext: context,
        color: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(primary_color),
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
