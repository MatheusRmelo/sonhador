import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sonhador/app/app_controller.dart';
import 'package:sonhador/app/modules/writer/widgets/search/search_controller.dart';
import 'package:sonhador/app/widgets/loading_container.dart';
import '../../../../widgets/customappbar.dart';
import '../../../../widgets/textbox.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final searchController = Modular.get<SearchController>();
  final appController = Modular.get<AppController>();

  void getTexts() {
    searchController.fetchTexts(appController.user.value.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (searchController.texts.error != null) {
          return Center(
            child: Column(
              children: [
                Text('Ocorreu um erro, tente novamente mais tarde'),
                RaisedButton(
                  onPressed: () {},
                  child: Text('Recarregar'),
                )
              ],
            ),
          );
        }

        var texts = searchController.texts.value;
        return Scaffold(
            appBar: CustomAppBar(
                color: Colors.white,
                pageContext: context,
                title: 'Jovem, pesquise seu texto abaixo'),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset.fromDirection(1, 1),
                            spreadRadius: 0),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  margin: EdgeInsets.all(16),
                  child: TextFormField(
                    style: TextStyle(fontFamily: 'Fredoka One', fontSize: 12),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        hintText: 'Digite o nome do seu texto',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.search,
                          size: 32,
                          color: Colors.grey[400],
                        )),
                    onChanged: (text) {
                      searchController.searchText(text);
                    },
                  ),
                ),
                searchController.texts.value == null
                    ? LoadingContainer(
                        status: 'Carregando...',
                        expanded: true,
                      )
                    : Expanded(
                        child: GridView.count(
                        crossAxisCount: 3,
                        children: List.generate(
                            texts.length,
                            (index) => TextBox(
                                  margin: EdgeInsets.all(8),
                                  imgUrl: texts[index].photoUrl,
                                  textId: texts[index].id,
                                  title: texts[index].title,
                                  onTap: (textId) {
                                    Navigator.pushNamed(context, '/writer',
                                        arguments: {
                                          "newText": false,
                                          "textId": textId
                                        });
                                  },
                                )),
                      ))
              ],
            ));
      },
    );
  }
}
