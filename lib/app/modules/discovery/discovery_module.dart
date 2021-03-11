import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:sonhador/app/modules/discovery/discovery_controller.dart';
import 'package:sonhador/app/modules/discovery/discovery_page.dart';
import 'package:sonhador/app/modules/discovery/repository/discovery_repository.dart';
import 'package:sonhador/app/modules/discovery/repository/discovery_search_repository.dart';
import 'package:sonhador/app/modules/discovery/repository/discovery_text_repository.dart';
import 'package:sonhador/app/modules/discovery/widgets/search/discovery_search_controller.dart';
import 'package:sonhador/app/modules/discovery/widgets/text/discovery_text_controller.dart';

class DiscoveryModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind((i) => DiscoveryController(i.get())),
        Bind((i) => DiscoveryRepository()),
        Bind((i) => DiscoverySearchController(i.get())),
        Bind((i) => DiscoverySearchRepository()),
        Bind((i) => DiscoveryTextController(i.get())),
        Bind((i) => DiscoveryTextRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => DiscoveryPage()),
      ];

  @override
  Widget get view => DiscoveryPage();
}
