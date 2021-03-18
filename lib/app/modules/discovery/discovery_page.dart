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
                title: 'Jovem, pesquise tudo aqui em baixo',
                color: secondary_color,
                itemsColor: Colors.white),
            backgroundColor: secondary_color,
            body: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed('/home/search');
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    width: widthDevice,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
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
                            'Melhores textos da semana',
                            style: smallTextLight,
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
                                    margin: EdgeInsets.only(right: 16, top: 16),
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
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            'Melhores usuários da semana',
                            style: smallTextLight,
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
                                          Modular.to.pushNamed('/home/profile',
                                              arguments: {"userId": userId});
                                        }
                                      },
                                    ),
                                  ))
                      ],
                    )),
                Text(
                  'Clique no ícone para saber mais sobre os pontos',
                  style: smallStyleLight,
                ),
                IconButton(
                    icon: Icon(
                      Icons.info,
                      size: 48,
                      color: Colors.white,
                    ),
                    onPressed: () => showInfo(context)),
              ],
            ));
      },
    );
  }
}
