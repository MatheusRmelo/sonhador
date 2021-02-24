import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/modules/home/home_content/home_content_controller.dart';
import 'package:sonhador/app/modules/home/home_content/repository/home_text_repository.dart';
import 'package:sonhador/app/modules/home/home_controller.dart';

import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
        Bind((i) => HomeContentController(i.get())),
        Bind((i) => HomeTextRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
