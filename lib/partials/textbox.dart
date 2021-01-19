import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  TextBox({@required this.textId, @required this.title, this.onTap});

  final String textId;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          onTap(textId);
        },
        child: Stack(
          children: [
            Container(
              width: 90,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFF483D3F),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset.fromDirection(1, 10),
                        spreadRadius: 0)
                  ]),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 10,
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
              right: 0,
              bottom: 16,
              child: Text(
                title,
                style: TextStyle(
                    color: Color(0xFF969191),
                    fontSize: 8,
                    fontFamily: 'Fredoka One'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
