part of '../main.dart';

Widget _signInButton(context) {
  TextStyle smallStyleSecondary = TextStyle(
      fontFamily: 'Fredoka One', fontSize: 12, color: Color(0xFF483D3F));
  return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: Colors.white,
      onPressed: () {
        //writer.signOutGoogle();
        user.loginGmail();
      },
      child: Row(children: [
        Container(
          margin: EdgeInsets.only(right: 16),
          child: Image(
              width: 24, height: 24, image: AssetImage('assets/google.png')),
        ),
        Text(
          'Entrar com o google',
          style: smallStyleSecondary,
        ),
      ]));
}

class NoUserWidget extends StatelessWidget {
  TextStyle smallStyleSecondary = TextStyle(
      fontFamily: 'Fredoka One', fontSize: 12, color: Color(0xFF483D3F));
  TextStyle h1Light =
      TextStyle(fontFamily: 'Fredoka One', fontSize: 24, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;

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
            Text('Se aventure conosco', style: h1Light),
            Container(width: widthDevice * 0.5, child: _signInButton(context)),
          ],
        ),
      ),
    );
  }
}
