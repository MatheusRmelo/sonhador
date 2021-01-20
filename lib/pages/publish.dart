import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/writerdata.dart';
import '../partials/customappbar.dart';
import '../partials/textbox.dart';

class PublishPage extends StatefulWidget {
  @override
  _PublishPage createState() => _PublishPage();
}

class _PublishPage extends State<PublishPage> {
  bool _isChecked18 = false;
  bool _isCheckedAds = true;

  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;
    TextStyle smallText =
        TextStyle(fontFamily: 'Fredoka One', fontSize: 16, color: Colors.black);
    return Consumer<WriterData>(
        builder: (ctx, writerdata, child) => Scaffold(
              backgroundColor: Color(0xFF9B9987),
              appBar: CustomAppBar(
                  pageContext: context, title: 'Jovem, publique agora!'),
              body: Center(
                child: Column(
                  children: [
                    TextBox(
                      textId: '0gpwENULwWV85HN4yhdt',
                      title: 'Sonhador',
                      height: 135,
                      width: 120,
                      credit: true,
                      social: 'matheusRmelo',
                    ),
                    Container(
                      height: heightDevice * 0.3,
                      child: Column(children: [
                        CheckboxListTile(
                          title: Text('O texto contém contéudo adulto',
                              style: smallText),
                          value: _isChecked18,
                          onChanged: (val) {
                            setState(() {
                              _isChecked18 = val;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text(
                            'Monetizar esse texto',
                            style: smallText,
                          ),
                          value: _isCheckedAds,
                          onChanged: (val) {
                            setState(() {
                              _isCheckedAds = val;
                            });
                          },
                        )
                      ]),
                    ),
                    Container(
                      width: 200,
                      height: 40,
                      child: RaisedButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/search');
                          },
                          child: Text('PUBLICAR',
                              style: TextStyle(
                                  fontFamily: 'Fredoka One',
                                  fontSize: 16,
                                  color: Color(0xFF483D3F)))),
                    ),
                  ],
                ),
              ),
            ));
  }
}
