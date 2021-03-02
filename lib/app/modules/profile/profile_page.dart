import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/modules/writer/widgets/search/search_controller.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/widgets/loading.dart';
import '../../widgets/profilebox.dart';
import '../../widgets/textbox.dart';
import '../../utils/fonts.dart';

class ProfilePage extends StatelessWidget {
  final appController = Modular.get<AppController>();
  final searchController = Modular.get<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        double widthDevice = MediaQuery.of(context).size.width;
        double heightDevice = MediaQuery.of(context).size.height;

        if (searchController.texts.value == null) {
          return Loading(status: 'Carregando...');
        }
        var texts = searchController.texts.value;
        return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(16),
                    //color: Colors.red,
                    height: heightDevice * 0.3,
                    width: widthDevice,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProfileBox(
                          photoURL: 'image',
                        ),
                        Text(
                          appController.user.value.userName,
                          style: smallStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              child: Column(
                                children: [
                                  Text('3265', style: smallText),
                                  Text('Seguindo', style: smallStyle)
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 24, right: 24),
                              child: Column(
                                children: [
                                  Text('2321', style: smallText),
                                  Text('Seguidores', style: smallStyle)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: widthDevice * 0.35,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                color: secondary_color,
                                onPressed: () {
                                  Modular.to.pushNamed('/home/edit');
                                },
                                child: Text(
                                  'Editar',
                                  style: smallStyleLight,
                                ),
                              ),
                            ),
                            Container(
                              width: widthDevice * 0.1,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                color: primary_color,
                                onPressed: () {},
                                child: Icon(
                                  Icons.language,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                Divider(
                  color: Colors.black,
                ),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(
                      texts.length,
                      (index) => TextBox(
                            textId: texts[index].id,
                            title: texts[index].title,
                            onTap: (textId) {
                              Navigator.pushNamed(context, '/writer',
                                  arguments: {
                                    "newText": false,
                                    "textId": textId
                                  });
                            },
                          )),
                ))
              ],
            ));
      },
    );
  }
}