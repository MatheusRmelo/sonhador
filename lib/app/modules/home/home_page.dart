import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/modules/home/home_content/home_content_page.dart';
import 'package:sonhador/app/modules/home/home_controller.dart';
import 'package:sonhador/app/modules/login/login_module.dart';
import 'package:sonhador/app/modules/writer/writer_module.dart';
import 'package:sonhador/main.dart';

import '../../app_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

String userId = '';

class _HomePage extends State<HomePage> {
  final homeController = Modular.get<HomeController>();

  List widgetOptins = [
    HomeContentPage(),
    WriterModule(),
    WriterModule(),
    LoginModule(),
    WriterModule(),
  ];

  void createNewText(BuildContext pageContext) {
    final appController = Modular.get<AppController>();

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
                              if (appController.user.value == null) {
                                Modular.to.pop();
                                homeController.updateCurrentIndex(3);
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
                              if (appController.user.value == null) {
                                Modular.to.pop();
                                homeController.updateCurrentIndex(3);
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
    return Scaffold(
      body: Observer(
        builder: (_) => widgetOptins.elementAt(homeController.currentIndex),
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
              currentIndex: homeController.currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(0xFF9B9987),
              selectedItemColor: Colors.white,
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
                      color: Colors.white,
                    ),
                    icon: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    label: 'Inicio'),
                BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    label: 'Descobrir'),
                BottomNavigationBarItem(
                    activeIcon: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xFFe4e4e4)),
                      width: 32,
                      height: 32,
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                    icon: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFFe4e4e4)),
                      width: 32,
                      height: 32,
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.library_books,
                      color: Colors.white,
                    ),
                    icon: Icon(Icons.library_books, color: Colors.black),
                    label: 'Biblioteca'),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  icon: Icon(Icons.person, color: Colors.black),
                  label: 'Perfil',
                ),
              ],
            ));
  }
}
