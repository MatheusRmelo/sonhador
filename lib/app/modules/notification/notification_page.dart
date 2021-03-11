import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/modules/notification/notification_controller.dart';
import 'package:sonhador/app/modules/notification/widgets/notificationbox.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/widgets/customappbar.dart';
import 'package:sonhador/app/widgets/loading.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final notificationController = Modular.get<NotificationController>();
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (notificationController.notifications.value == null) {
          return Loading(status: 'Carregando...');
        }

        return Scaffold(
          backgroundColor: secondary_color,
          appBar: CustomAppBar(
              pageContext: context,
              centerTitle: true,
              title: 'Suas últimas notificações',
              backButton: false,
              color: secondary_color,
              itemsColor: Colors.white),
          body: Container(
            padding: EdgeInsets.all(16),
            child: ListView.builder(
                itemCount: notificationController.notifications.value.length,
                itemBuilder: (context, index) => NotificationBox(
                      index: index,
                      message: notificationController
                          .notifications.value[index].message,
                      photoUrl: notificationController
                          .notifications.value[index].photoUrl,
                    )),
          ),
        );
      },
    );
  }
}
