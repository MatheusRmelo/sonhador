import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/modules/writer/widgets/photo/photo_controller.dart';
import 'package:sonhador/app/modules/writer/widgets/publish/publish_controller.dart';
import 'package:sonhador/app/modules/writer/writer_controller.dart';
import 'package:sonhador/app/utils/fonts.dart';
import '../../../../widgets/customappbar.dart';
import '../../../../widgets/textbox.dart';

class PublishPage extends StatefulWidget {
  @override
  _PublishPage createState() => _PublishPage();
}

class _PublishPage extends State<PublishPage> {
  final writerController = Modular.get<WriterController>();
  final publishController = Modular.get<PublishController>();
  final photoController = Modular.get<PhotoController>();
  final appController = Modular.get<AppController>();

  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;

    var text = writerController.text.value;

    return Observer(builder: (_) {
      return Scaffold(
        backgroundColor: Color(0xFF9B9987),
        appBar:
            CustomAppBar(pageContext: context, title: 'Jovem, publique agora!'),
        body: Center(
          child: Column(
            children: [
              TextBox(
                margin: EdgeInsets.all(8),
                textId: text.id,
                title: text.title,
                height: 135,
                width: 120,
                credit: true,
                social: appController.user.value.userName,
                imgUrl: photoController.photo.value.photoUrl,
              ),
              Container(
                height: heightDevice * 0.3,
                child: Column(children: [
                  CheckboxListTile(
                    checkColor: Colors.white,
                    activeColor: Colors.black,
                    title: Text('O texto contém contéudo adulto',
                        style: smallText),
                    value: publishController.adult,
                    onChanged: (val) {
                      publishController.adult = val;
                    },
                  ),
                  // CheckboxListTile(
                  //   checkColor: Colors.white,
                  //   activeColor: Colors.black,
                  //   title: Text(
                  //     'Monetizar esse texto',
                  //     style: smallText,
                  //   ),
                  //   value: publishController.ads,
                  //   onChanged: (val) {
                  //     publishController.ads = val;
                  //   },
                  // ),
                ]),
              ),
              Container(
                  width: 200,
                  height: 40,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        publishController.publishText(text.id);
                        Modular.to.pushNamed('/home');
                      },
                      child: Text('PUBLICAR',
                          style: TextStyle(
                              fontFamily: 'Fredoka One',
                              fontSize: 16,
                              color: Color(0xFF483D3F))))),
            ],
          ),
        ),
      );
    });
  }
}
