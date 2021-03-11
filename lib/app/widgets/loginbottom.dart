import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/utils/fonts.dart';

void showbottomlogin(context) {
  final AppController appController = Modular.get<AppController>();

  Widget _signInButton(context) {
    TextStyle smallStyleSecondary = TextStyle(
        fontFamily: 'Fredoka One', fontSize: 16, color: Color(0xFF483D3F));
    return RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: Colors.white,
        onPressed: () {
          appController.loginGmail();
          Modular.to.pop();
        },
        child: Row(children: [
          Container(
            margin: EdgeInsets.only(right: 16),
            child: Image(
                width: 32, height: 32, image: AssetImage('assets/google.png')),
          ),
          Text(
            'Entrar com o google',
            style: smallStyleSecondary,
          ),
        ]));
  }

  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        double heightDevice = MediaQuery.of(context).size.height;
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
                color: primary_color,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            padding: EdgeInsets.all(32),
            height: heightDevice * 0.6,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  child: Text(
                    'Faça o login para continuar',
                    style: h1Light,
                  ),
                ),
                Container(
                  height: 48,
                  child: _signInButton(context),
                )
              ],
            ),
          ),
        );
      });
}
