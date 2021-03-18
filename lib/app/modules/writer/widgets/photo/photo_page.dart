import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/modules/writer/widgets/photo/photo_controller.dart';
import 'package:sonhador/app/modules/writer/writer_controller.dart';
import 'package:sonhador/app/utils/colors.dart';
import 'package:sonhador/app/widgets/loading.dart';
import 'package:sonhador/app/widgets/loading_container.dart';
import 'package:sonhador/app/widgets/customappbar.dart';
import 'package:sonhador/app/widgets/textbox.dart';

class PhotoPage extends StatefulWidget {
  @override
  _PhotoPage createState() => _PhotoPage();
}

class _PhotoPage extends State<PhotoPage> {
  final appController = Modular.get<AppController>();
  final writerController = Modular.get<WriterController>();
  final photoController = Modular.get<PhotoController>();

  final picker = ImagePicker();

  File _image;

  Future getImage(String local) async {
    final pickedFile = await picker.getImage(
        source: local == 'camera' ? ImageSource.camera : ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        print(pickedFile.path);
        _image = File(pickedFile.path);
        savePhoto();
      } else {
        print('No image selected.');
      }
    });
  }

  void savePhoto() {
    photoController.savePhoto(_image, writerController.text.value.id);
  }

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

  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;
    double widthDevice = MediaQuery.of(context).size.width;

    return Observer(
      builder: (_) {
        if (photoController.photo == null) {
          return Loading(status: 'Carregando...');
        }
        return Scaffold(
          backgroundColor: Color(0xFF9B9987),
          appBar: CustomAppBar(
              pageContext: context, title: 'Escolha uma imagem de capa'),
          body: Center(
            child: Column(
              children: [
                photoController.photo.value == null
                    ? LoadingContainer(
                        status: 'Carregando...',
                        expanded: false,
                        width: widthDevice * 0.8,
                        height: heightDevice * 0.25,
                      )
                    : TextBox(
                        credit: true,
                        social: appController.user.value.userName,
                        textId: writerController.text.value.id,
                        title: writerController.text.value.title,
                        imgUrl: photoController.photo.value.photoUrl,
                        file: _image,
                      ),
                Container(
                    width: 200,
                    height: 40,
                    margin: EdgeInsets.only(bottom: 32),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        color: secondary_color,
                        onPressed: () {
                          _showPicker(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.photo_camera,
                              color: Colors.white,
                            ),
                            Text('Alterar foto',
                                style: TextStyle(
                                    fontFamily: 'Fredoka One',
                                    fontSize: 16,
                                    color: Colors.white))
                          ],
                        ))),
                Container(
                    width: 200,
                    height: 40,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        color: Colors.white,
                        onPressed: () async {
                          bool published = await photoController
                              .published(writerController.text.value.id);
                          if (published == null) {
                            published = false;
                          }
                          if (published) {
                            Modular.to.pushNamed('home');
                          } else {
                            Modular.to.pushNamed('writer/publish');
                          }
                        },
                        child: Text('AVANÇAR',
                            style: TextStyle(
                                fontFamily: 'Fredoka One',
                                fontSize: 16,
                                color: Color(0xFF483D3F))))),
              ],
            ),
          ),
        );
      },
    );
  }
}
