import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/modules/notification/notification_controller.dart';
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
        // if (notificationController.notifications.value == null) {
        //   return Loading(status: 'Carregando...');
        // }

        return Scaffold(
          appBar: CustomAppBar(
            pageContext: context,
            title: 'Suas últimas notificações',
            backButton: false,
          ),
          body: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) => Container(child: Text('ewq'))),
        );
      },
    );
  }
}
