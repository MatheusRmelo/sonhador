import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/writerdata.dart';

import '../partials/customappbar.dart';
import '../partials/loadingappbar.dart';
import '../partials/textbox.dart';
import '../partials/loading.dart';

class PublishPage extends StatefulWidget {
  @override
  _PublishPage createState() => _PublishPage();
}

class _PublishPage extends State<PublishPage> {
  bool _isCheckedAds = true;
  bool _isChecked18 = false;
  bool loading = false;

  void publishText(String textId) async {
    setState(() {
      loading = true;
    });
    await Provider.of<WriterData>(context)
        .publishText(textId, _isCheckedAds, _isChecked18);
    setState(() {
      loading = false;
    });
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> routeData = ModalRoute.of(context).settings.arguments;
    double heightDevice = MediaQuery.of(context).size.height;
    TextStyle smallText =
        TextStyle(fontFamily: 'Fredoka One', fontSize: 16, color: Colors.black);
    String textId = routeData['textId'];
    String userId = Provider.of<WriterData>(context).userId;
    String title = Provider.of<WriterData>(context).title;

    return Consumer<WriterData>(
        builder: (ctx, writerdata, child) => Scaffold(
              backgroundColor: Color(0xFF9B9987),
              appBar: loading
                  ? LoadingAppBar(pageContext: context)
                  : CustomAppBar(
                      pageContext: context, title: 'Jovem, publique agora!'),
              body: loading
                  ? Loading(status: 'Carregando...')
                  : Center(
                      child: Column(
                        children: [
                          TextBox(
                            textId: textId,
                            title: title,
                            height: 135,
                            width: 120,
                            credit: true,
                            social: userId,
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
                                  publishText(textId);
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
