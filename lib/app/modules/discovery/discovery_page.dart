import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/modules/discovery/discovery_controller.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/utils/fonts.dart';
import 'package:sonhador/app/widgets/customappbar.dart';
import 'package:sonhador/app/widgets/loading.dart';

import 'package:sonhador/app/widgets/textbox.dart';
import 'package:sonhador/app/widgets/userbox.dart';

import 'package:sonhador/app/widgets/infopoints.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPage createState() => _DiscoveryPage();
}

class _DiscoveryPage extends State<DiscoveryPage> {
  final discoveryController = Modular.get<DiscoveryController>();
  final appController = Modular.get<AppController>();

  void getTexts() {
    discoveryController.fetchTexts();
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    //double heightDevice = MediaQuery.of(context).size.height;

    return Observer(
      builder: (_) {
        if (discoveryController.texts.error != null ||
            discoveryController.users.error != null) {
          return Center(
            child: Column(
              children: [
                Text('Ocorreu um erro, tente novamente mais tarde'),
                RaisedButton(
                  onPressed: () {},
                  child: Text('Recarregar'),
                )
              ],
            ),
          );
        }
        if (discoveryController.texts.value == null ||
            discoveryController.users.value == null) {
          return Loading(status: 'Carregando...');
        }

        var texts = discoveryController.texts.value;
        var users = discoveryController.users.value;
        return Scaffold(
            appBar: CustomAppBar(
                backButton: false,
                pageContext: context,
                title: 'Jovem, pesquise tudo aqui',
                color: Colors.white,
                itemsColor: Colors.black),
            backgroundColor: Colors.white,
            body: RefreshIndicator(
              onRefresh: () async {
                discoveryController.fetchTexts();
              },
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Modular.to.pushNamed('/home/search');
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      width: widthDevice,
                      height: 48,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset.fromDirection(1, 1),
                                spreadRadius: 0),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      margin: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Digite aqui...',
                            style: smallStyleGray,
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.grey[400],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'Textos populares da semana',
                              style: smallText,
                            ),
                          ),
                          Container(
                            height: 150,
                            child: texts.length == 0
                                ? Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Text(
                                      'Nenhum texto ainda, começe a escrever!',
                                      style: h1Primary,
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: texts.length,
                                    itemBuilder: (context, index) => TextBox(
                                      showTrophy: true,
                                      credit: true,
                                      social: 'matheus',
                                      index: index,
                                      margin:
                                          EdgeInsets.only(right: 16, top: 16),
                                      imgUrl: texts[index].photoURL,
                                      color: primary_color,
                                      textId: texts[index].id,
                                      title: texts[index].title,
                                      points: texts[index].points.toString(),
                                      onTap: (textId) {
                                        Modular.to.pushNamed('/home/text',
                                            arguments: {"textId": textId});
                                      },
                                    ),
                                  ),
                          )
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: 0, bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'Melhores usuários da semana',
                              style: smallText,
                            ),
                          ),
                          Container(
                              height: 150,
                              child: users.length == 0
                                  ? Container(
                                      margin: EdgeInsets.only(top: 16),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Ningúem',
                                            style: h1Primary,
                                          ),
                                          Icon(
                                            Icons.sentiment_very_dissatisfied,
                                            size: 32,
                                            color: primary_color,
                                          )
                                        ],
                                      ),
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: users.length,
                                      itemBuilder: (context, index) => UserBox(
                                        showTrophy: true,
                                        index: index,
                                        margin:
                                            EdgeInsets.only(right: 16, top: 16),
                                        color: primary_color,
                                        userId: users[index].userId,
                                        userName: users[index].userName,
                                        points: users[index].points.toString(),
                                        photo: users[index].photo,
                                        onTap: (userId) {
                                          if (appController.user.value.userId !=
                                              userId) {
                                            Modular.to.pushNamed(
                                                '/home/profile',
                                                arguments: {"userId": userId});
                                          }
                                        },
                                      ),
                                    ))
                        ],
                      )),
                  Container(
                    width: widthDevice,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Como posso lucrar no Sonhador?',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.score,
                              size: 16,
                            ),
                            Text(
                              '10000 pts - R\$ 10,00 (ACUMULATIVO)',
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.emoji_events,
                              color: Colors.yellow[800],
                              size: 16,
                            ),
                            Text(
                              'R\$ 3,00 (TEXTO E/OU USUÁRIO)',
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.emoji_events,
                              color: Colors.grey[400],
                              size: 16,
                            ),
                            Text(
                              'R\$ 2,00 (TEXTO E/OU USUÁRIO)',
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.emoji_events,
                              color: Colors.brown[700],
                              size: 16,
                            ),
                            Text(
                              'R\$ 1,00 (TEXTO E/OU USUÁRIO)',
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
