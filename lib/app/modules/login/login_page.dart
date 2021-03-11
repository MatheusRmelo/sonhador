import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/utils/fonts.dart';
import 'package:sonhador/app/widgets/loading.dart';

class LoginPage extends StatelessWidget {
  final appController = Modular.get<AppController>();

  TextStyle smallStyleSecondary = TextStyle(
      fontFamily: 'Fredoka One', fontSize: 12, color: Color(0xFF483D3F));

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
          //user.loginGmail();
          appController.loginGmail();
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

  Widget _signOutButton(context) {
    TextStyle smallStyleSecondary = TextStyle(
        fontFamily: 'Fredoka One', fontSize: 12, color: Color(0xFF483D3F));
    return RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Colors.white,
        onPressed: () {
          //writer.signOutGoogle();
          //user.loginGmail();
          appController.signOut();
        },
        child: Text(
          'Sair',
          style: smallStyleSecondary,
        ));
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;

    return Observer(builder: (_) {
      if (appController.user.value == null) {
        return Loading(
          status: 'Carregando...',
          color: secondary_color,
        );
      }
      if (appController.user.value.userId == '') {
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
                Container(
                    width: widthDevice * 0.5, child: _signInButton(context)),
              ],
            ),
          ),
        );
      }
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
              Container(
                  width: widthDevice * 0.5, child: _signOutButton(context)),
            ],
          ),
        ),
      );
    });
  }
}
