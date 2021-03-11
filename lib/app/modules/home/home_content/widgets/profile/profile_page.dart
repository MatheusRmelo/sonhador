import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/model/user_model.dart';
import 'package:sonhador/app/modules/home/home_content/widgets/profile/profile_controller.dart';
import 'package:sonhador/app/modules/writer/widgets/search/search_controller.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/widgets/customappbar.dart';
import 'package:sonhador/app/widgets/loading.dart';
import 'package:sonhador/app/widgets/loginbottom.dart';
import '../../../../../widgets/profilebox.dart';
import '../../../../../widgets/textbox.dart';
import '../../../../../utils/fonts.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final appController = Modular.get<AppController>();
  final searchController = Modular.get<SearchController>();
  final profileController = Modular.get<HomeProfileController>();

  void getPhoto() async {
    await Future.delayed(Duration(seconds: 1));
    Map<String, dynamic> routeData = ModalRoute.of(context).settings.arguments;
    String userId = routeData['userId'];
    searchController.fetchTexts(userId);
    profileController.getPhoto(userId);
    profileController.getUser(userId);
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
        if (appController.user.value == null) {
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
        if (profileController.user.value == null) {
          return Loading(status: 'Carregando...');
        }

        var texts = searchController.texts.value;
        UserModel user = profileController.user.value;
        bool follow = appController.user.value.following.contains(user.userId);
        return Scaffold(
          appBar: CustomAppBar(
              title: user.displayName,
              pageContext: context,
              color: Colors.white),
          body: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
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
                            color: primary_color,
                            photoURL: profileController.photoUrl.value.photoUrl,
                          ),
                          Text(
                            user.userName,
                            style: smallStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 24, right: 24),
                                child: Column(
                                  children: [
                                    Text(user.following.length.toString(),
                                        style: smallText),
                                    Text('Seguindo', style: smallStyle)
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 24, right: 24),
                                child: Column(
                                  children: [
                                    Text(user.followers.length.toString(),
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
                                height: 30,
                                margin: EdgeInsets.only(top: 1),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  color: secondary_color,
                                  onPressed: () {
                                    if (appController.user.value.userId == '') {
                                      showbottomlogin(context);
                                    } else {
                                      appController.newFollow(user.userId);
                                      profileController.newFollow(
                                          appController.user.value.userId);
                                    }
                                  },
                                  child: Text(
                                    follow ? 'Deixar de seguir' : 'Seguir',
                                    style: smallStyleLight,
                                  ),
                                ),
                              ),
                              Container(
                                width: widthDevice * 0.1,
                                height: 30,
                                margin: EdgeInsets.only(top: 1),
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
                    height: 1,
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
                                Modular.to.pushNamed('/home/text',
                                    arguments: {"textId": textId});
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
