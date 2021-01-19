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
  List list = ['e', ',1', 'w'];

  void doSearch(pageContext, text) async {
    // List newList = await Provider.of<AppData>(pageContext).searchCity(text);

    // setState(() {
    //   list = newList;
    // });
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
                    doSearch(context, text);
                  },
                ),
              ),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(
                    list.length,
                    (index) => TextBox(
                          textId: '0gpwENULwWV85HN4yhdt',
                          title: 'list[index]',
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
