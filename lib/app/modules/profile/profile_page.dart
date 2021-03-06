import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/modules/profile/profile_controller.dart';
import 'package:sonhador/app/modules/writer/widgets/search/search_controller.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/widgets/loading.dart';
import '../../widgets/profilebox.dart';
import '../../widgets/textbox.dart';
import '../../utils/fonts.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final appController = Modular.get<AppController>();
  final searchController = Modular.get<SearchController>();
  final profileController = Modular.get<ProfileController>();

  void getPhoto() async {
    await Future.delayed(Duration(seconds: 1));
    searchController.fetchTexts(appController.user.value.userId);
    profileController.getPhoto(appController.user.value.userId);
    profileController.loading = false;
  }

  void initState() {
    super.initState();
    profileController.loading = true;
    getPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        double widthDevice = MediaQuery.of(context).size.width;
        double heightDevice = MediaQuery.of(context).size.height;

        if (appController.user.value.userId == '' ||
            appController.user.value == null) {
          return Loading(status: 'Carregando...');
        }
        if (profileController.loading) {
          return Loading(status: 'Carregando...');
        }
        if (searchController.texts.value == null) {
          return Loading(status: 'Carregando...');
        }
        if (profileController.photoUrl.error != null) {
          return Loading(status: 'Carregando...');
        }
        if (profileController.photoUrl.value == null) {
          return Loading(status: 'Carregando...');
        }

        var texts = searchController.texts.value;
        return RefreshIndicator(
          onRefresh: () async {
            searchController.fetchTexts(appController.user.value.userId);
          },
          child: Container(
              margin: EdgeInsets.only(top: 16),
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      //color: Colors.red,
                      height: heightDevice * 0.3,
                      width: widthDevice,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Modular.to.pushNamed('/home/edit');
                            },
                            child: ProfileBox(
                              color: primary_color,
                              photoURL:
                                  profileController.photoUrl.value.photoUrl,
                            ),
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
                                    Text(
                                        appController
                                            .user.value.following.length
                                            .toString(),
                                        style: smallText),
                                    Text('Seguindo', style: smallStyle)
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 24, right: 24),
                                child: Column(
                                  children: [
                                    Text(
                                        appController
                                            .user.value.followers.length
                                            .toString(),
                                        style: smallText),
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
                                height: heightDevice * 0.05,
                                margin: EdgeInsets.only(top: 1),
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
                                height: heightDevice * 0.05,
                                margin: EdgeInsets.only(top: 1),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  color: primary_color,
                                  onPressed: () {
                                    appController.signOut();
                                  },
                                  child: Icon(
                                    Icons.logout,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Divider(
                      color: Colors.black,
                      height: 1,
                    ),
                  ),
                  Expanded(
                      child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(
                        texts.length,
                        (index) => TextBox(
                              showTrophy: false,
                              showPoints: false,
                              points: texts[index].points,
                              imgUrl: texts[index].photoUrl,
                              textId: texts[index].id,
                              title: texts[index].title,
                              margin: EdgeInsets.all(8),
                              height: heightDevice * 0.14,
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
              )),
        );
      },
    );
  }
}
