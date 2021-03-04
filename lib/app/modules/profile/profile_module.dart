import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:sonhador/app/modules/profile/profile_controller.dart';
import 'package:sonhador/app/modules/profile/widgets/edit/edit_controller.dart';
import 'repository/profile_repository.dart';

import 'profile_page.dart';

class ProfileModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind((i) => EditController(i.get())),
        Bind((i) => ProfileController(i.get())),
        Bind((i) => ProfileRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => ProfilePage()),
      ];

  @override
  Widget get view => ProfilePage();
}
