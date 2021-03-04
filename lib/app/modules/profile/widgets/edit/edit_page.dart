import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/modules/profile/profile_controller.dart';
import 'package:sonhador/app/modules/profile/widgets/edit/edit_controller.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/utils/fonts.dart';
import 'package:sonhador/app/widgets/profilebox.dart';
import '../../../../widgets/customappbar.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final appController = Modular.get<AppController>();
  final editController = Modular.get<EditController>();
  final profileController = Modular.get<ProfileController>();
  final picker = ImagePicker();

  File _image;

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeria de fotos'),
                      onTap: () {
                        getImage('gallery');
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Tirar nova fota'),
                    onTap: () {
                      getImage('camera');
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future getImage(String local) async {
    final pickedFile = await picker.getImage(
        source: local == 'camera' ? ImageSource.camera : ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        print(pickedFile.path);
        _image = File(pickedFile.path);
        editController.saveImage(_image, appController.user.value.userId);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;

    return Observer(
      builder: (_) {
        return Scaffold(
          backgroundColor: primary_color,
          appBar: CustomAppBar(pageContext: context),
          body: Container(
            padding: EdgeInsets.all(32),
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        ProfileBox(
                          photoURL: profileController.photoUrl.value.photoUrl,
                          file: _image,
                        ),
                        Container(
                          width: 150,
                          margin: EdgeInsets.only(top: 8),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: Color(0xFF483D3F),
                            onPressed: () {
                              _showPicker(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.photo_camera,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Alterar a foto',
                                  style: smallStyleLight,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                Text(
                  'Usuário',
                  style: smallTextLight,
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    padding: EdgeInsets.all(16),
                    width: widthDevice,
                    height: 48,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(appController.user.value.userName),
                  ),
                  onTap: () {
                    Modular.to.pushNamed(
                        '/home/input/Úsuario/${appController.user.value.userName}/user_name');
                  },
                ),
                Text(
                  'Nome completo',
                  style: smallTextLight,
                ),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    padding: EdgeInsets.all(16),
                    width: widthDevice,
                    height: 48,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(appController.user.value.displayName),
                  ),
                  onTap: () {
                    Modular.to.pushNamed(
                        '/home/input/Nome completo/${appController.user.value.displayName}/display_name');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
