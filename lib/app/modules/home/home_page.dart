import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/modules/discovery/discovery_module.dart';
import 'package:sonhador/app/modules/home/home_content/home_content_page.dart';
import 'package:sonhador/app/modules/home/home_controller.dart';
import 'package:sonhador/app/modules/login/login_module.dart';
import 'package:sonhador/app/modules/notification/notification_module.dart';
import 'package:sonhador/app/modules/profile/profile_module.dart';
import 'package:sonhador/app/modules/writer/writer_module.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/utils/fonts.dart';
import 'package:sonhador/app/widgets/loading.dart';
import '../../app_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final homeController = Modular.get<HomeController>();
  final appController = Modular.get<AppController>();

  List widgetOptins = [
    HomeContentPage(),
    DiscoveryModule(),
    WriterModule(),
    NotificationModule(),
    ProfileModule(),
  ];

  void createNewText(BuildContext pageContext) {
    showDialog(
        context: pageContext,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              scrollable: true,
              content: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(children: [
                    Container(
                        width: 200,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: Color(0xFF9B9987),
                            onPressed: () {
                              if (appController.user.value.userId == '') {
                                Modular.to.pop();
                                homeController.updateCurrentIndex(4);
                              } else {
                                Modular.to.pushNamed('/writer',
                                    arguments: {"newText": true});
                              }
                            },
                            child: Text(
                              'Nova história',
                              style: smallStyleLight,
                            ))),
                    Container(
                        width: 200,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: Color(0xFF483D3F),
                            onPressed: () {
                              if (appController.user.value.userId == '') {
                                Modular.to.pop();
                                homeController.updateCurrentIndex(4);
                              } else {
                                Modular.to.pushNamed('/writer/search');
                              }
                            },
                            child: Text('Continuar história',
                                style: smallStyleLight))),
                  ])));
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
      body: Observer(
        builder: (_) {
          if (appController.user.value == null) {
            return Loading(
              status: 'Carregando...',
              color: secondary_color,
            );
          }
          if (homeController.currentIndex == 0 ||
              homeController.currentIndex == 1) {
            return widgetOptins.elementAt(homeController.currentIndex);
          }
          if (appController.user.value.userId == '') {
            return LoginModule();
          }

          return widgetOptins.elementAt(homeController.currentIndex);
        },
      ),
      bottomNavigationBar: _bottomTabNavigator(),
    );
  }

  Widget _bottomTabNavigator() {
    return Observer(
        builder: (_) => BottomNavigationBar(
              onTap: (index) {
                //print(index);
                if (index == 2) {
                  createNewText(context);
                } else {
                  homeController.updateCurrentIndex(index);
                }
              },
              elevation: 10,
              currentIndex: homeController.currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: primary_color,
              unselectedItemColor: Colors.black,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedLabelStyle: TextStyle(fontFamily: 'Fredoka One'),
              unselectedLabelStyle: TextStyle(fontFamily: 'Fredoka One'),
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.home,
                      color: primary_color,
                    ),
                    icon: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    label: 'Inicio'),
                BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.search,
                      color: primary_color,
                    ),
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    label: 'Descobrir'),
                BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.post_add,
                      color: primary_color,
                      size: 32,
                    ),
                    icon: Icon(
                      Icons.post_add,
                      color: Colors.black,
                      size: 32,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.notifications,
                      color: primary_color,
                    ),
                    icon: Icon(Icons.notifications, color: Colors.black),
                    label: 'Alertas'),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.person,
                    color: primary_color,
                  ),
                  icon: Icon(Icons.person, color: Colors.black),
                  label: 'Perfil',
                ),
              ],
            ));
  }
}
