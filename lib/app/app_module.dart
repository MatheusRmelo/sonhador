import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/modules/home/home_module.dart';
import 'package:sonhador/app/modules/writer/writer_module.dart';
import 'package:sonhador/app/repository/user_repository.dart';
import 'package:sonhador/app/services/user_services.dart';

import 'app_widget.dart';
import 'modules/splash/splash_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController(i.get(), i.get())),
        Bind((i) => UserRepository(i.get())),
        Bind((i) => UserService()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: SplashModule()),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/writer', module: WriterModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
