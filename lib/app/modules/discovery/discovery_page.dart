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
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  margin: EdgeInsets.all(16),
                  child: TextFormField(
                    style: TextStyle(fontFamily: 'Fredoka One', fontSize: 12),
                    decoration: InputDecoration(
                        hintText: 'Pesquise um usuário ou texto aqui',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        suffixIcon: Icon(
                          Icons.search,
                          size: 32,
                        )),
                    onChanged: (text) {
                      //discoveryController.searchText(text);
                    },
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
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: texts.length,
                            itemBuilder: (context, index) => TextBox(
                              margin: EdgeInsets.only(right: 16, top: 16),
                              color: primary_color,
                              textId: texts[index].id,
                              title: texts[index].title,
                              points: texts[index].points.toString(),
                              onTap: (textId) {
                                Navigator.pushNamed(context, '/writer',
                                    arguments: {
                                      "newText": false,
                                      "textId": textId
                                    });
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
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: users.length,
                            itemBuilder: (context, index) => UserBox(
                              margin: EdgeInsets.only(right: 16, top: 16),
                              color: primary_color,
                              textId: users[index].userId,
                              title: users[index].userName,
                              points: users[index].points.toString(),
                              photo: users[index].photo,
                              onTap: (textId) {
                                Navigator.pushNamed(context, '/writer',
                                    arguments: {
                                      "newText": false,
                                      "textId": textId
                                    });
                              },
                            ),
                          ),
                        )
                      ],
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Uma curtida = 3 pontos',
                      style: smallStyleLight,
                    ),
                    Text(
                      'Um compartilhamento = 2 pontos',
                      style: smallStyleLight,
                    ),
                    Text(
                      'Uma visualização = 1 ponto',
                      style: smallStyleLight,
                    ),
                    Text(
                      'Um comentário = 1 ponto',
                      style: smallStyleLight,
                    ),
                  ],
                )
              ],
            ));
      },
    );
  }
}
