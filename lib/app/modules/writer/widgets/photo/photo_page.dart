import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/modules/writer/widgets/hashtags/hashtags_controller.dart';
import 'package:sonhador/app/modules/writer/writer_controller.dart';
import 'package:sonhador/app/widgets/loading_container.dart';
import 'package:sonhador/app/widgets/customappbar.dart';
import 'package:sonhador/app/widgets/textbox.dart';

class PhotoPage extends StatefulWidget {
  @override
  _PhotoPage createState() => _PhotoPage();
}

class _PhotoPage extends State<PhotoPage> {
  final hashtagsController = Modular.get<HashTagsController>();
  final writerController = Modular.get<WriterController>();

  void getHashtags() async {
    await Future.delayed(Duration(seconds: 1));
    hashtagsController.getHashtags(writerController.text.value.id);
  }

  void initState() {
    super.initState();
    getHashtags();
  }

  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;
    double widthDevice = MediaQuery.of(context).size.width;

    return Observer(
      builder: (_) {
        return Scaffold(
          backgroundColor: Color(0xFF9B9987),
          appBar: CustomAppBar(
              pageContext: context, title: 'Escolha uma imagem de capa'),
          body: Center(
            child: Column(
              children: [
                hashtagsController.loading
                    ? LoadingContainer(
                        status: 'Carregando...',
                        expanded: false,
                        width: widthDevice * 0.8,
                        height: heightDevice * 0.25,
                      )
                    : TextBox(textId: 'textId', title: 'title'),
                Container(
                    width: 200,
                    height: 40,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          hashtagsController
                              .saveHashtags(writerController.text.value.id);
                          Modular.to.pushNamed('writer/publish');
                        },
                        child: Text('SALVAR',
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
