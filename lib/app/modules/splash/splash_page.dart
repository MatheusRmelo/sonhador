import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/utils/loading.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final appController = Modular.get<AppController>();

  void initState() {
    super.initState();
    appController.verifyLogin();
  }

  void homePage() {
    Timer(Duration(microseconds: 1), () {
      Modular.to.pushNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        print(appController.user.value);
        if (appController.user.value != null) {
          homePage();
        }
        SystemChrome.setEnabledSystemUIOverlays([]);
        return Center(
          child: Container(
              padding: EdgeInsets.all(50),
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Image.asset(
                'assets/logo.png',
              )),
        );
      },
    );
  }
}
