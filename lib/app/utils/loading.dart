import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sonhador/partials/loadingappbar.dart';

class Loading extends StatelessWidget {
  Loading({@required this.status});

  final String status;

  TextStyle smallText =
      TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Fredoka One');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoadingAppBar(pageContext: context, color: Color(0xFF9B9987)),
      backgroundColor: Color(0xFF9B9987),
      body: Center(
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
