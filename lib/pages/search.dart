import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/writerdata.dart';

import '../partials/customappbar.dart';
import '../partials/textbox.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  List<Map> texts = [
    {
      "id": '',
      "text": {"title": ''}
    }
  ];
  String error = '';
  bool loading = false;

  void doSearch(text) async {
    // List newList = await Provider.of<AppData>(pageContext).searchCity(text);

    // setState(() {
    //   list = newList;
    // });
  }
  void getTexts() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      loading = true;
    });

    Map result = await Provider.of<WriterData>(context)
        .getMyTexts(userId: 'matheusRmelo');
    setState(() {
      if (result['error'] != '') {
        error = result['error'];
      } else {
        texts = result['data'];
      }
      loading = false;
    });
  }

  void initState() {
    super.initState();

    getTexts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WriterData>(
      builder: (ctx, writerdata, child) => Scaffold(
          appBar: CustomAppBar(
              pageContext: context, title: 'Jovem, pesquise seu texto abaixo'),
          backgroundColor: Color(0xFF9B9987),
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.all(16),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Digite o nome do seu texto',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      suffixIcon: Icon(
                        Icons.search,
                        size: 32,
                      )),
                  onChanged: (text) {
                    doSearch(text);
                  },
                ),
              ),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(
                    texts.length,
                    (index) => TextBox(
                          textId: texts[index]['id'],
                          title: texts[index]['text']['title'],
                          onTap: (textId) {
                            Navigator.pushNamed(context, '/writer',
                                arguments: {"textId": textId});
                          },
                        )),
              ))
            ],
          )),
    );
  }
}
