import 'package:flutter/material.dart';

class NoUserWidget extends StatelessWidget {
  TextStyle smallStyleSecondary = TextStyle(
      fontFamily: 'Fredoka One', fontSize: 12, color: Color(0xFF483D3F));
  TextStyle h1Light =
      TextStyle(fontFamily: 'Fredoka One', fontSize: 24, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF483D3F),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              color: Colors.white,
              size: 64,
            ),
            Text('Crie uma conta', style: h1Light),
            Container(
                width: 200,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Colors.white,
                    onPressed: () {},
                    child: Text(
                      'Criar conta',
                      style: smallStyleSecondary,
                    ))),
          ],
        ),
      ),
    );
  }
}
