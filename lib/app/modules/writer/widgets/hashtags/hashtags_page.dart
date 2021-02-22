import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/modules/writer/widgets/hashtags/hashtags_controller.dart';
import 'package:sonhador/app/modules/writer/writer_controller.dart';
import 'package:sonhador/partials/customappbar.dart';

class HashtagPage extends StatefulWidget {
  @override
  _HashtagPage createState() => _HashtagPage();
}

class _HashtagPage extends State<HashtagPage> {
  final hashtagsController = Modular.get<HashTagsController>();
  final writerController = Modular.get<WriterController>();

  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;
    double widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF9B9987),
      appBar: CustomAppBar(
          pageContext: context, title: 'Escolha as hashtags mais quentes!'),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              height: heightDevice * 0.25,
              width: widthDevice * 0.8,
              child: TextFormField(
                controller: hashtagsController.textController,
                style: TextStyle(fontFamily: 'EBGaramond'),
                //controller: _controller,
                textAlignVertical: TextAlignVertical.top,
                textAlign: TextAlign.start,
                expands: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (text) {
                  hashtagsController.tags = text;
                },
                decoration: InputDecoration(
                  hintText: '#poema #amor #sonhador',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
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
                      hashtagsController
                          .saveHashtags(writerController.text.value.id);
                      Modular.to.pushNamed('writer/publish');
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
  }
}
