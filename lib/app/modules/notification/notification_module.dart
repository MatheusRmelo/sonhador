import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:sonhador/app/modules/notification/notification_controller.dart';
import 'package:sonhador/app/modules/notification/notification_page.dart';
import 'package:sonhador/app/modules/notification/repository/notification_repository.dart';

class NotificationModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind((i) => NotificationController(i.get(), i.get())),
        Bind((i) => NotificationRepository()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => NotificationPage()),
      ];

  @override
  Widget get view => NotificationPage();
}
