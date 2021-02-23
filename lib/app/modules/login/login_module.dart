import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:sonhador/app/modules/home/home_controller.dart';
import 'login_page.dart';

class LoginModule extends WidgetModule {
  @override
  List<Bind> get binds => [Bind((i) => HomeController())];

  @override
  List<ModularRouter> get routers =>
      [ModularRouter('/', child: (_, args) => LoginPage())];

  @override
  Widget get view => LoginPage();
}
